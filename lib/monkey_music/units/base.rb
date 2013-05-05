module MonkeyMusic
  class Base
    attr_accessor :x, :y, :character
    attr_reader :level, :id

    @@curr_id = 0

    def assign_id
      @id = @@curr_id
      @@curr_id += 1
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

    # As shown to player
    def serialize
      asciify
    end

    # As shown in console ui
    def asciify
      @character
    end

    def to_json(options = {})
      { :id => @id,
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
