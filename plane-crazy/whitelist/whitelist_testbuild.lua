local Flux = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt")()
local Window = Flux:Window("PC Tools", "Press N to open/close", Color3.fromRGB(255, 110, 48), Enum.KeyCode.N)
local mouse = game.Players.LocalPlayer:GetMouse()
local uis = game:GetService("UserInputService")
_G.Whitelist = false -- dont worry about this
_G.WhitelistCode = ""
_G.WhitelistName = ""

function RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end

function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

local DoCheck = RandomVariable(20)
_G.DoCheck = DoCheck -- for debugging

local Tab1 = Window:Tab("Whitelist", "http://www.roblox.com/asset/?id=6023426915")
Tab1:Label("Made by Nexity#3200")
Tab1:Textbox("Whitelist Code", "Create a code and make sure both people have the same code", true, function(text)
    _G.WhitelistCode = text
end)
Tab1:Textbox("Whitelist User", "Input the user (the other person not you) name", true, function(text)
    _G.WhitelistName = text
end)
Tab1:Button("Enable receive data to whitelist user", "Click this to start receiving place remotes from whitelist user", function()
    _G.Whitelist = true
end)
Tab1:Button("Enable send data to whitelist user", "Click this to start sending place remotes to whitelist user", function()
    _G.Whitelist = false
end)
Tab1:Button("destroy this GUI", "does what it says", function()
    game:GetService("CoreGui").FluxLib:Destroy()
    _G.DoCheck = ""
end)

-- request handler because of black magic happening in metatable
_G.DoDoSend = false
_G.DoDoToSend = ""
spawn(function()
    while true do
        if _G.DoCheck ~= DoCheck then
            break
        end
        wait()
        if _G.DoDoSend then
            _G.DoDoSend = false
            spawn(function()
                game:HttpGet(_G.DoDoToSend)
            end)
        end
    end
end)

-- for receiving
spawn(function()
    while true do
        if _G.DoCheck ~= DoCheck then
            break
        end
        if _G.Whitelist then
            local r = game:HttpGet("https://WhitelistPC.nexitysecond.repl.co/receive?code=" .. _G.WhitelistCode)
            local datatodo = Split(r, "SPACE")
            for i,v in pairs(datatodo) do
                print(v)
                spawn(function()
                    loadstring(v)()
                end)
                wait(0.7)
            end
        end
        wait()
    end
end)

-- for sending
local mt = getrawmetatable(game);
local old = mt.__namecall
setreadonly(mt,false)

mt.__namecall = newcclosure(function(remote,...)
   args = {...}
   method = tostring(getnamecallmethod())
   if method == "InvokeServer" and tostring(remote) == "PlaceBIockRegion" and _G.DoCheck == DoCheck and _G.Whitelist == false then
        local YourXOffset = ""
        local TheirXOffset = ""
        for i,v in pairs(workspace.BuildingZones:GetChildren()) do 
            if tostring(v.Owner.Value) == game.Players.LocalPlayer.Name then
                YourXOffset = v.CFrame.x
            end
            if tostring(v.Owner.Value) == _G.WhitelistName then
                TheirXOffset = v.CFrame.x
            end
        end
        
        print("ok", YourXOffset, TheirXOffset)
        print("args", args)
        print(tostring(math.round(YourXOffset - TheirXOffset) - args[1].x))
        local a2 = tostring(args[2]):gsub(",", "")
        local datatosend = table.concat(
            {
                tostring(math.round(YourXOffset - TheirXOffset) - args[1].x), " ", tostring(args[1].y), " ", tostring(args[1].z) .. "N" .. a2 .. "N" .. tostring(args[3]) .. "N" .. tostring(args[4])
            })
        datatosend = datatosend:gsub(" ", "S")
        local requesttosend = table.concat({"https://WhitelistPC.nexitysecond.repl.co/send?code=", _G.WhitelistCode, "&data=", datatosend})
        _G.DoDoSend = true
        _G.DoDoToSend = requesttosend
   end
   return old(remote,...)
end)

setreadonly(mt,true)
