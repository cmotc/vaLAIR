-- The return value of this function tells the map what image to use to select
-- a list of surfaces by tag to create an entity. It's not as complicated as it
-- sounds. It just has to return an array of tags for the resource manager to
-- search for.
decided_image = nil
function map_image_decide()
        decided_image = "wall"
        return decided_image
end
-- The return value of this function tells the map what image to use to select
-- a list of surfaces by tag to create an entity that is mobile.
decided_mob = nil
function mob_image_decide()
        decided_mob = human
        return decided_mob
end
-- The return value of this function tells the map what sound to use to select a
-- list of sounds by tag to create an entity.
decided_sound = nil
function map_sound_decide()
        decided_sound = "step"
        return decided_sound
end
-- The return value of this function tells the map what sound to use to select a
-- list of fonts by tag to create an entity.
decided_font = nil
function map_fonts_decide()
        decided_font = "font"
        return decided_font
end

map_image_decide()
