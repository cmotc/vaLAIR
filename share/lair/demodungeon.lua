-- The return value of this function tells the map what image to use to select
-- a list of surfaces by tag to create an entity. It's not as complicated as it
-- sounds. It just has to return an array of tags for the resource manager to
-- search for.
function map_image_decide()
        local decided_image = "wall stone"
        print "decided on" decided_image
        return decided_image
end
-- The return value of this function tells the map what image to use to select
-- a list of surfaces by tag to create an entity that is mobile.
function mob_image_decide()
        local decided_mob = "med"
        print "decided on" decided_mob
        return decided_mob
end
-- The return value of this function tells the map what sound to use to select a
-- list of sounds by tag to create an entity.
function map_sound_decide()
        local decided_sound = "step"
        print "decided on" decided_sound
        return decided_sound
end
-- The return value of this function tells the map what sound to use to select a
-- list of fonts by tag to create an entity.
function map_fonts_decide()
        local decided_font = "font"
        print "decided on" decided_font
        return decided_font
end

print loaded demodungeon.lua
