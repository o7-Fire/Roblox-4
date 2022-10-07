while true do
	task.wait(.25)
	if game.Players.LocalPlayer.PlayerGui:FindFirstChild("CitizenGui") then
	  game:GetService("ReplicatedStorage").Remotes.Ow:FireServer(-math.huge)
	end
end
