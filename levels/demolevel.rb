carrying_capacity 3
metadata_requests_per_turn 2
max_turns 100

legend({ 
  "1" => Monkey.player(1),
  "2" => Monkey.player(2),
  "X" => Track.worth(-2),
  "x" => Track.worth(-1),
  "l" => Track.worth(1),
  "t" => Track.worth(2),
  "T" => Track.worth(3),
  "U" => User,
  "#" => Wall,
})

layout <<LAYOUT
....t..t...
.#.......#.
#..#1U2#..#
.#X.....X#.
.....t.....
LAYOUT
