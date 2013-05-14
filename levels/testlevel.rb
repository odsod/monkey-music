carrying_capacity 3
turn_limit 100
time_limit 10000

legend({ 
  "1" => Monkey.player(1),
  "2" => Monkey.player(2),
  "X" => Track.worth(-2),
  "x" => Track.worth(-1),
  "l" => Track.worth(1),
  "t" => Track.worth(2),
  "T" => Track.worth(3),
  "U" => User,
  "W" => Wall,
})

layout <<LAYOUT
...........
.WW.....WW.
.Wx.....xW.
.......T...
1..........
...t......U
2..........
.......l...
.WX.....xW.
.WW.....WW.
...........
LAYOUT
