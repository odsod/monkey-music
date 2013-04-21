module MonkeyMusic
  class User
    attr_reader :name
    attr_accessor :track_toplist, :album_toplist, :artist_toplist
    attr_accessor :top_decade
    attr_accessor :recommendations

    def initialize()
      @track_toplist = []
      @album_toplist = []
      @artist_toplist = []
      @recommendations = []
    end

    def serialize
      "TODO"
    end

    def load
      UserLoader.new(self).instance_eval(File.read(load_path))
    end
    
    private

    def load_path
      File.join(File.expand_path("."), "users/#{@name}.rb")
    end

  end
end
