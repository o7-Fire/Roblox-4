local s = string.rep("@@@", 75) --replace this if u want
local r = game:GetService("ReplicatedStorage").ChatEvents.ChatRequest

function send(x)
    r:FireServer(x)
end

_G.Enabled = true
while _G.Enabled do
    coroutine.wrap(send)(s)
    task.wait(.01)
end
