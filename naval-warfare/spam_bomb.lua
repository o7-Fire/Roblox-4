
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local doa = true

game:GetService("RunService").Stepped:Connect(function()
    if UserInputService:IsKeyDown(Enum.KeyCode.B) then
        game:GetService("ReplicatedStorage").Event:FireServer("bomb")
    end
end)
