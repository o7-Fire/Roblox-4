local Flux = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt")()
local Window = Flux:Window("MOTG", "Press N to open/close", Color3.fromRGB(255, 110, 48), Enum.KeyCode.N)
local lp = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local Remotes = RS.Resources.Remotes

function drink()
    for i,v in pairs(game.Workspace.Buildings:GetChildren()) do
        if v.Name == "Well" then
            Remotes.DrinkFromWell:FireServer(v)
        end
    end
end

function use(v, x)
    for i=1, x, 1 do
        spawn(function()
            Remotes.InteractItem:FireServer("Use", v)
        end)
        task.wait(.01)
    end
end

local Tab1 = Window:Tab("Misc", "http://www.roblox.com/asset/?id=6023426915")
Tab1:Button("Drink", "drinks from wells", function()
    drink()
end)
Tab1:Button("Revive Self", "revives yourself in case you die", function()
    Remotes.Spawn:FireServer(lp)
end)
Tab1:Button("End Season", "ends current season", function()
    Remotes.EndSeason:FireServer()
end)
Tab1:Button('Destroy this GUI', "boom", function()
    game:GetService("CoreGui").FluxLib:Destroy()
end)

local touse = ""
local amounttouse = 0
local Tab2 = Window:Tab("Use", "http://www.roblox.com/asset/?id=6023426915")
Tab2:Textbox("Object To Use", "Name Here", true, function(output)
    touse = tostring(output)
end)
Tab2:Textbox("Amount of Times", "Amount Here", true, function(output)
    amounttouse = tonumber(output)
end)
Tab2:Button("Use", "uses the item inf amount of times without it being destroyed", function()
    use(lp.Character[touse], amounttouse)
end)

local fishtosummon = ""
local Tab3 = Window:Tab("Fish", "http://www.roblox.com/asset/?id=6023426915")
Tab3:Textbox("Fish To Spawn", "Name Here", true, function(output)
    fishtosummon = tostring(output)
end)
Tab3:Button("Spawn", "spawns the fish, requires you to have fishing rod out", function()
    Remotes.MakeFish:FireServer(fishtosummon, lp.Character.HumanoidRootPart.Position)
end)
