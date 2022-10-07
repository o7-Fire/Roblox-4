local faces = {"Front","Back","Bottom","Left","Right","Top"}
local function ESP(v, color)
    for i, face in pairs(faces) do
        local surface = Instance.new("SurfaceGui")
        surface.Parent = v
        surface.Name = "cham"
        surface.Face = Enum.NormalId[face]
        surface.AlwaysOnTop = true
        local mainFrame = Instance.new("Frame")
        mainFrame.Parent = surface
        mainFrame.BackgroundColor3 = color
        mainFrame.BorderSizePixel = 0
        mainFrame.BackgroundTransparency = 0.8
        mainFrame.Size = UDim2.new(1,0,1,0)
    end
end

while true do
    wait(.25)
    for i,v in pairs(game.Workspace.Spiders:GetChildren()) do
        if v:FindFirstChild("Hitbox") then
            if not v.Hitbox:FindFirstChild("cham") then
                coroutine.wrap(ESP)(v.Hitbox, Color3.fromRGB(152,115,172))
            end
        end
    end
    for i,v in pairs(game.Workspace.Candy:GetChildren()) do
        if v:FindFirstChild("CandyHitbox") then
            if not v.CandyHitbox:FindFirstChild("cham") then
                coroutine.wrap(ESP)(v.CandyHitbox, Color3.fromRGB(255,165,0))
            end
        end
    end
end
