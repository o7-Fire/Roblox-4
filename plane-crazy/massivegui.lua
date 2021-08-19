-- https://github.com/o7-Fire/Roblox-2/blob/main/lf-prototype/README.md
-- ^^ to render your own videos / download videos

local Flux = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt")()
local Window = Flux:Window("PC Tools", "Press N to open/close", Color3.fromRGB(255, 110, 48), Enum.KeyCode.N)
local mouse = game.Players.LocalPlayer:GetMouse()
local uis = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local isVideoPlaying = true
local isSpamBlacklist = false
local isRandomPaint = false
local isGridEnabled = false

function colourthisblock(block, r, g, b)
    spawn(function()
        local A_1 = block
        local A_2 = Color3.new(r, g, b)
        local Event = game:GetService("ReplicatedStorage").Remotes.Paint
        Event:FireServer(A_1, A_2)
    end)
end 
    
function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

local function zeroGrav(part)
    if part:FindFirstChild("BodyForce") then return end
    local temp = Instance.new("BodyForce")
    temp.Force = part:GetMass() * Vector3.new(0,workspace.Gravity,0)
    temp.Parent = part
end

function round(n)
    return (n + 0.5) - (n + 0.5) % 1
end

function parachute()
    while wait() do
        local string_1 = nil
        local string_2 = "Parachute";
        local string_3 = "";
        local string_4 = "";
        local Target = game:GetService("ReplicatedStorage").Remotes.ListHandler;
        Target:FireServer(string_1, string_2, string_3, string_4);
    end
end

local Tab1 = Window:Tab("Building", "http://www.roblox.com/asset/?id=6023426915")
Tab1:Label("stuff to help you build")
Tab1:Button("Paint Aircraft Random Colour", "paints your aircraft random colours every 0.5 seconds", function()
    if isRandomPaint then
        isRandomPaint = false
    else
        isRandomPaint = true
    end
    while wait(0.2) do
        if isRandomPaint then
            local args = {
                [1] = workspace.PlayerAircraft[game.Players.LocalPlayer.Name].BlockStd.BlockStd,
                [2] = Color3.new(math.random(0, 255) / 255, math.random(0, 255) / 255, math.random(0, 255) / 255),
                [3] = "a"
            }
            
            game:GetService("ReplicatedStorage").Remotes.Paint:FireServer(unpack(args))
        else
            break
        end
    end
end)
Tab1:Button("Gravity gun", "gives a gravity gun that can move only your creation", function()
    loadstring(game:HttpGet(('https://pastebin.com/raw/6cfa5Wxa'),true))()
end)
Tab1:Button("Infinite Yield", "loads in infinite yield", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)
Tab1:Button("Mirror mode", "mirrors your placement", function()
    
end)
Tab1:Button("Building Grid", "makes a platform so you dont have to build scaffolding to place blocks", function()
    if isGridEnabled then
        isGridEnabled = false
        pcall(function()
            game.Workspace.PlayerAircraft[game.Players.LocalPlayer.Name].GridWall:Destroy()
        end)
    else
        isGridEnabled = true
        for i,zone in pairs(game.Workspace.BuildingZones:GetChildren()) do
            if tostring(zone.Owner.Value) == game.Players.LocalPlayer.Name then
                local wall = Instance.new("Part")
                wall.Size = Vector3.new(130, 2.5, 130)
                wall.Material = Enum.Material.SmoothPlastic
                wall.Name = "GridWall"
                wall.CanCollide = false
                wall.Transparency = 0.7
                wall.Anchored = true
                wall.CFrame = CFrame.new(zone.Position.x, zone.Position.y + 3.5, zone.Position.z)
                wall.Parent = game.Workspace.PlayerAircraft[game.Players.LocalPlayer.Name]
            end
        end
    end
end)

Tab1:Button("Rise building grid", "moves the building grid up", function()
    pcall(function()
        wall = game.Workspace.PlayerAircraft[game.Players.LocalPlayer.Name].GridWall
        wall.CFrame = CFrame.new(wall.Position.x, wall.Position.y + 2.5, wall.Position.z)
    end)
end)
Tab1:Button("Lower building grid", "moves the building grid down", function()
    pcall(function()
        wall = game.Workspace.PlayerAircraft[game.Players.LocalPlayer.Name].GridWall
        wall.CFrame = CFrame.new(wall.Position.x, wall.Position.y - 2.5, wall.Position.z)
    end)
end)
Tab1:Button("destroy this GUI", "does what it says", function()
    game:GetService("CoreGui").FluxLib:Destroy()
end)

