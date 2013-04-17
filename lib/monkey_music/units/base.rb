module MonkeyMusic
  module Units
    class Base
      attr_accessor :pos

      def initialize(level, x, y)
        @level = level
        @pos = [x, y]
      end

      def act!
        # To be overriden
      end

      def at?(pos)
        @pos == pos
      end

      def distance_to(unit)
        x, y = *unit.pos
        (@x - x).abs + (@y - y).abs
      end

      def direction_of(unit)
        x, y = *pos
        unit_x, unit_y = *unit.pos
        if (x - unit_x).abs > (y - unit_y).abs
          unit_x > x ? :east : :west
        else
          unit_y > y ? :south : :north
        end
      end

    end
  end
end
