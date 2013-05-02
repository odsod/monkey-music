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
      @toplists.each do |type, uri|
        loaded_toplists[type] = load_from_list(type, uri)
      end
      load_from_albums(loaded_toplists[:albums])
      #load_from_artists(loaded_toplists[:artists])
      session.logout
      sleep 1 # Give libspotify a sec to cool off and release memory
    end

    private

    def load_from_list(type, uri)
      playlist = Hallon::Playlist.new(uri).load
      tracks = playlist.tracks.to_a
      tracks.each(&:load)
      if type == :tracks
        tracks
      elsif type == :artists
        tracks.map(&:artist).each(&:load)
      else
        tracks.map(&:album).each(&:load)
      end
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
