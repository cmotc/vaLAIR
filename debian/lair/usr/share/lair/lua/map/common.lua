math.randomseed(os.time())


function greater_than(aa, bb)
        if aa > bb then
                print(" " .. aa .. " is greater than " .. bb )
                return true
        else
                print(" " .. aa .. " is not greater than " .. bb .. " " )
                return false
        end
end
function lesser_than(aa, bb)
        if aa < bb then
                print(" " .. aa .. " is lesser than " .. bb .. " " )
                return true
        else
                print(" " .. aa .. " is not lesser than " .. bb .. " " )
                return false
        end
end
function get_tag_count(variable)
        if type(variable) == "table" then
                return variable.c
        else
                return 0
        end
end
function get_tag_table(variable)
        if type(variable) == "table" then
                return variable
        else
                return 0
        end
end
function where_in_floor_get_x()
        print(" " .. (tonumber(generator_coarse_x.x) + tonumber(room_coarse_x.x)) )
        return tonumber(generator_coarse_x.x) + tonumber(room_coarse_x.x)
end
function where_in_floor_get_y()
        print(" " .. (tonumber(generator_coarse_y.y) + tonumber(room_coarse_y.y)) )
        return tonumber(generator_coarse_y.y) + tonumber(room_coarse_y.y)
end
function where_in_floor_get_x_bare()
        return tonumber(generator_coarse_x.x) + tonumber(room_coarse_x.x)
end
function where_in_floor_get_y_bare()
        return tonumber(generator_coarse_y.y) + tonumber(room_coarse_y.y)
end
function where_in_room_gen_x()
        print(" " .. generator_coarse_x.x )
        return generator_coarse_x.x
end
function where_in_room_gen_y()
        print(" " .. generator_coarse_y.y )
        return generator_coarse_y.y
end
function how_long_room_gen_w()
        print(" " .. generator_coarse_w.w)
        return generator_coarse_w.w
end
function how_long_room_gen_h()
        print(" " .. generator_coarse_h.h)
        return generator_coarse_h.h
end
function what_pixel_is_gen_x()
        print(" " .. generator_x.x)
        return generator_x.x
end
function what_pixel_is_gen_y()
        print(" " .. generator_y.y)
        return generator_y.y
end
function where_is_room_corner_x()
        print(" " .. room_coarse_x.x)
        return room_coarse_x.x
end
function where_is_room_corner_y()
        print(" " .. room_coarse_y.y)
        return room_coarse_y.y
end
function where_is_room_farcorner_x()
        print(" " .. room_coarse_xw.x)
        return room_coarse_xw.x
end
function where_is_floor_farcorner_x()
        print(" " .. floor_coarse_h.h)
        return floor_coarse_h.h
end
function where_is_floor_farcorner_y()
        print(" " .. floor_coarse_w.w)
        return floor_coarse_w.w
end
function where_is_room_farcorner_y()
        print(" " .. room_coarse_yh.y)
        return room_coarse_yh.y
end
function what_pixel_is_room_corner_x()
        print(" " .. room_x.x)
        return room_x.x
end
function what_pixel_is_room_corner_y()
        print(" " .. room_y.y)
        return room_y.y
end
function what_pixel_is_room_farcorner_x()
        print(" " .. room_xw.x)
        return room_xw.x
end
function what_pixel_is_room_farcorner_y()
        print(" " .. room_yh.y)
        return room_yh.y
end
function what_pixel_is_floor_farcorner_y()
        print(" " .. floor_h.h)
        return floor_h.h
end
function what_pixel_is_floor_farcorner_x()
        print(" " .. floor_w.w)
        return floor_w.w
end
function how_long_room_pixels_w()
        print(" " .. generator_w.w)
        return generator_w.w
end
function how_long_room_pixels_h()
        print(" " .. generator_h.h)
        return generator_h.h
end
function how_many_particles_so_far()
        print(" " .. generator_particle_count.c)
        return generator_particle_count.c
end
function how_many_mobiles_so_far()
        print(" " .. generator_mobile_count.c)
        return generator_mobile_count.c
end
function get_map_savepath()
        local home = os.getenv("HOME")
        local map = home .. "/.config/lair/map_table.lua"
        return map
