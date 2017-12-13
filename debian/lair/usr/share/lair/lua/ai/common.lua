require "os"

function sleep(s)
        local ntime = os.clock() + s
        repeat until os.clock() > ntime
end

function table_length(T)
        local count = 0
        for _ in pairs(T) do count = count + 1 end
        return count
end

function print_seen_details()
        local r = false
        print("Printing details about nearby entities:")
        print("---------------------------------------")
        for key, value in pairs(vision) do
                print("  * " .. value .. " was found at key: " .. key)
        end
        print("")
        return r
end

function print_self_details()
        local r = false
        print("Printing details about self:")
        print("----------------------------")
        for key, value in pairs(self) do
                print("  * " .. value .. " was found at key: " .. key)
        end
        for key, value in pairs(self_speed) do
                print("  * " .. value .. " was found at key: " .. key)
        end
        print("")
        return r
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

--there need to be more helpers

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

function stand_still()
        return "stand_still()"
end
