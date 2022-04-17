local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local plant = "Java Tree Seed"

function spawn(item)
    local args = {[1] = item,[2] = hrp.Position}
    game:GetService("ReplicatedStorage").Resources.Remotes.MakeItem:FireServer(unpack(args))
end
function take(item)
    local args = {[1] = "Take",[2] = workspace.Items:WaitForChild(item)}
    game:GetService("ReplicatedStorage").Resources.Remotes.InteractItem:FireServer(unpack(args))
end
function use(item)
    local args = { [1] = "Use",[2] = game:GetService("Players").LocalPlayer.Character:WaitForChild(item)}
    game:GetService("ReplicatedStorage").Resources.Remotes.InteractItem:FireServer(unpack(args))
end
function destroy(item)
    local args = {[1] = "Destroy",[2] = game:GetService("Players").LocalPlayer.Character:WaitForChild(item)}
    game:GetService("ReplicatedStorage").Resources.Remotes.InteractItem:FireServer(unpack(args))
end

for i=1, 100, 1 do
    wait(0.2)
    if game.Workspace.Items:FindFirstChild(plant) then
        take(plant)
        use(plant)
        destroy(plant)
    else
        make(plant)
        take(plant)
        use(plant)
        destroy(plant)
    end
end
