local mode = "receive"
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
spawn(function()
    while true do
        wait(4.3)
        if _G.SDFUSEGUHSRFGUI == randomvar then
            pcall(function()
                local r = game:HttpGet("http://192.168.0.166:8080/receive")
                if r ~= "no remotes to beam" then
                    local rdata = Split(r, "SPLITLINE")
                    local cd = Split(rdata[2], "U")
                    local args = {
                        [1] = rdata[1],
                        [2] = Color3.new(cd[1], cd[2], cd[3])
                    }
                    game:GetService("ReplicatedStorage").UpdateColor:FireServer(unpack(args))
                end
            end)
        else
            break
        end
    end
end)
