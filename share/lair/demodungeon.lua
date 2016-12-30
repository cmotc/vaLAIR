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
        local decided_sound = "step"
        return decided_sound
end
-- The return value of this function tells the map what font to use to select a
-- list of fonts by tag to create an entity.
function map_fonts_decide()
        local decided_font = "font"
        return decided_font
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
        local decided_mob_sound = "step"
        return decided_mob_sound
end
-- The return value of this function tells the map what font to use to select
-- a list of fonts by tag to create an entity that is mobile.
function mob_fonts_decide()
        local decided_mob_font = "font"
        return decided_mob_font
end

return "loaded demodungeon.lua"
