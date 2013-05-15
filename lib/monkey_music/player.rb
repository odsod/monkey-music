require 'benchmark'

module MonkeyMusic
  class Player
    attr_accessor :monkey, :level, :has_boost, :remaining_time, :command_line_argument
    
    def initialize(file)
      @file = file
      @monkey = Monkey.new
      @has_boost = true
      @penalty = 0
      @moves = []
      @queries = []
      @command_line_argument = ""
    end

    def init!
      IO.popen([@file, @command_line_argument], "r+") do |io| 
        io.puts initial_output
      end
    end

    def query!(turn)
      if @penalty > 0
        @penalty -= 1
        @remaining_time = @monkey.level.time_limit if @penalty < 1
      else
        IO.popen(@file, "r+") do |io|
          io.puts turn_output(turn)
          @remaining_time -= (Benchmark.realtime { @input = io.gets } * 1000).round
          parse!(@input) if @input
        end
        @penalty = 5 if @remaining_time < 0
      end
    end

    def initial_output
      level = @monkey.level
      user = @monkey.level.user
      [ "INIT",
        level.width,
        level.height,
        level.turn_limit,
        user.toplists[:top_tracks].length,
        user.toplists[:top_tracks].map(&:serialize).join("\n"),
        user.toplists[:top_albums].length,
        user.toplists[:top_albums].map(&:serialize).join("\n"),
        user.toplists[:top_artists].length,
        user.toplists[:top_artists].map(&:serialize).join("\n"),
        user.toplists[:disliked_artists].length,
        user.toplists[:disliked_artists].map(&:serialize).join("\n"),
      ].join("\n")
    end

    def turn_output(turn)
      [ "TURN",
        turn,
        @monkey.id,
        @monkey.remaining_capacity,
        @remaining_time,
        response_to(@queries),
        @monkey.level.serialize,
      ].join("\n")
    end

    def parse!(s)
      @queries = []
      @tokens = s.chomp.split(",")
      parse_next_token!
    end

    def parse_next_token!
      token = @tokens.shift
      if /^[NWES]$/.match(token) then @moves << parse_move(token)
      elsif /^spotify:track:/.match(token) then @queries << token
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
        lines << "#{track.uri},#{track.metadata.serialize}"
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
