module MonkeyMusic
  module Units
    class Monkey < Base
      attr_accessor :name, :score

      def initialize
        @score = 0
      end

      def move!(direction)
        target = translate(@x, @y, direction)
        unless @level.out_of_bounds?(*target)
          @x, @y = *target
        end
      end

      def name
        if @name && !@name.empty?
          @name
        else
          "Monkey"
        end
      end

    end
  end
end
