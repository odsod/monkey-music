module MonkeyMusic
  class Track < Base
    attr_accessor :uri, :name, :artist, :album, :popularity, :year,
      :value, :multiplier

    def self.worth(n)
      Class.new Track do @worth = n end
    end

    def self.from_recommendations(recommendations)
      if @worth
        found = recommendations.shuffle.find do 
          |r| r.multiplier == @worth 
        end
        found || recommendations.sample
      else
        recommendations.sample
      end
    end

    def serialize
      @uri
    end

    def to_json(options = {})
      { :id => @id,
        :x => @x,
        :y => @y,
        :type => self.class.name.split('::').last,
        :name => @name,
        :multiplier => @multiplier,
        :value => @value,
      }.to_json
    end
  end
end
