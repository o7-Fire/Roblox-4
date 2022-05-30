_G.Enabled = true
_G.Debugging = true -- change to true if the script doesnt work to see errors

local start = Vector3.new(75.5, 896.441, 142.5)

function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

while true do
    wait(0.3)
    if _G.Enabled then
        --if game.Workspace.SkyIsland.ClassicMinesweeper.board:FindFirstChild("0|0") then
            function thescript()
                local numbertiles = {}
                
                for i,tile in pairs(game.Workspace.SkyIsland.ClassicMinesweeper.board:GetChildren()) do
                    if tile.ClassName ~= "StringValue" then
                        local posx = (tile.Position.X - start.x) / 3
                        local posz = (tile.Position.Z - start.Z) / 3
                        if not game.Workspace.SkyIsland.ClassicMinesweeper.board:FindFirstChild(tostring(posx) .. "|" .. tostring(posz)) then
                            local origname = Instance.new("StringValue")
                            origname.Name = tostring(posx) .. "|" .. tostring(posz)
                            origname.Parent = game.Workspace.SkyIsland.ClassicMinesweeper.board
                            origname.Value = tostring(posx) .. "|" .. tostring(posz)
                            local origtile = Instance.new("StringValue")
                            origtile.Name = "origtile"
                            origtile.Parent = origname
                            origtile.Value = tile.Name
                        end
                    end
                end
                
                for i,tile in pairs(game.Workspace.SkyIsland.ClassicMinesweeper.board:GetChildren()) do
                    if tile.ClassName == "StringValue" then
                        local actualtile = game.Workspace.SkyIsland.ClassicMinesweeper.board[tile.origtile.Value]
                        if actualtile.BrickColor == BrickColor.new("Institutional white") and actualtile:FindFirstChild("temp") then
                            table.insert(numbertiles, tile)
                        end
                    end
                end
                    
                for i,tile in pairs(numbertiles) do
                    local actualtile = game.Workspace.SkyIsland.ClassicMinesweeper.board[tile.origtile.Value]
                    local tilepos = Split(tile.Name, "|")
                    local tilex = tonumber(tilepos[1])
                    local tilez = tonumber(tilepos[2])
                    local totalnearbybombs = 0
                    local totalpossiblebombs = 0
                    local safetiles = {}
                    for x=-1, 1, 1 do
                        for z=-1, 1, 1 do
                            if game.Workspace.SkyIsland.ClassicMinesweeper.board:FindFirstChild(tostring(tilex + x) .. "|" .. tostring(tilez + z)) then
                                local nearbytile = game.Workspace.SkyIsland.ClassicMinesweeper.board[tostring(tilex + x) .. "|" .. tostring(tilez + z)]
                                local realtile = game.Workspace.SkyIsland.ClassicMinesweeper.board[nearbytile.origtile.Value]
                                if realtile.BrickColor == BrickColor.new("Really red") then
                                    totalpossiblebombs = totalpossiblebombs + 1
                                    totalnearbybombs = totalnearbybombs + 1
                                end
                                if realtile.BrickColor == BrickColor.new("Medium stone grey") then
                                    totalpossiblebombs = totalpossiblebombs + 1
                                    table.insert(safetiles, realtile)
                                end
                            end
                        end
                    end
                    
                    --print(tile.Name, tonumber(tile.SurfaceGui.TextLabel.Text), totalnearbybombs, totalpossiblebombs)
                    -- this part for rendering
                    if totalnearbybombs == tonumber(actualtile.temp.TextLabel.Text) then
                        for i,stile in pairs(safetiles) do
                            if stile.Color ~= Color3.new(0, 1, 0) then
                                stile.Color = Color3.new(0, 1, 0)
                            end
                        end
                    elseif totalpossiblebombs == tonumber(actualtile.temp.TextLabel.Text) then
                        for i,stile in pairs(safetiles) do
                            if stile.Color ~= Color3.new(1, 0, 0) then
                                stile.Color = Color3.new(1, 0, 0)
                            end
                        end
                    end
                end
            end
            
            if _G.Debugging then
                thescript()
            else
                pcall(function()
                    thescript()
                end)
            end
        --end
    else
        break
    end
end
