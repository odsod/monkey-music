module MonkeyMusic
  class Position
    attr_reader :floor
    DIRECTIONS = [:north, :east, :south, :west]
    RELATIVE_DIRECTIONS = [:forward, :right, :backward, :left]
    
    def initialize(floor, x, y, direction = nil)
      @floor = floor
      @x = x
      @y = y
      @direction_index = DIRECTIONS.index(direction || :north)
    end

    def direction
      DIRECTIONS[@direction_index]
    end

    def relative_space(forward, right = 0)
      @floor.space(*translate_offset(forward, right))
    end

    def move(forward, right = 0)
      @x, @y = *translate_offset(forward, right)
    end

    def distance_from_stairs
      distance_of(@floor.stairs_space)
    end

    def distance_of(space)
      x, y = *space.location
      (@x - x).abs + (@y - y).abs
    end

    def direction_of(space)
      space_x, space_y = *space.location
      if (@x - space_x).abs > (@y - space_y).abs
        space_x > @x ? :east : :west
      else
        space_y > @y ? :south : :north
      end
    end
    
  end
end
