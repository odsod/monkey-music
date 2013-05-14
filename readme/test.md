<img class="logo" src="documents/logo.png" />

Introduction
============

The Spotify backend is consists of a multitude of individual services.
One such service is the music recommendation service, which is responsible
for finding and recommending new tracks to Spotify users, according to their taste in music.

The music recommendation service has lately been getting some pretty negative feedback
from users. The word out on Twitter is that even monkeys could find better music recommendations!

Therefore, upper management has made an informed decision that the next version of the music recommendation
service shall be operated entirely by monkeys. As product manager for the music recommendation service, your job is to make sure that the monkeys do a good job. 

You have therefore decided to write a computer program that helps monkeys find good track recommendations for Spotify users.

This is all entirely fictional of course.
{: .tip}

Quick start
===========

To install the challenge runtime:

    > gem install monkeymusic

To get started quickly:

    > monkeymusic demo

To see something on the screen:

    > monkeymusic -p demo_player

You can probably learn a lot about the game from reading the `demo_player`.

Also make sure to read the protocol examples at the end of the document.

Metadata fields are separated by double commas! (`,,`)
{: .tip}

The level
=========

Your monkey moves around in a flat 2D level. You can think of the level as
a matrix, where any square can be occupied by one thing at any given time.

     Xl     1 U 2     lX 
    t    ll       ll    t
    ###t ########### t###
    #t # #T tlTlt T# # t#
    ##   #T#l   l#T#   ##
    #l ######X X###### l#
    ##  #   # x #   #  ##
    #T#   #t#   #t#   #T#
    #x#l##### # #####l#x#
    #   #   # l #   #   #
    ### # # # # # # # ###
    #t    #   #   #    t#
    #l###l#t#t#t#t#l###l#

Every monkey is represented in the level by a numerical id:

* *Monkey*: `\d`

Besides monkeys, the level can also contain:

* *Tracks*: `spotify:track:......................`
* *Walls*: `#`
* *The User*: `U`

Your monkey has one mission: to find and deliver suitable track 
recommendations to *The User*.

Glossary
========

Level units
-----------

Monkey `M#\d+`
: Description of a monkey and stuffs.

User
: Deliver your tracks to the User to score points!

Wall
: An obstacle. Represented by the ASCII character `#`.
