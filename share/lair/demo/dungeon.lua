--
dofile("/usr/share/lair/lua/common.lua")

--
function map_cares_insert()
        local decided_to = "false"
        print_general_props()
        if where_in_room_gen_x() < 3 then
                decided_to="true"
        elseif where_in_room_gen_x() > (where_is_room_farcorner_x()- 3) then
                decided_to="true"
        end
        if where_in_room_gen_y() < 3 then
                decided_to="true"
        elseif where_in_room_gen_y() > (where_is_room_farcorner_x() - 3) then
                decided_to="true"
        end
        if where_in_room_gen_x() > 5 then
                if where_in_room_gen_x() < 9 then
                        print("x " .. where_in_room_gen_x() .. " " .. 5 .. " " .. 9)
                        decided_to="false"
                end
        end
        if where_in_room_gen_y() > 5 then
                if where_in_room_gen_y() < 9 then
                        print("y " .. where_in_room_gen_y() .. " " .. 5 .. " " .. 9)
                        decided_to="false"
                end
        end

        if where_in_floor_get_x() < 2 then
                if where_is_room_corner_x() == 0 then
                        decided_to="true"
                end
        end
        if where_in_floor_get_y() < 2 then
                if where_is_room_corner_y() == 0 then
                        decided_to="true"
                end
        end
        return decided_to
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
        local decided_sound = "step"
        return decided_sound
end
-- The return value of this function tells the map what font to use to select a
-- list of fonts by tag to create an entity.
function map_fonts_decide()
        local decided_font = "font"
        return decided_font
end

--
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
        local decided_mob_sound = "step"
        return decided_mob_sound
end
-- The return value of this function tells the map what font to use to select
-- a list of fonts by tag to create an entity that is mobile.
function mob_fonts_decide()
        local decided_mob_font = "font"
        return decided_mob_font
end
