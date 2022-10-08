-- hold down V and left click
local plr = game.Players.LocalPlayer
local RS = game.ReplicatedStorage
local mouse = plr:GetMouse()
local UIS = game:GetService("UserInputService")

local function makeProjectile(pos)
    RS.Resources.Remotes.MakeProjectile:FireServer("Dart", pos, 99999)
end

while true do
    task.wait(.03)
    if UIS:IsKeyDown(Enum.KeyCode.V) and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        coroutine.wrap(makeProjectile)(mouse.Hit.p)
    end
end
