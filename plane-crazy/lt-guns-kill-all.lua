local whitelisted = {"player1", "player2"} -- wont attack these people

local function zeroGrav(part)
    if part:FindFirstChild("BodyForce") then return end
    local temp = Instance.new("BodyForce")
    temp.Force = part:GetMass() * Vector3.new(0,workspace.Gravity,0)
    temp.Parent = part
end

while wait(0.1) do
    local guns = {}
    for i,v in pairs(game:GetService("Workspace")[game.Players.LocalPlayer.Name .. "Aircraft"]:GetChildren()) do
        if v.Name == "Gun" then
            table.insert(guns, v)
            zeroGrav(v.Part)
        end
    end
    for i,v in pairs(game.Players:GetChildren()) do
        local a = 1
        for x,z in pairs(whitelisted) do
            if v.Name == z then
                a = 0
            end
        end
        if v.Name == game.Players.LocalPlayer.Name then
            a = 0
        end
        if a == 1 then
            pcall(function()
                guns[i].Part.CFrame = v.Character.HumanoidRootPart.CFrame + v.Character.HumanoidRootPart.CFrame.lookVector * -100
                local args = {[1] = true}
                guns[i].Input:FireServer(unpack(args))
            end)
        end
    end
end
