local M = {}

local event_stack = {}
local loop_steps = 0

function M.sync(func)
    loop_steps = loop_steps + 1
    event_stack[loop_steps] = coroutine.create(func)
end

function M.wait(func)
    return func(coroutine.yield())
end

function M.run()
    while (loop_steps > 0) do
        for co = 1, loop_steps do
            repeat
                if (not event_stack[co]) then
                    break
                end 

                if (coroutine.status(event_stack[co]) == "dead") then
                    table.remove(event_stack, co)
                    loop_steps = loop_steps - 1
                    break
                end
                
                coroutine.resume(event_stack[co])
            until true
        end
    end
end

return M