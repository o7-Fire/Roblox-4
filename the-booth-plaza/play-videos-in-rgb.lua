_G.Enabled = true
--local data = readfile("nframes/amongus.txt")
local data = game:HttpGet("https://raw.githubusercontent.com/o7-Fire/Roblox-4/main/the-booth-plaza/amongus.txt") -- prerendered amongus video

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

local colours = {
    ["black"] = {0, 0, 0},
    ["white"] = {255, 255, 255},
    ["gray"] = {150, 150, 150},
    ["darkgray"] = {93, 93, 93},
    ["blue"] = {0, 0, 255},
    ["brown"] = {118, 85, 77},
    ["lightbrown"] = {165, 113, 78},
    ["verylightbrown"] = {171, 149, 132},
    ["pale"] = {255, 204, 153},
    ["green"] = {108, 187, 60},
    ["lightgreen"] = {153, 198, 142},
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
    end
    
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
    elseif closestcolour == "verylightbrown" then
        return "📜"
    elseif closestcolour == "pale" then
        return "🏻"
    elseif closestcolour == "green" then
        return "💚"
    elseif closestcolour == "lightgreen" then
        return "🌵"
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

local splitteddata = Split(data:sub(1, -2), "N")
for fhnrteyrtnhi,line in pairs(splitteddata) do
    if _G.Enabled then
       local finalstring = ""
       local currentd = 1
       local themlines = Split(line:sub(1, -2), "A")
       for i, lineb in pairs(themlines) do
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
       coroutine.wrap(update)(finalstring)
       task.wait(.03)
   end
end
