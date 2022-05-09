while wait(0.1) do
    if game.Players.LocalPlayer.Character.Humanoid.Health > 350 then
        local args = {
        [1] = "Lovecraftian Locket"
        }
        game:GetService("ReplicatedStorage").Remotes.DropItem:InvokeServer(unpack(args))
        wait(0.2)
        game:GetService("ReplicatedStorage").Remotes.UseLocket:FireServer()
    end
end