local Tab2 = Window:Tab("PVP", "http://www.roblox.com/asset/?id=6023426915")
Tab2:Label("Requires to be in PVP servers")
Tab2:Button("Kill Guns", "kill players using guns", function()
    pcall(function()
        while wait() do
            local guns = {}
            for i,v in pairs(game:GetService("Workspace")[game.Players.LocalPlayer.Name .. "Aircraft"]:GetChildren()) do
                if v.Name == "Gun" then
                    table.insert(guns, v)
                    zeroGrav(v.Part)
                end
            end
            for i,v in pairs(game.Players:GetChildren()) do
                local a = 1
                if v.Name == game.Players.LocalPlayer.Name then
                    a = 0
                end
                if a == 1 then
                    pcall(function()
                        guns[i].Part.CFrame = v.Character.HumanoidRootPart.CFrame + v.Character.HumanoidRootPart.CFrame.lookVector * -100
                        local args = {[1] = true}
                        guns[i].Input:FireServer(unpack(args))
                    end)
                end
            end
        end
    end)
end)

Tab2:Button("Kill Rockets", "kill players using rockets. close tracking for better effect", function()
    pcall(function()
        while wait() do
            local guns = {}
            for i,v in pairs(game:GetService("Workspace")[game.Players.LocalPlayer.Name .. "Aircraft"]:GetChildren()) do
                if v.Name == "Rocket" then
                    table.insert(guns, v)
                    zeroGrav(v.MainPart)
                end
            end
            for i,v in pairs(game.Players:GetChildren()) do
                local a = 1
                if v.Name == game.Players.LocalPlayer.Name then
                    a = 0
                end
                if a == 1 then
                    pcall(function()
                        guns[i].MainPart.CFrame = v.Character.HumanoidRootPart.CFrame + v.Character.HumanoidRootPart.CFrame.lookVector * 100
                        local args = {
                            [1] = guns[i],
                            [2] = 1629193720
                            
                        }
                        game:GetService("ReplicatedStorage").Remotes.spawnrocket:FireServer(unpack(args))
                    end)
                end
            end
        end
    end)
end)

Tab2:Button("Kill TNT", "kill players using tnt", function()
    local bomb = {}
    local Players = game:GetService("Players")
    local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
    local explode = remotes:WaitForChild("Explode")
    local player = Players.LocalPlayer
    local aircraftName = player.Name.. "Aircraft"
    local aircraft = game.Workspace:WaitForChild(aircraftName)
    for i, v in pairs(aircraft:GetChildren()) do
        if v.Name == "ExplosiveBlock" then
            table.insert(bomb, v)
            for j, k in pairs(v:GetDescendants()) do
                if k:IsA("BasePart") then
                    k.CanCollide = false
                end
            end
            local bodyPosition = Instance.new("BodyPosition")
            bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyPosition.Parent = v.PrimaryPart
            bodyPosition.P = 1000000
            bodyPosition.D = 100
        end
    end
    
    local step = RunService.RenderStepped:Connect(function()
        for i, v in pairs(Players:GetPlayers()) do
            if v.Name ~= player.Name then
                local block = bomb[i]
                local main = block.PrimaryPart
                local character = v.Character
                if character and game.Workspace:FindFirstChild(v.Name.. "Aircraft") then
                    local targetPart = character.HumanoidRootPart
                    local target = targetPart.Position + targetPart.Velocity / 2
                    if target.Y > -100 then
                        if (main.Position - target).Magnitude < 12 then
                            spawn(function()
                                table.remove(bomb, i)
                                for i = 1, 10 do
                                    RunService.RenderStepped:Wait()
                                    explode:FireServer(block, 2000, 12)
                                end
                            end)
                        end
                        main.BodyPosition.Position = target
                    end
                else
                    main.BodyPosition.Position = Vector3.new(0, 999, 0)
                end
            end
        end
    end)
    
    local removed = game.Workspace.ChildRemoved:Connect(function()
        if not game.Workspace:FindFirstChild(aircraftName) then
            reset()
        end
    end)
    
    function reset()
        step:Disconnect()
        removed:Disconnect()
        print("Reset")
    end
end)

local Tab3 = Window:Tab("Non-PVP", "http://www.roblox.com/asset/?id=6023426915")
Tab3:Label("Does not require you to be in a PVP servers")
Tab3:Button("Spam Blacklist Others", "blacklists and unblacklist other people causing them to get sent back to base", function()
    if isSpamBlacklist then
        isSpamBlacklist = false
    else
        isSpamBlacklist = true
    end
    pcall(function()
        while wait() do
            if isSpamBlacklist then
                for i,v in pairs(game.Players:GetChildren()) do
                    if v.Name ~= game.Players.LocalPlayer.Name then
                        local args = {[1] = v.Name, [2] = "BlackList", [3] = true}
                        game:GetService("ReplicatedStorage").Remotes.ListHandler:FireServer(unpack(args))
                        wait(0.2)
                        local args = {[1] = v.Name, [2] = "BlackList", [3] = false}
                        game:GetService("ReplicatedStorage").Remotes.ListHandler:FireServer(unpack(args))
                        wait(0.2)
                    end
                end
            else
                b.b.b.b() -- scuffed break
            end
        end
    end)
end)

