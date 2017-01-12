LAIR's Lua-Based Configuration for Level Generation
===================================================

LAIR is scriptable in several ways in order to facilitate it's ability to do
Procedural Content Generation.

Terminology:
------------

  * Floor: Floor is a synonym for Map as Map is used in this document. In the
  Vala code, a Map is always referred to as a Floor, and a stack of Maps is
  always referred to as a Tower. Each is basically a layer of syntactic sugar
  for manipulating the smaller data structure.

  * Room: Rooms are organized units of Particles and Mobiles. Each room has
  retrievable properties and has

  * Entity: Entity is an organized unit of data(it's a type) that corresponds to
  the minimum interactable unit of content. A single floor tile is a single
  Entity, as is a single wall, as is a single monster and the player itself. All
  the direct interaction in the game is done strictly on an entity->entity
  basis.

  * Particle: A particle is an entity which never has any effect on another
  entity UNLESS that effect is to trigger a non-damaging collision. In essence,
  an otherwise benign wall is always a particle. It's still the same kind of
  entity, but since these types of entities will be A) Commonplace, and
  B) Guaranteed to never do *most* of the things other entities will sometimes
  do, it makes sense to skip alot of steps when they take their turns.

  * Mobile: A mobile is an entity which is interactive in some way or another.
  It might be damaging to the player if it is touched, it might be possible to
  add to your player's inventory, it might be able to converse eventually.


Map Configuration:
------------------

###The Map Generation Loop

LAIR's maps are made of "Rooms" and "Particles." Rooms have fixed dimensions,
for instance, 480 pixels by 480 pixels(which is wequivalent to 15 tiles in-game)
but they don't necessarily have walls or any other features at all until they
are filled with particles. Particles are a list of "Entities" which correspond
to features of the environment like walls and surfaces, whereas Mobiles are
entities that do more interesting things(Technically this is an arbitrary
distinction, but there are alot of things walls and surfaces will never do that
other entities will so it makes sense to skip some checks on Particles). The
list of particles is generated at the start of the game by looping over all the
possible particle positions and making a decision about what to put there by
calling functions contained in Lua scripts. In order to generate a dungeon,
a dungeon generation script must contain the following 8 functions.

####User-Defined Lua Functions Selecting Particle Entities

  * **map\_cares\_insert()** : \[ *Returns: bool* \] This determines whether the map
  is going to bother to insert a Particle in this square whatsoever. If the
  value is false, then none of the other selection functions will be run for
  that Particle.
  * **map\_image\_decide()** : \[ *Returns: Array of Strings* \] This determines what
  attributes the image selected for the new particle should have. It returns an
  array of strings which corresponds to a set of tags. The tags will be checked
  against the game resources and a random image with all the tags will be
  retrieved.
  * **map\_sound\_decide()** : \[ *Returns: Array of Strings* \] This determines what
  attributes the sound selected for the new particle should have. It returns an
  array of strings which corresponds to a set of tags. The tags will be checked
  against the game resources and a random sound with all the tags will be
  retrieved.
  * **map\_fonts\_decide()** : \[ *Returns: Array of Strings* \] This determines what
  attributes the font selected for the new particle should have. It returns an
  array of strings which corresponds to a set of tags. The tags will be checked
  against the game resources and a random font with all the tags will be
  retrieved.

####User-Defined Lua Functions Selecting Mobile Entities

  * **mob\_cares\_insert()** : \[ *Returns: bool* \] This determines whether the map
  is going to bother to insert a Mobile in this square whatsoever. If the value
  is false, then none of the other selection functions will be run for that
  Mobile.
  * **mob\_image\_decide()** : \[ *Returns: Array of Strings* \] This determines what
  attributes the image selected for the new mobile should have. It returns an
  array of strings which corresponds to a set of tags. The tags will be checked
  against the game resources and a random image with all the tags will be
  retrieved.
  * **mob\_sound\_decide()** : \[ *Returns: Array of Strings* \] This determines what
  attributes the image selected for the new mobile should have. It returns an
  array of strings which corresponds to a set of tags. The tags will be checked
  against the game resources and a random image with all the tags will be
  retrieved.
  * **mob\_fonts\_decide()** : \[ *Returns: Array of Strings* \] This determines what
  attributes the image selected for the new mobile should have. It returns an
  array of strings which corresponds to a set of tags. The tags will be checked
  against the game resources and a random image with all the tags will be
  retrieved.

These functions must be defined in your dungeon generate script in order for it
to work. If not, a common one will be used which I haven't written yet, but
it'll shoot for the bare minimum.

###Making Decisions about Particle Placement by Querying Information about the Map

Obviously you need to have some information about the map to be able to "decide"
what tiles to place where. To accomplish this, every time the loop runs LAIR
informs the Lua VM of the maps characteristics. The map generation scripts can
then query this information to decide whether they want to place a


####General Information: Dungeon Generator Cursor Positon, Dimensions of Room and Floor, Coarse Count



####Dynamic Variables Exported to Global Scope in Lua From Vala During Map Generation

During map generation, Vala also keeps a running list of the tags associated
with the entities in all the rooms on a per-room basis. This list is then
exported along with the numeric prevalence of the tag.

####Why Tables?

I'd like to say I planned this or even that I think it's inherently the best
way, but neither of those things are true. I think it's an acceptable way, and
that it might be useful to add things on to the tables for each variable

###Vala Functions registered with Lua for Map Generation

Besides that, you need to be able to retrieve different types of information
from the map in order to control which results your decider functions feed to
the map generator. Damn I'm bad at explaining this, but I promise it works.
Maybe it'll get better when I've written the first example. These functions are
used to retrieve information from the map about it's properties and the
properties associated with specific areas and tags. Probably more things as I
think of them. These don't work yet but once they do all the remaining map
generation helpers will be placed in common.lua.

  * particle\_index\_byxy :
  * mobile\_index\_byxy :

Current Limitations
-------------------

Obviously, the programming interface isn't really finished yet.

Because the map generator currently works from left to right, then from top to
bottom, and because by definition all the information that the map can recieve
has to come from entities that the map has already initialized, there is bias
inherent in how the maps are generated. This can be solved, but it might not get
solved for a little while because I want a prototype and that issue is fairly
isolated.

I still haven't done the Lua configuration for AI controlled entities.

I still haven't decided whether I'll be using Lua to script how player
characters are generated.
