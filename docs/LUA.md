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

  * **map\_cares\_insert:()**  \[ *Returns: bool* \] This determines whether the
  map is going to bother to insert a Particle in this square whatsoever. If the
  value is false, then none of the other selection functions will be run for
  that Particle.

  * **map\_image\_decide:()**  \[ *Returns: Array of Strings* \] This determines
  whatattributes the image selected for the new particle should have. It returns
  an array of strings which corresponds to a set of tags. The tags will be
  checked against the game resources and a random image with all the tags will
  be retrieved.

  * **map\_sound\_decide:()**  \[ *Returns: Array of Strings* \] This determines
  what attributes the sound selected for the new particle should have. It
  returns an array of strings which corresponds to a set of tags. The tags will
  be checked against the game resources and a random sound with all the tags
  will be retrieved.

  * **map\_fonts\_decide:()**  \[ *Returns: Array of Strings* \] This determines
  what attributes the font selected for the new particle should have. It returns
  an array of strings which corresponds to a set of tags. The tags will be
  checked against the game resources and a random font with all the tags will be
  retrieved.

####User-Defined Lua Functions Selecting Mobile Entities

  * **mob\_cares\_insert:()**  \[ *Returns: bool* \] This determines whether the
  map is going to bother to insert a Mobile in this square whatsoever. If the
  value is false, then none of the other selection functions will be run for
  that Mobile.

  * **mob\_image\_decide:()**  \[ *Returns: Array of Strings* \] This determines
  what   attributes the image selected for the new mobile should have. It
  returns an array of strings which corresponds to a set of tags. The tags will
  be checked against the game resources and a random image with all the tags
  will be
  retrieved.

  * **mob\_sound\_decide:()**  \[ *Returns: Array of Strings* \] This determines
  what attributes the image selected for the new mobile should have. It returns
  an array of strings which corresponds to a set of tags. The tags will be
  checked against the game resources and a random image with all the tags will
  be retrieved.

  * **mob\_fonts\_decide:()**  \[ *Returns: Array of Strings* \] This determines
  what attributes the image selected for the new mobile should have. It returns
  an array of strings which corresponds to a set of tags. The tags will be
  checkedagainst the game resources and a random image with all the tags will be
  retrieved.

  * **mob\_ai\_decide:()**  \[ *Returns: String* \] This determines the function
  that will be run during the game for the generated mob's AI Input Loop. This
  determine's the mob's runtime behavior. The string it returns should
  correspond to the identifier of a function in ai.lua(Or the specified Mob ai
  file.)

These functions must be defined in your dungeon generate script in order for it
to work. If not, a common one will be used which I haven't written yet, but
it'll shoot for the bare minimum.

###Making Decisions about Particle Placement by Querying Information about the Map

Obviously you need to have some information about the map to be able to "decide"
what tiles to place where. To accomplish this, every time the loop runs LAIR
informs the Lua VM of the maps characteristics. The map generation scripts can
then query this information to decide whether they want to place a new Particle
or Mobile in a given place.

####General Information: Dungeon Generator Cursor Positon, Dimensions of Room and Floor, Coarse Count

**where\_in\_floor\_get\_x():** returns the current coarse(tile) X position of
the map generation cursor on the *whole floor*.

        function where_in_floor_get_x()
                return tonumber(generator_coarse_x.x) + tonumber(room_coarse_x.x)
        end

**where\_in\_floor\_get\_y():** returns the current coarse(tile) Y position of
the map generation cursor on the *whole floor*.

        function where_in_floor_get_y()
                return tonumber(generator_coarse_y.y) + tonumber(room_coarse_y.y)
        end

**where\_in\_room\_gen\_y():** returns the current coarse(tile) X position of
the map generation cursor on the *room containing the cursor's current*
*position*.

        function where_in_room_gen_x()
                return generator_coarse_x.x
        end

**where\_in\_room\_gen\_y():** returns the current coarse(tile) Y position of
the map generation cursor on the *room containing the cursor's current*
*position*.

        function where_in_room_gen_y()
                return generator_coarse_y.y
        end

**how\_long\_room\_gen\_w():** returns the width of the rooms in coarse(tile)
units.

        function how_long_room_gen_w()
                return generator_coarse_w.w
        end

