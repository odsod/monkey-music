module MonkeyMusic
  class Song < Base
    attr_accessor :uri, :artist, :album, :popularity, :available, :territories
  end
end
