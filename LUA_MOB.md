LAIR's Lua-Based Configuration for Programmable Mob Behavior
============================================================

How to get Information from the Mob's Point of View
---------------------------------------------------

Every time an event occurs, the mob checks a nearby area for things it needs to
be aware of, and it "notices" some details about them by putting them into a
long list of strings and then making those strings accessible in the "vision"
global lua table. Each mob has it's own vision table and the vision table
changes periodically. The vision table contains all the information about the
entity's surroundings that it can use to make decisions. The table can be
accessed numerically. It's length is accessible at vision\_length.l or with the
function get\_vision\_length(). Each member can then be searched for information
about the mob's surroundings and the ai script can use it to make decisions.

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
