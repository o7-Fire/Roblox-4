local itemtogive = "alien egg"
--[[
day 1-12 present
platypus egg
pumpkin ghost egg
rudolph egg
]]

for _,v in pairs (game:children()) do
   if v.Name == ("ReplicatedStorage") then
       for _,a in pairs(v:GetDescendants()) do
           if a.ClassName == ("Model") then
               if a.Name:match(itemtogive) then
                  local remote = game:GetService("ReplicatedStorage").remotes.entity.claimEgg
                  remote:FireServer(a.Name)
               end
           end
       end
   end
end
