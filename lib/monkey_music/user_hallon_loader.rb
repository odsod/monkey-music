require 'hallon'

module MonkeyMusic
  class UserHallonLoader
    
    def initialize(user, username)
      @user = user
      @username = username
    end

    def load_track_toplist
      @track_toplist = load_user_toplist(:tracks)
      @user.track_toplist = []
      @track_toplist.each do |track|
        @user.track_toplist << {
          :name => track.name,
          :uri => track.to_link.to_str
        }
      end
    end

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
      @album_toplist.first(5).each do |album|
        browse = album.browse
        browse.load
        browse.tracks.first(5).each do |track|
          @user.recommendations << parse_track(track)
        end
      end
    end

    def load_recommendations_from_top_artists
      @artist_toplist.first(5).each do |artist|
        browse = artist.browse
        browse.load
        browse.top_hits.first(5).each do |track|
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

    private

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
      user_track.value = evaluate_track(track, album, artist)
      user_track
    end

    def evaluate_track(track, album, artist) 
      value = 1
      value *= 1.5 if @user.album_toplist.include?(album.name)
      value *= 1.5 if @user.artist_toplist.include?(artist.name)
      value *= 1.5 if @user.top_decade == decade_of(album)
      value *= (1 + (track.popularity / 100.0))
      value
    end

    def load_user_toplist(type)
      toplist = Hallon::Toplist.new(type, @username)
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
  end
end
