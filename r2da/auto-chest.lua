-- teleports chest on top of your head if it exists

while true do
    wait(1)
    if game.Workspace:WaitForChild("Map"):FindFirstChild("RegularChest") then
        game.Workspace.Map.RegularChest.Chest.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 2, 0)
    end
end
