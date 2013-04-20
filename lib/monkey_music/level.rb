module MonkeyMusic
  class Level
    attr_accessor :width, :height, :max_turns
    
    def initialize(name, players)
      @name = name
      @width = 0
      @height = 0
      @units = []
      @players = players
    end
    
    def add(unit, x, y)
      unit.place!(self, x, y)
      @units << unit
    end
    
    def units
      @units
    end
    
    def other_units
      units.reject { |u| u.kind_of? Units::Monkey }
    end
    
    def out_of_bounds?(x, y)
      x < 0 || y < 0 || x > @width-1 || y > @height-1
    end

    def load
      LevelLoader.new(self, @players).instance_eval(File.read(load_path))
    end
    
    def to_s
      rows = []
      rows << " " + ("-" * @width)
      @height.times do |y|
        row = "|"
        @width.times do |x|
          row << get_character(x, y)
        end
        row << "|"
        rows << row
      end
      rows << " " + ("-" * @width)
      rows.join("\n") + "\n"
    end

    private
    
    def get(x, y)
      units.detect { |u| u.at?(x, y) }
    end

    def get_character(x, y)
      if u = get(x, y) then u.character else ' ' end
    end

    def load_path
      File.join(File.expand_path("."), "levels/#{@name}.rb")
    end
  end
end
