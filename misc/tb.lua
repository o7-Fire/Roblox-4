-- not mine, all credits go to https://v3rmillion.net/member.php?action=profile&uid=482542
-- https://v3rmillion.net/showthread.php?tid=1128635&pid=7979082

wait(15)
local Message = "Nexity said hi (plane crazy community)" -- Message to say after joining a server
local MessageMultiplier = 5 -- Times to say message before joining new server
local PlaceIDOverride = "" -- leave this blank, unless you want to join a child place of the game you're in (a specific world)
local ExcludedAccounts = {"MrBlobFish13","SusRickje","","",""} -- accounts that shouldn't be used as bots, if you wanna join and flex your might!!!!!
local WaitAfterOnExecute = 2 -- time to wait after firing the function below, and before joining a new server
local function OnExecute()
    -- function to run, or thing to do after entering a server
    -- for a crash bot or similar, you'd put a crash script here
    -- leave blank, or like this to make it not do anything (DO NOT REMOVE THE FUNCTION! LOL)
end





local Players = game:GetService("Players")
if not Players.LocalPlayer then
    game:GetService("Players"):GetPropertyChangedSignal("LocalPlayer"):Wait()
end

for i = 1,#ExcludedAccounts do
    if ExcludedAccounts[i] == game.Players.LocalPlayer.Name then
        return
    end
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
repeat wait() until ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
repeat wait() until ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
for i = 1,tonumber(MessageMultiplier) do
    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(tostring(Message), "All")
end
local HttpService = game:GetService("HttpService")
local function GetServers(placeid)
    local Servers = {}
    local CurrentCursor = ""
    if placeid == nil then
        placeid = game.PlaceId
    end
    repeat
        local ListRaw = game:HttpGet("https://games.roblox.com/v1/games/"..tostring(placeid).."/servers/Public?sortOrder=Asc&limit=100&cursor="..CurrentCursor)
        local CurrentList = HttpService:JSONDecode(ListRaw) -- done in 2 steps for getting cursor later
        if CurrentList.data == nil then
            game.StarterGui:SetCore("SendNotification", {
                Title = "ERROR";
                Text = "Something went wrong with grabbing servers (data doesn't exist)";
                Icon = "rbxassetid://2541869220";
                Duration = 7;
            })
            break
        end
        for i = 1,#CurrentList.data do
            if CurrentList ~= nil then
                if CurrentList.data[i].maxPlayers - 1 > CurrentList.data[i].playing then
                    table.insert(Servers, CurrentList.data[i])
                end
            end
        end
        local CursorIndex = string.find(ListRaw, "nextPageCursor")
        local EndComma = string.find(ListRaw, ",", CursorIndex)
        local ToEdit = string.sub(ListRaw, CursorIndex, EndComma - 1)
        local ToEdit = string.gsub(ToEdit, '"', "")
        CurrentCursor = string.gsub(ToEdit, 'nextPageCursor:', "")
        wait()
    until CurrentCursor == "null"
    return Servers
end

OnExecute()
wait(WaitAfterOnExecute) -- uuuuh simple

local Servers
if PlaceIDOverride ~= "" and tonumber(PlaceIDOverride) ~= nil then
    Servers = GetServers(tonumber(PlaceIDOverride))
else
    Servers = GetServers(game.PlaceId)
end
game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Servers[math.random(1,#Servers)].id, Players.LocalPlayer)
while wait(5) do
    local Servers
    if PlaceIDOverride ~= "" and tonumber(PlaceIDOverride) ~= nil then
        Servers = GetServers(tonumber(PlaceIDOverride))
    else
        Servers = GetServers(game.PlaceId)
    end
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Servers[math.random(1,#Servers)].id, Players.LocalPlayer)
end
