--
dofile("/usr/share/lair/lua/common.lua")
dofile("/usr/share/lair/lua/map/basicwall_cares_insert.lua")
dofile("/usr/share/lair/lua/map/cut_hallways.lua")

--The return value of this function tells the map whether it should place a new
--particle at all.

function map_cares_insert()
        reload_map()
        particle_index_byxy(0, 0)
        result = thickwall_cares_insert()
        result = cut_hallways(result)
        result = thinwall_cares_insert(result)
        return result
end
-- The return value of this function tells the map what image to use to select
-- a list of surfaces by tag to create an entity. It's not as complicated as it
-- sounds. It just has to return an array of tags for the resource manager to
-- search for.
function map_image_decide()
        local decided_image = "wall stone"
        return decided_image
end
-- The return value of this function tells the map what sound to use to select a
-- list of sounds by tag to create an entity.
function map_sound_decide()
        local decided_sound = "footsteps"
        return decided_sound
end
-- The return value of this function tells the map what font to use to select a
-- list of fonts by tag to create an entity.
function map_fonts_decide()
        local decided_font = "font"
        return decided_font
end

--The return value of this function tells the map whether it should place a new
--mobile at all.
function mob_cares_insert()
        local decided_to = "false"
        return decided_to
end
-- The return value of this function tells the map what image to use to select
-- a list of surfaces by tag to create an entity that is mobile.
function mob_image_decide()
        local decided_mob_image = "med"
        return decided_mob_image
end
-- The return value of this function tells the map what sound to use to select
-- a list of sound by tag to create an entity that is mobile.
function mob_sound_decide()
        local decided_mob_sound = "footsteps"
        return decided_mob_sound
end
-- The return value of this function tells the map what font to use to select
-- a list of fonts by tag to create an entity that is mobile.
function mob_fonts_decide()
        local decided_mob_font = "font"
        return decided_mob_font
end
