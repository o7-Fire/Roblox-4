function move(distance)
    local args = {[1] = distance}
    game:GetService("ReplicatedStorage").Remotes.MoveAircraft:InvokeServer(unpack(args))
end

allblocks = {1, 53, 65, 6, 74, 75, 84, 26, 66, 67, 68, 70, 45, 46, 70, 119, 172}
for i,v in pairs(allblocks) do
    for x=1, 52, 1 do
        for y=1, 39, 1 do
            spawn(function()
                local A_1 = Vector3.new(x-26, y, -25)
                local A_2 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                local A_3 = v
                local A_4 = ""
                local Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                Event:InvokeServer(A_1, A_2, A_3, A_4)
            end)
            wait(0.15)
        end
    end
    wait(3)
    move(Vector3.new(0, 0, 1))
    wait(3)
end

--[[
add your own block ids in allblocks to extend your lag machine
the block of choosing has to be over 1990 blocks
]]
