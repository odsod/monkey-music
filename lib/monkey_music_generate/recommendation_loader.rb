require 'hallon'

module MonkeyMusic::Generate
  class RecommendationLoader

    def initialize(loaded_toplists, load_factor = 5)
      @loaded_toplists = loaded_toplists
      @load_factor = load_factor
    end

    def load_for_user!(user)
      @user = user
      @loaded_toplists.each do |name, list|
        puts "Loading #{name}..."
        list[:items].each { |item| load_recommendations_for!(list[:type], item) }
      end
    end

    private

    def load_recommendations_for!(type, item)
      if type == :tracks
        @user.recommendations << parse_track(item)            
      else
        browse = case type
                   when :artists then item.browse(:no_albums)
                   when :albums then item.browse
                 end
        puts "Browsing #{item.name}..."
        browse.load unless browse.loaded?
        collection = case type
                       when :artists then browse.top_hits
                       when :albums then browse.tracks
                     end
        collection.first(@load_factor).each do |track|
          @user.recommendations << parse_track(track)            
        end
      end
    end

    def parse_track(track)
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
