for i,v in pairs(game.Workspace[game.Players.LocalPlayer.Name .. "Aircraft"]:GetChildren()) do
    if v:FindFirstChild("Throttle") then
        v.Throttle.Value = 10000 -- calculated in percentage
    end
end
