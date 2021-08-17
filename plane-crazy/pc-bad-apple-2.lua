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
        local image_link = "https://smhreplitissotrashathandlingtonsoffileswhydoievenuseit.nexitysecond.repl.co/frames"
        local response = game:HttpGet(image_link)
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
            if framecount > 90 and framecount % (skipframe + 1) == 0 then
                print(framecount)
                local lastframe_table = {}
                local frame_table = {}
                local lasttotalcount = 1
                local totalcount = 1
                local lastframemessage = ""
                local framemessage = ""
                for i=1, #frame do
                    if totalcount == 24 then
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
                    if lasttotalcount == 24 then
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
        end
    end
end
