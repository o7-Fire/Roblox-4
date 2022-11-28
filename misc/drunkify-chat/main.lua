local char_to_hex = function(c)
  return string.format("%%%02X", string.byte(c))
end

local function urlencode(url)
  if url == nil then
    return
  end
  url = url:gsub("\n", "\r\n")
  url = url:gsub("([^%w ])", char_to_hex)
  url = url:gsub(" ", "+")
  return url
end

_G.thetranslatething = {0, ""}
local chatremote = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
task.spawn(function()
    while true do
        task.wait(.05)
        if _G.thetranslatething[1] == 1 then
            local r = game:HttpGet("http://192.168.0.166:8080?textinput=" .. urlencode(_G.thetranslatething[2]) .. "&interval=3")
            _G.thetranslatething[1] = 2
            chatremote:FireServer(r, "All")
        end
    end
end)

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt,false)
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if getnamecallmethod() == 'FireServer' and self.Name == 'SayMessageRequest' then
        if _G.thetranslatething[1] == 2 then
            _G.thetranslatething[1] = 0
            return old(self, unpack(args))
        else
            _G.thetranslatething[2] = args[1]
            _G.thetranslatething[1] = 1
        end
    else
        return old(self, unpack(args))
    end
end)
