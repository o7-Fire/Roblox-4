-- abilities can be activated regardless if they unlocked it or not
local foryouonly = true
local farmonly = true

function activate(v)
    local args = {
        [1] = v,
        [2] = v.Abilities.AbilityID
    }
    game:GetService("ReplicatedStorage").AbilityEvent:FireServer(unpack(args))
end

for i,v in pairs(game.Workspace.Towers:GetChildren()) do
    if foryouonly then
        if farmonly then
            if v.Name == "Server Farm" and v.Owner.Value == game.Players.LocalPlayer.Name then
                activate(v)
            end
        else
            if v.Owner.Value == game.Players.LocalPlayer.Name then
                pcall(function()
                    activate(v)
                end)
            end
        end
    else
        if farmonly then
            if v.Name == "Server Farm" then
                activate(v)
            end
        else
            pcall(function()
                activate(v)
            end)
        end
    end
end
