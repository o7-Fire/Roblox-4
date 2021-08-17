-- a
local Luminosity = loadstring(game:HttpGet("https://raw.githubusercontent.com/iHavoc101/Genesis-Studios/main/UserInterface/Luminosity.lua", true))()
local Window = Luminosity.new("PCTools", "v1.0.0", 4370345701)
local mouse = game.Players.LocalPlayer:GetMouse()
local uis = game:GetService("UserInputService")

_G.Build1 = false
mouse.Button1Down:Connect(function()
    if _G.Build1 then
        if mouse.Target and uis:IsKeyDown(Enum.KeyCode.B) then
            warn(mouse.Target:GetFullName())
        end
    end
end)

local Tab1 = Window.Tab("Building", 6026568198)

local Folder = Tab1.Folder("Building Improvement Tools", "")
Folder.Switch("copy paste parts of your build", function(Status)
    _G.Build1 = Status
end)

local Folder = Tab1.Folder("This GUI", "")
Folder.Button("destroy this GUI", "click", function()
    game:GetService("CoreGui").Luminosity:Destroy()
end)

game:GetService("UserInputService").InputBegan:Connect(function(Input)
if Input.KeyCode == Enum.KeyCode.N then
Window:Toggle()
end
end)
