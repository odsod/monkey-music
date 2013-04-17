module MonkeyMusic
  class LevelLoader
    def initialize(level)
      @level = MonkeyMusic::Level.new
    end

    def rounds(rounds)
      @level.rounds = rounds
    end

    def size(width, height)
      @level.width = width
      @level.height = height
    end

    def unit(unit, x, y)
      unit = unit_to_constant(unit).new unless unit.kind_of? Units::Base
      @level.add(unit, x, y)
      yield unit if block_given?
      unit
    end

    def monkey(x, y)
      # If there is a remaining player, add monkey to level
    end

    private

    def unit_to_constant(name)
      camel = name.to_s.split('_').map { |s| s.capitalize }.join
      eval("Units::#{camel}")
    end
  end
end
