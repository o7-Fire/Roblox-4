local plr = game.Players.LocalPlayer
local character = plr.Character
local hrp = character:WaitForChild("HumanoidRootPart")
local Mouse = plr:GetMouse()
local inputService = game:GetService("UserInputService")

local parts = {}
_G.Enabled = true

local function isMouseButtonDown(inputType)
	for _,button in pairs(inputService:GetMouseButtonsPressed()) do
		if button.UserInputType == inputType then
			return true
		end
	end
	return false
end

function RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end
local DoCheck = RandomVariable(20)
_G.DoCheck = DoCheck

function applybodygyro(part, CFrame)
    if part:FindFirstChild("BodyPosition") then
        local BP = part.BodyPosition
        local bodyGyro = part.BodyGyro
        BP.Position = CFrame.Position
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
    	BP.Position = CFrame.Position
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

function setupbsconstraints(part, lastpart)
    local a = Instance.new("BallSocketConstraint")
    a.Parent = part
    a.Name = "BallSocketConstraint"
    a.Attachment0 = part.AttachmentBottom
    a.Attachment1 = lastpart.AttachmentTop
    a.LimitsEnabled = true
    a.UpperAngle = 5
    a.TwistLimitsEnabled = true
    a.TwistUpperAngle = 10
    a.TwistLowerAngle = -10
    a.MaxFrictionTorque = 5000000
end

local p = Instance.new("Part")
p.Parent = game.Workspace
p.Name = "VGBlock"
p.CFrame = hrp.CFrame
p.Size = Vector3.new(2.5, 2.5, 2.5)
p.Transparency = 1
table.insert(parts, p)
for i, part in pairs(game.Workspace[game.Players.LocalPlayer.Name..' Aircraft']:GetChildren()) do
    if part.ClassName == "Model" and part.Name ~= "PilotSeat" then
	    table.insert(parts, part.PrimaryPart) -- put the parts into the table
	    part.PrimaryPart.CustomPhysicalProperties = PhysicalProperties.new(0.4, 0.1, 1, 1, 1)
	    part.PrimaryPart.CanCollide = true
    end
end

for i, part in pairs(parts) do
    if i == 1 then
        setupconstraints(part, 7)
    else
        setupconstraints(part, 7)
        setupbsconstraints(part, parts[i-1])
    end
end

while wait(0.1) do
    if _G.Enabled and _G.DoCheck == DoCheck then
        local cf = character.HumanoidRootPart.CFrame
        applybodygyro(parts[1], cf * CFrame.Angles(0, math.rad(180), 0) + Vector3.new(0, -15, 0))
    	local lastpart = parts[#parts]
	else
	    break
    end
end
