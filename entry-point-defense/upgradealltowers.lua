local dowait = true
local theremote = game:GetService("ReplicatedStorage").UpgradeEvent

function upgrade(v)
    for i=1, 6, 1 do
        local args = {
            [1] = game:GetService("Players").LocalPlayer,
            [2] = v
        }
        theremote:FireServer(unpack(args))
        if dowait then
            wait(.2)
        end
    end
    local args = {
        [1] = game:GetService("Players").LocalPlayer,
        [2] = v,
        [3] = "A"
    }
    theremote:FireServer(unpack(args))
end

for i,v in pairs(game.Workspace.Towers:GetChildren()) do
    if v:FindFirstChild("Owner") then
        if v.Owner.Value == game.Players.LocalPlayer.Name then
            if v.Upgrades:FindFirstChild("6") then
                upgrade(v)
                if dowait then
                    wait(1)
                end
            end
        end
    end
end
