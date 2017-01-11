math.randomseed(os.time())

function lua_get_x()
        return tonumber(generator_coarse_x.x) + tonumber(room_coarse_x.x)
end

function lua_get_y()
        return tonumber(generator_coarse_y.y) + tonumber(room_coarse_y.y)
end

function get_tag_count(variable)
        if type(variable) == "table" then
                return variable.c
        else
                return "0"
        end
end

function print_tag_count(variable)
        if type(variable) == "table" then
                print("  Generator " .. tostring(variable) .. " Particle Count: " .. get_tag_count(variable))
        else
                return "0"
        end
end


function print_props()
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
end
