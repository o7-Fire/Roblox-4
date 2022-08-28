local Flux = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt")()
local Window = Flux:Window("MOTG", "Press N to open/close", Color3.fromRGB(255, 110, 48), Enum.KeyCode.N)

local RS = game:GetService("ReplicatedStorage")
local drinkremote = RS.Resources.Remotes.DrinkFromWell
local interactremote = RS.Resources.Remotes.InteractItem

function drink()
    for i,v in pairs(game.Workspace.Buildings:GetChildren()) do
        if v.Name == "Well" then
            drinkremote:FireServer(v)
        end
    end
end

function use(v, x)
    for i=1, x, 1 do
        spawn(function()
            interactremote:FireServer("Use", v)
        end)
        task.wait(.01)
    end
end

local Tab1 = Window:Tab("Misc", "http://www.roblox.com/asset/?id=6023426915")
Tab1:Button('Drink', "drinks from wells", function()
    drink()
end)
Tab1:Button('Destroy this GUI', "boom", function()
    game:GetService("CoreGui").FluxLib:Destroy()
end)

local touse = ""
local amounttouse = 0
local Tab2 = Window:Tab("Use", "http://www.roblox.com/asset/?id=6023426915")
Tab2:Textbox('Object to Use', 'Name Here', true, function(output)
    touse = tostring(output)
end)
Tab2:Textbox('Amount of Times', 'Amount Here', true, function(output)
    amounttouse = tonumber(output)
end)
Tab2:Button('Use', "uses the item inf amount of times without it being destroyed", function()
    use(game.Players.LocalPlayer.Character[touse], amounttouse)
end)

