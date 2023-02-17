local blocksize = 3 -- original plane crazy is 2.5 for a 1x1 block, in other planec razy similar games they are different
local charactersize = 37

for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if v.ClassName == "MeshPart" then
        print(v.Name, v.Size.x * charactersize / blocksize, v.Size.y * charactersize / blocksize, v.Size.z * charactersize / blocksize)
    end
end
