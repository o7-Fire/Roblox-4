local mode = "receive"
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
spawn(function()
    while true do
        wait()
        if _G.SDFUSEGUHSRFGUI == randomvar then
            local r = game:HttpGet("https://help-bots-for-rplace-copy.nexitysecond.repl.co/receive")
            if r ~= "no remotes to beam" then
                rdata = Split(r, "SPLITLINE")
                local args = {
                    [1] = rdata[1],
                    [2] = from_hex(rdata[2])
                }
                game:GetService("ReplicatedStorage").UpdateColor:FireServer(unpack(args))
                wait(4.2)
            end
        else
            break
        end
    end
end)
