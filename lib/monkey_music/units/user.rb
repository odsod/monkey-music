require 'yaml'

module MonkeyMusic
  class User < Base
    attr_accessor :toplists, :recommendations

    def initialize
      @toplists = {}
      @recommendations = @remaining_recommendations = []
    end

    def recommend!(worth)
      index = @remaining_recommendations.index do |r|
        r.multiplier == worth
      end
      if index
        @remaining_recommendations.delete_at(index)
      else
        @recommendations.find { |r| r.multiplier == worth }
      end
    end

    def dump
      YAML::dump :toplists => @toplists,
                 :recommendations => @recommendations
    end

    def load_from_file(file)
      data = YAML::load(IO.read(file))
      @toplists = data[:toplists]
      @recommendations = data[:recommendations]
      @remaining_recommendations = @recommendations
    end
    
  end
end
