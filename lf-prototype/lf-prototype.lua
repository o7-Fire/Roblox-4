_G.Enabled = true

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

function colourthisblock(block, r, g, b)
    spawn(function()
        local A_1 = block
        local A_2 = Color3.new(r, g, b)
        local Event = game:GetService("ReplicatedStorage").Remotes.Paint
        Event:FireServer(A_1, A_2)
    end)
end 
    
local checkloop = 0
local waitloop = 0
for assad2,playerzone in pairs(game.Workspace.BuildingZones:GetChildren()) do
    pcall(function()
        if tostring(playerzone.Owner.Value) == tostring(game.Players.LocalPlayer) then
            checkloop = 1
        end
    end)
    if checkloop == 1 then
        checkloop = 0
        --[[
        local image_link = "https://smhreplitissotrashathandlingtonsoffileswhydoievenuseit.nexitysecond.repl.co/rendervideo?videolink=https://www.youtube.com/watch?v=cA9DEewBR_w"
        local response = game:HttpGet(image_link)
        local string_content = Split(response, "N")
        ]]--
        local response = readfile("rickroll1.txt")
        local string_content = Split(response, "N")
        for assad,block in pairs(game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)]:GetChildren()) do
            if block.Name == "BlockStd" then
              
                local GridX = playerzone.CFrame.x
                local GridY = playerzone.CFrame.y
                local GridZ = playerzone.CFrame.z
                local GridCenter = playerzone.CFrame.x, playerzone.CFrame.y, playerzone.CFrame.z
                local DifferenceX = round((block.PrimaryPart.CFrame.x - GridX) / 2.5) 
                 DifferenceX = DifferenceX - 1
                local DifferenceY = round((block.PrimaryPart.CFrame.y - GridY) / 2.5)
                local DifferenceZ = round((block.PrimaryPart.CFrame.z - GridZ) / 2.5)
                local ThePos = Vector3.new(DifferenceX, DifferenceY, DifferenceZ)
                block.Name = "BlockStd"..tostring(DifferenceX).."x"..tostring(25 - DifferenceY)
            end
        end
        for framecount, frame in pairs(string_content) do
            local skipframe = 0
            if framecount > 2 and framecount % (skipframe + 1) == 0 then
                ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
                if ping > 500 then
                    wait(0.5)
                end -- ping bias
                if _G.Enabled then

                    print(framecount)
                    local framergb = Split(frame, "A")
                    local lastframergb = Split(string_content[framecount - 1], "A")
                    local frame_table = {}
                    local totalcount = 1
    
                    for number=1, #framergb do
                        pcall(function()
                            local lastrgb = Split(lastframergb[number], " ")
                            local rgb = Split(framergb[number], " ")
                            local rgb1 = tonumber(rgb[1])
                            local rgb2 = tonumber(rgb[2])
                            local theblock = game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)]["BlockStd" .. rgb1 .. "x" .. rgb2].PrimaryPart
                            local increment = 50 -- 1-255, 1 = absolute value, higher = more noise but less lag
                            local lastrgbc = Color3.new(math.floor(lastrgb[3] / increment), math.floor(lastrgb[4] / increment), math.floor(lastrgb[5] / increment))
                            local rgbc = Color3.new(math.floor(rgb[3] / increment), math.floor(rgb[4] / increment), math.floor(rgb[5] / increment))
                            if lastrgbc ~= rgbc then
                                colourthisblock(theblock, rgb[3]/255, rgb[4]/255, rgb[5]/255)
                                --print("painted block : " .. tostring(c) .. "x" .. tostring(number2) .. " " .. tostring(rgb[1]) .. " " .. tostring(rgb[2]) .. " " .. tostring(rgb[3]))
                            end
                        end)
                    end
                else
                    b.b.b.b.b() -- when break dont work
                end
                wait(0.033)
            end
        end
    end
end
