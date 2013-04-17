module MonkeyMusic
  module Units
    class Song < Base
      attr_accessor :uri, :artist, :album, :popularity

      def character
        "!"
      end

    end
  end
end
