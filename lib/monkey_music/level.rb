module MonkeyMusic
  class Level
    attr_accessor :width, :height
    
    def initialize(name)
      @width = 0
      @height = 0
      @units = []
    end
    
    def load
      LevelLoader.new(self).instance_eval(File.read(load_path))
    end

    def play(turns = 1000)
      turns.times do |n|
        @units.each { |unit| unit.prepare_turn }
        @units.each { |unit| unit.perform_turn }
        yield if block_given?
        @time_bonus -= 1 if @time_bonus > 0
      end
    end
    
    def add(unit, x, y, direction = nil)
      @units << unit
      unit.position = Position.new(self, x, y, direction)
    end
    
    def place_stairs(x, y)
      @stairs_location = [x, y]
    end
    
    def stairs_space
      space(*@stairs_location)
    end
    
    def units
      @units.reject { |u| u.position.nil? }
    end
    
    def other_units
      units.reject { |u| u.kind_of? Units::Warrior }
    end
    
    def get(x, y)
      units.detect do |unit|
        unit.position.at?(x, y)
      end
    end
    
    def space(x, y)
      Space.new(self, x, y)
    end
    
    def out_of_bounds?(x, y)
      x < 0 || y < 0 || x > @width-1 || y > @height-1
    end
    
    def character
      rows = []
      rows << " " + ("-" * @width)
      @height.times do |y|
        row = "|"
        @width.times do |x|
          row << space(x, y).character
        end
        row << "|"
        rows << row
      end
      rows << " " + ("-" * @width)
      rows.join("\n") + "\n"
    end
    
    def unique_units
      unique_units = []
      units.each do |unit|
        unique_units << unit unless unique_units.map { |u| u.class }.include?(unit.class)
      end
      unique_units
    end
  end
end
