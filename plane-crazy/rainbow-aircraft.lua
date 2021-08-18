_G.Enabled = true

while wait(0.5) do
    if _G.Enabled then
        local args = {
            [1] = workspace.PlayerAircraft[game.Players.LocalPlayer.Name].BlockStd.BlockStd,
            [2] = Color3.new(math.random(0, 255) / 255, math.random(0, 255) / 255, math.random(0, 255) / 255),
            [3] = "a"
        }
        
        game:GetService("ReplicatedStorage").Remotes.Paint:FireServer(unpack(args))
    else
        break
    end
end