end
function get_mob_savepath()
        local home = os.getenv("HOME")
        local map = home .. "/.config/lair/mob_table.lua"
        return map
end
function get_map_archivepath()
        local home = os.getenv("HOME")
        local time = os.time()
        local map = home .. "/.config/lair/map_table-" .. time .. ".lua"
        return map
end
function get_mob_archivepath()
        local home = os.getenv("HOME")
        local time = os.time()
        local map = home .. "/.config/lair/mob_table-" .. time .. ".lua"
        return map
end
function file_exists(name)
        local f=io.open(name,"r")
        if f~=nil then io.close(f) return true else return false end
end
function reload_map()
        if file_exists(get_map_savepath()) then
                dofile(get_map_savepath())
        end
end
function reload_mobs()
        if file_exists(get_mob_savepath()) then
                dofile(get_mob_savepath())
        end
end
function stringup_cell(variable)
        local member = tostring(variable)
        local table = "cell"
        local key = tostring(what_pixel_is_gen_x()) .. "_" .. tostring(what_pixel_is_gen_y())
        local command = table .. "[\"" .. key .. "\"] = \"" .. member .. "\"\n"
        return command
end
function stringup_mob(variable)
        local member = tostring(variable)
        local table = "mobs"
        local key = tostring(what_pixel_is_gen_x()) .. "_" .. tostring(what_pixel_is_gen_y())
        local command = table .. "[\"" .. key .. "\"] = \"" .. member .. "\"\n"
        return command
end
function archive_old_map()
        if file_exists(get_map_savepath()) then
                os.rename(get_map_savepath(), get_map_archivepath())
                os.rename(get_mob_savepath(), get_mob_archivepath())
        end
end
function setup_new_map()
        if file_exists(get_map_savepath()) == false then
                file = io.open(get_map_savepath(), "a")
                file:write("cell = {}\n")
                file:close()
        end
end
function setup_new_mob()
        if file_exists(get_mob_savepath()) == false then
                file = io.open(get_mob_savepath(), "a")
                file:write("mobs = {}\n")
                file:close()
        end
end
function record_cell(variable)
        --print(tostring(variable))
        setup_new_map()
        local local_table = stringup_cell(variable)
        file = io.open(get_map_savepath(), "a")
        file:write(local_table)
        file:close()
end
function record_mobile(variable)
        --print(tostring(variable))
        setup_new_mob()
        local local_table = stringup_mob(variable)
        file = io.open(get_mob_savepath(), "a")
        file:write(local_table)
        file:close()
end
function particle_index_byxy(xx, yy)
        local cell_index = tostring(xx) .. "_" .. tostring(yy)
        if type(cell) == "table" then
                if type(cell[cell_index]) ~= "nil" then
                        return tostring(cell[cell_index])
                else
                        return "false"
                end
        else
                print("cell table not present")
                return "false"
        end
end
function mobile_index_byxy(xx, yy)
        local mob_index = tostring(xx) .. "_" .. tostring(yy)
        if type(mobs) == "table" then
                if type(mobs[mob_index]) ~= "nil" then
                        return tostring(mobs[mob_index])
                else
                        return "false"
                end
        else
                print("mob table not present")
                return "false"
        end
end
function what_is_tile_w()
        local w = tonumber(generator_w.w) / tonumber(generator_coarse_w.w)
        return w
end
function what_is_tile_h()
        local h = tonumber(generator_h.h) / tonumber(generator_coarse_h.h)
        return h
end
function is_blocked_particle_here()
        return particle_index_byxy(what_pixel_is_gen_x(), what_pixel_is_gen_y())
end
function is_blocked_mobile_here()
        return mobile_index_byxy(what_pixel_is_gen_x(), what_pixel_is_gen_y())
end
function particle_index_by_coarse_xy(xx, yy)
        xxx = xx * what_is_tile_w()
        yyy = yy * what_is_tile_h()
        local r = particle_index_byxy(xxx,yyy)
        return r
end
function mobile_index_by_coarse_xy(xx, yy)
        xxx = xx * what_is_tile_w()
        yyy = yy * what_is_tile_h()
        local r = mobile_index_byxy(xxx,yyy)
        return r
