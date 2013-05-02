require 'hallon'

module MonkeyMusic
  class RecommendationGenerator
    attr_reader :recommendations

    def initialize(toplists, load_factor = 5)
      @toplists = toplists
      @load_factor = load_factor
      @recommendations = []
    end

    def generate!(spotify_account, spotify_password, spotify_appkey)
      Hallon.load_timeout = 0
      session = Hallon::Session.initialize(spotify_appkey)
      session.login!(spotify_account, spotify_password)
      loaded_toplists = {}
      @toplists.each do |type, list|
        loaded_toplists[type] = load_toplist(type, list)
      end
      load_from_albums(loaded_toplists[:albums])
      load_from_artists(loaded_toplists[:artists])
      session.logout
      sleep 1 # Give libspotify a sec to cool off and release memory
    end

    private

    def load_toplist(type, list)
      to_load = []
      puts "loading #{type.to_s}..."
      list.each do |uri|
        puts uri
        item = case type
               when :tracks then Hallon::Track.new(uri).load
               when :albums then Hallon::Track.new(uri).load.album.load
               when :artists then Hallon::Track.new(uri).load.artist.load
               end
        to_load << item
        puts "loaded #{item.name}"
      end
      #to_load.each do |item|
        #puts "loading #{item.to_s}"
        #item.load
        #puts "loaded #{item.to_s}"
      #end
      puts "loaded #{type.to_s}"
      parse_toplist(to_load)
    end

    def load_from_albums(albums)
      albums.first(@load_factor).each do |album|
        browse = album.browse
        browse.load
        browse.tracks.first(@load_factor).each do |track|
          @recommendations << parse_track(track)
        end
      end
    end

    def load_from_artists(artists)
      artists.first(@load_factor).each do |artist|
        browse = artist.browse
        browse.load
        browse.top_hits.first(@load_factor).each do |track|
          @recommendations << parse_track(track)
        end
      end
    end

    def parse_track(track)
      album = track.album
      album.load
      artist = track.artist
      artist.load
      user_track = Track.new
      user_track.uri = track.to_link.to_str
      user_track.name = track.name
      user_track.artist = artist.name
      user_track.album = album.name
      user_track.popularity = track.popularity
      user_track.year = album.release_year
      user_track
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