Tab3:Button("Blackhole out of your blocks", "makes a black hole at your position out of your creation's blocks, better effect with 1x1 blocks", function()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local charcframe = LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
    local unanchoredparts = {}
    local movers = {}
    for index, part in pairs(workspace:GetDescendants()) do
        if part:IsA("Part") and part.Anchored == false and part:IsDescendantOf(LocalPlayer.Character) == false then
            table.insert(unanchoredparts, part)
            part.Massless = true
            part.CanCollide = false
            if part:FindFirstChildOfClass("BodyPosition") ~= nil then
                part:FindFirstChildOfClass("BodyPosition"):Destroy()
            end
        end
    end
    for index, part in pairs(unanchoredparts) do
        local mover = Instance.new("BodyPosition", part)
        table.insert(movers, mover)
        mover.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    end
    repeat
        for index, mover in pairs(movers) do
            mover.Position = charcframe:PointToWorldSpace(Vector3.new(math.random(0, 200), math.random(0, 200), math.random(0, 200)))
        end
        wait(0.5)
    until LocalPlayer.Character:FindFirstChild("Humanoid").Health <= 0
    for _, mover in pairs(movers) do
        mover:Destroy()
    end
end)
Tab3:Button("Lag server", "lags the server you are in to the point where it crashes", function()
    for i=1, 20 do
       pcall(function()
           parachute()
       end) 
    end
end)
Tab3:Button("Disable Anti Copy Blacklist", "it will disable the blacklist and make anti copy blocks visible again", function()
    for i,models in pairs(game.Workspace.BuildingZones:GetChildren()) do
        models.BlackListPart:Destroy()
    end
    for i,v in pairs(game.Workspace.PlayerAircraft[AntiCopyName.Text]:GetDescendants()) do
        pcall(function()
            v.Transparency = 0
        end)
    end
end)
Tab3:Button("Infinite Terrain Generation", "infinite terrain generation client sided, does not work well on low-end pc", function()
    --Chunk generator by rater193
    --just edited by nexity
    --TODO: make trees, bushes and custom villages (able to bomb the village pog warcrimes)
    
    --The chunk generator settings
    local settings = {
    	chunkSize = 256,
    	renderDistance = 4
    }
    --Chunk generation
    --This stores the list of chunks queued to generate terrain
    chunksToGenerate = {}
    
    --This handles queuing new chunks to generate
    function queueChunk(x, y)
    	table.insert(chunksToGenerate, {["x"] = x, ["y"] = y})
    end
    
    --Here we are tapping into the runservice stepped event to process queued chunks to generate
    game:GetService("RunService").Stepped:connect(function()
    	--Only run if we have chunks to generate
    	if(#chunksToGenerate>0) then
    		--Here we are retreiving the first item in the list
    		local item = chunksToGenerate[1]
    		
    		--Then we remove it from the list, and process it
    		table.remove(chunksToGenerate, 1)
    		
    		--Here we are setting the chunk's part to render green, to show that we have generated the chunk(for debugging)
    		chunks[getChunkID(item.x, item.y)].part.BrickColor = BrickColor.new(Color3.fromRGB(0,255,0))
    		
    		--Here are some additional reused values for generating the terrain
    		local chunkgeneratorsettings = {
    			["xstart"] = item.x*settings.chunkSize,
    			["ystart"] = item.y*settings.chunkSize,
    			["width"] = math.ceil(settings.chunkSize/4),
    			["height"] = math.ceil(settings.chunkSize/4)
    		}
    		
    		--Here we are generating the terrain
    		for _x = 0,chunkgeneratorsettings.width do
    			for _y = 0,chunkgeneratorsettings.height do
    				
    				--Actual terrain generation logic
    				local _height = (math.noise(((_x*4)+chunkgeneratorsettings.xstart)/1000,((_y*4)+chunkgeneratorsettings.ystart)/1000)+0.5) * 150
    				local _material = Enum.Material.Air
    
    				-- imagine yanderedev
    				-- snowy hills biome
    				if(_height<1) then
    					_height = 1
    					_material = Enum.Material.Water
    				elseif(_height<3) then
    					_material = Enum.Material.Sand
    				elseif (_height>math.random(100, 150)) then
    					_material = Enum.Material.Snow
    				else
    					_material = Enum.Material.Grass
    				end
    
    				game.workspace.Terrain:FillBlock(CFrame.new((_x*4)+chunkgeneratorsettings.xstart,_height/2,(_y*4)+chunkgeneratorsettings.ystart), Vector3.new(1,_height,1), _material)
    			end
    		end
    	end
    end)
    
    --Now we are going to start handling chunks loading in around the players
    --Chunk management
    --The list of generated chunks
    chunks = {}
    --This gets the id in the list for the chunk
    function getChunkID(x, y)
    	return tostring(x)..","..tostring(y)
    end
    
    --This checks if we need to generate the chunk
    function checkChunk(x, y)
    	local chunkID = getChunkID(x, y)
    	if(chunks[chunkID]==nil) then
    		chunks[chunkID] = {}
    		
    		--Here we are generating a preview part, to let us know what chunks we are trying to generate(for debugging)
    		local part = Instance.new("Part")
    		part.Anchored = true
    		part.CanCollide = true
    		part.BrickColor = BrickColor.new(Color3.fromRGB(255,0,0))
    		part.Transparency = 0.5
    		part.Material = Enum.Material.Grass
    		part.Size = Vector3.new(settings.chunkSize, 1, settings.chunkSize)
    		part.Position = Vector3.new(settings.chunkSize * x, 0, settings.chunkSize * y) + Vector3.new(settings.chunkSize/2,0,settings.chunkSize/2)
    		
    		part.Parent = game.Workspace
    		
    		part.Name = "Chunk-"..tostring(x).."."..tostring(y)
    		
    		--Adding the preview part to the chunk data
    		chunks[chunkID].part = part
    		
    		--Finally, queue the chunk for terrain generation
    		queueChunk(x,y)
    	end
    end
    
    --Here we are tapping into the run service stepped event to handle chunks around the players
    game:GetService("RunService").Stepped:connect(function()
    	for i, player in pairs(game.Players:GetPlayers()) do
    		if(player.character and player.character:findFirstChild("Head")) then
    			local _pos = {
    				["x"]= math.floor((player.character.Head.Position.X)/settings.chunkSize),
    				["y"]= math.floor((player.character.Head.Position.Z)/settings.chunkSize)
    			}
    			
    
    			for _x = _pos.x-settings.renderDistance, _pos.x+settings.renderDistance do
    				for _y = _pos.y-settings.renderDistance, _pos.y+settings.renderDistance do
    					checkChunk(_x, _y)
    				end
    			end
    		end
    	end
    end)
end)
Tab3:Textbox("Change thruster speed", "changes all movement speed by %, default 100%", true, function(text)
    for i,v in pairs(game.Workspace[game.Players.LocalPlayer.Name .. "Aircraft"]:GetDescendants()) do
        pcall(function()
            if v.ClassName == "Model" and v.Throttle then
                v.Throttle.Value = tonumber(text)
            end
        end)
    end
end)
Tab3:Button("Ocean Map", "turns the map into islands and oceans (client side)", function()
   local region = Region3.new(Vector3.new(-3750,-100,-2050), Vector3.new(2500,43,2700))
   region = region:ExpandToGrid(4)
   game.Workspace.Terrain:FillRegion(region, 4, Enum.Material.Water)
end)
Tab3:Button("Kill TNT", "kill players using tnt in non-pvp servers", function()
    local bomb = {}
    local Players = game:GetService("Players")
    local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
    local explode = remotes:WaitForChild("Explode")
    local player = Players.LocalPlayer
    local aircraftName = player.Name.. "Aircraft"
    local aircraft = game.Workspace:WaitForChild(aircraftName)
    for i, v in pairs(aircraft:GetChildren()) do
        if v.Name == "ExplosiveBlock" then
            table.insert(bomb, v)
            for j, k in pairs(v:GetDescendants()) do
                if k:IsA("BasePart") then
                    k.CanCollide = false
                end
            end
            local bodyPosition = Instance.new("BodyPosition")
            bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyPosition.Parent = v.PrimaryPart
            bodyPosition.P = 1000000
            bodyPosition.D = 100
        end
    end
    
    local step = RunService.RenderStepped:Connect(function()
        for i, v in pairs(Players:GetPlayers()) do
            if v.Name ~= player.Name then
                local block = bomb[i]
                local main = block.PrimaryPart
                local character = v.Character
                if character and game.Workspace:FindFirstChild(v.Name.. "Aircraft") then
                    local targetPart = character.HumanoidRootPart
                    local target = targetPart.Position + targetPart.Velocity / 2
                    if target.Y > -100 then
                        if (main.Position - target).Magnitude < 12 then
                            spawn(function()
                                table.remove(bomb, i)
                                for i = 1, 10 do
                                    RunService.RenderStepped:Wait()
                                    explode:FireServer(block, 2000, 12)
                                end
                            end)
                        end
                        main.BodyPosition.Position = target
                    end
                else
                    main.BodyPosition.Position = Vector3.new(0, 999, 0)
                end
            end
        end
    end)
    
    local removed = game.Workspace.ChildRemoved:Connect(function()
        if not game.Workspace:FindFirstChild(aircraftName) then
            reset()
        end
    end)
    
    function reset()
        step:Disconnect()
        removed:Disconnect()
        print("Reset")
    end
end)

Tab3:Button("Explode TNT", "explodes tnt while in non-pvp servers", function()
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    
    local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
    local explode = remotes:WaitForChild("Explode")
    
    local player = Players.LocalPlayer
    
    local aircraftName = player.Name.. "Aircraft"
    local aircraft = game.Workspace:WaitForChild(aircraftName)
    
    local bomb = {}
    
    for i, v in pairs(aircraft:GetChildren()) do
        if v.Name == "ExplosiveBlock" then
            table.insert(bomb, v)
        end
    end
    
    for i, bombs in pairs(bomb) do
        explode:FireServer(bombs, 0, 0)
    end
end)

local Tab4 = Window:Tab("Paint", "http://www.roblox.com/asset/?id=6023426915")
Tab4:Label("Paint Images on Canvas, accepts discord cdn links")
Tab4:Textbox("1x1 canvas", "requires 1x1 canvas", true, function(text)
    local link = text
    name = "BlockStd"
    checkloop = 0
    waitloop = 0
    for assad2,playerzone in pairs(game.Workspace.BuildingZones:GetChildren()) do
        pcall(function()
            if tostring(playerzone.Owner.Value) == tostring(game.Players.LocalPlayer) then
                checkloop = 1
            end
        end)
        if checkloop == 1 then
            checkloop = 0
            local image_link = "https://api.nexitysecond.repl.co/convertimagetotextblocks?link=" .. link
            local response = game:HttpGet(image_link)
            string_content = Split(response, "N")

            for assad,block in pairs(game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)]:GetChildren()) do
                if block.Name == name then
                  
                    local GridX = playerzone.CFrame.x
                    local GridY = playerzone.CFrame.y
                    local GridZ = playerzone.CFrame.z
                    local GridCenter = playerzone.CFrame.x, playerzone.CFrame.y, playerzone.CFrame.z
                    local DifferenceX = round((block.PrimaryPart.CFrame.x - GridX) / 2.5)
                    DifferenceX = DifferenceX + 25 -- for my sanity
                    local DifferenceY = round((block.PrimaryPart.CFrame.y - GridY) / 2.5)
                    local DifferenceZ = round((block.PrimaryPart.CFrame.z - GridZ) / 2.5)
                    local ThePos = Vector3.new(DifferenceX, DifferenceY, DifferenceZ)
                    block.Name = name..tostring(DifferenceX).."x"..tostring(DifferenceY)
                end
            end
            for assad3, image_pixel in pairs(string_content) do
                image_table = Split(tostring(image_pixel), " ")
                local pixel_type = ""
                local image_pixelX = image_table[1] - 2
                local image_pixelY = image_table[2]
                local image_R = image_table[3] / 255
                local image_G = image_table[4] / 255
                local image_B = image_table[5] / 255
                if waitloop ~= image_pixelX then
                    wait()
                end
                waitloop = image_pixelX
                
                local A_image_pixelX = math.floor(image_pixelX / 2) + 1
                local A_image_pixelY = math.floor(image_pixelY / 2) + 1
                if A_image_pixelY == 40 then
                    A_image_pixelY = 39
                end
                spawn(function()
                    local A_1 = game:GetService("Workspace").PlayerAircraft[tostring(game.Players.LocalPlayer)][name .. A_image_pixelX .. "x" .. A_image_pixelY].PrimaryPart
                    local A_2 = Color3.new(image_R, image_G, image_B)
                    local Event = game:GetService("ReplicatedStorage").Remotes.Paint
                    Event:FireServer(A_1, A_2)
                end)
            end
        end
    end
