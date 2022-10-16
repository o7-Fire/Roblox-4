local enemy = game.Workspace.Game.Enemies:GetChildren()
local r = game:GetService("ReplicatedStorage").InflictTarget
local weapon
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if v.ClassName == "Tool" then
        weapon = v
    end
end
local gundamage = require(weapon.Setting).BaseDamage

local function damage(x, y)
    local args = {
        [1] = weapon,
        [2] = game:GetService("Players").LocalPlayer,
        [3] = x.Humanoid,
        [4] = x.HumanoidRootPart,
        [5] = y,
        [6] = {
            [1] = 0,
            [2] = 0,
            [3] = false,
            [4] = false,
            [5] = weapon.GunScript_Server.IgniteScript,
            [6] = weapon.GunScript_Server.IcifyScript,
            [7] = 100,
            [8] = 100
        },
        [7] = {
            [1] = false,
            [2] = 5,
            [3] = 3
        },
        [8] = x:FindFirstChild("Right Arm"):FindFirstChild("Right Arm")
    }
    
    r:InvokeServer(unpack(args))
end

for i,v in pairs(enemy) do
    while v.Humanoid.Health > 0 do
        coroutine.wrap(damage)(v, gundamage)
        task.wait(.01)
    end
end
