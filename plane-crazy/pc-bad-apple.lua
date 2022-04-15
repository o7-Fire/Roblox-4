-- https://www.youtube.com/watch?v=bKYnk0yN6jY

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

function paintline(x, y, x3, y3, r, g, b)
    local x1 = 0
    local y1 = 0
    local x2 = 0
    local y2 = 0
    if x >= x3 then
        x1 = x
        x2 = x3
    else
        x1 = x3
        x2 = x
    end
    if y >= y3 then
        y1 = y
        y2 = y3
    else
        y1 = y3
        y2 = y
    end
    for x4=x2, x1 do
        for y4=y2, y1 do
            --print("x4" .. tostring(x4) .. "  y4 " .. tostring(y4))
            local block = game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)]["HeliumBlock" .. tostring(x4) .. "x" .. tostring(y4)].PrimaryPart
            if block.Color ~= Color3.new(r*255, g*255, b*255) then
                colourthisblock(block, r, g, b)
            end
        end
    end
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
        local image_link = "https://smhreplitissotrashathandlingtonsoffileswhydoievenuseit.nexitysecond.repl.co/pccframes"
        local response = game:HttpGet(image_link)
        local string_content = Split(response, "N")

        for assad,block in pairs(game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)]:GetChildren()) do
            if block.Name == "BlockStd" then
              
                local GridX = playerzone.CFrame.x
                local GridY = playerzone.CFrame.y
                local GridZ = playerzone.CFrame.z
                local GridCenter = playerzone.CFrame.x, playerzone.CFrame.y, playerzone.CFrame.z
                local DifferenceX = round((block.PrimaryPart.CFrame.x - GridX) / 2.5)
                DifferenceX = DifferenceX + 25 -- for my sanity
                local DifferenceY = round((block.PrimaryPart.CFrame.y - GridY) / 2.5)
                local DifferenceZ = round((block.PrimaryPart.CFrame.z - GridZ) / 2.5)
                local ThePos = Vector3.new(DifferenceX, DifferenceY, DifferenceZ)
                block.Name = "BlockStd"..tostring(DifferenceX).."x"..tostring(40 - DifferenceY)
            end
        end
        for assad,block in pairs(game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)]:GetChildren()) do
            if block.Name == "HeliumBlock" then
              
                local GridX = playerzone.CFrame.x
                local GridY = playerzone.CFrame.y
                local GridZ = playerzone.CFrame.z
                local GridCenter = playerzone.CFrame.x, playerzone.CFrame.y, playerzone.CFrame.z
                local DifferenceX = round((block.PrimaryPart.CFrame.x - GridX) / 2.5)
                DifferenceX = DifferenceX + 25 -- for my sanity
                local DifferenceY = round((block.PrimaryPart.CFrame.y - GridY) / 2.5)
                local DifferenceZ = round((block.PrimaryPart.CFrame.z - GridZ) / 2.5)
                local ThePos = Vector3.new(DifferenceX, DifferenceY, DifferenceZ)
                block.Name = "HeliumBlock"..tostring(DifferenceX).."x"..tostring(DifferenceY)
            end
        end
        for framecount, frame in pairs(string_content) do
            local skipframe = 0
            if framecount > 90 and framecount % (skipframe + 1) == 0 then
                print(framecount)
                local lastframe_table = {}
                local frame_table = {}
                local lasttotalcount = 1
                local totalcount = 1
                local lastframemessage = ""
                local framemessage = ""
                for i=1, #frame do
                    if totalcount == 51 then
                        table.insert(frame_table, framemessage)
                        framemessage = ""
                        totalcount = 1
                    else
                        local character = frame:sub(i, i)
                        framemessage = framemessage .. character
                        totalcount += 1
                    end
                end
                
                for i=1, #string_content[framecount - (skipframe + 1)] do
                    if lasttotalcount == 51 then
                        table.insert(lastframe_table, lastframemessage)
                        lastframemessage = ""
                        lasttotalcount = 1
                    else
                        local lastframe = string_content[framecount - (skipframe + 1)]
                        local character = lastframe:sub(i, i)
                        lastframemessage = lastframemessage .. character
                        lasttotalcount += 1
                    end
                end
                charactercount = 0
                for _ in pairs(frame_table) do charactercount = charactercount + 1 end
                for number=1, charactercount do
                    local character = frame_table[number]
                    for c=1, #character do
                        local ch = character:sub(c, c)
                        local lch = lastframe_table[number]:sub(c, c)
                        --print("ch " .. ch .. " lch " .. lch)
                        local theblock = game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)]["BlockStd" .. tostring(c) .. "x" .. tostring(number)].PrimaryPart
                        if ch ~= lch and ch == "B" then
                            colourthisblock(theblock, 0, 0, 0)
                            --print("colouring 1")
                        elseif ch ~= lch and ch == "A" then
                            colourthisblock(theblock, 1, 1, 1)
                            --print("colouring 2")
                        end
                    end
                end
                wait(0.033)
            end
            --[[
            for count=1, 39 do
                for count2=1, 50 do
                    print("current " .. currentblocks:sub(count2, count2) .. " last " .. lastframeblocks:sub(count2, count2))
                    theblock = game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)][name .. tostring(count2) .. "x" .. tostring(count)].PrimaryPart
                    if currentblocks:sub(count2, count2) ~= lastframeblocks:sub(count2, count2) and currentblocks:sub(count2, count2) == "B" then
                        colourthisblock(theblock, 0, 0, 0)
                    elseif currentblocks:sub(count2, count2) ~= lastframeblocks:sub(count2, count2) and currentblocks:sub(count2, count2) == "A" then
                        colourthisblock(theblock, 1, 1, 1)
                    end
                end
            end]]
        end
    end
end
