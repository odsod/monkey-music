module MonkeyMusic
  module Units
    class Monkey < Base
      attr_writer :name
      attr_reader :score

      def initialize
        @score = 0
      end

      def move!(direction)
        #puts "Moving monkey #{direction}"
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

      def to_s
        name
      end

      def character
        "M"
      end
      
    end
  end
end
