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
})

layout <<LAYOUT
XXXXXXXXXXXXXXXXXXXXXXXXXUXXXXXXXXXXXXXXX
X X X     X   X X   X    1 2  X X     X X
X X X XXX XXX X X XXXXXXX X X X XXXXX X X
X   X X     X   X X X   X X X       X   X
X X XXX XXX XXX X X X XXX X XXXXXXXXX X X
X X X X X X X X         X X   X   X   X X
XXX X X X XXX X XXX XXXXX X X X X XXX X X
X X    t      X X   X       X   X X X X X
X X XXXXXXXXX XXX XXXXXXX XXX XXX X X X X
X   X   X         X X X   X   X     X X X
XXX X X X X XXXXX X X X XXX X XXX X XXX X
X X   X X X X X   X X     X X X X X     X
X XXX X XXXXX X X X X   X X X X XXXXXXX X
X     X   X   X X       X X X X   X   X X
XXXXXXXXX X XXX XXXXXXXXX XXX X X XXX XXX
X   X  lX       X   X X X T X X X     X X
X XXX X X X X XXX X X X X XXX X XXX XXX X
X     X X X X X   X   X X X X   X X   X X
XXX XXX X XXXXXXX X XXX X X XXX X X XXX X
X  T  X           Xt            X      tX
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
LAYOUT
