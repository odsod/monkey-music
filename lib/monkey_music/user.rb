module MonkeyMusic
  class User
    #attr_accessor :favorite_albums, :favorite_tracks, :favorite_artists, :region, :age

    def initialize(name)
      @name = name
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
