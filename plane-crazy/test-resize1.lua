local plr = game.Players.LocalPlayer
local hrp = plr.Character.HumanoidRootPart
local build = game.Workspace[plr.Name .. "Aircraft"]
local RunService = game:GetService("RunService")

local function zeroGrav(part)
    local bodyForce = Instance.new("BodyVelocity")
    bodyForce.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyForce.P = math.huge
    bodyForce.Velocity = Vector3.new(0, 0, 0)
    bodyForce.Parent = part
end

function RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end
local DoCheck = RandomVariable(20)
_G.DoCheck346784576 = DoCheck

local blocks = {}
for i,v in pairs(build:GetChildren()) do
    if v.ClassName == "Model" and v.Name == "BlockStd" and v.PrimaryPart.BrickColor == BrickColor.new("Lime green") then
        table.insert(blocks, v)
        v.PrimaryPart.CanCollide = false
        zeroGrav(v.PrimaryPart)
        --[[if v.PrimaryPart:FindFirstChild("BodyPosition") then
            local BP = v.PrimaryPart.BodyPosition
            BP.Position = hrp.Position + Vector3.new(10, 0, 0) + hrp.CFrame.LookVector * 10
        else
        	local BP = Instance.new("BodyPosition", v.PrimaryPart)
        	BP.MaxForce = Vector3.new(25000,25000,25000)
        	BP.P = 100
        	BP.D = 100
        	BP.Position = hrp.Position + Vector3.new(10, 0, 0) + hrp.CFrame.LookVector * 10
	    end]]
    else
        pcall(function()
            v.PrimaryPart.CanCollide = false
            zeroGrav(v.PrimaryPart)
        end)
    end
end
wait(0.1)
while wait() do
    if _G.DoCheck346784576 == DoCheck then
        local count = 1
        for i,v in pairs(game.Workspace[plr.Name]:GetChildren()) do 
            if v.ClassName == "MeshPart" then
                local block = blocks[count]
                --[[if block.PrimaryPart:FindFirstChild("BodyPosition") then
                    local BP = block.PrimaryPart.BodyPosition
                    BP.Position = v.Position + Vector3.new(10, 0, 0) + v.CFrame.LookVector * 10
                else
                    block.PrimaryPart.CanCollide = false
                	local BP = Instance.new("BodyPosition", block.PrimaryPart)
                	BP.MaxForce = Vector3.new(2e9,2e9,2e9)
                	BP.P = 100
                	BP.D = 100
                	BP.Position = v.Position + Vector3.new(10, 0, 0) + v.CFrame.LookVector * 10
        	    end]]
        	    block.PrimaryPart.CFrame = v.CFrame
                count += 1
            end
        end
        RunService.Heartbeat:Wait()
    else
        break
    end
end
