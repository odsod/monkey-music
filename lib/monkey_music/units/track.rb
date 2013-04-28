module MonkeyMusic
  class Track < Base
    attr_accessor :uri, :name, :artist, :album, :popularity, :value, :modifiers, :year

    def initialize
      @modifiers = []
    end

    def serialize
      @uri
    end

    def to_s
      @name
    end

    def to_json(options = {})
      { :id => @id,
        :x => @x,
        :y => @y,
        :type => self.class.name.split('::').last,
        :name => @name,
        :value => @value
      }.to_json
    end
  end
end
