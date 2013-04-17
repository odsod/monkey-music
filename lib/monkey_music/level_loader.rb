module MonkeyMusic
  #
  # LevelLoader defines a DSL for building levels in a ruby file
  #
  class LevelLoader
    def initialize(level, players)
      @level = level
      @players = players
    end

    def max_turns(max_turns)
      @level.max_turns = max_turns
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
      if @players
        @level.add(@players.monkey, x, y)
      end
    end

    def song(x, y)
      song = Units::Song.new
      yield song if block_given?
      @level.add(Units::Song.new, x, y)

    end

    private

    def unit_to_constant(name)
      camel = name.to_s.split('_').map { |s| s.capitalize }.join
      eval("Units::#{camel}")
    end
  end
end
