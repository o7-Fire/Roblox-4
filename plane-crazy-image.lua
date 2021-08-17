link = "https://cdn.discordapp.com/attachments/840041811384860708/861259650862284820/4371452d69f3654d88520a373d536a0b.png"
name = "HoverThruster"
checkloop = 0
waitloop = 0

function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function round(n)
    return (n + 0.5) - (n + 0.5) % 1
end

--actual script
for assad2,playerzone in pairs(game.Workspace.BuildingZones:GetChildren()) do
    pcall(function()
        if tostring(playerzone.Owner.Value) == tostring(game.Players.LocalPlayer) then
            checkloop = 1
        end
    end)
    if checkloop == 1 then
        checkloop = 0
        local image_link = "https://api.planecrazyarchive.tk/convertimagetotext?link=" .. link
        local response = game:HttpGet(image_link)
        string_content = Split(response, "N")

        for assad,block in pairs(game.Workspace.PlayerAircraft[game.Players.LocalPlayer.Name]:GetChildren()) do
            if block.Name == name then
              
                local GridX = playerzone.CFrame.x
                local GridY = playerzone.CFrame.y
                local GridZ = playerzone.CFrame.z
                local GridCenter = playerzone.CFrame.x, playerzone.CFrame.y, playerzone.CFrame.z
                local DifferenceX = round((block.PrimaryPart.CFrame.x - GridX) / 2.5)
                DifferenceX = DifferenceX + 25 -- for my sanity
                local DifferenceY = round((block.PrimaryPart.CFrame.y - GridY) / 2.5)
                local DifferenceZ = round((block.PrimaryPart.CFrame.z - GridZ) / 2.5)
                local ThePos = Vector3.new(DifferenceX, DifferenceY, DifferenceZ)
                block.Name = name..tostring(DifferenceX).."x"..tostring(DifferenceY)

                block.BlockStd.Name = "BlockStd3" 
                block.BlockStd.Name = "BlockStd1" 
                block.BlockStd.Name = "BlockStd2" 
                block.BlockStd.Name = "BlockStd4"
                block.BlockStd.Name = "BlockStd5" 
            end
        end
        for assad3, image_pixel in pairs(string_content) do
            image_table = Split(tostring(image_pixel), " ")
            local pixel_type = ""
            local image_pixelX = image_table[1] - 2
            local image_pixelY = image_table[2]
            local image_R = image_table[3] / 255
            local image_G = image_table[4] / 255
            local image_B = image_table[5] / 255
            if waitloop ~= image_pixelX then
                wait()
            end
            waitloop = image_pixelX

            if (image_pixelX % 2 == 0) then
                if (image_pixelY % 2 == 0) then
                    pixel_type = "BlockStd4"
                else
                    pixel_type = "BlockStd3"
                end
            else
                if (image_pixelY % 2 == 0) then
                    pixel_type = "BlockStd1"
                else
                    pixel_type = "BlockStd2"
                end
            end
            
            local A_image_pixelX = math.floor(image_pixelX / 2) + 1
            local A_image_pixelY = math.floor(image_pixelY / 2) + 1
            local B_image_pixelX = (A_image_pixelX * 2) - image_pixelX
            local B_image_pixelY = (A_image_pixelY * 2) - image_pixelY
            local paintassad = 0
            if A_image_pixelY == 40 then
                A_image_pixelY = 39
            end
            spawn(function()
                local A_1 = game:GetService("Workspace").PlayerAircraft[tostring(game.Players.LocalPlayer)][name .. A_image_pixelX .. "x" .. A_image_pixelY][pixel_type]
                local A_2 = Color3.new(image_R, image_G, image_B)
                local Event = game:GetService("ReplicatedStorage").Remotes.Paint
                Event:FireServer(A_1, A_2)
            end)
        end
    end
end
