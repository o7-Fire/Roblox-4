--[[
game: https://www.roblox.com/games/2653064683/Word-Bomb
huge credits to this man https://v3rmillion.net/member.php?action=profile&uid=1727702
he made the initial code, i added extra features
]]--

print("Successfully Loaded")

hookfunction(error, warn)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local PlayerScripts = LocalPlayer.PlayerScripts
local ClientGameScript = PlayerScripts:WaitForChild("ClientGameScript")
local MobileService = require(ClientGameScript:WaitForChild("MobileService"))

getgenv().Settings = {
    AutoType = true,
    AutoJoin = true,
    LongWords = false,
    breakscript = false,
    TypeTime = 4
}

local Response = game:HttpGet("https://raw.githubusercontent.com/o7-Fire/Roblox-4/main/words.txt")
local Words = {}

for line in string.gmatch(Response,"[^\r\n]*") do
    if line ~= "" then
        table.insert(Words, line)
    end
end

local Response = game:HttpGet("https://raw.githubusercontent.com/o7-Fire/Roblox-4/main/longwords.txt")
local LongWords = {}

for line in string.gmatch(Response,"[^\r\n]*") do
    if line ~= "" then
        table.insert(LongWords, line)
    end
end


local KeyCodes = {
    A = 0x41,
    B = 0x42,
    C = 0x43,
    D = 0x44,
    E = 0x45,
    F = 0x46,
    G = 0x47,
    H = 0x48,
    I = 0x49,
    J = 0x4A,
    K = 0x4B,
    L = 0x4C,
    M = 0x4D,
    N = 0x4E,
    O = 0x4F,
    P = 0x50,
    Q = 0x51,
    R = 0x52,
    S = 0x53,
    T = 0x54,
    U = 0x55,
    V = 0x56,
    W = 0x57,
    X = 0x58,
    Y = 0x59,
    Z = 0x5B
}

local ui_options = {
	main_color = Color3.fromRGB(41, 74, 122),
	min_size = Vector2.new(400, 300),
	toggle_key = Enum.KeyCode.RightShift,
	can_resize = true,
}

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/gwxn/egirl/main/elerium.lua"))()

local Used = {}
local Random = Random.new()

local Typing = false

function CanType()
    local GameSpace = PlayerGui.GameUI.Container.GameSpace
    if GameSpace:FindFirstChild("DefaultUI") and GameSpace.DefaultUI:FindFirstChild("GameContainer") and GameSpace.DefaultUI.GameContainer:FindFirstChild("DesktopContainer") then
        return GameSpace.DefaultUI.GameContainer.DesktopContainer.Typebar.Typebox.Visible
    end
    return false
end

function GetJoinButton()
    local GameSpace = PlayerGui.GameUI.Container.GameSpace
    if GameSpace:FindFirstChild("DefaultUI") and GameSpace.DefaultUI:FindFirstChild("DesktopFrame") then
        return GameSpace.DefaultUI.DesktopFrame:FindFirstChild("JoinButton")
    end
end

function GetCurrentPattern()
    local GameSpace = PlayerGui.GameUI.Container.GameSpace
    if GameSpace:FindFirstChild("DefaultUI") and GameSpace.DefaultUI:FindFirstChild("GameContainer") and GameSpace.DefaultUI.GameContainer:FindFirstChild("DesktopContainer") then
        local Pattern = ""
        for _, LetterFrame in next, GameSpace.DefaultUI.GameContainer.DesktopContainer.InfoFrameContainer.InfoFrame.TextFrame:GetChildren() do
            if LetterFrame:IsA("Frame") and LetterFrame.Letter.ImageColor3 ~= Color3.new(255, 255, 255) then
                Pattern ..= LetterFrame.Letter.TextLabel.Text
            end
        end
        return Pattern
    end
end
    
