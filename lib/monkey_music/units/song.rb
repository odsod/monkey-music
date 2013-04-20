module MonkeyMusic
  module Units
    class Song < Base
      attr_accessor :uri, :artist, :album, :popularity
    end
  end
end
