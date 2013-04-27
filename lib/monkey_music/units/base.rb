module MonkeyMusic
  class Base
    attr_accessor :x, :y, :character
    attr_reader :level, :id

    def get_id
      # Didn't manage to use auto incrementing class id for some reason.
      # Might as well play the fail lottery.
      rand(36**8).to_s(36)
    end

    def initialize
      @id = "hej"
    end

    def place!(level, x, y)
      @level = level
      @x, @y = x, y
    end

    def move!
      # To be overriden
    end

    def at?(x, y)
      @x == x && @y == y
    end

    def distance_to(unit)
      (@x - unit.x).abs + (@y - unit.y).abs
    end

    def pos
      [@x, @y]
    end

    def direction_of(unit)
      if (@x - unit.x).abs > (@y - unit.y).abs
        unit.x > @x ? :east : :west
      else
        unit.y > @y ? :south : :north
      end
    end

    def to_s
      asciify
    end

    def serialize
      asciify
    end

    def asciify
      @character
    end

    def to_json(options = {})
      puts @id
      {
        :id => @id,
        :x => @x,
        :y => @y,
        :type => self.class.name.split('::').last
      }.to_json
    end

    private

    def translate(x, y, direction)
      case direction
      when :north then [x,     y - 1]
      when :south then [x,     y + 1]
      when :east  then [x + 1, y    ]
      when :west  then [x - 1, y    ]
      end
    end

  end
end
