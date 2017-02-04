dofile("/usr/share/lair/lua/ai/common.lua")

function default()
        local decide_behave = step_down()
        return decide_behave
end
