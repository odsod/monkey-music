Monkey Music
============

This is the runtime for a programming contest, it's a work in progress.

To test-drive:

    ./bin/monkeymusic --user users/poscar.yaml --level levels/testlevel.rb --player-file p1 --player-name p1 --player-file p1 --player-name p2

Rules
-----

### Which monkey gets to move first?

Every round, all monkeys are put into a Fisher-Yates shuffled array, and
the monkeys will be allowed to move in order of increasing index.

Input
-----

One line with one positive integer, id, that identifies your monkey.
One line with two positive integers, w, h. The width and the 
height of the level.
h lines with w comma-separated strings each. Each string represents a
space in the level.

A space can contain the following:

A monkey, on the form M#id, the letter M followed by a hash followed by the id of a monkey.
A basket, on the form B#id, the letter B followed by a hash followed by
A track URI, on the form spotify:track:XXXXXXXXXXXXXXX.
the id of the monkey the basket belongs to.
A palm tree, on the form P.

Output
------

One of the characters ['N','W','E','S'] followed by a line-break '\n'.
