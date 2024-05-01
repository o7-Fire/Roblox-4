function makeCharacterInvisible(character)
    -- Check if the character exists and is an R15 model
    if character and character:IsA("Model") and character:FindFirstChild("Head") then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                -- Set the transparency of the part to 1 to make it invisible
                part.Transparency = 1
            elseif part:IsA("Accessory") then
                -- If the part is an accessory, make its handle transparent
                if part:FindFirstChild("Handle") then
                    part.Handle.Transparency = 1
                end
            end
        end
    end
end

makeCharacterInvisible(game.Players.LocalPlayer.Character)
