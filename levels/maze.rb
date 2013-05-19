carrying_capacity 3
turn_limit 40
time_limit 1500

legend "M" => Monkey.player(1),
       "l" => Track.tier(1),
       "t" => Track.tier(2),
       "T" => Track.tier(3),
       "U" => User,
       "#" => Wall

layout <<EOS
t.#T#.t
#.....#
..#.#..
.##.##.
.1#U#2.
EOS
