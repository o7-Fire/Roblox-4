local GeneratedC={} -- Used for tracking which chunks are currently loaded (could be merged with generationtracking but doesnt matter)
local GenerationTracking = {} -- used for tracking the parts in each chunk (for unloading) uses alot of memory but oh well
local randomizer = math.random(1, 600)

local Settings = {
	['XSize'] = nil,
	['YSize'] = nil,
	['XScale'] = 200,
	['YScale'] = 200,
	['Spacing'] = 20,
	['Power'] = 12;
	['Amplifier'] = 25,
	['Frequency'] = 0.6,
	['Octaves'] = 10,
	['ChunkSize'] = 5,
	['ChunkCount'] = 10
}

local BiomeSettings = {

}

function GetNoise(t,seed,tog)

	tog = tog or 0
	-- t should contain layers of generation settings
	local RetVal = 0
	local noise = math.noise -- 2d noise, can be replaced with simplex if you can find a lua implementation

	for i,v in pairs(t) do
		--[[NOISE EQUASION]] if type(v) ~= 'table' then continue end

		local posX,posZ = v['posX'],v['posZ']
		local Spacing,ChunkSize = Settings.Spacing,Settings.ChunkSize


		--[[get the current chunk]]
		local function PositionFormula(Chunk,Offset)
			return (Offset*Spacing)+((Chunk*ChunkSize)*Spacing)
		end
		-- math is cool but its also kinda not cool
		local ChunkX,ChunkZ = t['Chunkx'],t['Chunkz']	
		local ChunkPosX,ChunkPosZ = t['i'],t['l']
		local posX=PositionFormula(ChunkX,ChunkPosX)
		local posZ=PositionFormula(ChunkZ,ChunkPosZ)

		--[[get the current chunk]] 


		RetVal+=math.noise(posX/v['scaleX'],posZ/v['scaleZ'],seed)*v['Power']


		--[[END NOISE EQUASION]]
	end

	local function gb(yx)
		return yx<0
	end
	--[[
	if tog == 0 then

		
		t['i'] +=1
		local x = GetNoise(t,seed,1)
		t['i'] -=2 
		local y = GetNoise(t,seed,1)
		t['i']+=1
		if gb(x) ~= gb(y) then return (x+y)/2 end
	end]]

	--if RetVal < 0 then return 0 end
	--if RetVal > 0 then return RetVal*2 end
	return RetVal	
end

-- CoverChunks

local BiomeInfo = {}

BiomeInfo['RockyMountains'] = {
	['Below'] = 10000;
	['Above'] = 0;
	['Properties'] = {
		['Color'] = Color3.new(0.5,0.5,0.5);
		['Material'] = Enum.Material.Rock;
	}
}
BiomeInfo['GrassLands'] = {
	['Below'] = 0;
	['Above'] = -10000 ;
	['Properties'] = {
		['Color'] = Color3.new(0,.4,0);
		['Material'] = Enum.Material.Grass;
	}
}


local function draw3dTriangle(a, b, c, parent, w1, w2)
	local wedge = Instance.new("WedgePart");
	wedge.Reflectance = 0
	wedge.Anchored = true;
	wedge.TopSurface = Enum.SurfaceType.Smooth;
	wedge.BottomSurface = Enum.SurfaceType.Smooth;

	local Store = {
		['a']=a;
		['b']=b;
		['c']=c;
	}

	a=a.Position
	b=b.Position
	c=c.Position
	local ab, ac, bc = b - a, c - a, c - b;
	local abd, acd, bcd = ab:Dot(ab), ac:Dot(ac), bc:Dot(bc);

	if (abd > acd and abd > bcd) then
		c, a = a, c;
	elseif (acd > bcd and acd > abd) then
		a, b = b, a;
	end

	ab, ac, bc = b - a, c - a, c - b;

	local right = ac:Cross(ab).unit;
	local up = bc:Cross(right).unit;
	local back = bc.unit;

	local height = math.abs(ab:Dot(up));

	w1 = w1 or wedge:Clone();
	w1.Name = 'w1'

	w1.Size = Vector3.new(0, height, math.abs(ab:Dot(back)));
	w1.CFrame = CFrame.fromMatrix((a + b)/2, right, up, back);
	w1.Parent = parent;

	w2 = w2 or wedge:Clone();
	w2.Name = 'w2'
	w2.Size = Vector3.new(0, height, math.abs(ac:Dot(back)));
	w2.CFrame = CFrame.fromMatrix((a + c)/2, -right, up, -back);
	w2.Parent = parent;

	local Model = Instance.new('Model')
	if game.Workspace:FindFirstChild("TerrainSkin") then
	    Model.Parent = game.Workspace.TerrainSkin
    else
        local terrainskin = Instance.new("Folder", game.Workspace)
        terrainskin.Name = "TerrainSkin"
        Model.Parent = terrainskin
    end
	Model.Name = Store['a'].Name..'|'..Store['b'].Name..'|'..Store['c'].Name..'|'
	w1.Parent = Model
	w2.Parent = Model
	return w1, w2;
