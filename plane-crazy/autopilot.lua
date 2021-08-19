--something i made a long time ago
-- ill make a better version soon

-- Gui to Lua
-- Version: 3.2

-- Instances:

local PlaneCrazyAutopilot = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Status = Instance.new("TextLabel")
local Orientation = Instance.new("TextLabel")
local E = Instance.new("TextLabel")
local TextBox = Instance.new("TextBox")
local Height = Instance.new("TextLabel")
local Enable = Instance.new("TextButton")
local Disable = Instance.new("TextButton")

--Properties:

PlaneCrazyAutopilot.Name = "Plane Crazy Autopilot"
PlaneCrazyAutopilot.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
PlaneCrazyAutopilot.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = PlaneCrazyAutopilot
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.Position = UDim2.new(0.674254715, 0, 0.284542263, 0)
Frame.Size = UDim2.new(0, 386, 0, 275)

Status.Name = "Status"
Status.Parent = Frame
Status.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Status.BackgroundTransparency = 1.000
Status.Position = UDim2.new(0.0507727116, 0, 0.291480392, 0)
Status.Size = UDim2.new(0, 225, 0, 50)
Status.Font = Enum.Font.SourceSans
Status.Text = "Status: "
Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Status.TextSize = 24.000
Status.TextXAlignment = Enum.TextXAlignment.Left

Orientation.Name = "Orientation"
Orientation.Parent = Frame
Orientation.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Orientation.BackgroundTransparency = 1.000
Orientation.Position = UDim2.new(0.0507727116, 0, 0.406347632, 0)
Orientation.Size = UDim2.new(0, 225, 0, 50)
Orientation.Font = Enum.Font.SourceSans
Orientation.Text = "Orientation:"
Orientation.TextColor3 = Color3.fromRGB(255, 255, 255)
Orientation.TextSize = 24.000
Orientation.TextXAlignment = Enum.TextXAlignment.Left

E.Name = "E"
E.Parent = Frame
E.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
E.BackgroundTransparency = 1.000
E.Position = UDim2.new(0.144036949, 0, 0.0338777229, 0)
E.Size = UDim2.new(0, 274, 0, 50)
E.Font = Enum.Font.SourceSans
E.Text = "Disabled"
E.TextColor3 = Color3.fromRGB(255, 255, 255)
E.TextSize = 24.000

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 1.000
TextBox.Position = UDim2.new(0.0507727116, 0, 0.184529468, 0)
TextBox.Size = UDim2.new(0, 133, 0, 42)
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "Maintain Height"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 23.000
TextBox.TextXAlignment = Enum.TextXAlignment.Left

Height.Name = "Height"
Height.Parent = Frame
Height.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Height.BackgroundTransparency = 1.000
Height.Position = UDim2.new(0.0507727116, 0, 0.537256718, 0)
Height.Size = UDim2.new(0, 225, 0, 50)
Height.Font = Enum.Font.SourceSans
Height.Text = "Height:"
Height.TextColor3 = Color3.fromRGB(255, 255, 255)
Height.TextSize = 24.000
Height.TextXAlignment = Enum.TextXAlignment.Left

Enable.Name = "Enable"
Enable.Parent = Frame
Enable.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Enable.BorderColor3 = Color3.fromRGB(85, 255, 0)
Enable.Position = UDim2.new(0.0289978664, 0, 0.75272727, 0)
Enable.Size = UDim2.new(0, 171, 0, 50)
Enable.Font = Enum.Font.SourceSans
Enable.Text = "Enable"
Enable.TextColor3 = Color3.fromRGB(0, 255, 0)
Enable.TextSize = 25.000

Disable.Name = "Disable"
Disable.Parent = Frame
Disable.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Disable.BorderColor3 = Color3.fromRGB(255, 0, 0)
Disable.Position = UDim2.new(0.521225989, 0, 0.75272727, 0)
Disable.Size = UDim2.new(0, 171, 0, 50)
Disable.Font = Enum.Font.SourceSans
Disable.Text = "Disable"
Disable.TextColor3 = Color3.fromRGB(255, 0, 0)
Disable.TextSize = 25.000

_G.enabled = false

Enable.MouseButton1Click:Connect(function()
    _G.enabled = true
    E.Text = "Enabled"
end)

Disable.MouseButton1Click:Connect(function()
    _G.enabled = false
    E.Text = "Disabled"
end)


while wait() do
    pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    orientation = game.Players.LocalPlayer.Character.HumanoidRootPart.Orientation
    Orientation.Text = "Orientation: " .. tostring(orientation.x)
    Height.Text = "Height: " .. tostring(pos.y)
    assad = 0
    pcall(function()
       maintain = tonumber(TextBox.Text)
    end)
    
    if _G.enabled then
        if orientation.x > 15 and pos.y < (maintain + 300) then
            Status.Text = "Status: Pitching down"
            keypress(0x51)
            wait(0.01)
            keyrelease(0x51)
        elseif orientation.x < -15 then
            Status.Text = "Status: Pitching up"
            keypress(0x45)
            wait(0.01)
            keyrelease(0x45)
        elseif pos.y < maintain and orientation.x < 8 then
            Status.Text = "Status: Pitching up"
            keypress(0x45)
            wait(0.01)
            keyrelease(0x45)
        elseif pos.y > (maintain + 300) and orientation.x > -8 then
            Status.Text = "Status: Pitching down"
            keypress(0x51)
            wait(0.01)
            keyrelease(0x51)
        elseif orientation.x > 5 and pos.y > 2000 and pos.y < (maintain + 300) then
            Status.Text = "Status: Pitching down"
            keypress(0x51)
            wait(0.01)
            keyrelease(0x51)
        elseif orientation.x < 1 and pos.y > 2000 and pos.y < (maintain + 300) then
            Status.Text = "Status: Pitching up"
            keypress(0x45)
            wait(0.01)
            keyrelease(0x45)
        else
            Status.Text = "Status: Stopped pitching"
        end
    else
        Status.Text = "Status: Disabled"
    end
end
