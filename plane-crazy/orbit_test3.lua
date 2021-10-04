local character = game.Players.LocalPlayer.Character
local hrp = character:WaitForChild("HumanoidRootPart")

local parts = {}
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

--local axis = Vector3.new(1, 0.5, 0)
--local speed = 20
while wait() do
    if _G.Enabled and _G.DoCheck == DoCheck then
    	for i, part in pairs(parts) do
    		if part:FindFirstChild("BodyVelocity") then
    		    local force = part.BodyVelocity
    		    local numbervalue = part.rot
    		    local speed = part.speed
    		    force.Velocity = (part.Position - hrp.Position):Cross(Vector3.new(0, numbervalue.Value, 0)).Unit * speed.Value
		    else
		        local numbervalue = Instance.new("NumberValue", part)
		        numbervalue.Name = "rot"
		        if math.random(1,2) == 1 then
		            numbervalue.Value = -1
	            else
	                numbervalue.Value = 1
		        end
                local speed = Instance.new("NumberValue", part)
                speed.Name = "speed"
                speed.Value = math.random(20, 50)
		        local force = Instance.new("BodyVelocity", part)
		        force.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		        force.Velocity = (part.Position - hrp.Position):Cross(Vector3.new(0, numbervalue.Value, 0)).Unit * speed.Value
	        end
		end
	else
	    break
    end
end
