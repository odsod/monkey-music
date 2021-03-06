module MonkeyMusic
  #
  # LevelLoader defines a DSL for building levels in a ruby file
  #
  class LevelLoader
    def initialize(level)
      @level = level
      @legend = {}
    end

    def turn_limit(turn_limit)
      @level.turn_limit = turn_limit
    end

    def time_limit(time_limit)
      @level.time_limit = time_limit
      @level.players.each {|p| p.remaining_time = time_limit }
    end

    def carrying_capacity(capacity)
      @level.players.each { |p| p.monkey.capacity = capacity }
    end

    def boost_cooldown(cooldown)
      @level.boost_cooldown = cooldown
    end

    def legend(legend)
      @legend = legend
    end

    def layout(layout)
      # Transform layout into x y indexed array
      units = (layout.lines.map { |l| l.chomp.split(//) }).transpose
      @level.width = units.length
      @level.height = units[0].length
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
        unit = if (klass <= Monkey)
          klass.from_players(@level.players)
        elsif klass <= Track
          klass.from_user(@level.user)
        elsif klass == User
          @level.user
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
