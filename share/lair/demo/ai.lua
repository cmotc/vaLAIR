dofile("/usr/share/lair/lua/ai/common.lua")

function default()
        local decide_behave = step_down()
        --if i < 15 then
                --decide_behave = step_up()
        --elseif i < 30 then
                --decide_behave = step_left()
        --elseif i < 45 then
                --decide_behave = step_down()
        --elseif i < 60 then
                --decide_behave = step_right()
        --end
        print("default ai cycle test")
        print("vision field length = " .. vision_length.l .. ": " .. get_vision_length())
        return decide_behave
end