end)
Tab4:Textbox("hover engine canvas", "requires hover engine canvas", true, function(text)
    local link = text
    name = "HoverThruster"
    checkloop = 0
    waitloop = 0
    for assad2,playerzone in pairs(game.Workspace.BuildingZones:GetChildren()) do
        pcall(function()
            if tostring(playerzone.Owner.Value) == tostring(game.Players.LocalPlayer) then
                checkloop = 1
            end
        end)
        if checkloop == 1 then
            checkloop = 0
            local image_link = "https://api.nexitysecond.repl.co/convertimagetotext?link=" .. link
            local response = game:HttpGet(image_link)
            string_content = Split(response, "N")

            for assad,block in pairs(game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)]:GetChildren()) do
                if block.Name == name then
                  
                    local GridX = playerzone.CFrame.x
                    local GridY = playerzone.CFrame.y
                    local GridZ = playerzone.CFrame.z
                    local GridCenter = playerzone.CFrame.x, playerzone.CFrame.y, playerzone.CFrame.z
                    local DifferenceX = round((block.PrimaryPart.CFrame.x - GridX) / 2.5)
                    DifferenceX = DifferenceX + 25 -- for my sanity
                    local DifferenceY = round((block.PrimaryPart.CFrame.y - GridY) / 2.5)
                    local DifferenceZ = round((block.PrimaryPart.CFrame.z - GridZ) / 2.5)
                    local ThePos = Vector3.new(DifferenceX, DifferenceY, DifferenceZ)
                    block.Name = name..tostring(DifferenceX).."x"..tostring(DifferenceY)

                    block.BlockStd.Name = "BlockStd3" 
                    block.BlockStd.Name = "BlockStd1" 
                    block.BlockStd.Name = "BlockStd2" 
                    block.BlockStd.Name = "BlockStd4"
                    block.BlockStd.Name = "BlockStd5" 
                end
            end
            for assad3, image_pixel in pairs(string_content) do
                image_table = Split(tostring(image_pixel), " ")
                local pixel_type = ""
                local image_pixelX = image_table[1] - 2
                local image_pixelY = image_table[2]
                local image_R = image_table[3] / 255
                local image_G = image_table[4] / 255
                local image_B = image_table[5] / 255
                if waitloop ~= image_pixelX then
                    wait()
                end
                waitloop = image_pixelX

                if (image_pixelX % 2 == 0) then
                    if (image_pixelY % 2 == 0) then
                        pixel_type = "BlockStd4"
                    else
                        pixel_type = "BlockStd3"
                    end
                else
                    if (image_pixelY % 2 == 0) then
                        pixel_type = "BlockStd1"
                    else
                        pixel_type = "BlockStd2"
                    end
                end
                
                local A_image_pixelX = math.floor(image_pixelX / 2) + 1
                local A_image_pixelY = math.floor(image_pixelY / 2) + 1
                local B_image_pixelX = (A_image_pixelX * 2) - image_pixelX
                local B_image_pixelY = (A_image_pixelY * 2) - image_pixelY
                local paintassad = 0
                if A_image_pixelY == 40 then
                    A_image_pixelY = 39
                end
                spawn(function()
                    local A_1 = game:GetService("Workspace").PlayerAircraft[tostring(game.Players.LocalPlayer)][name .. A_image_pixelX .. "x" .. A_image_pixelY][pixel_type]
                    local A_2 = Color3.new(image_R, image_G, image_B)
                    local Event = game:GetService("ReplicatedStorage").Remotes.Paint
                    Event:FireServer(A_1, A_2)
                end)
            end
        end
    end
