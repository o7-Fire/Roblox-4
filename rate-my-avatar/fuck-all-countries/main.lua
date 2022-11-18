_G.Enabled = true

local updater = game:GetService("ReplicatedStorage").CustomiseBooth
function update(text)
    local args = {
        [1] = "Update",
        [2] = {
            ["DescriptionText"] = text,
            ["ImageId"] = 0
        }
    }
    updater:FireServer(unpack(args))
end

while _G.Enabled do
    local r = game:HttpGet("http://192.168.0.166:8080/randomflag")
    coroutine.wrap(update)(r)
    task.wait(3)
end
