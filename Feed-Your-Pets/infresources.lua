--[[
hives are better than smash rocks
especially with gold

gold hive
big gold hive
fruit hive
big fruit hive
fly hive
big fly hive
coconut hive
banana hive
seaweed hive
head hive
peach hive
bamboo hive
fish hive

gold smash rock
sapphire smash rock
emerald smash rock
ruby smash rock
pearl smash rock
stargem smash rock
]]

local Event = game:GetService("ReplicatedStorage").remotes.entity.lootInteractable
local char = game.Players.LocalPlayer.Character
local smashrock = "big fly hive"
local therock = game.Workspace.entities[smashrock]

for i=1, 500, 1 do
    spawn(function()
        char.HumanoidRootPart.CFrame = therock.Base.CFrame
        Event:FireServer(therock)
        Event:FireServer(therock)
    end)
    wait()
end
