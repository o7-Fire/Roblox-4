while true do
    wait(0.2)
    fireclickdetector(game:GetService("Workspace").Map["sandoids spawn"].RefillGivers.Grenade.ClickDetector)
    game.Players.LocalPlayer.Backpack:WaitForChild("Frag Grenade").Parent = game.Workspace[game.Players.LocalPlayer.Name]
end
