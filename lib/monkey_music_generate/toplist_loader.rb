require 'hallon'

module MonkeyMusic::Generate
  class ToplistLoader
    attr_reader :loaded_toplists

    def initialize(toplist_file)
      @toplist_file = toplist_file
      @toplists = {}
      @loaded_toplists = {}
    end

    def load_for_user!(user)
      @user = user
      # Load toplists URI:s from file
      self.instance_eval(IO.read @toplist_file)
      # Load toplist contents from libspotify
      load_toplists!
    end

    private

    # User toplist DSL

    def toplist(type, name, uri)
      @toplists[name] = { :type => type, :uri => uri }
    end

    # Toplist loading

    def load_toplists!
      @toplists.each do |name, list|
        @loaded_toplists[name] = { 
          :type => list[:type],
          :items => load_from_list(list[:type], list[:uri])
        }
        @user.toplists[name] = parse_toplist(list[:type], @loaded_toplists[name][:items])
      end
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

    def parse_toplist(type, list)
      case type
        when :tracks  then list.map { |track| load_track track }
        when :albums  then list.map { |album| load_album album }
        when :artists then list.map { |artist| load_artist artist }
      end
    end

    def load_album(album)
      artist = album.artist.load
      MonkeyMusic::Metadata::Album.new :name => album.name, 
                                       :artist => artist.name, 
                                       :year => album.release_year
    end

    def load_artist(artist)
      MonkeyMusic::Metadata::Artist.new :name => artist.name
    end

    def load_track(track)
      album = track.album.load
      artist = track.artist.load
      MonkeyMusic::Metadata::Track.new :uri => track.to_link.to_str,
                                       :name => track.name,
                                       :artist => artist.name,
                                       :album => album.name,
                                       :year => album.release_year
    end

  end
end
