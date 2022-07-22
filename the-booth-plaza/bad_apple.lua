function update(text)
    local args = {
        [1] = "Update",
        [2] = {
            ["Decoration"] = "Select from dropdown",
            ["Text"] = text,
            ["Icon"] = "5621948051",
            ["Colour"] = "Select from dropdown"
        }
    }
    
    game:GetService("ReplicatedStorage").Booth:FireServer(unpack(args))
end

function Split(s, delimiter)
   result = {};
   for match in (s..delimiter):gmatch("(.-)"..delimiter) do
       table.insert(result, match);
   end
   return result;
end

local data = game:HttpGet("https://smhreplitissotrashathandlingtonsoffileswhydoievenuseit.nexitysecond.repl.co/frames3")
local splitteddata = Split(data, "N")

for fhnrteyrtnhi,line in pairs(splitteddata) do
   local finalstring = ""
   local currentd = 0
   for i=1, #line do
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
       end
       currentd += 1
   end
   print(finalstring)
   update(finalstring)
   wait(.1)
end
