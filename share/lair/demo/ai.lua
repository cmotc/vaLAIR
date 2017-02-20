dofile("/usr/share/lair/lua/ai/common.lua")

function default()
        local decide_behave = step_down()
        if self_turn.p < 15 then
                decide_behave = step_up()
        elseif self_turn.p < 30 then
                decide_behave = step_left()
        elseif self_turn.p < 45 then
                decide_behave = step_down()
        elseif self_turn.p < 60 then
                decide_behave = step_right()
        end
        print("default ai cycle test")
        print("vision field length = " .. vision_length.l .. ": " .. get_vision_length())
        print("turning " .. self_turn.p)
        return decide_behave
end
