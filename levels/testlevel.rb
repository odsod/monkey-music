carrying_capacity 3
turn_limit 100
time_limit 10000

legend({ 
  "1" => Monkey.player(1),
  "2" => Monkey.player(2),
  "X" => Track.tier(-2),
  "x" => Track.tier(-1),
  "l" => Track.tier(1),
  "t" => Track.tier(2),
  "T" => Track.tier(3),
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
