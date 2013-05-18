require 'em-websocket'

module MonkeyMusic::UI
  class Browser

    def initialize(level, players, delay)
      @delay = delay
      @players = players
      @level = level
      puts "Initializing websockets..."
      Thread.new {
        EM.run {
          EM::WebSocket.run(:host => "0.0.0.0", :port => 3000) do |ws|
            @ws = ws
            ws.onopen { update }
          end
        }
      }
      print "Using browser UI. Press the enter key to start game. "
      gets
      puts "Starting game..."
      puts "Game started!"
    end

    def update(turn = 0, turn_time = 0)
      @ws.send({
        :width => @level.width,
        :height => @level.height,
        :units => @level.units,
        :turn_limit => @level.turn_limit,
        :time_limit => @level.time_limit,
        :turn => turn,
      }.to_json) if @ws
      sleep 0.50
    end

  end
end
