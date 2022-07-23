local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Remote = ReplicatedStorage:FindFirstChild('Event')

local function SetValue(I, Value)
   Remote:FireServer('changeLock', table.pack(I, Value))
end

while true do
    wait(3)
    for i,v in pairs(game.Players:GetChildren()) do
        SetValue(v.leaderstats.Coin, 9999)
        SetValue(v.leaderstats.Win, 9999)
        SetValue(v.leaderstats.Score, 9999)
    end
    for i,v in pairs(game.Workspace:GetChildren()) do
        if v:FindFirstChild("Owner") then
            SetValue(v.HP, 999999999999)
            if v:FindFirstChild("BombC") then
                SetValue(v.BombC, 999999999999)
                SetValue(v.Fuel, 999999999999)
            end
        end
    end
end

SetValue(game:GetService("Workspace").USDock.HP, 999999999999)
SetValue(game:GetService("Workspace").JapanDock.HP, 999999999999)
