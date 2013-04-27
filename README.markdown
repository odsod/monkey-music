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
