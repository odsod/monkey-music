require 'yaml'

module MonkeyMusic
  class User
    attr_reader :name
    attr_accessor :toplists, :recommendations

    def initialize(name)
      @name = name
      @toplists = {}
      @recommendations = []
    end

    def serialize
      YAML::dump(self)
    end

    def self.read_from_file(file)
      YAML::load(IO.read(file))
    end
    
  end
end
