local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Remote = ReplicatedStorage:FindFirstChild('Event')

local function SetValue(I, Value)
   Remote:FireServer('changeLock', table.pack(I, Value))
end

while true do
    wait(3)
    for i,v in pairs(game.Workspace:GetChildren()) do
        if v:FindFirstChild("Team") then
            if v.Team.Value == game.Players.LocalPlayer.Team.Name then
                SetValue(v.HP, 2000000000)
                if v:FindFirstChild("BombC") then
                    SetValue(v.BombC, 100)
                    SetValue(v.Fuel, 100)
                end
            end
        end
    end
end
