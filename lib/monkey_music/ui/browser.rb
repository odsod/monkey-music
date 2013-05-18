require 'em-websocket'

module MonkeyMusic::UI
  class Browser

    def initialize(delay, level)
      @delay = delay
      puts "Initializing websockets..."
      Thread.new {
        EM.run {
          EM::WebSocket.run(:host => "0.0.0.0", :port => 3000) do |ws|
            @ws = ws
            ws.onopen do |handshake|
              ws.send(level.as_json)
            end

            ws.onclose do
            end

            ws.onmessage do |msg|
            end
          end
        }
      }
      print "Using browser UI. Press the enter key to start game. "
      gets
      puts "Starting game..."
      puts "Game started!"
    end

    def update(level, turn = 0, turn_time = 0)
      @ws.send(level.as_json) if @ws
      sleep 0.50
    end

  end
end
