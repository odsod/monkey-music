module MonkeyMusic
  #
  # LevelLoader defines a DSL for building levels in a ruby file
  #
  class LevelLoader
    def initialize(level)
      @level = level
      @available_players = Array.new(level.players)
      @legend = {}
    end

    def max_turns(max_turns)
      @level.max_turns = max_turns
    end

    def width(width)
      @level.width = width
    end

    def carrying_capacity(capacity)
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
      @level.height.times do |y|
        @level.width.times do |x|
          curr_character = units[x][y]
          unit = parse_character(curr_character)
          @level.add(unit, x, y) if unit
        end
      end
    end

    private

    def parse_character(character)
      klass = @legend[character]
      if klass
        unit = if (klass == Monkey) 
          @available_players.pop.monkey unless @available_players.empty?
        elsif klass <= Track
          klass.from_recommendations(@level.user.recommendations)
        else
          klass.new
        end
        if unit
          unit.character = character
          unit
        end
      end
    end

  end
end
