module MonkeyMusic
  class UI
    class << self
      def puts(msg)
        Config.out_stream.puts(msg) if Config.out_stream
      end
      
      def puts_with_delay(msg)
        result = puts(msg)
        sleep(Config.delay) if Config.delay
        result
      end
      
      def print(msg)
        Config.out_stream.print(msg) if Config.out_stream
      end
      
      def gets
        Config.in_stream ? Config.in_stream.gets : ''
      end
      
      def request(msg)
        print(msg)
        gets.chomp
      end
      
      def ask(msg)
        request("#{msg} [yn] ") == 'y'
      end
      
    end
  end
end
