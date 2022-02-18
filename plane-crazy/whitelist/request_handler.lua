-- this is required because you cant send http requests inside metatables
-- why? idk black magic
_G.DoDoSend = false
_G.DoDoToSend = ""
while true do
    wait()
    if _G.DoDoSend then
        _G.DoDoSend = false
        game:HttpGet(_G.DoDoToSend)
    end
end
