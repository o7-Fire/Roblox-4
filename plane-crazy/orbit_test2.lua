local character = game.Players.LocalPlayer.Character
local hrp = character:WaitForChild("HumanoidRootPart")

local parts = {}
_G.Enabled = fal

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

local axis = Vector3.new(0, 1, 1)
local speed = 50
while wait() do
    if _G.Enabled and _G.DoCheck == DoCheck then
    	for i, part in pairs(parts) do
    		if part:FindFirstChild("BodyVelocity") then
    		    local force = part.BodyVelocity
    		    force.Velocity = (part.Position - hrp.Position):Cross(axis).Unit * speed
		    else
		        local force = Instance.new("BodyVelocity", part)
		        force.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		        force.Velocity = (part.Position - hrp.Position):Cross(axis).Unit * speed
	        end
		end
	else
	    break
    end
end
