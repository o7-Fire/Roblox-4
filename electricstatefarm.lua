_G.Enabled = true
local plr = game.Players.LocalPlayer

while true do
    if _G.Enabled == false then
        break
    end
    wait(1)
    
    -- harvest and plant
    for i,v in pairs(game.Workspace.Buildings[plr.Name]:GetChildren()) do
        if v.Name == "Carrot Farm" or v.Name == "Tomato Farm" or v.Name == "Corn Farm" then
            if v["3"].Transparency == 0 or v["1"].Transparency == 1 then
                local args = {
                    [1] = 40,
                    [2] = v
                }
                game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(unpack(args))
            end
        end
    end
    --sell
    for i,v in pairs(plr.Backpack:GetChildren()) do
        wait(0.5)
        if v.Name == "[Farmer] Carrot" or v.Name == "[Farmer] Tomato" or v.Name == "[Farmer] Corn" then
            v.Parent = plr.Character
            local args = {
                [1] = 41,
                [2] = workspace.Buildings[plr.Name]:FindFirstChild("Capital Cargo Station"),
                [3] = plr.Character[v.Name]
            }
            game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(unpack(args))
        end
    end
    --redundancy selling
    for i,v in pairs(plr.Character:GetChildren()) do
        if v.Name == "[Farmer] Carrot" or v.Name == "[Farmer] Tomato" or v.Name == "[Farmer] Corn" then
            local args = {
                [1] = 41,
                [2] = workspace.Buildings[plr.Name]:FindFirstChild("Capital Cargo Station"),
                [3] = v
            }
            game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(unpack(args))
        end
    end
end
