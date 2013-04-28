require 'yaml'

module MonkeyMusic
  class User
    attr_reader :name
    attr_accessor :track_toplist, :album_toplist, :artist_toplist, 
      :top_decade, :recommendations, :disliked_artists

    def initialize(name)
      @name = name
      @track_toplist = []
      @album_toplist = []
      @artist_toplist = []
      @recommendations = []
      @disliked_artists = []
    end

    def serialize
      YAML::dump(self)
    end

    def self.read_from_file(file)
      YAML::load(IO.read(file))
    end
    
    private

    def load_path
      File.join(File.expand_path("."), "users/#{@name}.rb")
    end

  end
end
