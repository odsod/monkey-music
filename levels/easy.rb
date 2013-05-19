carrying_capacity 4
turn_limit 10
time_limit 1500
boost_cooldown 5

legend "1" => Monkey.player(1),
       "2" => Monkey.player(2), 
       "l" => Track.tier(1),
       "t" => Track.tier(2),
       "T" => Track.tier(3),
       "U" => User,
       "#" => Wall

layout <<EOS
...T...
.......
...1...
.......
...U...
EOS
