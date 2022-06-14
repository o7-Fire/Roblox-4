while true do
    pcall(function()
        for i,v in pairs(game.Workspace.Characters.Zombies:GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name and v:FindFirstChild("HumanoidRootPart") and not v:FindFirstChild("NoThrow") then
                magnitude = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude
                if magnitude > 15 then
                    v.HumanoidRootPart.Transparency = 1
                    v.HumanoidRootPart.CanCollide = false
                    v.HumanoidRootPart.Size = Vector3.new(10, 10, 10)
                else
                    v.HumanoidRootPart.Transparency = 1
                    v.HumanoidRootPart.CanCollide = false
                    v.HumanoidRootPart.Size = Vector3.new(3, 3, 3)
                end
            end
        end
    end)
    wait()
end
