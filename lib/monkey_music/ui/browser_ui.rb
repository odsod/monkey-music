require 'em-websocket'
require 'json'
require 'rack'

module MonkeyMusic
  class BrowserUI

    def initialize(delay = 1)
      @delay = delay
      puts "Initializing websockets..."
      Thread.new {
        EM.run {
          EM::WebSocket.run(:host => "0.0.0.0", :port => 3000) do |ws|
            @ws = ws
            ws.onopen do |handshake|
            end

            ws.onclose do
            end

            ws.onmessage do |msg|
            end
          end
        }
      }
      sleep 1 # TODO: Asynchronous acknowledge that ui is ready
      puts "Websockets initialized!"
    end

    def update(level, query_time = 0)
      @ws.send(level.as_json) if @ws
      sleep 1
    end

  end
end
