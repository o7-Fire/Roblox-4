local nodes = {}
local plr = game.Players.LocalPlayer
local hrp = plr.Character.HumanoidRootPart
local nodeconnection = {9, 0, 1, 2, 3, 0, 5, 6, 7, 0, 9, 10, 11, 0, 13, 14, 15, 0, 17, 18, 19}

function RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end
local DoCheck = RandomVariable(20)
_G.DoCheck = DoCheck

function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end


local function zeroGrav(part)
    if not part:FindFirstChild("BodyForce") then 
        local temp = Instance.new("BodyForce")
        temp.Force = part:GetMass() * Vector3.new(0,workspace.Gravity,0)
        temp.Parent = part
    end
end

_G.Enabled = true
if _G.Enabled then
    for i=0, 20, 1 do -- deeply sorry for this crime
        for _, v in pairs(game.Workspace[plr.Name .. "Aircraft"]:GetDescendants()) do
            if v:IsA("BasePart") then
                if v.Color == Color3.fromRGB(i, i, i) then
                    table.insert(nodes, v)
                end
                zeroGrav(v)
                v.CanCollide = false
            end
        end
        task.wait(.03)
    end
end

while _G.Enabled do
    if _G.DoCheck ~= DoCheck then
        break
    end
    task.wait(.03)
    local r = game:HttpGet("http://192.168.0.167:8080/")
    for c, node in pairs(Split(r, "B")) do
        local data = Split(node, " ")
        local anode = nodes[data[1] + 1]
        local pos = hrp.Position + Vector3.new(data[3] / 3, data[4] / 3, data[2] / 3) + Vector3.new(-70, 100, -150)
        local tolookat = CFrame.lookAt(anode.Position, nodes[nodeconnection[data[1] + 1] + 1].Position)
        if anode:FindFirstChild("bbbg") then
            anode.bbbg.CFrame = tolookat
            anode.bbbp.Position = pos
        else
            local bg = Instance.new("BodyGyro")
            bg.Parent = anode
            bg.Name = "bbbg"
            bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bg.D = 100
            bg.CFrame = tolookat
            local bp = Instance.new("BodyPosition")
            bp.Parent = anode
            bp.Name = "bbbp"
            bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bp.P = 25000
            bp.D = 1000
            bp.Position = pos
        end
    end
end
