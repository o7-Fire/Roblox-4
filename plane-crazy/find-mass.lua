-- https://docs.google.com/spreadsheets/d/1YJ3EDigS8OPv6il3G1LMLE84fNRiTbUvrPZke6T3o4Y/edit?usp=sharing
-- you see

for i,v in pairs(game:GetService("Workspace")[game.Players.LocalPlayer.Name]:GetChildren()) do
    pcall(function()
        print(v.Name .. " " .. v.PrimaryPart.Mass)
    end)
end
