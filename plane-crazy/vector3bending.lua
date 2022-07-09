_G.Enableethebuild = false

local function build(x,y,z, blockid)
    spawn(function()
        local args = {
            [1] = Vector3.new(x,y,z),
            [2] = CFrame.new(0, 0, 0) * CFrame.Angles(-0, 0, -0),
            [3] = blockid,
            [4] = ""
        }
        game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(unpack(args))
    end)
    wait(.1)
end

for x=-10, 10, 1 do
    for z=-10, 10, 1 do
        if _G.Enableethebuild then
            build(x, 2 + math.cosh(math.abs(x/7)) + math.cosh(math.abs(z/7)), z, 12)
        end
    end
end
