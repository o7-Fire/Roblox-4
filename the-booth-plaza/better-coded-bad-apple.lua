--for this specific game https://www.roblox.com/games/6708206173/Rate-My-Avatar#!/game-instances
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


function Split(s, delimiter)
   result = {};
   for match in (s..delimiter):gmatch("(.-)"..delimiter) do
       table.insert(result, match);
   end
   return result;
end

local data = game:HttpGet("https://raw.githubusercontent.com/o7-Fire/Roblox-4/main/the-booth-plaza/bad_apple_frames.txt")
local splitteddata = Split(data, "N")

_G.Enabled = true
for fhnrteyrtnhi,line in pairs(splitteddata) do
    if _G.Enabled then
       local finalstring = ""
       local currentd = 0
       local linecount = 0
       for i=1, #line do
           if linecount < 28 then
               local chara = ""
               --print("Chara " .. string.sub(line, i, i))
               if string.sub(line, i, i) == "A" then
                   chara = "⚫" 
               else
                   chara = "⚪" 
               end
               if currentd ~= 50 then
                   finalstring ..= chara
               else
                   finalstring ..= "\n" .. chara
                   currentd = 0
                   linecount += 1
               end
               currentd += 1
           end
       end
       --print(finalstring)
       coroutine.wrap(update)(finalstring)
       task.wait(.03)
   end
end