end)
Tab4:Textbox("snow blaster canvas", "requires an item called snow blaster be made into a canvas", true, function(text)
    local link = text
    name = "SnowBlower"
    checkloop = 0
    waitloop = 0
    for assad2,playerzone in pairs(game.Workspace.BuildingZones:GetChildren()) do
        pcall(function()
            if tostring(playerzone.Owner.Value) == tostring(game.Players.LocalPlayer) then
                checkloop = 1
            end
        end)
        if checkloop == 1 then
            checkloop = 0
            local image_link = "https://api.nexitysecond.repl.co/convertimagetotext?link=" .. link
            local response = game:HttpGet(image_link)
            string_content = Split(response, "N")

            for assad,block in pairs(game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)]:GetChildren()) do
                if block.Name == name then
                  
                    local GridX = playerzone.CFrame.x
                    local GridY = playerzone.CFrame.y
                    local GridZ = playerzone.CFrame.z
                    local GridCenter = playerzone.CFrame.x, playerzone.CFrame.y, playerzone.CFrame.z
                    local DifferenceX = round((block.PrimaryPart.CFrame.x - GridX) / 2.5)
                    DifferenceX = DifferenceX + 25 -- for my sanity
                    local DifferenceY = round((block.PrimaryPart.CFrame.y - GridY) / 2.5)
                    local DifferenceZ = round((block.PrimaryPart.CFrame.z - GridZ) / 2.5)
                    local ThePos = Vector3.new(DifferenceX, DifferenceY, DifferenceZ)
                    block.Name = name..tostring(DifferenceX).."x"..tostring(DifferenceY)

                    block.Union.Name = "Union1"
                    block.Union.Name = "Union4"
                    block.Union.Name = "Union2"
                    block.Union.Name = "Union3"
                end
            end
            for assad3, image_pixel in pairs(string_content) do
                image_table = Split(tostring(image_pixel), " ")
                local pixel_type = ""
                local image_pixelX = image_table[1] - 2
                local image_pixelY = image_table[2]
                local image_R = image_table[3] / 255
                local image_G = image_table[4] / 255
                local image_B = image_table[5] / 255
                if waitloop ~= image_pixelX then
                    wait()
                end
                waitloop = image_pixelX

                if (image_pixelX % 2 == 0) then
                    if (image_pixelY % 2 == 0) then
                        pixel_type = "Union3"
                    else
                        pixel_type = "Union1"
                    end
                else
                    if (image_pixelY % 2 == 0) then
                        pixel_type = "Union4"
                    else
                        pixel_type = "Union2"
                    end
                end
                
                local A_image_pixelX = math.floor(image_pixelX / 2) + 1
                local A_image_pixelY = math.floor(image_pixelY / 2) + 1
                local B_image_pixelX = (A_image_pixelX * 2) - image_pixelX
                local B_image_pixelY = (A_image_pixelY * 2) - image_pixelY
                local paintassad = 0
                if A_image_pixelY == 40 then
                    A_image_pixelY = 39
                end
                spawn(function()
                    local A_1 = game:GetService("Workspace").PlayerAircraft[tostring(game.Players.LocalPlayer)][name .. A_image_pixelX .. "x" .. A_image_pixelY][pixel_type]
                    local A_2 = Color3.new(image_R, image_G, image_B)
                    local Event = game:GetService("ReplicatedStorage").Remotes.Paint
                    Event:FireServer(A_1, A_2)
                end)
            end
        end
    end
