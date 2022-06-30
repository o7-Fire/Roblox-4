-- intended use in vip server
-- casino halls have tons of chests
local isgrindaccount = true

while true do
    wait(1)
    if game.Players.LocalPlayer.Character then
        if game.Workspace:WaitForChild("Map"):FindFirstChild("RegularChest") then
            if isgrindaccount then
                game.Workspace.Map.RegularChest.Chest.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 2, 0)
            end
        else
            local args = {
                [1] = 10000,
                [2] = game:GetService("Players").LocalPlayer.Character.Humanoid
            }
            game:GetService("ReplicatedStorage").RemoteEvents.SelfDamage:FireServer(unpack(args))
            wait(10)
            local args = {
                [1] = true
            }
            game:GetService("ReplicatedStorage").RemoteEvents.SetReady:FireServer(unpack(args))
        end
    end
end
