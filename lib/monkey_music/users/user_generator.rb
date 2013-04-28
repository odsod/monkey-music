require 'hallon'

module MonkeyMusic
  class UserGenerator

    def initialize(user_to_generate, 
                   spotify_account, 
                   spotify_password, 
                   spotify_appkey,
                   load_factor)
      @user = User.new(@user_to_generate)
      @score_system = ScoreSystem.new(@user)
      @spotify_account = spotify_account
      @spotify_password = spotify_password
      @spotify_appkey = spotify_appkey
      @load_factor = 5
    end

    def generate!
      session = Hallon::Session.initialize(@spotify_appkey)
      session.login!(@spotify_account, @spotify_password)
      load_track_toplist
      load_album_toplist
      load_artist_toplist
      load_recommendations_from_top_albums
      load_recommendations_from_top_artists
      # Load some crappy(?) recommendations from Mexico
      load_recommendations_from_country_toplist(:mx)
      sleep 2 # Give libspotify a sec or two to cool off and release memory
      @user
    end

    private

    def load_track_toplist
      @track_toplist = load_user_toplist(:tracks)
      @user.track_toplist = parse_toplist(@track_toplist)
    end

    def load_album_toplist
      @album_toplist = load_user_toplist(:albums)
      @user.album_toplist = parse_toplist(@album_toplist)
      @user.top_decade = calc_top_decade(@album_toplist)
    end

    def load_artist_toplist
      @artist_toplist = load_user_toplist(:artists)
      @user.artist_toplist = parse_toplist(@artist_toplist)
    end

    def load_recommendations_from_top_albums
      @album_toplist.first(@load_factor).each do |album|
        browse = album.browse
        browse.load
        browse.tracks.first(@load_factor).each do |track|
          @user.recommendations << parse_track(track)
        end
      end
    end

    def load_recommendations_from_top_artists
      @artist_toplist.first(@load_factor).each do |artist|
        browse = artist.browse
        browse.load
        browse.top_hits.first(@load_factor).each do |track|
          @user.recommendations << parse_track(track)
        end
      end
    end

    def load_recommendations_from_country_toplist(country)
      toplist = load_toplist(:tracks, country)
      toplist.each do |track|
        @user.recommendations << parse_track(track)
      end
    end

    def calc_top_decade(albums)
      decade_count = Array.new(10, 0)
      albums.each do |album|
        if album.release_year != 0
          decade_count[decade_of(album)] += 1
        end
      end
      decade_count.each_with_index.max[1]
    end

    def parse_track(track)
      album = track.album
      album.load
      artist = track.artist
      artist.load
      user_track = Track.new
      user_track.uri = track.to_link.to_str
      user_track.name = track.name,
      user_track.artist = artist.name,
      user_track.album = album.name,
      user_track.popularity = track.popularity,
      user_track.value = @score_system.evaluate_track(track)
      user_track
    end

    def load_user_toplist(type)
      toplist = Hallon::Toplist.new(type, @user.name)
      toplist.load
      toplist.results
    end

    def load_toplist(type, region)
      toplist = Hallon::Toplist.new(type, region)
      toplist.load
      toplist.results
    end

    def parse_toplist(list)
      result = []
      list.each do |item|
        result << item.name
      end
      result
    end

    def decade_of(year)
      (year % 100) / 10
    end

  end
end