end)
Tab4:Button("Build canvas 1x1 blocks", "builds a fullsize canvas out of 1x1 blocks", function()
    for x=1, 51, 1 do
        for y=1, 39, 1 do
            spawn(function()
                local A_1 = Vector3.new(x-26, y, 25)
                local A_2 = CFrame.new(0, 0, 0, 1, 0, 0, 0, -4.37113883e-08, -1, 0, 1, -4.37113883e-08)
                local A_3 = 1
                local Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                Event:InvokeServer(A_1, A_2, A_3)
            end)
            wait(0.15)
        end
    end
end)
Tab4:Button("Build canvas HoverEngine blocks", "builds a fullsize canvas out of hover engines", function()
    for x=1, 51, 1 do
        for y=1, 39, 1 do
            spawn(function()
                local A_1 = Vector3.new(x-26, y, 25)
                local A_2 = CFrame.new(0, 0, 0, 1, 0, 0, 0, -4.37113883e-08, -1, 0, 1, -4.37113883e-08)
                local A_3 = 173
                local Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                Event:InvokeServer(A_1, A_2, A_3)
            end)
            wait(0.15)
        end
    end
end)
Tab4:Button("Build canvas SnowBlaster blocks", "builds a fullsize canvas out of snow blasters", function()
    for x=1, 51, 1 do
        for y=1, 39, 1 do
            spawn(function()
                local A_1 = Vector3.new(x-26, y, 25)
                local A_2 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1.31134158e-07, 1, 0, -1, 1.31134158e-07)
                local A_3 = 104
                local Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                Event:InvokeServer(A_1, A_2, A_3)
            end)
            wait(0.15)
        end
    end
