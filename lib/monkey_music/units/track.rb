module MonkeyMusic
  class Track < Base
    attr_accessor :metadata

    def self.worth(n)
      Class.new Track do @worth = n end
    end

    def self.from_user(user)
      track = Track.new
      track.metadata = if @worth
        user.recommend!(@worth) || user.recommendations.sample
      else
        user.recommendations.sample
      end
      track
    end

    def value
      @metadata[:value]
    end

    def uri
      @metadata[:uri]
    end

    def serialize
      uri
    end

    def to_json(options = {})
      { :id => @id,
        :x => @x,
        :y => @y,
        :type => self.class.name.split('::').last,
        :name => @metadata[:name],
        :multiplier => @metadata[:multiplier],
        :value => @metadata[:value]
      }.to_json
    end
  end
end
