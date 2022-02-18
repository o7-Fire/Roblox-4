local HttpService = game:GetService("HttpService")
local code = "AVRUERBWI"

local mt = getrawmetatable(game);
local old = mt.__namecall
setreadonly(mt,false)

mt.__namecall = newcclosure(function(remote,...)
   args = {...}
   method = tostring(getnamecallmethod())
   if method == "InvokeServer" and tostring(remote) == "PlaceBIockRegion" then
       local a2 = tostring(args[2]:gsub(",", ""))
       local datatosend = table.concat(
           {
               tostring(args[1].x), " ", tostring(args[2].y), " ", tostring(args[3].z) .. "N" .. a2 .. "N" .. tostring(args[3]) .. "N" .. tostring(args[4])
           })
       HttpService:GetAsync("https://WhitelistPC.nexitysecond.repl.co/send?code=" .. code .. "&data=" .. datatosend)
   end
   return old(remote,...)
end)
setreadonly(mt,true)

--[[
local args = {
    [1] = Vector3.new(31, 1, 1),
    [2] = CFrame.new(Vector3.new(0, 0, 0), Vector3.new(-0, -0, -1)),
    [3] = 1,
    [4] = ""
}

game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(unpack(args))
]]
