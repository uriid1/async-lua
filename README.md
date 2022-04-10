# async-lua

#  Example
```lua
local a = require "async"

a.sync(function()
    for i = 1, 5 do
        a.wait(function()
            print(i)
        end)
    end
end)

a.sync(function()
    for i = 1, 5 do
        local result = a.wait(function()
            return i
        end)

        print(result)
    end
end)

a.run()
```