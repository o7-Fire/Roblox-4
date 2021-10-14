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

local tweenService = game:GetService("TweenService")
local info = TweenInfo.new()

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
        	v.PrimaryPart.Anchored = false
            v.PrimaryPart.CanCollide = false
            zeroGrav(v.PrimaryPart)
        end)
    end
end

local hrpb = {}
for i,v in pairs(game.Workspace[plr.Name]:GetChildren()) do
	if v.ClassName == "MeshPart" then
		table.insert(hrpb, v)
	end
end

wait(0.1)
while wait() do
    if _G.DoCheck346784576 == DoCheck then
        local count = 0
        for i,v in pairs(build:GetChildren()) do 
            if v.ClassName == "Model" and v.Name == "BlockStd" then
            	local yeatp = false
            	if v.PrimaryPart.BrickColor == BrickColor.new("Really red") then
            		yeatp = true
        			count = 1
    			elseif v.PrimaryPart.BrickColor == BrickColor.new("Really blue") then
    				yeatp = true
        			count = 2
    			elseif v.PrimaryPart.BrickColor == BrickColor.new("New Yeller") then
    				yeatp = true
        			count = 3
    			elseif v.PrimaryPart.BrickColor == BrickColor.new("CGA brown") then
    				yeatp = true
        			count = 4
    			elseif v.PrimaryPart.BrickColor == BrickColor.new("Magenta") then
    				yeatp = true
        			count = 5
    			elseif v.PrimaryPart.BrickColor == BrickColor.new("Toothpaste") then
    				yeatp = true
        			count = 6
    			elseif v.PrimaryPart.BrickColor == BrickColor.new("Lime green") then
    				yeatp = true
        			count = 7
    			elseif v.PrimaryPart.BrickColor == BrickColor.new("Persimmon") then
    				yeatp = true
        			count = 8
    			elseif v.PrimaryPart.BrickColor == BrickColor.new("Navy blue") then
    				yeatp = true
        			count = 9
    			elseif v.PrimaryPart.BrickColor == BrickColor.new("Pink") then
    				yeatp = true
        			count = 10
    			elseif v.PrimaryPart.BrickColor == BrickColor.new("Tr. Red") then
    				yeatp = true
        			count = 11
    			elseif v.PrimaryPart.BrickColor == BrickColor.new("Smoky grey") then
    				yeatp = true
        			count = 12
    			elseif v.PrimaryPart.BrickColor == BrickColor.new("Bright green") then
    				yeatp = true
        			count = 13
    			elseif v.PrimaryPart.BrickColor == BrickColor.new("Linen") then
    				yeatp = true
        			count = 14
    			elseif v.PrimaryPart.BrickColor == BrickColor.new("Cyan") then
    				yeatp = true
        			count = 15
    			end
            	
            	local hrptotp = hrpb[count]
            	if yeatp then
	                if v.PrimaryPart:FindFirstChild("BodyPosition") then
	                    local BP = v.PrimaryPart.BodyPosition
	                    local bodyGyro = v.PrimaryPart.BodyGyro
	                    BP.Position = hrptotp.Position --+ v.CFrame.LookVector * 10
	                    bodyGyro.CFrame = hrptotp.CFrame
	                else
	                    v.PrimaryPart.CanCollide = false
	                    local bodyGyro = Instance.new("BodyGyro", v.PrimaryPart)
	                    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
						bodyGyro.D = 100
	                	local BP = Instance.new("BodyPosition", v.PrimaryPart)
	                	BP.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	                	BP.P = 25000
	                	BP.D = 1000
	                	BP.Position = hrptotp.Position --+ v.CFrame.LookVector * 10
	                	bodyGyro.CFrame = hrptotp.CFrame
	        	    end
        	    end
        	    --block.PrimaryPart.CFrame = v.CFrame
            end
        end
        RunService.Heartbeat:Wait()
    else
    	print("ended")
        break
    end
end
