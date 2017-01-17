
function cut_hallways(vari)
        if type(vari) == "string" then
                decided_to = vari
        else
                decided_to = "false"
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
        return decided_to
end
