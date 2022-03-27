-- makes a snake out of available parts
-- works best if you have single 1x1 blocks
local character = game.Players.LocalPlayer.Character
local hrp = character:WaitForChild("HumanoidRootPart")

local parts = {character.HumanoidRootPart}
_G.Enabled = true

function RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end
local DoCheck = RandomVariable(20)
_G.DoCheck = DoCheck

for i, part in pairs(game.Workspace[game.Players.LocalPlayer.Name..'Aircraft']:GetChildren()) do
    if part.ClassName == "Model" then
	    table.insert(parts, part.PrimaryPart) -- put the parts into the table
    end
end

local lastpart = character.HumanoidRootPart
while wait(0.1) do
    if _G.Enabled and _G.DoCheck == DoCheck then
    	for i, part in pairs(parts) do
    	    if part.Name ~= "HumanoidRootPart" then
                if part:FindFirstChild("BodyPosition") then
                    local BP = part.BodyPosition
                    local bodyGyro = part.BodyGyro
                    BP.Position = part.Position + (lastpart.Position - part.Position).Unit * ((lastpart.Position - part.Position).magnitude - 3)
                    bodyGyro.CFrame = lastpart.CFrame
                else
                    --part.CanCollide = false
                    local bodyGyro = Instance.new("BodyGyro")
                    bodyGyro.Parent = part
                    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    				bodyGyro.D = 100
                	local BP = Instance.new("BodyPosition")
                	BP.Parent = part
                	BP.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                	BP.P = 25000
                	BP.D = 1000
                	BP.Position = part.Position + (lastpart.Position - part.Position).Unit * ((lastpart.Position - part.Position).magnitude - 3)
                	bodyGyro.CFrame = lastpart.CFrame
                end
    	    end
            lastpart = part
    	end
	    lastpart = character.HumanoidRootPart
	else
	    break
    end
end
