local Flux = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt")()
local Window = Flux:Window("PC Tools", "Press N to open/close", Color3.fromRGB(255, 110, 48), Enum.KeyCode.N)
local mouse = game.Players.LocalPlayer:GetMouse()
local uis = game:GetService("UserInputService")
_G.Whitelist = false -- dont worry about this
_G.WhitelistCode = ""
local blocks = {}
local subdomain = "WhitelistPCTestBuild"

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
Tab1:Button("Enable receive data to whitelist user", "Click this to start receiving place remotes from whitelist user", function()
    _G.Whitelist = true
    game:HttpGet(table.concat({"https://", subdomain, ".nexitysecond.repl.co/user?code=", _G.WhitelistCode, "&name=", game.Players.LocalPlayer.Name, "&active=yes"}))
end)
Tab1:Button("Enable send data to whitelist user", "Click this to start sending place remotes to whitelist user", function()
    _G.Whitelist = false
    game:HttpGet(table.concat({"https://", subdomain, ".nexitysecond.repl.co/user?code=", _G.WhitelistCode, "&name=", game.Players.LocalPlayer.Name, "&active=no"}))
end)
Tab1:Button("destroy this GUI", "does what it says", function()
    game:GetService("CoreGui").FluxLib:Destroy()
    _G.DoCheck = ""
end)

-- handle new blocks placed
game.Workspace.PlayerAircraft:WaitForChild(game.Players.LocalPlayer.Name).ChildAdded:connect(function(v)
    table.insert(blocks, v)
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
            local r = game:HttpGet("https://", subdomain, ".nexitysecond.repl.co/receive?code=" .. _G.WhitelistCode)
            local splitted = Split(r, "SPACE")
            local datatodo = Split(splitted, "ZXC")[2]
            for i,v in pairs(datatodo) do
                print(v)
                
                if Split(splitted, "ZXC")[1] then
                    local timea = os.time()
                    game.Workspace.PlayerAircraft:WaitForChild(game.Players.LocalPlayer.Name).ChildAdded:connect(function(b)
                        table.insert(blocks, b)
                    end)
                end
                
                spawn(function()
                    loadstring(v)()
                end)
                
                if Split(splitted, "ZXC")[1] then
                    local oldb = len(blocks)
                    local theblockname = ""
                    while true do
                        if len(blocks) ~= oldb then
                            local name = Split(splitted, "ZXC")[3]
                            blocks[len(blocks)].Name = name
                            theblockname = name
                            break
                        end
                        wait()
                    end
                end
                
                local newtime = os.time()
                if newtime - timea > 0.7 then
                    wait(newtime - timea)
                else
                    wait(0.7)
                end
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
        spawn(function()
            local oldb = len(blocks)
            local theblockname = ""
            while true do
                if len(blocks) ~= oldb then
                    local randomn = RandomVariable(20)
                    blocks[len(blocks)].Name = randomn
                    theblockname = randomn
                    break
                end
                wait()
            end
            local a2 = tostring(args[2]):gsub(",", "")
            print(args[1])
            local datatosend = table.concat(
                {
                    tostring(args[1].x), " ", tostring(args[1].y), " ", tostring(args[1].z) .. "N" .. a2 .. "N" .. tostring(args[3]) .. "N" .. tostring(args[4])
                })
            datatosend = datatosend:gsub(" ", "S")
            local requesttosend = table.concat({"https://", subdomain, ".nexitysecond.repl.co/send?code=", _G.WhitelistCode, "&remote=place", "&block=", theblockname, "&data=", datatosend})
            _G.DoDoSend = true
            _G.DoDoToSend = requesttosend
        end)
        return old(remote,...)
    else
        return old(remote,...)
    end
end)

setreadonly(mt,true)