end

local function CoverChunk(x,z,Points)
	local StartingPartCFrame = CFrame.new((x*Settings.ChunkSize)*Settings.Spacing,10,(z*Settings.ChunkSize)*Settings.Spacing)
	local StartPartName = tostring(StartingPartCFrame.X/Settings.Spacing)..':'..tostring(StartingPartCFrame.Z/Settings.Spacing)
	local StartingPart = Points[StartPartName] 
	--if not StartingPart then return {} end
	local ChunkSize = Settings.ChunkSize 
	local Spacing = Settings.Spacing
	local RtrnTable = {}
	for i = 0,ChunkSize do
		for l = 0,ChunkSize do
			local EstimatedPCFrame = CFrame.new((i*Spacing)+((x*(ChunkSize))*Spacing),10,(l*Spacing)+((z*(ChunkSize))*Spacing))
			local EstimatedPartName = tostring(EstimatedPCFrame.X/Settings.Spacing)..':'..tostring(EstimatedPCFrame.Z/Settings.Spacing)
			local Part = Points[EstimatedPartName]
			if Part then
				local f = Part.Name:split(':')[1]
				local t = Part.Name:split(':')[2]
				local _,tx =  pcall(function() return {
					[1] = Part;
					[2] = Points[tostring(tonumber(f))..':'..tostring(tonumber(t+1))];
					[3] = Points[tostring(tonumber(f+1))..':'..tostring(tonumber(t))];
					}
				end)
				if tx and tx[1] and tx[2] and tx[3] then
					local p1,p2 = draw3dTriangle(tx[1],tx[2],tx[3],game.Workspace) -- pass part not position, must store part name for later use in the function
					table.insert(RtrnTable,p1)
					table.insert(RtrnTable,p2)
				end
				local _,t2 = pcall(function() return {
					[1] = Part;
					[2] = Points[tostring(tonumber(f+1))..':'..tostring(tonumber(t-1))];
					[3] = Points[tostring(tonumber(f+1))..':'..tostring(tonumber(t))];
					}
				end)
				if t2 and t2[1] and t2[2] and t2[3] then
					local p1,p2 = draw3dTriangle(t2[1],t2[2],t2[3],game.Workspace)
					table.insert(RtrnTable,p1)
					table.insert(RtrnTable,p2)
				end
			end
		end
	end
	return RtrnTable
end

-- terrain generation script

