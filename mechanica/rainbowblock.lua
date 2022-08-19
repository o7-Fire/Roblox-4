_G.Enabled = true
local remote = game.Players.LocalPlayer.PlayerGui.MainGui.Events.Paint

function paint(r, g, b)
    local args = {
    [1] = workspace.Creations[game.Players.LocalPlayer.Name].Block,
    [2] = Color3.new(r/255, g/255, b/255),
    [3] = "Neon"
    }
    remote:FireServer(unpack(args))
end

while _G.Enabled do
    paint(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    task.wait(.03)
end
