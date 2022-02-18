_G.code = "AVRUERBWI"

function RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end
local DoCheck = RandomVariable(20)
_G.DoCheck = DoCheck

local mt = getrawmetatable(game);
local old = mt.__namecall
setreadonly(mt,false)

mt.__namecall = newcclosure(function(remote,...)
   args = {...}
   method = tostring(getnamecallmethod())
   if method == "InvokeServer" and tostring(remote) == "PlaceBIockRegion" and _G.DoCheck == DoCheck then
        local a2 = tostring(args[2]):gsub(",", "")
        print(args[1])
        local datatosend = table.concat(
            {
                tostring(args[1].x), " ", tostring(args[1].y), " ", tostring(args[1].z) .. "N" .. a2 .. "N" .. tostring(args[3]) .. "N" .. tostring(args[4])
            })
        datatosend = datatosend:gsub(" ", "S")
        local requesttosend = table.concat({"https://WhitelistPC.nexitysecond.repl.co/send?code=", _G.code, "&data=", datatosend})
        _G.DoDoSend = true
        _G.DoDoToSend = requesttosend
   end
   return old(remote,...)
end)

setreadonly(mt,true)
