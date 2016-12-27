-- The return value of this function tells the map what image to use to select
-- a list of surfaces by tag to create an entity. It's not as complicated as it
-- sounds. It just has to return an array of tags for the resource manager to
-- search for.
function map_image_decide()
        return "stonewall"
end
-- The return value of this function tells the map what image to use to select
-- a list of surfaces by tag to create an entity that is mobile.
function map_image_decide()
        return "human"
end
-- The return value of this function tells the map what sound to use to select a
-- list of sounds by tag to create an entity.
function map_sound_decide()
end
-- The return value of this function tells the map what sound to use to select a
-- list of fonts by tag to create an entity.
function map_fonts_decide()
end
