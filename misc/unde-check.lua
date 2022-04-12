-- for future purposes
for i,v in pairs(game.Players:GetChildren()) do
    if v:GetUnder13() then
        print(v.Name .. " is under 13")
    else
        print(v.Name .. " is not under 13")
    end
end
