module MonkeyMusic
  #
  # LevelLoader defines a DSL for building users in a ruby file
  #
  class UserLoader

    def initialize(user)
      @user = user
    end

    def name(name)
      @user.name = name
    end

    def favorite_songs(tracks)
    end

    def favorite_albums(albums)
    end

    def favorite_artists(artists)
    end

    private

    def unit_to_constant(name)
      camel = name.to_s.split('_').map { |s| s.capitalize }.join
      eval("Units::#{camel}")
    end
  end
end
