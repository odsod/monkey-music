require 'em-websocket'

module MonkeyMusic::UI
  class Browser

    def initialize(delay = 1)
      @delay = delay
      print "Using browser UI. Press the enter key to start game. "
      gets
      puts "Starting game..."
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
      sleep 1.5 # TODO: Asynchronous acknowledge that ui is ready
      puts "Websockets initialized!"
    end

    def update(level, turn = 0, turn_time = 0)
      @ws.send(level.as_json) if @ws
      sleep 1
    end

  end
end
