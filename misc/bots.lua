--[[
credits: Nexity#3107

commands (use chat to execute):
say [text]
edance [dance] (e.g, edance /e dance1)
enable1 [name]
enable2 [name]
enable3 [name]
disable
equiptool [toolnum]
unequiptool
enablepathfind (use walkto instead of tping for some certain games that has anticheat)
disablepathfind
breakscript (it breaks the script loop if you want to re-execute or want to stop the bot)
]]--

ControllerName = "YourRobloxAccountNameHere"
Enabled1 = false
Enabled2 = false
Enabled3 = false
pathfind = false
breakscript = false
toolenabled = false
_G.Name = ""
number = 1 -- the bot number 1-8

function tpto(offsetX, offsetY, offsetZ)
    local plr1 = game.Players.LocalPlayer.Character
    local plr2 = game.Workspace[_G.Name].HumanoidRootPart
    if pathfind then
        plr1.Humanoid:MoveTo(Vector3.new(plr2.Position.x + offsetX, plr2.Position.y + offsetY, plr2.Position.z + offsetZ))
    else
        plr1.HumanoidRootPart.CFrame = plr2.CFrame * CFrame.new(offsetX, offsetY, offsetZ)
    end
end

function sendMsg(msg)
    local tbl_main = {msg , "All"}
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(tbl_main))
end

for i, v in pairs(game.Players:GetPlayers()) do
    v.Chatted:Connect(function(message)
        if breakscript == false then
            if v.Name == ControllerName or v.Name == _G.Name then -- change the name to whoever is the main account
                if string.find(message:lower(), "say") then
                    sendMsg(string.gsub(message, "say ", ""))
                elseif string.find(message:lower(), "equiptool") then
                    a = 1
                    for i,v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
                        if v:isA("Tool") then
                            if tostring(a) == string.gsub(message, "equiptool ", "") then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                                toolenabled = true
                                --[[pcall(function()
                                    while wait() do
                                        if toolenabled then
                                            for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren())do
                                                if v.ClassName == "Tool" then
                                                v:Activate()
                                                end
                                            end
                                        else
                                            break
                                        end
                                    end
                                end)]]--
                            end
                            a = a + 1
                        end
                    end
                elseif tostring(message) == "unequiptool" then
                    toolenabled = false
                    game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                elseif string.find(message:lower(), "edance") then
                    game.Players:Chat(string.gsub(message, "edance ", ""))
                elseif tostring(message) == "enablepathfind" then
                    pathfind = true
                elseif tostring(message) == "disablepathfind" then
                    pathfind = false
                elseif string.find(message, "enable1") then
                    Enabled1 = true
                    _G.Name = string.gsub(tostring(message), "enable1 ", "")
                elseif string.find(message, "enable2") then
                    Enabled2 = true
                    _G.Name = string.gsub(tostring(message), "enable2 ", "")
                elseif string.find(message, "enable3") then
                    Enabled3 = true
                    _G.Name = string.gsub(tostring(message), "enable3 ", "")
                elseif tostring(message) == "disable" then
                    Enabled1 = false
                    Enabled2 = false
                    Enabled3 = false
                    _G.Name = ""
                elseif tostring(message) == "breakscript" then
                    breakscript = true
                    sendMsg("stopped script")
                end
            end
        end
    end)
end

spawn(function()
    while wait() do
        if Enabled1 then
            spawn(function()
                if number == 1 then
                    tpto(2, 0, 0)
                elseif number == 2 then
                    tpto(-2, 0, 0)
                elseif number == 3 then
                    tpto(4, 0, 0)
                elseif number == 4 then
                    tpto(-4, 0, 0)
                elseif number == 5 then
                    tpto(6, 0, 0)
                elseif number == 6 then
                    tpto(-6, 0, 0)
                elseif number == 7 then
                    tpto(8, 0, 0)
                elseif number == 8 then
                    tpto(-8, 0, 0)
                end
            end)
        end
        if Enabled2 then
            spawn(function()
                if number == 1 then
                    tpto(3, 0, 3)
                elseif number == 2 then
                    tpto(3, 0, -3)
                elseif number == 3 then
                    tpto(-3, 0, 3)
                elseif number == 4 then
                    tpto(-3, 0, -3)
                elseif number == 5 then
                    tpto(6, 0, 0)
                elseif number == 6 then
                    tpto(-6, 0, 0)
                elseif number == 7 then
                    tpto(0, 0, 6)
                elseif number == 8 then
                    tpto(0, 0, -6)
                end
            end)
        end
        if Enabled3 then
            spawn(function()
                if number == 1 then
                    tpto(0, 0, 2)
                elseif number == 2 then
                    tpto(0, 0, -2)
                elseif number == 3 then
                    tpto(0, 0, 4)
                elseif number == 4 then
                    tpto(0, 0, -4)
                elseif number == 5 then
                    tpto(0, 0, 6)
                elseif number == 6 then
                    tpto(0, 0, -6)
                elseif number == 7 then
                    tpto(0, 0, 8)
                elseif number == 8 then
                    tpto(0, 0, -8)
                end
            end)
        end
        if breakscript then
            break
        end
    end
end)

