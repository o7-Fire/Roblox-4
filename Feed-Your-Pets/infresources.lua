--[[
gold smash rock
sapphire smash rock
emerald smash rock
ruby smash rock
pearl smash rock
stargem smash rock
]]

local Event = game:GetService("ReplicatedStorage").remotes.entity.lootInteractable
local char = game.Players.LocalPlayer.Character
local smashrock = "gold smash rock"
local therock = game.Workspace.entities[smashrock]

char:MoveTo(therock.Base.Position)
wait(2)
for i=1, 1000, 1 do
Event:FireServer(therock)
wait()
end
