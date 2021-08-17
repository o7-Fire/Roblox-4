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
