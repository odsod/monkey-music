module MonkeyMusic
  class Player
    attr_accessor :monkey, :name
    
    def initialize(file)
      @file = File.join(Dir.pwd, file)
      @monkey = Units::Monkey.new()
    end

    def query_move!
      IO.popen(@file, "r+") do |io|
        io.puts @monkey.user.serialize
        io.puts @monkey.level.serialize
        @next_move = parse_move(io.gets.chomp)
      end
    end

    def parse_move(s)
      case s
      when "N" then :north
      when "W" then :west
      when "E" then :east
      when "S" then :south
      end
    end

    def move!
      @monkey.move! @next_move if @next_move
    end

    def to_s
      @file
    end

  end
end
