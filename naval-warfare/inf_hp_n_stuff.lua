local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Remote = ReplicatedStorage:FindFirstChild('Event')

local function SetValue(I, Value)
   Remote:FireServer('changeLock', table.pack(I, Value))
end

while true do
    wait(.3)
    for i,v in pairs(game.Workspace:GetChildren()) do
        if v:FindFirstChild("Owner") then
            if v.Owner.Value == game.Players.LocalPlayer.Name then
                SetValue(v.HP, 20000)
                if v:FindFirstChild("BombC") then
                    SetValue(v.BombC, 100)
                    SetValue(v.Fuel, 100)
                end
            end
        end
    end
end
