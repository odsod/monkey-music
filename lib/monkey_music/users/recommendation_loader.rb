require 'hallon'

module MonkeyMusic
  class RecommendationLoader

    def initialize(loaded_toplists, load_factor = 3)
      @loaded_toplists = loaded_toplists
      @load_factor = load_factor
    end

    def load_for_user!(user)
      @user = user
      load_recommendations_from_albums!
      load_recommendations_from_artists!
      load_recommendations_from_top_track_albums!
      load_recommendations_from_already_heard!
      load_recommendations_from_disliked!
    end

    private

    def load_recommendations_from_albums!
      @loaded_toplists[:top_albums].each do |album|
        browse = album.browse
        browse.load unless browse.loaded?
        browse.tracks.first(@load_factor).each do |rec|
          @user.recommendations << parse_track(rec)
        end
      end
    end

    def load_recommendations_from_artists!
      @loaded_toplists[:top_artists].each do |artist|
        browse = artist.browse(:no_albums)
        browse.load unless browse.loaded?
        browse.top_hits.first(@load_factor).each do |rec|
          @user.recommendations << parse_track(rec)
        end
      end
    end

    def load_recommendations_from_top_track_albums!
      @loaded_toplists[:top_track_albums].each do |album|
        browse = album.browse
        browse.load unless browse.loaded?
        browse.tracks.first(@load_factor).each do |rec|
          @user.recommendations << parse_track(rec)
        end
      end
    end

    def load_recommendations_from_already_heard!
      @loaded_toplists[:top_tracks].each do |track|
        @user.recommendations << parse_track(track)
      end
    end

    def load_recommendations_from_disliked!
      @loaded_toplists[:disliked].each do |artist|
        browse = artist.browse(:no_albums)
        browse.load unless browse.loaded?
        browse.top_hits.first(@load_factor).each do |rec|
          @user.recommendations << parse_track(rec)
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

  end
end
