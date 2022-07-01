-- gives the overclock effect to your server farms lol
for i,v in pairs(game.Workspace.Towers:GetChildren()) do
    if v.Name == "Server Farm" then
        local args = {
            [1] = v,
            [2] = v.Abilities.AbilityID
        }
        game:GetService("ReplicatedStorage").AbilityEvent:FireServer(unpack(args))
    end
end
