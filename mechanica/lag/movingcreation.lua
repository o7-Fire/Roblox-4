-- uses the move creation remote to lag other people
-- in terms of fps spikes and rendering
local moveremote = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Events.MoveCreation

function move(v)
    moveremote:FireServer(v)
end

_G.Enabled = true
while _G.Enabled do
    coroutine.wrap(move)(Vector3.new(0,0,10))
    task.wait(.01)
    coroutine.wrap(move)(Vector3.new(0,0,-10))
    task.wait(.01)
end
