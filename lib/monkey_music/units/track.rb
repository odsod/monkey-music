module MonkeyMusic
  class Track < Base
    attr_accessor :uri, :name, :artist, :album, :popularity, :year,
      :value, :multiplier

    def self.worth(n)
      Class.new Track do @worth = n end
    end

    def self.from_user(user)
      if @worth
        user.recommend!(@worth) || user.recommendations.sample
      else
        user.recommendations.sample
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
