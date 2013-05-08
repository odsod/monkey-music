module MonkeyMusic::Metadata
  class Artist
    attr_accessor :name

    def initialize(args = {})
      @name = args[:name]
    end
    
    def serialize
      @name
    end
  end
end
