module MonkeyMusic
  class UserLoader
    attr_reader :toplists

    def initialize(file)
      @file = file
      @toplists = {}
    end

    def load!
      self.instance_eval(@file)
    end

    private

    def toplist(type, uri)
      @toplists[type] = uri
    end
  end
end
