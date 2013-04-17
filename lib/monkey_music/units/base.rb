module MonkeyMusic
  module Units
    class Base
      attr_accessor :pos

      def initialize(level, x, y)
        @level = level
        @pos = [x, y]
      end
      
      def act!
      end

      def at?(x, y)
        @pos == [x, y]
      end

      def distance_to(unit)
        x, y = *unit.pos
        (@x - x).abs + (@y - y).abs
      end

      private

    end
  end
end
