require 'hallon'

module MonkeyMusic
  class ToplistLoader
    attr_reader :loaded_toplists

    def initialize(toplist_file)
      @toplist_file = IO.read(toplist_file)
      @toplists = {}
    end

    def load_for_user!(user)
      @user = user
      # Load toplists URI:s from file
      self.instance_eval(@toplist_file)
      # Load toplist contents from libspotify
      load_toplists!
      load_top_track_albums!
    end

    private

    # User toplist DSL

    def toplist(type, uri)
      @toplists[type] = uri
    end

    # Toplist loading

    def load_toplists!
      @loaded_toplists = {}
      @toplists.each do |type, uri|
        @loaded_toplists[type] = load_from_list(type, uri)
        @user.toplists[type] = parse_toplist(@loaded_toplists[type])
      end
    end

    def load_top_track_albums!
      @loaded_toplists[:top_track_albums] = 
        @loaded_toplists[:top_tracks].map(&:album).each(&:load)
      @user.toplists[:top_track_albums] = 
        parse_toplist(@loaded_toplists[:top_track_albums])
    end

    def load_from_list(type, uri)
      playlist = Hallon::Playlist.new(uri).load
      tracks = playlist.tracks.to_a
      tracks.each(&:load)
      if type == :top_tracks
        tracks
      elsif type == :top_artists || type == :disliked
        tracks.map(&:artist).each(&:load)
      elsif type == :top_albums
        tracks.map(&:album).each(&:load)
      end
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
