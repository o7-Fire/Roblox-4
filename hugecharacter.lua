local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local doa = true

game:GetService("RunService").Stepped:Connect(function()
    if UserInputService:IsKeyDown(Enum.KeyCode.B) then
        if doa then
            fireclickdetector(workspace.ClothingRacks.ClothingRack.Hitbox.ClickDetector)
            for _,v in ipairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                if v.Name == "OriginalSize" then v:Destroy() end
            end
            for _,v in ipairs(game:GetService("Players").LocalPlayer.Character.Humanoid:GetChildren()) do
                if string.find(v.Name,"Scale") then v:Destroy() end
            end
        end
        wait(.1)
    end
end
