module MonkeyMusic
  class Player
    attr_accessor :monkey, :level
    
    def initialize(file)
      @file = file
      @monkey = Monkey.new()
    end

    def query_move!
      IO.popen(@file, "r+") do |io|
        io.puts player_output
        move = io.gets
        @next_move = parse_move(move) if move
      end
    end

    def player_output
      [ @monkey.id,
        @monkey.remaining_capacity,
        @monkey.level.requests_per_turn,
        @monkey.level.width,
        @monkey.level.height,
        @monkey.level.serialize,
      ].join("\n")
    end

    def parse_move(s)
      case s.chomp
      when "N" then :north
      when "W" then :west
      when "E" then :east
      when "S" then :south
      end
    end

    def move!
      @monkey.move! @next_move if @next_move
      @next_move = nil
    end

    def to_s
      @monkey.name
    end

  end
end
