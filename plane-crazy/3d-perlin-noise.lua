--local function GenerateNoiseMap(seed, mapSize, noiseScale, amplitude)
local seed = math.random(1,100000)
local mapSize = 51
local noiseScale = 10 
local amplitude = 10

local blocks = {1, 53, 74, 75, 24, 108}
for x = mapSize, 0, -1 do
	for z = mapSize, 0, -1 do
		for y = mapSize, 0, -1 do
			local xNoise = math.noise(y/noiseScale, z/noiseScale, seed) * amplitude
			local yNoise = math.noise(x/noiseScale, z/noiseScale, seed) * amplitude
			local zNoise = math.noise(x/noiseScale, y/noiseScale, seed) * amplitude
			
			local density = xNoise + yNoise	+ zNoise + y
							
			if density < 18 and density > 10 then
				spawn(function()
                    local args = {
                        [1] = Vector3.new(x-26, y-5, z-26),
                        [2] = CFrame.new(Vector3.new(0, 0, 0), Vector3.new(-0, -0, -1)),
                        [3] = blocks[math.random(1, #blocks)],
                        [4] = ""
                    }
                    
                    game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(unpack(args))
                end)
                wait(0.07)
			end
		end
	end
end
