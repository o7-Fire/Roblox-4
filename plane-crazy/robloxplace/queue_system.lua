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

local queue = {}
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
		    table.insert(queue, tonumber(Split(thename, "T")[2]))
		end
	end
end)

spawn(function()
    while true do
        wait()
        if _G.SDFUSEGUHSRFGUI == randomvar then
            if #queue > 0 then
                local firstqueue = queue[1]
                print(firstqueue)
                table.remove(queue, 1)
                local args = {
                    [1] = "T" .. tostring(firstqueue),
                    [2] = color
                }
                game:GetService("ReplicatedStorage").UpdateColor:FireServer(unpack(args))
                wait(4.2)
            end
        else
            break
        end
    end
end)
