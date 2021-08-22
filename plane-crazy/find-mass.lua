for i,v in pairs(game:GetService("Workspace")["Admin_854684568Aircraft"]:GetChildren()) do
    pcall(function()
        print(v.Name .. " " .. v.PrimaryPart.Mass)
    end)
end
