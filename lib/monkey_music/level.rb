module MonkeyMusic
  class Level
    attr_accessor :width, :height, :max_turns
    attr_accessor :events
    attr_reader :players
    attr_reader :user
    
    def initialize(players, user)
      @players = players
      @user = user
      @width = 0
      @height = 0
      @units = []
      @events = []
    end
    
    def add(unit, x, y)
      unit.place!(self, x, y)
      @units << unit
    end
    
    def at(x, y)
      @units.detect { |u| u.at?(x, y) }
    end

    def empty?(x, y)
      at(x, y).nil?
    end

    def complete?
      (@units.detect { |u| u.kind_of? Track }).nil?
    end

    def remove(unit)
      @units.reject! { |u| u == unit }
    end
    
    def out_of_bounds?(x, y)
      x < 0 || y < 0 || x > @width-1 || y > @height-1
    end

    def accessible?(x, y)
      not out_of_bounds?(x, y) && empty?(x, y)
    end

    def load_from_file(file)
      LevelLoader.new(self).instance_eval(File.read(file))
      self
    end

    def asciify
      rows = []
      rows << " " + ("_" * @width)
      @height.times do |y|
        row = ["|"]
        @width.times do |x|
          unit = at(x, y)
          row << if unit then unit.asciify else ' ' end
        end
        row << "|"
        rows << row.join
      end
      rows << "|" + ("_" * @width) + "|"
      rows.join("\n")
    end

    def serialize
      rows = []
      @height.times do |y|
        row = []
        @width.times do |x|
          unit = at(x, y)
          row << if unit then unit.serialize else '_' end
        end
        rows << row.join(",")
      end
      rows.join("\n")
    end

    def to_s
      asciify
    end

  end
end
