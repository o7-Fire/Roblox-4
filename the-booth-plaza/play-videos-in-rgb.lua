function update(text)
    local args = {
        [1] = "Update",
        [2] = {
            ["DescriptionText"] = text,
            ["ImageId"] = 0
        }
    }
    
    game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
end

local colourthreshold = 25
local ct = colourthreshold
local hct = math.round(colourthreshold / 2)
local rct = 255 - ct
local colours = {
    ["black"] = {0, 0, 0},
    ["white"] = {255, 255, 255},
    ["gray"] = {150, 150, 150},
    ["darkgray"] = {93, 93, 93},
    ["blue"] = {0, 0, 255},
    ["brown"] = {118, 85, 77},
    ["lightbrown"] = {165, 113, 78},
    ["green"] = {0, 255, 0},
    ["orange"] = {255, 165, 0},
    ["purple"] = {147, 112, 211},
    ["red"] = {255, 0, 0},
    ["lightyellow"] = {255, 243, 128},
    ["yellow"] = {255, 255, 0}
}

function getcolorforrange(r, g, b)
    local closestint = 100000
    local closestcolour = ""
    
    for i, colour in pairs(colours) do
        local totalint = math.sqrt( ((r - colour[1])^2) + ((g - colour[2])^2) + ((b - colour[3])^2) )
        if totalint < closestint then
            closestint = totalint
            closestcolour = i
        end
        --print(totalint)
    end
    
    --print(closestcolour)
    if closestcolour == "black" then
        return "🖤"
    elseif closestcolour == "white" then
        return "🤍"
    elseif closestcolour == "gray" then
        return "💿"
    elseif closestcolour == "darkgray" then
        return "🌑"
    elseif closestcolour == "blue" then
        return "💙"
    elseif closestcolour == "brown" then
        return "🤎"
    elseif closestcolour == "lightbrown" then
        return "🧤"
    elseif closestcolour == "green" then
        return "💚"
    elseif closestcolour == "orange" then
        return "🧡"
    elseif closestcolour == "purple" then
        return "💜"
    elseif closestcolour == "red" then
        return "❤️"
    elseif closestcolour == "lightyellow" then
        return "💛"
    elseif closestcolour == "yellow" then
        return "📁"
    end
end

function Split(s, delimiter)
   result = {};
   for match in (s..delimiter):gmatch("(.-)"..delimiter) do
       table.insert(result, match);
   end
   return result;
end

local data = readfile("nframes/amongus.txt")
local splitteddata = Split(data, "N")

_G.Enabled = true
for fhnrteyrtnhi,line in pairs(splitteddata) do
    if _G.Enabled then
       local finalstring = ""
       local currentd = 1
       local themlines = Split(line:sub(1, -2), "A")
       for i, lineb in pairs(themlines) do
           --print(line:sub(-500))
           local rgb = Split(lineb, " ")
           local chara = getcolorforrange(tonumber(rgb[1]), tonumber(rgb[2]), tonumber(rgb[3]))
           
           if currentd ~= 50 then
               finalstring ..= chara
           else
               finalstring ..= chara .. "\n"
               currentd = 0
           end
           currentd += 1
       end
       print(finalstring)
       coroutine.wrap(update)(finalstring)
       task.wait(.03)
   end
end
