
function table_length(T)
        local count = 0
        for _ in pairs(T) do count = count + 1 end
        return count
end

function check_right_for_detail(query)
        local r = false
        for key, value in pairs(vision) do
                if string.find(value, query) then
                        print(value .. " was found at key: " .. key)
                        r = true;
                else
                        print(value .. " was not found.")
                end
        end
        return r
end

function check_left_for_detail(query)
        local r = false
        for key, value in pairs(vision) do
                if string.find(value, query) then
                        print(value .. " was found at key: " .. key)
                        r = true;
                else
                        print(value .. " was not found.")
                end
        end
        return r
end

function check_up_for_detail(query)
        local r = false
        for key, value in pairs(vision) do
                if string.find(value, query) then
                        print(value .. " was found at key: " .. key)
                        r = true;
                else
                        print(value .. " was not found.")
                end
        end
        return r
end

function check_down_for_detail(query)
        local r = false
        for key, value in pairs(vision) do
                if string.find(value, query) then
                        print(value .. " was found at key: " .. key)
                        r = true;
                else
                        print(value .. " was not found.")
                end
        end
        return r
end

function get_vision_length()
        return table_length(vision)
end

function stats_default()
        return "10 10 10 10 10"
end

function step_down()
        return "step_down()"
end

function step_up()
        return "step_up()"
end

function step_left()
        return "step_left()"
end

function step_right()
        return "step_right()"
end

function step_south()
        return "step_down()"
end

function step_north()
        return "step_up()"
end

function step_west()
        return "step_left()"
end

function step_east()
        return "step_right()"
end
