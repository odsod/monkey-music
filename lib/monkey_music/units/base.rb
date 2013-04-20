module MonkeyMusic
  module Units
    class Base
      attr_accessor :x, :y, :character

      def place!(level, x, y)
        @level = level
        @x, @y = x, y
        @character = "?"
      end

      def move!
        # To be overriden
      end

      def at?(x, y)
        [@x, @y] == [x, y]
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

      def character
        return ' '
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
end
