local mode = "send"
-- receive = be the one placing the blocks
-- send = the account to give instructions to place blocks

local function from_hex(hex)
        local r, g, b = string.match(hex, "^#?(%w%w)(%w%w)(%w%w)$")
        return Color3.fromRGB(tonumber(r, 16),
                tonumber(g, 16), tonumber(b, 16))
end
local function to_hex(color)
        return string.format("#%02X%02X%02X", color.R * 0xFF,
                color.G * 0xFF, color.B * 0xFF)
end

function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end
local randomvar = RandomVariable(20)
_G.SDFUSEGUHSRFGUI = randomvar
local SDFUSEGUHSRFGUI = randomvar

local color = Color3.new(0,0,0)
for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.MainGui.PaintMenu.Colors:GetChildren()) do
    v.MouseButton1Click:Connect(function()
        local bgc = v.BackgroundColor3
        color = bgc
    end)
end

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.Button1Down:Connect(function()
	if mouse.Target and mouse.Target.Parent and _G.SDFUSEGUHSRFGUI == randomvar then
		--print(mouse.Target.Name)
		local thename = mouse.Target.Name
		if thename:find("T", 1, true) == 1 then
		    local r = game:HttpGet("https://help-bots-for-rplace-copy.nexitysecond.repl.co/send?" .. thename .. "SPLITLINE" .. to_hex(color))
		end
	end
end)
