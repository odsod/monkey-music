require 'em-websocket'
require 'json'
require 'sinatra'

module MonkeyMusic
  class BrowserUI

    def initialize
      puts "Initializing webserver!"
      #get '/' do 
        #"Hello!"
      #end
      puts "Initializing websockets!"
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
    end

    def update(level)
      @ws.send(level.as_json) if @ws
      sleep 1
    end

  end
end

