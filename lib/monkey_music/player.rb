module MonkeyMusic
  class Player
    attr_accessor :monkey, :level, :has_boost
    
    def initialize(file)
      @file = file
      @monkey = Monkey.new()
      @remaining_time = 30000
      @has_boost = true
    end

    def initial_output
      [ "INIT",
        @monkey.id,
        @monkey.level.width,
        @monkey.level.height,
        @monkey.level.max_turns,
        @monkey.level.user.serialize_toplists,
      ].join("\n")
    end

    def turn_output(turn)
      [ "TURN",
        turn,
        @monkey.remaining_capacity,
        @remaining_time,
        @monkey.level.serialize,
      ].join("\n")
    end

    def init!
      IO.popen(@file, "r+") do |io|
        io.puts initial_output
      end
    end

    def query!(turn)
      IO.popen(@file, "r+") do |io|
        io.puts turn_output
        input = io.gets
        parse!(input) if input
        io.puts response_to(@queries) unless @queries.empty?
        @queries = []
      end
    end

    def parse!(s)
      @tokens = s.chomp.split(",")
      parse_next_token!
    end

    def parse_next_token!
      token = @tokens.pop
      if /^([NWES])$/.match(token) then @moves << parse_move($1)
      elsif /^(spotify:track:)/.match(token) then @queries << token
      elsif "B" == token then boost!
      end
    end

    def boost!
      return unless @has_boost
      @has_boost = false
      [3, @tokens.length].min.times { parse_next_token! }
    end

    def response_to(queries)
      tracks = []
      queries.each do |uri|
        tracks << @monkey.level.tracks.find {|t| t.uri == uri }
      end
      lines = []
      lines << tracks.length
      tracks.each do |track|
        lines << "#{track.uri},#{track.serialize}"
      end
      lines.join("\n")
    end

    def parse_move(move)
      case move
        when "N" then :north
        when "W" then :west
        when "E" then :east
        when "S" then :south
      end
    end

    def move!
      @moves.each {|move| @monkey.move! move }
      @moves = []
    end

    def to_s
      @monkey.name
    end

  end
end