function FindWord(Pattern)
    if Settings.LongWords == true then
        local total = {}
        for _, Word in next, LongWords do
            if string.find(Word, Pattern) and not table.find(Used, Word) then
                table.insert(total, Word)
            end
        end
        local theword = total[math.random(1, #total)]
        table.insert(Used, theword)
        return theword
    else
        local total = {}
        for _, Word in next, Words do
            if string.find(Word, Pattern) and not table.find(Used, Word) then
                table.insert(total, Word)
            end
        end
        local theword = total[math.random(1, #total)]
        table.insert(Used, theword)
        return theword
    end
end
    
function Type(Word)
    local Typebox = PlayerGui.GameUI.Container.GameSpace.DefaultUI.GameContainer.DesktopContainer.Typebar.Typebox
    local WaitTime = (Settings.TypeTime / 3) / 10
    if math.random(1, 5) == 1 then
        for _, Letter in next, string.split(Word, "") do
            if math.random(1, 5) == 1 then
                Typebox.Text ..= string.char(math.random(string.byte('A'), string.byte('Z')))
                wait(WaitTime / 1.5)
                Typebox.Text ..= string.char(math.random(string.byte('A'), string.byte('Z')))
                wait(WaitTime * 2.8)
                Typebox.Text = Typebox.Text:sub(0, -2)
                wait(WaitTime / 1.3)
                Typebox.Text = Typebox.Text:sub(0, -2)
                wait(WaitTime / 1.3)
                Typebox.Text ..= Letter
                wait(WaitTime)
            else
                Typebox.Text ..= Letter
                wait(WaitTime)
            end
        end
        firesignal(Typebox.FocusLost, true)
    else
        for _, Letter in next, string.split(Word, "") do
            Typebox.Text ..= Letter
            wait(WaitTime)
        end
        firesignal(Typebox.FocusLost, true)
    end
end
    
function TypeWord(Pattern)
    local Word = FindWord(string.lower(Pattern))
    if Word then
        Type(Word)
    end
    wait(0.25)
    Typing = false
end

do
    local Window = library:AddWindow("Word Bomb", {
        main_color = Color3.fromRGB(41, 74, 122),
        min_size = Vector2.new(500, 300),
        toggle_key = Enum.KeyCode.RightShift,
        can_resize = true
    })

    local Tab = Window:AddTab("Main")

    local AutoTypeSwitch = Tab:AddSwitch("Auto Type", function(Value)
        Settings.AutoType = Value
    end)
    AutoTypeSwitch:Set(Settings.AutoType)

    local AutoJoinSwitch = Tab:AddSwitch("Auto Join", function(Value)
        Settings.AutoJoin = Value
    end)
    AutoJoinSwitch:Set(Settings.AutoJoin)
    
    local LongWordsSwitch = Tab:AddSwitch("Long Words Only", function(Value)
        Settings.LongWords = Value
    end)
    LongWordsSwitch:Set(Settings.LongWords)
    
    local BreakScriptSwitch = Tab:AddSwitch("Break Script", function(Value)
        Settings.breakscript = Value
    end)
    BreakScriptSwitch:Set(Settings.breakscript)
    
    local TypeTimeSlider = Tab:AddSlider("Type Time", function(Value)
        Settings.TypeTime = Value
    end, {
        ["min"] = 0,
        ["max"] = 6,
        ["readonly"] = false
    })
    TypeTimeSlider:Set(Settings.TypeTime)

    Tab:Show()
    library:FormatWindows()
end

while wait() do
    if Settings.breakscript == true then
        game.CoreGui.imgui:Destroy()
        break
    end
    --[[if CanType() then
        if not Typing then
            wait(math.random(1, 6) / 3)
            Typing = true
            TypeWord(GetCurrentPattern())
        end
    end]]--
    local JoinButton = GetJoinButton()
    if JoinButton then
        wait(math.random(1, 5))
        Used = {}
        firesignal(JoinButton.MouseButton1Down)
    end
    if Settings.AutoType and CanType() then
        if not Typing then
            wait(math.random(7, 10) / 6)
            Typing = true
            TypeWord(GetCurrentPattern())
        end
    end
    if Settings.AutoJoin then
        local JoinButton = GetJoinButton()
        
    end
end
