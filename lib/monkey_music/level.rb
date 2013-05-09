require 'json'

module MonkeyMusic
  class Level
    attr_accessor :width, :height, :turn_limit, :time_limit
    attr_reader :players, :user, :units
    
    def initialize(players, user)
      @players = players
      @user = user
      @width = 0
      @height = 0
      @units = []
    end
    
    def add(unit, x, y)
      unit.place!(self, x, y)
      unit.assign_id
      @units << unit
    end
    
    def at(x, y)
      @units.detect { |u| u.at?(x, y) }
    end

    def empty?(x, y)
      at(x, y).nil?
    end

    def complete?
      (@units.detect { |u| u.kind_of? Track }).nil? &&
        (@players.detect { |p| p.monkey.carrying.count > 0 }).nil?
    end

    def tracks
      @units.select {|u| u.kind_of? Track }
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
      LevelLoader.new(self).instance_eval(IO.read(file))
      self
    end

    def to_s
      rows = []
      rows << " " + ("=" * @width)
      @height.times do |y|
        row = ["|"]
        @width.times do |x|
          unit = at(x, y)
          row << if unit then unit.to_s else ' ' end
        end
        row << "|"
        rows << row.join
      end
      rows << " " + ("=" * @width)
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

    def as_json
      {
        :width => @width,
        :height => @height,
        :units => @units,
      }.to_json
    end

  end
end
