# In this level, the monkeys ability to navigate a maze and pick
# the best out of many tracks is tested. Do not choose poorly...

width 20
height 10
capacity 1

legend({
  "T" => Tube,
  "M" => Monkey,
  "s" => Track,
  "#" => Wall,
})

layout <<EOS
T..#.....#.....#...s
...#..#..#..#..#...s
.M.#..#..#..#..#...s
...#..#..#..#..#...s
......#.....#......s
EOS