end
function print_general_props()
        print("PROPERTY DUMP")
        print("  Generator Particle Count: " .. generator_particle_count.c)
	print("  Generator Mobile Count: " .. generator_mobile_count.c)
        print("  Generator is at Pixel X: " .. generator_x.x)
	print("  Generator is at Pixel Y: " .. generator_y.y)
        print("  Generator is at Coarse X: " .. generator_coarse_x.x .. " in the room")
        print("  Generator is at Coarse Y: " .. generator_coarse_y.y .. " in the room")
        print("  Generator is at Coarse X: " .. where_in_floor_get_x_bare() .. " on the floor")
	print("  Generator is at Coarse Y: " .. where_in_floor_get_y_bare() .." on the floor")
        print("  Room Starts at Pixel X: " .. room_x.x)
	print("  Room Starts at Pixel Y: " .. room_y.y)
        print("  Room Starts at Coarse X: " .. room_coarse_x.x)
	print("  Room Starts at Coarse Y: " .. room_coarse_y.y)
        print("  Room Pixel Height: " .. generator_w.w)
	print("  Room Pixel Width: " .. generator_h.h)
        print("  Room Coarse Width: " .. generator_coarse_w.w)
	print("  Room Coarse Height: " .. generator_coarse_h.h)
        print("  Room Ends at Pixel X + Width: " .. room_xw.x)
	print("  Room Ends at Pixel Y + Height: " .. room_yh.y)
        print("  Room Ends at Coarse X + Width: " .. room_coarse_xw.x)
	print("  Room Ends at Coarse Y + Height: " .. room_coarse_yh.y)
        print("  Floor Pixel Width: " .. floor_w.w)
        print("  Floor Pixel Height: " .. floor_h.h)
        print("  Floor Coarse Width: " .. floor_coarse_w.w)
        print("  Floor Coarse Height: " .. floor_coarse_h.h)
        print("  Generator Tile Width: " .. tostring(what_is_tile_w()))
        print("  Generator Tile Height: " .. tostring(what_is_tile_h()))
        print("/PROPERTY DUMP")
        print("PROPERTY DUMP")
        print("  Generator Particle Count: " .. generator_particle_count.c)
	print("  Generator Mobile Count: " .. generator_mobile_count.c)
        print("  Generator is at Pixel X: " .. generator_x.x)
	print("  Generator is at Pixel Y: " .. generator_y.y)
        print("  Generator is at Coarse X: " .. generator_coarse_x.x .. " in the room")
        print("  Generator is at Coarse Y: " .. generator_coarse_y.y .. " in the room")
        print("  Generator is at Coarse X: " .. where_in_floor_get_x_bare() .. " on the floor")
	print("  Generator is at Coarse Y: " .. where_in_floor_get_y_bare() .." on the floor")
        print("  Room Starts at Pixel X: " .. room_corner_x.x)
	print("  Room Starts at Pixel Y: " .. room_corner_y.y)
        print("  Room Starts at Coarse X: " .. room_corner_coarse_x.x)
	print("  Room Starts at Coarse Y: " .. room_corner_coarse_y.y)
        print("  Room Pixel Width: " .. current_room_width.w)
	print("  Room Pixel Height: " .. current_room_height.h)
        print("  Room Coarse Width: " .. current_room_coarse_width.w)
	print("  Room Coarse Height: " .. current_room_coarse_height.h)
        print("  Room Ends at Pixel X + Width: " .. room_faredge_x.x)
	print("  Room Ends at Pixel Y + Height: " .. room_faredge_y.y)
        print("  Room Ends at Coarse X + Width: " .. room_faredge_coarse_x.x)
	print("  Room Ends at Coarse Y + Height: " .. room_faredge_coarse_y.y)
        print("  Floor Coarse Width: " .. floor_coarse_width.w)
        print("  Floor Coarse Height: " .. floor_coarse_height.h)
        print("  Floor Pixel Width: " .. floor_width.w)
        print("  Floor Pixel Height: " .. floor_height.h)
        print("  Generator Tile Width: " .. tostring(what_is_tile_w()))
        print("  Generator Tile Height: " .. tostring(what_is_tile_h()))
        print("/PROPERTY DUMP")
end
function coin()
        if math.random() < 0.5 then
                return "false"
        else
                return "true"
        end
end
function percent_chance(thresh)
        if math.random(100) > thresh then
                return "false"
        else
                return "true"
        end
end
