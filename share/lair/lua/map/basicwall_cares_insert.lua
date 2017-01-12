
function basicwall_cares_insert()
        local decided_to = "false"
        --print_general_props()
        if where_in_floor_get_x() < 3 then
                decided_to="true"
        end
        if where_in_floor_get_x() > where_is_floor_farcorner_x()- 4 then
                decided_to="true"
        end
        if where_in_floor_get_y() < 3 then
                decided_to="true"
        end
        if where_in_floor_get_y() > where_is_floor_farcorner_y() - 4 then
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
                decided_to="true"
        end
        if where_in_floor_get_y() < 2 then
                decided_to="true"
        end
        if where_in_floor_get_x() > where_is_floor_farcorner_x() - 3 then
                decided_to="true"
        end
        if where_in_floor_get_y() > where_is_floor_farcorner_y() - 3 then
                decided_to="true"
        end
        return decided_to
end
