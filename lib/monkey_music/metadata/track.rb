module MonkeyMusic::Metadata
  class Track
    attr_reader :uri, :name, :artist, :album, :year, :tier, :value

    def initialize(args = {})
      @name = args[:name]
      @artist = args[:artist]
      @album = args[:album]
      @year = args[:year]
      @uri = args[:uri]
    end

    def set_value(tier, value)
      @tier = tier
      @value = value
    end
    
    def serialize
      "#{@name},#{@artist},#{@album},#{@year}"
    end
  end
end
