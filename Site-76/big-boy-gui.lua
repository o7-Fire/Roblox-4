local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local settings = {"Rough", "Coarse", "1:1", "Fine", "Very Fine"}
local settingselected = "1:1"
local toolselected = ""
local hitboxexpander = false
local autolocket = false
local leverremote = game:GetService("ReplicatedStorage").Remotes:FindFirstChild("914Lever")

function lever(setting, item)
    local args = {
        [1] = setting,
        [2] = item
    }
    leverremote:FireServer(unpack(args))
end

local thegui = library:CreateWindow({
    Name = "Remote Clockwork Machine",
    Themeable = {
        Info = "made by Nexity#3200"
    }
})
local cctab = thegui:CreateTab({
    Name = "CC"
})
local settingmenu = cctab:CreateSection({
    Name = "Settings"
})
local itemsmenu = cctab:CreateSection({
    Name = "Tools"
})

for _, setting in pairs(settings) do
    settingmenu:AddButton({
        Name = setting,
        Callback = function()
            settingselected = setting
        end
    })
end

itemsmenu:AddSearchBox({
    Name = "Select tools",
    List = game.Players.LocalPlayer.Backpack,
	Callback = function(tool)
	    toolselected = tool.Name
	end
})

itemsmenu:AddButton({
    Name = "Activate Machine",
    Callback = function()
        lever(settingselected, toolselected)
    end
})

local general = cctab:CreateSection({
    Name = "Others"
})

general:AddToggle({
    Name = "Auto Lovecraftian Locket",
    Callback = function()
        if autolocket then
            autolocket = false
        else
            autolocket = true
        end
    end
})

general:AddToggle({
    Name = "Hitbox Expander",
    Callback = function()
        if hitboxexpander then
            hitboxexpander = false
        else
            hitboxexpander = true
        end
    end
})

spawn(function()
    while true do
        if autolocket then
            wait(0.2)
            if game.Players.LocalPlayer.Character.Humanoid.Health > 350 then
                local args = {
                [1] = "Lovecraftian Locket"
                }
                game:GetService("ReplicatedStorage").Remotes.DropItem:InvokeServer(unpack(args))
                wait(0.2)
                game:GetService("ReplicatedStorage").Remotes.UseLocket:FireServer()
            end
        else
            wait(1)
        end
    end
end)

spawn(function()
    while wait(0.1) do
        local sg = game:GetService("StarterGui")
        local plrs = game:GetService("Players")
        local lplr = plrs.LocalPlayer
        local mouse = lplr:GetMouse()
        
        function dov(v)
            pcall(function()
                v.Character.HumanoidRootPart.Size = Vector3.new(7, 7, 7)
                v.Character.HumanoidRootPart.Transparency = 1
                v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
                v.Character.HumanoidRootPart.Material = "Neon"
                v.Character.HumanoidRootPart.CanCollide = false
            end)
        end
        function doy(v)
            pcall(function()
                v.Character.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
                v.Character.HumanoidRootPart.Transparency = 1
                v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
                v.Character.HumanoidRootPart.Material = "Neon"
                v.Character.HumanoidRootPart.CanCollide = false
            end)
        end
        if hitboxexpander then
            if lplr.Name == "Prisoner" or lplr.Name == "Chaos Insurgency" then
                for _, v in pairs(plrs:GetPlayers()) do
                    if tostring(v.Name) ~= tostring(lplr.Name) and tostring(v.Team) ~= "Prisoner" and tostring(v.Team) ~= "Chaos Insurgency" then --This is where I think the problem might be, it's not reading the last and condition correctly
                        dov(v)
                    else
                        doy(v)
                    end
                end
            else
                for _, v in pairs(plrs:GetPlayers()) do
                    if tostring(v.Name) ~= tostring(lplr.Name) and tostring(v.Team) ~= "Foundation" then --This is where I think the problem might be, it's not reading the last and condition correctly
                        dov(v)
                    else
                        doy(v)
                    end
                end
            end
        else
            for _, v in pairs(plrs:GetPlayers()) do
                doy(v)
            end
        end
    end
end)

spawn(function()
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
                        if k:IsA'BasePart' and k.Name ~= "HumanoidRootPart" then
                            if hitboxexpander then
                                if k:FindFirstChild("Cham") then
                                    k.Cham.Transparency=.98
                                else
                                    local cham = Instance.new('BoxHandleAdornment',k)
                                    cham.ZIndex= 10
                                    cham.Adornee=k
                                    cham.AlwaysOnTop=true
                                    cham.Size=k.Size
                                    cham.Transparency=.98
                                    cham.Color3=v.TeamColor.Color
                                    cham.Name = "Cham"
                                end
                            elseif k:FindFirstChild("Cham") then
                                k.Cham.Transparency=1
                            end
                        end
                    end
                end
            end)
        end
    end
    
    while wait() do
        UpdatePlayerChams()
    end
end)
