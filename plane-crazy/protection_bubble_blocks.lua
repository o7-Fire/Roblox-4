local count = 0 --Increment
_G.Enabled = true

function zeroGrav(part)
    if part:FindFirstChild("BodyForce") then return end
    local temp = Instance.new("BodyForce")
    temp.Force = part:GetMass() * Vector3.new(0,workspace.Gravity,0)
    temp.Parent = part
end

local build = game.workspace:WaitForChild(game.Players.LocalPlayer.Name..'Aircraft')
local numPoints = 0 
for i, blocks in pairs(build:GetChildren()) do
    if blocks.ClassName == "Model" then
        zeroGrav(blocks.PrimaryPart)
        numPoints = numPoints + 1
    end
end

while true do
    --Start at origin then apply an offset using Angles()
    if _G.Enabled then
        for i, blocks in pairs(build:GetChildren()) do
            spawn(function()
                if blocks.ClassName == "Model" then
                    --blocks.PrimaryPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position) * CFrame.Angles(0, count, 0) * CFrame.new(0, 0, 20)
                    --count = count + math.rad(3)
                    local HumanoidPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    local pp, size = Vector3.new(HumanoidPos.x,HumanoidPos.y,HumanoidPos.z), 50
                    local ct = tick()/3
                    local phi = math.acos(1-2*((i/numPoints+ct)%1));
                    local theta = math.pi * 1 + math.pow(5, .5) * i + ct;
                    x = math.cos(theta) * math.sin(phi) * size;
                    y = math.sin(theta) * math.sin(phi) * size;
                    z = math.cos(phi) * size;
                    blocks.PrimaryPart.CFrame = CFrame.new(pp.X + x - size / 2, pp.Y + y + size / 2, pp.Z + z - size / 2)
                    blocks.PrimaryPart.Velocity = Vector3.new()
                    wait()
                end
            end)
        end
        wait()
    else
        break
    end
end