end)
Tab4:Button("Rainbow Aircraft", "paints your aircraft into random colours", function()
    for i,blocks in pairs(game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)]:GetDescendants()) do
        spawn(function()
            color1 = math.random(0,255)
            color2 = math.random(0,255)
            color3 = math.random(0,255)
            local A_1 = blocks
            local A_2 = Color3.new(color1, color2, color3)
            local Event = game:GetService("ReplicatedStorage").Remotes.Paint
            Event:FireServer(A_1, A_2)
        end)
    end
end)

local Tab5 = Window:Tab("LF-Prototype", "http://www.roblox.com/asset/?id=6023426915")
Tab5:Label("Play videos on 24x24 1x1 block canvas.")
Tab5:Button("Stop playing video", "stops the video from playing", function()
    pcall(function()
        isVideoPlaying = false
        wait(1)
        isVideoPlaying = true
    end)
end)
Tab5:Textbox("Video in workspace folder", "plays the video on a 24x24 canvas in your executor workspace folder", true, function(text)
    print(tostring(text))
    local checkloop = 0
    local waitloop = 0
    for assad2,playerzone in pairs(game.Workspace.BuildingZones:GetChildren()) do
        pcall(function()
            if tostring(playerzone.Owner.Value) == tostring(game.Players.LocalPlayer) then
                checkloop = 1
            end
        end)
        if checkloop == 1 then
            checkloop = 0
            --[[
            local image_link = "https://smhreplitissotrashathandlingtonsoffileswhydoievenuseit.nexitysecond.repl.co/rendervideo?videolink=https://www.youtube.com/watch?v=cA9DEewBR_w"
            local response = game:HttpGet(image_link)
            local string_content = Split(response, "N")
            ]]--
            local response = readfile("/frames/" .. text .. ".txt")
            local string_content = Split(response, "N")
            for assad,block in pairs(game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)]:GetChildren()) do
                if block.Name == "BlockStd" then
                  
                    local GridX = playerzone.CFrame.x
                    local GridY = playerzone.CFrame.y
                    local GridZ = playerzone.CFrame.z
                    local GridCenter = playerzone.CFrame.x, playerzone.CFrame.y, playerzone.CFrame.z
                    local DifferenceX = round((block.PrimaryPart.CFrame.x - GridX) / 2.5) 
                     DifferenceX = DifferenceX - 1
                    local DifferenceY = round((block.PrimaryPart.CFrame.y - GridY) / 2.5)
                    local DifferenceZ = round((block.PrimaryPart.CFrame.z - GridZ) / 2.5)
                    local ThePos = Vector3.new(DifferenceX, DifferenceY, DifferenceZ)
                    block.Name = "BlockStd"..tostring(DifferenceX).."x"..tostring(25 - DifferenceY)
                end
            end
            for framecount, frame in pairs(string_content) do
                local skipframe = 0
                if framecount > 2 and framecount % (skipframe + 1) == 0 then
                    ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
                    if ping > 500 then
                        wait(0.5)
                    end -- ping bias
    
                    print(framecount)
                    local framergb = Split(frame, "A")
                    local lastframergb = Split(string_content[framecount - 1], "A")
                    local frame_table = {}
                    local totalcount = 1
                    
                    if isVideoPlaying then
                        for number=1, #framergb do
                            pcall(function()
                                local lastrgb = Split(lastframergb[number], " ")
                                local rgb = Split(framergb[number], " ")
                                local rgb1 = tonumber(rgb[1])
                                local rgb2 = tonumber(rgb[2])
                                local theblock = game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)]["BlockStd" .. rgb1 .. "x" .. rgb2].PrimaryPart
                                local increment = 50 -- 1-255, 1 = absolute value, higher = more noise but less lag
                                local lastrgbc = Color3.new(math.floor(lastrgb[3] / increment), math.floor(lastrgb[4] / increment), math.floor(lastrgb[5] / increment))
                                local rgbc = Color3.new(math.floor(rgb[3] / increment), math.floor(rgb[4] / increment), math.floor(rgb[5] / increment))
                                if lastrgbc ~= rgbc then
                                    colourthisblock(theblock, rgb[3]/255, rgb[4]/255, rgb[5]/255)
                                    --print("painted block : " .. tostring(c) .. "x" .. tostring(number2) .. " " .. tostring(rgb[1]) .. " " .. tostring(rgb[2]) .. " " .. tostring(rgb[3]))
                                end
                            end)
                        end
                    else
                        b.b.b.b()
                    end
                    wait(0.033)
                end
            end
        end
    end
