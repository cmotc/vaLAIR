LAIR!
=====

LAIR! is a rogue-like dungeon crawling game that draws it's influences primarily
from the classic 2D Legend of Zelda games(Gameplay), Teleglitch: Die More
Edition(Aesthetically), Borderlands(Mechanically), and MMORPG's. It's been
something I've been developing for a long time, and I'll probably never consider
it truly done, but it's abou time I start documenting how to actually play it
now that I'm going to have a version in a week or two.

Installation
------------

It's getting there. I keep fiddling about with it and it's a little
transitional. That said, somebody with all the dependencies can build it on
Linux and probably other unixes and start playing with it for now. It's just
a makefile now, just running "Make" in the working directory will build the
executable in the ./bin/ directory. Then there's art and the configuration files
to install, which are in the [art repository](https://github.com/cmotc/lairart),
which you can install with make; sudo make install.

Configuration(You probably don't need to read this unless you want to mod)
--------------------------------------------------------------------------

Configuration is done with plain text files and a shell-script based launcher
for the actual binary /usr/bin/LAIR. You can hypothetically use the launcher
to combine multiple configuration files together and expand the content of the
game. Examples forthcoming, but if you've ever used sources.list.d you know
what I'm about.

As far as the actual configuration files go, it's pretty simple. Here's an
example line.

        "Path to a file containing a resource"    "Name"    "List of tags"
        /usr/share/lair/stonewall/stonewall-1.png stonewall wall stone

The first part is obviously a path to a png file. Followed by a space, the first
word following the path is the name of the file. The name is also the first tag
that can be used to produce a random tile from a specific category with the game
engine, or it can be used to retrieve a specific tile with the game engine. So
the first tag, the name, should be unique, and the remaining tags could be
non-unique. For more example configuration files, see the [art repository](https://github.com/cmotc/lairart).

How it works
------------

The game considers every piece of content to be the same type of in-game object.
They all have exactly the same attributes and all the same things can happen to
each of them. The only difference between the player and the other entities is
that the player's movement is controlled by a person and not by a scripted
routine. Inside the entities, there are scripts that control what actions the
entity takes depending on feedback from it's environment. That's mostly the
unfinished part, that and networking, and I need to create some new/better
template art, then it's going to be done. Yay.

History(Feels a little self-aggrandizing)
-----------------------------------------

It seems like there's a certain percentage of people who play video games in
their youth that, while they enjoy experiencing the medium, are doomed to
dissatisfaction as the video game that they truly want to play does not exist,
and is not likely to. The idea that is in the process of becoming LAIR! began
as that feeling for me, and like many people, this inspired me to learn how to
program computers. When I started the first version of LAIR it was doomed, I was
writing it in Visual Basic .NET while I took a VB6 class that used a VB4 book
from a teacher who had never successfully compiled a program. That version
didn't get much further than a character generator and a turn-based rules
executive that matched players and enemies and determined a winner based
entirely on stats and random rolls. It didn't even have a graphical
representation of the player. Then I went to my local library, which had exactly
one programming book(I learned why a little later, and it's creepy) which
focused on QBasic, which of course, nobody had at the time because QBasic had
long since been supplanted by the Visual Studio shit. However, I did eventually
get [FreeBASIC](https://www.freebasic.net) to run on my PC, and I produced the
first recognizable version of the game which played alot like Zelda classic.
However, this version didn't have much ability to be scripted and configured at
runtime. I clung to this version for a long time, and there's probably a version
out there on the web someplace, but eventually I grew up and re-wrote it again
in C++ and Lua, and it was pretty good. Actually, it was nearly complete, all I
needed was art, and I had a buddy who was working with me on that, but life
happens and we parted ways, and LAIR! was placed on hold again. Then I
discovered Vala and started being productive(Go too). But it looked like Vala
was the perfect game development language for me to do LAIR! in and so I slowly
started re-writing it while I considered how I would fix my art problem. That's
why I created a little helper program in Go called digitalAndy, and fortunately
for digitalAndy and LAIR!'s development, digitalAndy doesn't have a penis. Lol
just kidding homie. I mean, it really doesn't have a penis but your whole
[Spicy McHaggis](https://www.youtube.com/watch?v=_ZN3weW1udE) thing is something
I look back on fondly. But seriously, LAIR! version 5ish, a.k.a. VaLaIR, is the
result of all the successful features of 4 previous versions, and a few insights
that were forced upon me by the realities of my ability to produce pixel art.
Looking forward to a version by the new year.
