require 'hallon'

module MonkeyMusic
  class RecommendationGenerator
    attr_reader :toplists
    attr_reader :recommendations

    def initialize(toplists, load_factor = 3)
      @toplists = toplists
      @load_factor = load_factor
      @recommendations = []
    end

    def generate!(spotify_account, spotify_password, spotify_appkey)
      Hallon.load_timeout = 0
      session = Hallon::Session.initialize(spotify_appkey)
      session.login!(spotify_account, spotify_password)
      load_toplists!
      load_recommendations_from_albums!
      load_recommendations_from_artists!
      load_recommendations_from_tracks!
      load_recommendations_from_already_heard!
      load_recommendations_from_disliked!
      session.logout!
    end

    private

    def load_toplists!
      loaded_toplists = {}
      @toplists.each do |type, uri|
        loaded_toplists[type] = load_from_list(type, uri)
      end
      @toplists = loaded_toplists
    end

    def load_from_list(type, uri)
      playlist = Hallon::Playlist.new(uri).load
      tracks = playlist.tracks.to_a
      tracks.each(&:load)
      if type == :tracks
        tracks
      elsif type == :artists
        tracks.map(&:artist).each(&:load)
      elsif type == :albums
        tracks.map(&:album).each(&:load)
      end
    end

    def load_recommendations_from_albums!
      @toplists[:albums].each do |album|
        browse = album.browse.load
        browse.tracks.first(@load_factor).each do |rec|
          @recommendations << parse_track(rec)
        end
      end
    end

    def load_recommendations_from_artists!
      @toplists[:artists].each do |artist|
        browse = artist.browse.load
        browse.top_hits.first(@load_factor).each do |rec|
          @recommendations << parse_track(rec)
        end
      end
    end

    def load_recommendations_from_tracks!
      @toplists[:tracks].each do |track|
        album = track.album.load
        browse = album.browse.load
        browse.tracks.first(@load_factor).each do |rec|
          @recommendations << parse_track(rec)
        end
      end
    end

    def load_recommendations_from_tracks!
      @recommendations += @toplists[:tracks]
    end

    def load_recommendations_from_disliked!
      @toplists[:disliked].each do |artist|
        browse = artist.browse.load
        browse.top_hits.first(@load_factor).each do |rec|
          @recommendations << parse_track(rec)
        end
      end
    end

    def parse_track(track)
      album = track.album.load
      artist = track.artist.load
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
