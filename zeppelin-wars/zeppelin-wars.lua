local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/turtle"))()

local window1 = library:Window("Zeppelin Wars")

window1:Label("Misc", Color3.fromRGB(200, 200, 200))
window1:Button("Destroy this GUI", function()
   game.CoreGui.TurtleUiLib:Destroy()
end)


window1:Label("Teleport", Color3.fromRGB(200, 200, 200))
window1:Dropdown("Pirates", {"Pilot Seat", "Ammo Box", "Fuel Tank 1", "Fuel Tank 2", "Spawn Point"}, function(text)
    local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
    local zeppelin = {}
    for i,v in pairs(game.Workspace:GetChildren()) do
        if v.Name == "Zeppelin" then
            if v.TEAM.Value == BrickColor.new("Bright red") then
                zeppelin = v
            end
        end
    end
    if text == "Pilot Seat" then
        hrp.CFrame = zeppelin.MainSeat.ShipSeat.CFrame + Vector3.new(0, 3, 0)
    elseif text == "Ammo Box" then
        hrp.CFrame = zeppelin.AmmoBoxes.AmmoBox.MainAmmo.CFrame + Vector3.new(0, 3, 0)
    elseif text == "Fuel Tank 1" then
        hrp.CFrame = zeppelin.FuelTank1.Tank.CFrame + Vector3.new(0, 3, 0) 
    elseif text == "Fuel Tank 2" then
        hrp.CFrame = zeppelin.FuelTank2.Tank.CFrame + Vector3.new(0, 3, 0)
    elseif text == "Spawn Point" then
        hrp.CFrame = zeppelin.SpawnPoints.SpawnPoint.CFrame + Vector3.new(0, 3, 0)
    end
end)
window1:Dropdown("Patrol", {"Pilot Seat", "Ammo Box", "Fuel Tank 1", "Fuel Tank 2", "Spawn Point"}, function(text)
    local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
    local zeppelin = {}
    for i,v in pairs(game.Workspace:GetChildren()) do
        if v.Name == "Zeppelin" then
            if v.TEAM.Value == BrickColor.new("Bright blue") then
                zeppelin = v
            end
        end
    end
    if text == "Pilot Seat" then
        hrp.CFrame = zeppelin.MainSeat.ShipSeat.CFrame + Vector3.new(0, 3, 0)
    elseif text == "Ammo Box" then
        hrp.CFrame = zeppelin.AmmoBoxes.AmmoBox.MainAmmo.CFrame + Vector3.new(0, 3, 0)
    elseif text == "Fuel Tank 1" then
        hrp.CFrame = zeppelin.FuelTank1.Tank.CFrame + Vector3.new(0, 3, 0)
    elseif text == "Fuel Tank 2" then
        hrp.CFrame = zeppelin.FuelTank2.Tank.CFrame + Vector3.new(0, 3, 0)
    elseif text == "Spawn Point" then
        hrp.CFrame = zeppelin.SpawnPoints.SpawnPoint.CFrame + Vector3.new(0, 3, 0)
    end
end)
window1:Dropdown("Pirates (Skirmish)", {"Pilot Seat", "Ammo Box", "Fuel Tank", "Spawn Point"}, function(text)
    local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
    local zeppelin = {}
    for i,v in pairs(game.Workspace:GetChildren()) do
        if v.Name == "Zeppelin" then
            if v.TEAM.Value == BrickColor.new("Bright red") then
                zeppelin = v
            end
        end
    end
    if text == "Pilot Seat" then
        hrp.CFrame = zeppelin.MainSeat.ShipSeat.CFrame + Vector3.new(0, 3, 0)
    elseif text == "Ammo Box" then
        hrp.CFrame = zeppelin.AmmoBoxes.AmmoBox.MainAmmo.CFrame + Vector3.new(0, 3, 0)
    elseif text == "Fuel Tank" then
        hrp.CFrame = zeppelin.FuelTank.Tank.CFrame + Vector3.new(0, 3, 0)
    elseif text == "Spawn Point" then
        hrp.CFrame = zeppelin.SpawnPoints.SpawnPoint.CFrame + Vector3.new(0, 3, 0) 
    end
end)
window1:Dropdown("Patrol (Skirmish)", {"Pilot Seat", "Ammo Box", "Fuel Tank"}, function(text)
local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
    local zeppelin = {}
    for i,v in pairs(game.Workspace:GetChildren()) do
        if v.Name == "Zeppelin" then
            if v.TEAM.Value == BrickColor.new("Bright blue") then
                zeppelin = v
            end
        end
    end
    if text == "Pilot Seat" then
        hrp.CFrame = zeppelin.MainSeat.ShipSeat.CFrame + Vector3.new(0, 3, 0)
    elseif text == "Ammo Box" then
        hrp.CFrame = zeppelin.AmmoBoxes.AmmoBox.MainAmmo.CFrame + Vector3.new(0, 3, 0)
    elseif text == "Fuel Tank" then
        hrp.CFrame = zeppelin.FuelTank.Tank.CFrame + Vector3.new(0, 3, 0)
    elseif text == "Spawn Point" then
        hrp.CFrame = zeppelin.SpawnPoints.SpawnPoint.CFrame + Vector3.new(0, 3, 0)
    end
end)

--[[
window1:Button("Button name", function()
   print("pressed button")
end)

window1:Toggle("Example toggle", true, function(bool)
    print(bool) -- bool is true or false depending on the state of the toggle
end)

window1:ColorPicker("Color Picker", Color3.fromRGB(255, 255, 255), function(color)
   print(color)
end)

window1:Slider("Example Slider",0,100,20, function(value)
   print(value)
end)

window1:Label("Credits to Intrer#0421", Color3.fromRGB(127, 143, 166))

window1:Box("Walkspeed", function(text, focuslost)
   if focuslost then
   print(text)
   end
end)

local dropdown = window1:Dropdown("Example dropdown", {"Button 1", "Button 2", "Third button"}, function(name)
   print(name)
end)

dropdown:Button("New button")

dropdown:Remove("Button")

]]
