function place(x,y,z)
    spawn(function()
        local args = {
            [1] = Vector3.new(x, y, z),
            [2] = CFrame.new(Vector3.new(0, 0, 0), Vector3.new(-0, -0, -1)),
            [3] = 1,
            [4] = ""
        }
        game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(unpack(args))
    end)
    wait(0.08)
end


for x=3, 50, 5 do
    for z=1, 50, 2 do
        local x = x - 25
        local z = z - 25
        place(x, 1, z)
        place(x-1, 1, z)
        place(x-2, 1, z)
        place(x-1, 2, z)
        place(x-1, 3, z)
        place(x-1, 4, z)
    end
end
