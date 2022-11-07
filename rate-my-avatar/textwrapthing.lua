local s = "Among Us takes place in space-themed settings where players are colorful armless cartoon astronauts; Each player takes on one of two roles: most are Crewmates, but a small number play Impostors,[d] which appear identical to Crewmates. The goal of the Crewmates is to either identify and vote out the Impostors, or to complete all the tasks around the map; the goal of the Impostors is to covertly sabotage the mission either by killing the Crewmates before they complete all their tasks or by triggering a disaster that is not resolved in time."

local updater = game:GetService("ReplicatedStorage").CustomiseBooth
local function update(text)
    local args = {
        [1] = "Update",
        [2] = {
            ["DescriptionText"] = text,
            ["ImageId"] = 0
        }
    }
    
    updater:FireServer(unpack(args))
end

local ls = ""
for i=1, #s, 1 do -- extend #s if you want it to looopppppp
    local m = i % #s
    ls = ls .. s:sub(m, m)
    if i > 50 then
        ls = ls:sub(2)
    end
    coroutine.wrap(update)(ls)
    task.wait(.1)
end
