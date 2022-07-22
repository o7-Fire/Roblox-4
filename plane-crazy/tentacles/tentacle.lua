local plr = game.Players.LocalPlayer
local character = plr.Character
local hrp = character:WaitForChild("HumanoidRootPart")
local Mouse = plr:GetMouse()

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

function applybodygyro(part, CFrame, Position, radius)
    if part:FindFirstChild("BodyPosition") then
        local BP = part.BodyPosition
        local bodyGyro = part.BodyGyro
        BP.Position = Position
        bodyGyro.CFrame = CFrame
    else
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.Parent = part
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		bodyGyro.D = 100
    	local BP = Instance.new("BodyPosition")
    	BP.Parent = part
    	BP.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
    	BP.P = 25000
    	BP.D = 1000
    	BP.Position = Position
    	bodyGyro.CFrame = CFrame
    end
end

function setupconstraints(part, offset)
    local a = Instance.new("Attachment")
    a.Name = "AttachmentTop"
    a.Parent = part
    a.Axis = Vector3.new(0, 0, 0)
    a.CFrame = CFrame.new(0, 0, offset)
    local a = Instance.new("Attachment")
    a.Name = "AttachmentBottom"
    a.Parent = part
    a.Axis = Vector3.new(0, 0, 0)
    a.CFrame = CFrame.new(0, 0, -offset)
end

function setuphingeconstraints(part, lastpart)
    local a = Instance.new("BallSocketConstraint")
    a.Parent = part
    a.Name = "BallSocketConstraint"
    a.Attachment0 = part.AttachmentBottom
    a.Attachment1 = lastpart.AttachmentTop
    a.MaxFrictionTorque = 300000
    a.Radius = 2.5
end

for i, part in pairs(game.Workspace[game.Players.LocalPlayer.Name..'Aircraft']:GetChildren()) do
    if part.ClassName == "Model" then
	    table.insert(parts, part.PrimaryPart) -- put the parts into the table
	    part.PrimaryPart.CanCollide = true
    end
end

local firstpartcf = hrp.CFrame
applybodygyro(parts[1], firstpartcf + Vector3.new(0, 150, 0), firstpartcf.Position + Vector3.new(0, 150, 0), 3)
for i, part in pairs(parts) do
    if i == 1 then
        setupconstraints(part, 5)
    else
        setupconstraints(part, 5)
        setuphingeconstraints(part, parts[i-1])
    end
end

--[[
while wait(0.1) do
    if _G.Enabled and _G.DoCheck == DoCheck then
    	-- todo here
	else
	    break
    end
end]]
