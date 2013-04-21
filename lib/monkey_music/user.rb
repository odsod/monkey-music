require 'yaml'

module MonkeyMusic
  class User
    attr_reader :name
    attr_accessor :track_toplist, :album_toplist, :artist_toplist
    attr_accessor :top_decade
    attr_accessor :recommendations

    def initialize(name)
      @name = name
      @track_toplist = []
      @album_toplist = []
      @artist_toplist = []
      @recommendations = []
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
