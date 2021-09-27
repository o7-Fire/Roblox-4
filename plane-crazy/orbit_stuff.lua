local count = 0 --Increment
_G.Enabled = true

function zeroGrav(part)
    if part:FindFirstChild("BodyForce") then return end
    local temp = Instance.new("BodyForce")
    temp.Force = part:GetMass() * Vector3.new(0,workspace.Gravity,0)
    temp.Parent = part
end

local build = game.workspace:WaitForChild(game.Players.LocalPlayer.Name..'Aircraft')
for i, blocks in pairs(build:GetChildren()) do
    spawn(function()
        if blocks.ClassName == "Model" then
            blocks.PrimaryPart.CanCollide = false
            zeroGrav(blocks.PrimaryPart)
        end
    end)
end
    
while true do
    --Start at origin then apply an offset using Angles()
    if _G.Enabled then
        local build = game.workspace:WaitForChild(game.Players.LocalPlayer.Name..'Aircraft')
        for i, blocks in pairs(build:GetChildren()) do
            spawn(function()
                if blocks.ClassName == "Model" and count < 360 then
                    blocks.PrimaryPart.Velocity = Vector3.new()
                    blocks.PrimaryPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position) * CFrame.Angles(0, count, 0) * CFrame.new(0, 0, 50)
                    count = count + math.rad(3)
                elseif count > 360 then
                    count = 0
                end
            end)
        end
        wait(0.1)
    else
        break
    end
end
