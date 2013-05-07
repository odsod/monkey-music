module MonkeyMusic
  class Monkey < Base
    attr_accessor :name, :score, :capacity, :character
    attr_reader :carrying, :facing

    def self.player(number)
      Class.new Monkey do @player_index = number - 1 end
    end

    def self.from_players(players)
      @player_index &&
        players[@player_index] &&
        players[@player_index].monkey
    end

    def initialize
      @score = 0
      @capacity = 1
      @carrying = []
      @delivered = []
      @facing = [:west, :east].sample
    end

    def move!(direction)
      target = translate(@x, @y, direction)
      if target_unit = @level.at(*target)
        # Interact with unit
        interact_with!(target_unit)
      else
        # Face the right direction
        @facing = case direction
          when :west then :west
          when :east then :east
          else @facing
        end
        # Perform move
        @x, @y = *target if @level.accessible?(*target)
      end
    end

    def interact_with!(unit)
      case unit
      when Track then pick_up!(unit)
      when User then deliver!
      end
    end

    def pick_up!(unit)
      if @carrying.count < @capacity
        @level.remove(unit)
        @carrying << unit
      end
    end

    def deliver!
      @delivered += @carrying
      @score += tally(@carrying)
      @carrying = []
    end

    def tally(tracks)
      score = 0
      tracks.each do |track|
        score += track.value
      end
      score
    end

    def remaining_capacity
      (@capacity - carrying.count) || 0
    end

    def serialize
      @id
    end

    def to_json(options = {})
      { :id => @id,
        :x => @x,
        :y => @y,
        :facing => @facing,
        :type => self.class.name.split('::').last,
        :name => @name,
        :score => @score,
      }.to_json
    end

  end
end
