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

    # Delegate to metadata
    def method_missing(method, *args, &block)    
      if @metadata.respond_to?(method)
        @metadata.send(method, *args, &block)
      else
        raise NoMethodError  
      end    
    end

    def serialize
      @metadata.uri
    end

    def to_json(options = {})
      { :id => @id,
        :x => @x,
        :y => @y,
        :type => self.class.name.split('::').last,
        :name => @metadata.name,
        :multiplier => @metadata.multiplier,
        :value => @metadata.value,
      }.to_json
    end
  end
end