**how\_long\_room\_gen\_h():** returns the width of the rooms in coarse(tile)
units.

        function how_long_room_gen_h()
                return generator_coarse_h.h
        end

**what\_pixel\_is\_gen\_x():** returns the current Fine(pixel) X position of the
map generation cursor on the *room containing the cursor's current position*.

        function what_pixel_is_gen_x()
                return generator_x.x
        end

**what\_pixel\_is\_gen\_y():** returns the current Fine(pixel) Y position of the
map generation cursor on the *room containing the cursor's current position*.

        function what_pixel_is_gen_y()
                return generator_y.y
        end

**where\_is\_room\_corner\_x():** returns the current Coarse(tile) X position of
the room corner on the *room containing the cursor's current*
*position*.

        function where_is_room_corner_x()
                return room_coarse_x.x
        end

**where\_is\_room\_corner\_y():** returns the current Coarse(tile) Y position of
the room corner on the *room containing the cursor's current*
*position*.

        function where_is_room_corner_y()
                return room_coarse_y.y
        end

**where\_is\_room\_farcorner\_x():** returns the current Coarse(tile) Y position
of the room far corner on the *room containing the cursor's current*
*position*.

        function where_is_room_farcorner_x()
                return room_coarse_xw.x
        end

**where\_is\_room\_farcorner\_y():** returns the current Coarse(tile) Y position
of the room far corner on the *room containing the cursor's current*
*position*.

        function where_is_room_farcorner_y()
                return room_coarse_yh.y
        end

**where\_is\_floor\_farcorner\_x():** returns the current Coarse(tile) X
position of the room far corner on the *whole floor*.

        function where_is_floor_farcorner_x()
                return floor_coarse_yh.h
        end

**where\_is\_floor\_farcorner\_y():** returns the current Coarse(tile) Y
position of the room far corner on the *whole floor*.

        function where_is_floor_farcorner_y()
                return floor_coarse_w.w
        end

**what\_pixel\_is\_room\_corner\_x():** returns the current Fine(pixel) X
position of the room corner on the *room containing the cursor's*
*current position*.

        function what_pixel_is_room_corner_x()
                return room_x.x
        end

**what\_pixel\_is\_room\_corner\_y():** returns the current Fine(pixel) Y
position of the room corner on the *room containing the cursor's*
*current position*.

        function what_pixel_is_room_corner_y()
                return room_y.y
        end

**what\_pixel\_is\_room\_farcorner\_x():** returns the current Fine(pixel) X
position of the room far corner on the *room containing the cursor's*
*current position*.

        function what_pixel_is_room_farcorner_x()
                return room_xw.x
        end

**what\_pixel\_is\_room\_farcorner\_y():** returns the current Fine(pixel) Y
position of the room far corner on the *room containing the cursor's*
*current position*.

        function what_pixel_is_room_farcorner_y()
                return room_yh.y
        end

**what\_pixel\_is\_floor\_farcorner\_x():** returns the current Fine(pixel) X
position of the floor far corner on the *room containing the cursor's*
*current position*.

        function what_pixel_is_floor_farcorner_x()
                return floor_h.h
        end

**what\_pixel\_is\_floor\_farcorner\_y():** returns the current Fine(pixel) Y
position of the floor far corner on the *room containing the cursor's*
*current position*.

        function what_pixel_is_floor_farcorner_y()
                return floor_w.w
        end

**how\_long\_room\_pixels\_w():** returns the Fine(pixel) X length of the *room*
*containing the cursor's current position*.

        function how_long_room_pixels_w()
                return generator_w.w
        end

**how\_long\_room\_pixels\_h():** returns the Fine(pixel) Y length of the *room*
*containing the cursor's current position*.

        function how_long_room_pixels_h()
                return generator_h.h
        end

**how\_many\_particles\_so\_far():** returns the total count of particles already
placed in the *room containing the cursor's current position*.

        function how_many_particles_so_far()
                return generator_particle_count.c
        end

**how\_many\_mobiles\_so\_far():** returns the total count of particles already
placed in the *room containing the cursor's current position*.

        function how_many_mobiles_so_far()
                return generator_mobile_count.c
        end

####Dynamic Variables Exported to Global Scope in Lua From Vala During Map Generation

