dofile("/usr/share/lair/lua/ai/common.lua")

function default()
        local decide_behave = stand_still()
        doit = math.random(100)
        if doit < 90 then
                decide_behave = step_up()
        elseif doit < 92 then
                decide_behave = step_left()
        elseif doit < 94 then
                decide_behave = step_down()
        elseif doit < 96 then
                decide_behave = step_right()
        end
        wait = .2
        sleep(wait)
        print_seen_details()
        print_self_details()
        return decide_behave
end
