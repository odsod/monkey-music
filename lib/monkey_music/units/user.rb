require 'yaml'

module MonkeyMusic
  class User < Base
    attr_accessor :toplists, :recommendations

    def initialize(name)
      @toplists = {}
      @recommendations = []
    end

    def serialize
      YAML::dump({
        :toplists => @toplists,
        :recommendations => @recommendations
      })
    end

    def load_from_file(file)
      data = YAML::load(IO.read(file))
      @toplists = data[:toplists]
      @recommendations = data[:recommendations]
    end
    
  end
end
