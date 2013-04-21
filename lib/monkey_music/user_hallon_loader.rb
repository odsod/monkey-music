require 'hallon'

module MonkeyMusic
  class UserHallonLoader
    
    def initialize(user, hallon_user)
      @user = user
      @hallon_user = hallon_user
      @username = hallon_user.name
    end

    def load_track_toplist
      @track_toplist = load_toplist(:tracks)
      @user.track_toplist = []
      @track_toplist.each do |track|
        @user.track_toplist << {
          :name => track.name,
          :uri => track.to_link.to_str
        }
      end
    end

    def load_track_toplist
      @track_toplist = load_toplist(:tracks)
      @user.track_toplist = parse_toplist(@track_toplist)
    end

    def load_album_toplist
      @album_toplist = load_toplist(:albums)
      @user.album_toplist = parse_toplist(@album_toplist)
      @user.top_decade = calc_top_decade(@album_toplist)
    end

    def load_artist_toplist
      @artist_toplist = load_toplist(:artists)
      @user.artist_toplist = parse_toplist(@artist_toplist)
    end

    def load_recommendations_from_top_albums
      @album_toplist.each do |album|
        browse = album.browse
        browse.load
        browse.tracks.each do |track|
          @user.recommendations << parse_track(track)
        end
      end
    end

    private

    def calc_top_decade

    end

    def parse_track(track)
      result = {
        :name => track.name,
        :uri => track.to_link.to_str,
        :popularity => track.popularity,
        :value => evaluate_track(track)
      }
      #puts result
      result
    end

    def evaluate_track(track) 
      album = track.album
      album.load
      artist = track.artist
      artist.load
      puts "#{track.name},#{album.name},#{artist.name},#{album.release_year}"
      # Base value
      value = 1
      value *= 1.5 if @user.album_toplist.include?(album.name)
      value *= 1.5 if @user.artist_toplist.include?(artist.name)
      value *= (1 + (track.popularity / 100.0))
      value
    end

    def load_toplist(type)
      toplist = Hallon::Toplist.new(type, @username)
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
