dofile("/usr/share/lair/lua/ai/common.lua")

function default()
        local decide_behave = stand_still()
        doit = math.random(100)
        if doit < 25 then
                decide_behave = step_up()
        elseif doit < 50 then
                decide_behave = step_left()
        elseif doit < 75 then
                decide_behave = step_down()
        elseif doit < 100 then
                decide_behave = step_right()
        end
        return decide_behave
end