end)
Tab5:Textbox("Video inputstream", "testing currently not for use", true, function(text)
    local checkloop = 0
    local waitloop = 0
    for assad2,playerzone in pairs(game.Workspace.BuildingZones:GetChildren()) do
        pcall(function()
            if tostring(playerzone.Owner.Value) == tostring(game.Players.LocalPlayer) then
                checkloop = 1
            end
        end)
        if checkloop == 1 then
            checkloop = 0
            --[[
            local image_link = "https://smhreplitissotrashathandlingtonsoffileswhydoievenuseit.nexitysecond.repl.co/rendervideo?videolink=https://www.youtube.com/watch?v=cA9DEewBR_w"
            local response = game:HttpGet(image_link)
            local string_content = Split(response, "N")
            ]]--
            local response = game:HttpGet(text)
            local string_content = Split(response, "N")
            for assad,block in pairs(game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)]:GetChildren()) do
                if block.Name == "BlockStd" then
                  
                    local GridX = playerzone.CFrame.x
                    local GridY = playerzone.CFrame.y
                    local GridZ = playerzone.CFrame.z
                    local GridCenter = playerzone.CFrame.x, playerzone.CFrame.y, playerzone.CFrame.z
                    local DifferenceX = round((block.PrimaryPart.CFrame.x - GridX) / 2.5) 
                     DifferenceX = DifferenceX - 1
                    local DifferenceY = round((block.PrimaryPart.CFrame.y - GridY) / 2.5)
                    local DifferenceZ = round((block.PrimaryPart.CFrame.z - GridZ) / 2.5)
                    local ThePos = Vector3.new(DifferenceX, DifferenceY, DifferenceZ)
                    block.Name = "BlockStd"..tostring(DifferenceX).."x"..tostring(25 - DifferenceY)
                end
            end
            for framecount, frame in pairs(string_content) do
                local skipframe = 0
                if framecount > 2 and framecount % (skipframe + 1) == 0 then
                    ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
                    if ping > 500 then
                        wait(ping + ping)
                    end -- ping bias
                    print(framecount)
                    local framergb = Split(frame, "A")
                    local lastframergb = Split(string_content[framecount - 1], "A")
                    local frame_table = {}
                    local totalcount = 1
                    
                    if isVideoPlaying then
                        for number=1, #framergb do
                            pcall(function()
                                local lastrgb = Split(lastframergb[number], " ")
                                local rgb = Split(framergb[number], " ")
                                local rgb1 = tonumber(rgb[1])
                                local rgb2 = tonumber(rgb[2])
                                local theblock = game.Workspace.PlayerAircraft[tostring(game.Players.LocalPlayer)]["BlockStd" .. rgb1 .. "x" .. rgb2].PrimaryPart
                                local increment = 48 -- 1-255, 1 = absolute value, higher = more noise but less lag
                                local lastrgbc = Color3.new(math.floor(lastrgb[3] / increment), math.floor(lastrgb[4] / increment), math.floor(lastrgb[5] / increment))
                                local rgbc = Color3.new(math.floor(rgb[3] / increment), math.floor(rgb[4] / increment), math.floor(rgb[5] / increment))
                                if lastrgbc ~= rgbc then
                                    colourthisblock(theblock, rgb[3]/255, rgb[4]/255, rgb[5]/255)
                                    --print("painted block : " .. tostring(c) .. "x" .. tostring(number2) .. " " .. tostring(rgb[1]) .. " " .. tostring(rgb[2]) .. " " .. tostring(rgb[3]))
                                end
                            end)
                        end
                    else
                        b.b.b.b()
                    end
                    wait(0.033)
                end
            end
        end
    end
end)
