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
            local block = game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)]["BlockStd" .. tostring(49 - x4) .. "x" .. tostring(y4)].PrimaryPart
            if block.Color ~= Color3.new(r*255, g*255, b*255) then
                colourthisblock(block, r, g, b)
            end
        end
    end
end

function colourchar(x, y, character)
    --paintline(x, y, x, y, 1, 1, 1)
    if character == "a" then
        paintline(x, y, x, y+3, 1, 1, 1)
        paintline(x+2, y, x+2, y+3, 1, 1, 1)
        paintline(x+1, y+2, x+1, y+2, 1, 1, 1)
        paintline(x+1, y+4, x+1, y+4, 1, 1, 1)
        return 4
    elseif character == "b" then
        paintline(x, y, x, y+4, 1, 1, 1)
        paintline(x+1, y, x+1, y, 1, 1, 1)
        paintline(x+1, y+2, x+1, y+2, 1, 1, 1)
        paintline(x+1, y+4, x+1, y+4, 1, 1, 1)
        paintline(x+2, y+1, x+2, y+1, 1, 1, 1)
        paintline(x+2, y+3, x+2, y+3, 1, 1, 1)
        return 4
    elseif character == "c" then
        
    elseif character == "d" then
        
    elseif character == "e" then
        
    elseif character == "f" then
        
    elseif character == "g" then
        
    elseif character == "h" then
        
    elseif character == "i" then
        
    elseif character == "j" then
        
    elseif character == "k" then
        
    elseif character == "l" then
        
    elseif character == "m" then
        
    elseif character == "n" then
        
    elseif character == "o" then
        
    elseif character == "p" then
        
    elseif character == "q" then
        
    elseif character == "r" then
        
    elseif character == "s" then
        
    elseif character == "t" then
        
    elseif character == "u" then
        
    elseif character == "v" then
        
    elseif character == "w" then
        
    elseif character == "x" then
        
    elseif character == "y" then
        
    elseif character == "z" then
        
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
                block.Name = "BlockStd"..tostring(DifferenceX).."x"..tostring(DifferenceY)
            end
        end
        
        local wordtodisplay = "baabaabaabaabaabaabaa"
        local currentx = 1
        local currenty = 34
        for i=1, #wordtodisplay do
            if currentx > 45 then
                currenty = currenty - 6
                currentx = 1
            end
            currentx = currentx + colourchar(currentx, currenty, wordtodisplay:sub(i, i))
        end
    end
end
