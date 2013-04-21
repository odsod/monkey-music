module MonkeyMusic
  class Monkey < Base
    attr_accessor :name, :score, :capacity, :character

    def initialize
      @score = 0
      @capacity = 1
      @carrying = []
      @delivered = []
    end

    def move!(direction)
      target = translate(@x, @y, direction)
      # Interact with unit
      if target_unit = @level.at(*target)
        @monkey.interact_with!(target_unit)
      end
      # Perform move
      @x, @y = *target if @level.accessible?(*target)
    end

    def interact_with!(unit)
      case unit
      when Track then pick_up!(unit)
      when Tube then deliver!
      end
    end

    def pick_up!(unit)
      @level.remove(unit)
      @carrying << unit
    end

    def deliver!
      @delivered += @carrying
      @score += tally(@carrying)
      @carrying = []
    end

    def tally(units)
      score = 0
      units.each do |u|
        score += u.value if defined? u.value
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
