--
dofile("/usr/share/lair/lua/common.lua")

--
function map_cares_insert()
        local decided_to = "false"
        print("  Generator is at Coarse X: " .. generator_coarse_x.x .. " in the room")
        print("  Generator is at Coarse Y: " .. generator_coarse_y.y .. " in the room")
        print("  Generator is at Coarse X: " .. lua_get_x() .. " on the floor")
	print("  Generator is at Coarse Y: " .. lua_get_y() .." on the floor")
        print("  Generator Segment Coarse Width: " .. generator_coarse_w.w)
	print("  Generator Segment Coarse Height: " .. generator_coarse_h.h)
	print("  Generator is at X: " .. generator_x.x)
	print("  Generator is at Y: " .. generator_y.y)
        print("  Segment Starts at Coarse X: " .. room_coarse_x.x)
	print("  Segment Starts at Coarse Y: " .. room_coarse_y.y)
        print("  Segment Ends at Coarse X+Width: " .. room_coarse_xw.x)
	print("  Segment Ends at Coarse Y+Height: " .. room_coarse_yh.y)
        print("  Segment Starts at X: " .. room_x.x)
	print("  Segment Starts at Y: " .. room_y.y)
        print("  Segment Ends at X+Width: " .. room_xw.x)
	print("  Segment Ends at Y+Height: " .. room_yh.y)
        print("  Generator Segment Height: " .. generator_w.w)
	print("  Generator Segment Width: " .. generator_h.h)
        print("  Generator Particle Count: " .. generator_particle_count.c)
	print("  Generator Mobile Count: " .. generator_mobile_count.c)
        if type(wall) == "table" then
                print("  Generator Wall Particle Count: " .. wall.c)
        end
        --print("  Generator Particle Count: " .. generator_particle_count.c)
        if generator_coarse_x.x < 3 then
                if generator_coarse_x.x < 7 then
                        decided_to="true";
                elseif generator_coarse_x.x > 8 then
                        decided_to="true";
                end
        elseif generator_coarse_x.x > generator_coarse_w.w - 3 then
                if generator_coarse_x.x < 7 then
                        decided_to="true";
                elseif generator_coarse_x.x > 8 then
                        decided_to="true";
                end
        elseif generator_coarse_y.y < 3 then
                if generator_coarse_y.y < 7 then
                        decided_to="true";
                elseif generator_coarse_y.y > 8 then
                        decided_to="true";
                end
        elseif generator_coarse_y.y > generator_coarse_h.h - 3 then
                if generator_coarse_y.y < 7 then
                        decided_to="true";
                elseif generator_coarse_y.y > 8 then
                        decided_to="true";
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
