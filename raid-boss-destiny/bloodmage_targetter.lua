local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local doa = true

game:GetService("RunService").Stepped:Connect(function()
    if UserInputService:IsKeyDown(Enum.KeyCode.G) then
        if doa then
            doa = false
            local bosses = game.Workspace.Bosses:GetChildren()
            closest = nil
            local torso = game.Players.LocalPlayer.Character.Torso
            for i, v in pairs(bosses) do
                if v:FindFirstChild("HumanoidRootPart") then
                	if closest == nil then
                		closest = v.HumanoidRootPart
                	else
                		if (torso.Position.Magnitude - closest.Position.Magnitude) < (torso.Position.Magnitude - v.HumanoidRootPart.Position.Magnitude) then
                			closest = v.HumanoidRootPart
                 
                		end
                	end
            	end
            end
            
            local args = {
                [1] = closest.Position,
                [2] = closest,
                [3] = Enum.Material.Glass
            }
            
            game:GetService("ReplicatedStorage").ClientServer.Basic:FireServer(unpack(args))
            wait(0.3)
            doa = true
        end
    end
end)
