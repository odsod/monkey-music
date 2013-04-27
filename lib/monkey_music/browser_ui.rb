require 'em-websocket'
require 'json'

module MonkeyMusic
  class BrowserUI

    def initialize
      puts "Initializing websockets!"
      Thread.new {
        EM.run {
          EM::WebSocket.run(:host => "0.0.0.0", :port => 3000) do |ws|
            puts "Listening on websockets!"
            @ws = ws
            ws.onopen do |handshake|
              puts "WebSocket connection open!"
            end

            ws.onclose do
              puts "Connection closed!" 
            end

            ws.onmessage do |msg|
              puts "Received message: #{msg}"
              ws.send "Hello!"
            end
          end
        }
      }
    end

    def update(level)
      puts level.as_json
      @ws.send(level.as_json) if @ws
      sleep 1
    end

  end
end

