module MonkeyMusic
  class Player
    attr_accessor :monkey, :name
    
    def initialize(file)
      @file = File.join(Dir.pwd, file)
      @monkey = Units::Monkey.new()
    end

    def query_move!
      @next_move = :north
    end

    def move!
      @monkey.move! @next_move
    end

    def to_s
      @file
    end

  end
end
