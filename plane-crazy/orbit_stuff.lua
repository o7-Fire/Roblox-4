local count = 0 --Increment
_G.Enabled = true

while true do
    --Start at origin then apply an offset using Angles()
    if _G.Enabled then
        local build = game.workspace:WaitForChild(game.Players.LocalPlayer.Name..'Aircraft')
        for i, blocks in pairs(build:GetChildren()) do
            if blocks.ClassName == "Model" then
                blocks.PrimaryPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position) * CFrame.Angles(0, count, 0) * CFrame.new(0, 0, 100)
             
                --Increment i by 5 degrees every wait()
                count = count + math.rad(3)
                wait()
            end
        end
    else
        break
    end
end
