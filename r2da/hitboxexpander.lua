while true do
    pcall(function()
        for i,v in pairs(game.Workspace.Characters.Survivors:GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                v.HumanoidRootPart.Transparency = 1
                v.HumanoidRootPart.CanCollide = false
                v.HumanoidRootPart.Size = Vector3.new(10, 10, 10)
            end
        end
        for i,v in pairs(game.Workspace.Characters.Zombies:GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                v.HumanoidRootPart.Transparency = 1
                v.HumanoidRootPart.CanCollide = false
                v.HumanoidRootPart.Size = Vector3.new(10, 10, 10)
            end
        end
    end)
    wait()
end
