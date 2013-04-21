module MonkeyMusic
  #
  # LevelLoader defines a DSL for building levels in a ruby file
  #
  class LevelLoader
    def initialize(level)
      @level = level
      @legend = {}
    end

    def max_turns(max_turns)
      @level.max_turns = max_turns
    end

    def width(width)
      @level.width = width
    end

    def monkey_carrying_capacity(capacity)
      @level.players.each { |p| p.monkey.capacity = capacity }
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
      available_players = Array.new(@level.players)
      @level.height.times do |y|
        @level.width.times do |x|
          curr_character = units[x][y]
          if unit_class = @legend[curr_character]
            if unit_class == Monkey && player = available_players.pop
              player.monkey.character = curr_character
              @level.add(player.monkey, x, y)
            else
              new_unit = unit_class.new
              new_unit.character = curr_character
              @level.add new_unit, x, y
            end
          end
        end
      end
    end

  end
end
