module MonkeyMusic
  class ToplistLoader
    attr_reader :toplists

    def initialize(file)
      @file = file
      @toplists = {}
    end

    def load!
      self.instance_eval(@file)
    end

    private

    def toplist(type, items)
      @toplists[type] = []
      items.each do |name, uri|
        @toplists[type] << uri
      end
    end

  end
end
