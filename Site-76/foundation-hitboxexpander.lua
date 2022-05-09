_G.HeadSize = 7
_G.Disabled = true

spawn(function()
while wait() do
    spawn(function()
        local sg = game:GetService("StarterGui")
        local plrs = game:GetService("Players")
        local lplr = plrs.LocalPlayer
        local mouse = lplr:GetMouse()
        for _, v in pairs(plrs:GetPlayers()) do
            if tostring(v.Name) ~= tostring(lplr.Name) and tostring(v.Team) ~= "Foundation" then --This is where I think the problem might be, it's not reading the last and condition correctly
                pcall(function()
                    v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                    v.Character.HumanoidRootPart.Transparency = 1
                    v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
                    v.Character.HumanoidRootPart.Material = "Neon"
                    v.Character.HumanoidRootPart.CanCollide = false
                end)
            else
                pcall(function()
                    v.Character.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
                    v.Character.HumanoidRootPart.Transparency = 1
                    v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
                    v.Character.HumanoidRootPart.Material = "Neon"
                    v.Character.HumanoidRootPart.CanCollide = false
                end)
            end
        end
    end)
end
end)

function isnil(thing)
return (thing == nil)
end


local function round(n)
return math.floor(tonumber(n) + 0.5)
end

function UpdatePlayerChams()
    for i,v in pairs(game:GetService'Players':GetChildren()) do
        pcall(function()
            if not isnil(v.Character) then
                for _,k in pairs(v.Character:GetChildren()) do
                    if k:IsA'BasePart' and not k:FindFirstChild'Cham' and k.Name ~= "HumanoidRootPart" then
                        local cham = Instance.new('BoxHandleAdornment',k)
                        cham.ZIndex= 10
                        cham.Adornee=k
                        cham.AlwaysOnTop=true
                        cham.Size=k.Size
                        cham.Transparency=.99
                        cham.Color3=v.TeamColor.Color
                        cham.Name = 'Cham'
                    end
                end
            end
        end)
    end
end

while wait() do
UpdatePlayerChams()
end
