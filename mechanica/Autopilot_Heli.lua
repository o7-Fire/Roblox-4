local Flux = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt")()
local Window = Flux:Window("AutoPilot Heli", "Press N to open/close", Color3.fromRGB(255, 110, 48), Enum.KeyCode.N)
----------------- no touch ---------------
local UIS = game:GetService("UserInputService")
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local hrp = plr.Character.HumanoidRootPart
local targethrp = hrp
local targetpart
local lockon = false
local followmouse
local orbit = 0
local howhigh = 30
local howfartofollow = 1
_G.istheautopilotenalbed = false
local smoothness = 0.12
------------------------------------------

function RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end
local DoCheck = RandomVariable(20)
_G.DoCheck = DoCheck

local function getPlayer(text)
	for _, p in pairs(game.Players:GetChildren()) do
		if string.sub(string.lower(p.Name), 1, string.len(text)) == string.lower(text) then
		    print(p.Name)
			return p
		end
	end
end

local function zeroGrav(part)
    if not part:FindFirstChild("BodyForce") then 
        local temp = Instance.new("BodyForce")
        temp.Force = part:GetMass() * Vector3.new(0,workspace.Gravity,0)
        temp.Parent = part
    end
end

followmouse = mouse.Hit -- gonna fi xlater
local mouseymouempoeyosuemousey = false
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.B then
        mouseymouempoeyosuemousey = true
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.B then
        mouseymouempoeyosuemousey = false
    end
end)

task.spawn(function()
    while _G.DoCheck == DoCheck do
        task.wait(.1)
        if mouseymouempoeyosuemousey then
            followmouse = mouse.Hit
        end
    end
end)

local Tab1 = Window:Tab("main", "http://www.roblox.com/asset/?id=6023426915")
Tab1:Label("discord: .nexity. , nexitysecond")
Tab1:Button("init", "be in seat for it to work", function()
    followmouse = mouse.Hit
    for _, v in pairs(game.Workspace.Creations.MyModel:GetDescendants()) do
        if v:IsA("BasePart") then
            if v.Color == Color3.fromRGB(0, 255, 0) then
                targetpart = v
            end
            zeroGrav(v)
        end
    end
end)

Tab1:Button("Follow Target", "mke it fly", function()
    _G.istheautopilotenalbed = true
end)
Tab1:Button("Follow Mouse", "mke it crash", function()
    _G.istheautopilotenalbed = false
end)
Tab1:Textbox("Target", "choose who the target is", true, function(text)
    targethrp = getPlayer(text).Character.HumanoidRootPart
end)
Tab1:Textbox("Height", "how high are you", true, function(textbox)
    pcall(function()
        howhigh = tonumber(textbox)
    end)
end)
Tab1:Textbox("How Far to Follow (multiply by num, default = 1)", "how far to follow", true, function(text)
    pcall(function()
        howfartofollow = tonumber(text)
    end)
end)
Tab1:Button("Toggle LockOn", "make it face the target", function()
    if not lockon then
        lockon = true
    else
        lockon = false
    end
end)
Tab1:Button("Orbit", "follow in an orbit", function()
    if orbit == 0 then
        orbit = 1
    elseif orbit == 1 then
        orbit = -1
    else
        orbit = 0
    end
end)
Tab1:Button("Destroy This GUI", "does what it says", function()
    game.CoreGui.FluxLib:Destroy()
end)

local alphaorbitvalue = 0
task.spawn(function()
    while _G.DoCheck == DoCheck do
        task.wait(0.025)
        if alphaorbitvalue > 360 then
            alphaorbitvalue = 0
        elseif alphaorbitvalue < 0 then
            alphaorbitvalue = 360
        elseif orbit == 1 then
            alphaorbitvalue = alphaorbitvalue - 0.6
        elseif orbit == -1 then
            alphaorbitvalue = alphaorbitvalue + 0.6
        end
    end
end)

while not targetpart do
    task.wait(.3)
end

while true do
    task.wait(smoothness / 3) -- legendary 1 liner prevents a crash
    
    local t
    if _G.istheautopilotenalbed then
        t = {targethrp.CFrame, targethrp.Position}
    else
        t = {followmouse, followmouse.Position}
    end
    local v = targetpart.CFrame:VectorToObjectSpace(targetpart.Velocity)
    local distance = (targetpart.Position - t[2] + Vector3.new(0, howhigh * howfartofollow, 0)).Magnitude
    
    local lv
    if lockon then
        lv = CFrame.lookAt(targetpart.Position, t[2]) * CFrame.Angles(math.rad(v.z / 2), math.rad(v.y / 3), math.rad(-v.x / 2))
    else
        lv = CFrame.lookAt(targetpart.Position, Vector3.new(t[2].x, targetpart.Position.y, t[2].z)) * CFrame.Angles(math.rad(v.z / 2), math.rad(v.y / 3), math.rad(-v.x / 2))
    end
    local lvn = targetpart.CFrame.LookVector
    local lv2 = Vector3.new(lvn.x, 0, lvn.z).Unit * (-60 * howfartofollow)
    
    local cl
    if orbit ~= 0 then
        cl = targetpart.CFrame:Lerp(CFrame.new(t[2]) * CFrame.Angles(0, math.rad(alphaorbitvalue), 0) * CFrame.new(0, howhigh * howfartofollow, 60 * howfartofollow), smoothness).Position
    else
        cl = targetpart.CFrame:Lerp(t[1] * CFrame.new(0, howhigh * howfartofollow, 0) + lv2, smoothness).Position
    end
    
    if targetpart:FindFirstChild("bbbg") then
        targetpart.bbbg.CFrame = targetpart.CFrame:Lerp(lv, smoothness)
        targetpart.bbbp.Position = cl
    else
        local bg = Instance.new("BodyGyro")
        bg.Parent = targetpart
        bg.Name = "bbbg"
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.D = 100
        bg.CFrame = targetpart.CFrame:Lerp(lv, smoothness)
        local bp = Instance.new("BodyPosition")
        bp.Parent = targetpart
        bp.Name = "bbbp"
        bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bp.P = 25000
        bp.D = 1000
        bp.Position = cl
    end
    if _G.DoCheck ~= DoCheck then
        break
    end
end
