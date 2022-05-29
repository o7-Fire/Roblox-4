local Players = workspace.Players
 
local OldIndex = nil
 
OldIndex = hookmetamethod(Players, "__index", function(Self, Key)
    if not checkcaller() and tostring(Self) == "Torso" and Key == "Size" then
        return Vector3.new(7, 7, 7)
    end
    return OldIndex(Self, Key)
end)
