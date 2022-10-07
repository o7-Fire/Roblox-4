while true do
	task.wait(.25)
	if game.Players.LocalPlayer.PlayerGui:FindFirstChild("CitizenGui") then
		if game:GetService("Workspace").MrBlobFish13.Humanoid.Health < 150 then
			game:GetService("ReplicatedStorage").Remotes.Ow:FireServer(-1)
		end
	end
end
