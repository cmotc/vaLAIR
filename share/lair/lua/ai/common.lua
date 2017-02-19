function tellme(offset, story)
        for n,v in pairs(story) do
                if n ~= "loaded" and n ~= "_G" then
                print(offset .. n .. " " )
                print (v)
                if type(v) == "table" then
                        tellme(offset .. "--> ",v)
                end
                end
        end
end

function get_vision_length()
        return vision_length.l
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
