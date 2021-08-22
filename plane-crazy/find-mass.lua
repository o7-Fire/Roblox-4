for i,v in pairs(game:GetService("Workspace")[game.Players.LocalPlayer.Name]:GetChildren()) do
    pcall(function()
        print(v.Name .. " " .. v.PrimaryPart.Mass)
    end)
end
