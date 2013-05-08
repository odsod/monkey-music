module MonkeyMusic::Metadata
  class Album
    attr_reader :name, :artist, :year

    def initialize(args = {})
      @name = args[:name]
      @artist = args[:artist]
      @year = args[:year]
    end
    
    def serialize
      "#{@name},#{@artist},#{@album},#{@year}"
    end
  end
end
