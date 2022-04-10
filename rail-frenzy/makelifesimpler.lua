-- insta break stuff
local settings = {repeatamount = 5, inclusions = {"damage_item"}}

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
local function isincluded(uh)
   for i,o in next, settings.inclusions do
       if uh.Name == o then
           return true
       end
   end
   return false
end
mt.__namecall = function(uh, ...)
   local args = {...}
   local method = getnamecallmethod()
   if (method == "FireServer" or method == "InvokeServer") and isincluded(uh) then
       for i = 1,settings.repeatamount do
           old(uh, ...)
       end
   end
   return old(uh, ...)
end
setreadonly(mt, true)

-- auto send items to wagon
spawn(function()
    while true do
        wait(0.2)
        local wagons = {}
        for i,v in pairs(game.Workspace.Map.Wagons:GetChildren()) do
            if v.Name == "Storage" then
                table.insert(wagons, v)
            end
        end
        local args = {
            [1] = wagons[math.random(1, #wagons)],
            [2] = "Drop"
        }
        
        game:GetService("ReplicatedStorage").Knit.Services.ItemService.RE.wagon:FireServer(unpack(args))
    end
end)

-- chop everything gui
local Flux = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt")()
local Window = Flux:Window("the gui", "Press N to open/close", Color3.fromRGB(255, 110, 48), Enum.KeyCode.N)

local Tab1 = Window:Tab("do stuff", "http://www.roblox.com/asset/?id=6023426915")
Tab1:Label("Made by Nexity#3200")

Tab1:Button("try to break all stuff", "break rocks and trees", function()
    for i,v in pairs(game.Workspace.Map.Items:GetDescendants()) do
        if v.Name == "Hitbox" then
            local args = {
                [1] = Vector2.new(v.Position.x / 5, v.Position.z / 5)
            }
            
            game:GetService("ReplicatedStorage").Knit.Services.ItemService.RE.damage_item:FireServer(unpack(args))
        end
    end
end)
