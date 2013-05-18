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
        :players => @level.players.map {|p| {
          :has_boost => p.has_boost,
          :remaining_time => p.remaining_time,
          :score => p.monkey.score,
          :capacity => p.monkey.capacity,
          :id => p.monkey.id,
          :name => p.monkey.name,
        }},
        :turn_limit => @level.turn_limit,
        :time_limit => @level.time_limit,
        :turn => turn,
      }.to_json) if @ws
      sleep 0.50
    end

  end
end
