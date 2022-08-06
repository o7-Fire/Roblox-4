_G.Enabled = true
--local data = readfile("nframes/owl.txt")
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
    ["🖤"] = {0, 0, 0},
    ["💿"] = {192, 192, 192},
    ["🌑"] = {128, 128, 128},
    ["🤍"] = {255, 255, 255},
    ["🍒"]=  {128, 0, 0},
    ["❤️"] = {255, 0, 0},
    ["💜"] = {128, 0, 128},
    ["🌸"] = {255, 0, 255},
    ["🌳"] = {0, 128, 0},
    ["📗"] = {0, 255, 0},
    ["🦖"] = {128, 128, 0},
    ["🍋"] = {255, 255, 0},
    ["🔵"] = {0, 0, 128},
    ["📘"] = {0, 0, 255},
    ["🧪"] = {0, 128, 128},
    ["🐋"] = {0, 255, 255},
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
    return closestcolour
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
               finalstring = finalstring .. chara
           else
               finalstring = finalstring .. chara .. "\n"
               currentd = 0
           end
           currentd = currentd + 1
       end
       coroutine.wrap(update)(finalstring)
       task.wait(.03)
   end
end
