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

    def country(country)
      # TODO: Convert to region using region gem
      #@user.region =
    end

    def favorite_songs(songs)
      @user.favorite_songs = songs.lines
    end

    def favorite_albums(albums)
      @user.favorite_albums = albums.lines
    end

    def favorite_artists(artists)
      @user.favorite_artists = artists.lines
    end

    def song(metadata)
      @user.recommendations << metadata
    end

    private

    def unit_to_constant(name)
      camel = name.to_s.split('_').map { |s| s.capitalize }.join
      eval("Units::#{camel}")
    end
  end
end