local function MakeChunk(Posx,Posz,seed) -- this will cause parts inbetween chunks to be duplicated, should be fixed if causes errors

	spawn(function()
		local ChunkSize = Settings.ChunkSize
		local Cpos=tostring(Posx)..':'..tostring(Posz)
		local Spacing = Settings.Spacing
		GenerationTracking[Cpos]={}
		local Points = {}
		local function PointConstructor(position,name)
			return {
				['Name'] = name;
				['Position'] = position;
			}
		end
		for i = 0, (ChunkSize) do
			for l = 0,(ChunkSize)  do
				--game:GetService('RunService').RenderStepped:Wait()

				local function Parta(Trans,Clr)

					return PointConstructor(Vector3.new(),'hi')--this is leftover from when nodes were actually parts
				end
				local optionsTable = {
					['Chunkx'] = Posx;
					['Chunkz'] = Posz;
					['i'] = i;
					['l'] = l;
					[1] = {
						['scaleX'] = 2000,
						['scaleZ'] = 2000,
						['Spacing'] = 17.5,
						['Power'] = 300;
						['amplitude'] = 2.5,
						['frequency'] = 0.6,
					};
					[2] = {
						['scaleX'] = 200,
						['scaleZ'] = 200,
						['Spacing'] = 17.5,
						['Power'] = 20;
						['amplitude'] = 2.5,
						['frequency'] = 0.6,

					};
					--[[[3] = {
						['posX'] = (i*Spacing)+((Posx*ChunkSize)*Spacing),
						['posZ'] = (l*Spacing)+((Posz*ChunkSize)*Spacing),
						['scaleX'] = 10,
						['scaleZ'] = 10,
						['Spacing'] = 17.5,
						['Power'] = 10;
						['amplitude'] = 1.5,
						['frequency'] = 0.3,
					}]]
				}
				--(i*Spacing)+((Posx*ChunkSize)*Spacing),(l*Spacing)+((Posz*ChunkSize)*Spacing),Settings.XScale,Settings.YScale,Settings.Octaves,seed,Settings.Power,Settings.Amplifier,Settings.Frequency
				local height = GetNoise(optionsTable,seed) -- posX, posZ, scaleX, scaleZ, octavess, seed,power,amplitude,frequency

				local Part = Parta(1,Color3.new(math.random(),math.random(),math.random()))
				Part.Position = Vector3.new((i*Spacing)+((Posx*(ChunkSize))*Spacing),height,(l*Spacing)+((Posz*(ChunkSize))*Spacing))
				Part.Name = tostring(Part.Position.X/Spacing)..':'..tostring(Part.Position.Z/Spacing)

				Points[Part.Name] = Part
				if game.Workspace:FindFirstChild("TerrainPoints") then
				    Part.Parent = game.Workspace.TerrainPoints
			    else
			        local terrainpoints = Instance.new("Folder", game.Workspace)
			        terrainpoints.Name = "TerrainPoints"
			        Part.Parent = terrainpoints
		        end

			end
		end

		local NewParts = CoverChunk(Posx,Posz,Points)
		for i,v in pairs(NewParts) do
			table.insert(GenerationTracking[Cpos],v)
		end
	end)
end

local starttick = tick()
local seed = 1324543
local function IsEven(num)
	return num % 2 == 0
end
local c = Settings.ChunkCount/2
--[[for x = -c,c do 
	for y = -c,c do
		print(x,y)
		MakeChunk(x,y,seed)
		if c*2 > 4 then 
			wait((c)/32)
		end
	end
end]]

local RenderDistance = 6
local n = (Settings.ChunkSize)*Settings.Spacing
while wait() do 
	if not game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name) then game.Players.LocalPlayer.CharacterAdded:wait() game.Players.LocalPlayer.Character:WaitForChild('HumanoidRootPart') end
	local n = (Settings.ChunkSize)*Settings.Spacing
	local valuses = game.Players.LocalPlayer.Character.HumanoidRootPart.Position/Vector3.new(n,n,n)
	local Valx = valuses.x
	local Valz = valuses.z
	local vx = tonumber(math.floor(valuses.x))
	local vz = tonumber(math.floor(valuses.z))

	for i,v in pairs(GenerationTracking) do
		local Nsplit = i:split(':')
		local x = tonumber(Nsplit[1])
		local z = tonumber(Nsplit[2])
		if (x < vx-RenderDistance or x > vx + RenderDistance) or (z<vz-RenderDistance or z > vz+RenderDistance) then
			GeneratedC[x][z] = nil
			for _,y in pairs(v) do
				if y.Parent then
					y.Parent:Destroy()
				end
			end			
			GenerationTracking[i] = nil
		end
	end

	--check if any of the surrounding chunks arent made
	local tog
	for i=-RenderDistance,RenderDistance do
		for y=-RenderDistance,RenderDistance do
			if not GeneratedC[vx+i] or not (GeneratedC[vx+i] and GeneratedC[vx+i][vz+y]) then
				MakeChunk(vx+i,vz+y,seed)
				--print('GENERATING CHUNK:',vx+i,vz+y)
				GeneratedC[vx+i] = GeneratedC[vx+i] or {}
				GeneratedC[vx+i][vz+y] = true
			end

		end	
	end
	if not GeneratedC[vx] and not (GeneratedC[vx] and GeneratedC[vx][vz]) then
		MakeChunk(vx,vz,seed)


		GeneratedC[vx] = GeneratedC[vx] or {}
		GeneratedC[vx][vz] = true
	end
end
