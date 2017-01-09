
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
