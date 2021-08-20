for x=1, 52, 2 do
    for z=1, 52, 2 do
        spawn(function()
            local A_1 = Vector3.new(x-26, 1, z-26)
            local A_2 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            local A_3 = 149
            local A_4 = ""
            local Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
            Event:InvokeServer(A_1, A_2, A_3, A_4)
        end)
        wait(0.15)
    end
end

for x=2, 52, 2 do
    for z=2, 52, 2 do
        spawn(function()
            local A_1 = Vector3.new(x-26, 1, z-26)
            local A_2 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            local A_3 = 149
            local A_4 = ""
            local Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
            Event:InvokeServer(A_1, A_2, A_3, A_4)
        end)
        wait(0.15)
    end
end
-- 53, 74, 75, 149
