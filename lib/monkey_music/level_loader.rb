module MonkeyMusic
  #
  # LevelLoader defines a DSL for building levels in a ruby file
  #
  class LevelLoader
    def initialize(level, players)
      @level = level
      @players = players
      @legend = {}
    end

    def max_turns(max_turns)
      @level.max_turns = max_turns
    end

    def width(width)
      @level.width = width
    end

    def height(height)
      @level.height = height
    end

    def legend(legend)
      @legend = legend
    end

    def layout(layout)
      # Transform layout into x y indexed array
      units = (layout.lines.map { |l| l.chomp.split(//) }).transpose
      # Add units from layout to level
      @level.height.times do |y|
        @level.width.times do |x|
          curr_character = units[x][y]
          if unit = @legend[curr_character]
            if unit == Units::Monkey
              @players.monkey.character = curr_character
              @level.add(@players.monkey, x, y)
            else
              new_unit = unit.new
              new_unit.character = curr_character
              @level.add new_unit, x, y
            end
          end
        end
      end
    end

    private

    def unit_to_constant(name)
      camel = name.to_s.split('_').map { |s| s.capitalize }.join
      eval("Units::#{camel}")
    end
  end
end
