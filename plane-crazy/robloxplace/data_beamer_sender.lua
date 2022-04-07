local mode = "send"
-- receive = be the one placing the blocks
-- send = the account to give instructions to place blocks

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
		    spawn(function()
		    local r = game:HttpGet("http://192.168.0.166:8080/send?data=" .. thename .. "SPLITLINE" .. color.R .. "U" .. color.G .. "U" .. color.B)
		    end)
		end
	end
end)
