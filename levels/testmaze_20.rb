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
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
X       X X   X   l X X XT    X   X X   X
XXX X X X X XXXXXXX X X X X X XXX X X XXX
X X X X X X X X X   X X X X X     X X X X
X X XXX X X X X X X X X XXXXXXX X X X X X
X     X   X     X X X           X t X   X
XXXXX X XXX XXXXX XXX X XXX XXX X XXXXX X
X   X X X X   X         X X X X X X     X
X X X XXX X XXX   1U2   X XXX XXX XXX XXX
X X    l    X X           X     X   X   X
X X XXX X XXX X X X XXX X X X XXX XXX X X
X X X X X X         X X X   X         X X
XXXXX X XXXXX XXX XXX X XXXXXXX XXX X X X
X X X         X     X   X X       X X X X
X X X X XXX X X X XXXXX X X X X X X XXX X
X   t X   X X X X     X   X X XtX XT  X X
X XXX XXXXX XXXXXXXXXXX X X X XXXXX X X X
X   X   X   X X     X   X X X X   X X   X
X X X XXXXX X X X X XXXXXXX XXX X XXXXX X
X X X   X       X X       X     X   X   X
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
LAYOUT
