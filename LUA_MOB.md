LAIR's Lua-Based Configuration for Programmable Mob Behavior
============================================================

While the basics of the Map Generator are provided and now basically expect few
changes to the underlying functions, there are going to be alot of features of
the AI that will probably rapidly change. This is because we have to do one or
more of three things right now to make the AI work. We either have to

  1. Make the AI generator select basic behavior based on the tags that the map
  generation loop used to generate the mob's appearance. That's fucking racist.
  2. Make the Map generator specify random default behavior based one one more
  function it would need to support. I don't want to get back into the map
  generator yet, but it's still imperfect and this feature will probably be
  added shortly as it's the most appealing way to specify default behavior for
  the mobs. \{While writing this, I chose this solution. Here to record the fact\}
  3. Make it possible to modify the default AI behavior while the game is
  running. Basically make it possible for an entity to export "tags" of it's
  current behavioral state to influence the outcome of it's behavioral function.

Also, it might be of note that self-modifying code is indeed possible by putting
the code in a separate file and having lua do_file that code within a function.
This is not yet recommended, but it's being seriously considered.

So without further ado, LAIR AI functions.

What are AI functions
---------------------

Unlike Map functions, AI functions are not pre-defined. The dungeon designer
defines AI functions of his own in the ai.lua(or other lua file as directed) on
his or her own and decides the function that each Mobile will use at the

How AI Functions are decided per-Mobile
---------------------------------------

They are set at runtime, during the Mob Placement phase of Map Generation, by
the mob\_ai\_decide() function.

AI Function Helpers: Environment Information Gathering
------------------------------------------------------

TBD.

AI Function Hooks: Making Mobs take Actions
-------------------------------------------

Will correspond to the move functions for players, mostly.

AI Examples
-----------

TBD.

LAIR AI Library
---------------

TBD.
