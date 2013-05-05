require 'em-websocket'
require 'json'
require 'rack'

module MonkeyMusic
  class BrowserUI

    def initialize(delay)
      @delay = delay || 1
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

    def update(level)
      @ws.send(level.as_json) if @ws
      sleep @delay
    end

  end
end
