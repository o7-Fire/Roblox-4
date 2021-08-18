function move(distance)
    local args = {[1] = distance}
    game:GetService("ReplicatedStorage").Remotes.MoveAircraft:InvokeServer(unpack(args))
end

--[[
pcall(function()
    game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.Handles:Destroy()
end)

Instance.new("Handles", game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui)
game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.Handles.Adornee = 
]]
game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.Handles.MouseDrag:Connect(function(Face, Distance)
    local x = os.clock()
    Distance = math.floor(Distance / 6)
    if Face == Enum.NormalId.Top then
        move(Vector3.new(0, Distance, 0))
    elseif Face == Enum.NormalId.Bottom then
        move(Vector3.new(0, -Distance, 0))
    elseif Face == Enum.NormalId.Left then
        move(Vector3.new(-Distance, 0, 0))
    elseif Face == Enum.NormalId.Right then
        move(Vector3.new(Distance, 0, 0))
    elseif Face == Enum.NormalId.Front then
       move(Vector3.new(0, 0, -Distance))
    elseif Face == Enum.NormalId.Back then
        move(Vector3.new(0, 0, Distance))
    end
    wait(10 - (os.clock() - x))
end)