During map generation, Vala also keeps a running list of the tags associated
with the entities in all the rooms on a per-room basis. This list is then
exported along with the numeric prevalence of the tag. This allows you to
retrieve stats about what the room contains from Lua in greater detail and grow
a more balanced dungeon. These are all created as Table entries with a default
field "*c*" containing a running count of the tag's prevalence.

Retrieving these values safely without stopping the Lua interpreter requires
first checking if they are *nil*. An invalid script will result in an empty or
malfunctioning dungeon. To help keep this from happening, I recommend using
the accessor functions

**get\_tag\_count():** checks for the existence of a table and if it exists,
returns it, otherwise, returns entry "*c*," for count.

        function get_tag_count(variable)
                if type(variable) == "table" then
                        return variable.c
                else
                        return 0
                end
        end

**get\_tag\_table():** checks for the existence of a table and if it exists,
returns it, otherwise, returns zero.

        function get_tag_table(variable)
                if type(variable) == "table" then
                        return variable
                else
                        return 0
                end
        end

####Tile-Specific Data Retrieval Functions

  * **particle\_index\_byxy(x, y):** Returns the tags of the particle who's
  corner is at fine x, y as a long, space-delimited string.

  * **particle\_coarse\_index\_byxy(x, y):** Returns the tags of the particle
  who's corner is at coarse x, y as a long, space-delimited string.

  * **is\_blocked\_particle\_here()** Detects if there is or is not a particle
  at the current location of the map generation cursor.

  * **mobile\_index\_byxy(x, y):** Returns the tags of the mobile who's corner
  is at fine x, y as a long, space-delimited string.

  * **mobile\_coarse\_index\_byxy(x, y):** Returns the tags of the mobile who's
  corner is at coarse x, y as a long, space-delimited string.

  * **is\_blocked\_mobile\_here()** Detects if there is or is not a particle
  at the current location of the map generation cursor.

##### \*Why Tables?

I'd like to say I planned this or even that I think it's inherently the best
way, but neither of those things are true. I think it's an acceptable way, and
that it might be useful to add things on to the tables for each variable while
the dungeon is being generated.

Building Upon the Basic Functions Effectively
---------------------------------------------

In order to create re-usable code chunks which can help produce better maps
faster, some basic patterns should be followed. It is possible to write your
own functions, in your own external files, to influence the output of the
dungeon generator scripts in any complex way you want as long as it's possible
to accomplish with Lua.

###Example Function: Build a Thick Wall around the Outside of the Floor

First thing to notice is that the functions usually take an optional argument.
This optional argument is the running result of the parent decision function.
If the argument isn't provided, have the result default to "false."

        function thinwall_cares_insert(vari)
                if type(vari) == "string" then
                        decided_to = vari
                else
                        decided_to = "false"
                end

Because the coordinates of the tiles start at 0 and not 1, when the cursor is
at less than 1 we draw a wall.

                if where_in_floor_get_x() < 1 then
                        decided_to="true"
                end
                if where_in_floor_get_y() < 1 then
                        decided_to="true"
                end

And again, because we count from zero, to get a wall of thickness 1 on the far
side we test if we are greater than farcorner - 2.

                if where_in_floor_get_x() > where_is_floor_farcorner_x() - 2 then
                        decided_to="true"
                end
                if where_in_floor_get_y() > where_is_floor_farcorner_y() - 2 then
                        decided_to="true"
                end

Finally, return the result.

                return decided_to
        end

By doing this, you can declare a single variable in your map\_cares\_insert
function and transform it by repeatedly feeding it to functions like this.

        function map_cares_insert()
                result = thickwall_cares_insert()
                result = cut_hallways(result)
                result = thinwall_cares_insert(result)
                return result
        end

This map\_cares\_insert function in the share/lair/demo/dungeon.lua file creates
a thick border, then textures it, then seals the walls with a thin border, while
leaving a vast empty space between. Minimal demo map achieved.

Current Limitations
-------------------

Because the map generator currently works from left to right, then from top to
bottom, and because by definition all the information that the map can recieve
has to come from entities that the map has already initialized, there is bias
inherent in how the maps are generated. This issue will be solved shortly by
having 2 Map Generation loops for structural elements. This will make it easier
to create things like hidden treasures and decorated walls and allow reductive
map generation, which will aid in generating Mazes.

I still haven't done the Lua configuration for AI controlled entities. That's
changing slowly, it's not something I want to do too fast.
