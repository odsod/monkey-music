module MonkeyMusic
  class Track < Base
    attr_accessor :uri, :name, :artist, :album, :popularity, :value

    def serialize
      @uri
    end

    def to_s
      @name
    end
  end
end
