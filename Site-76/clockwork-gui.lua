local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local settings = {"Rough", "Coarse", "1:1", "Fine", "Very Fine"}
local settingselected = "1:1"
local toolselected = ""
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
