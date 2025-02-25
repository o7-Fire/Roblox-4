local function getPlayer(text)
	for _, p in pairs(game.Players:GetChildren()) do
		if string.sub(string.lower(p.Name), 1, string.len(text)) == string.lower(text) then
			print(p.Name)
			return p
		end
	end
end

local lplr = game.Players.LocalPlayer
--local target = game.Players["Player4"]
local predictionintensity = 0.28

-- function taken from boardbot's generic roleplay gaem gui that included autokill
-- hes a G
-- source: https://raw.githubusercontent.com/Boardbot/grg/main/Boardbot's%20GRG%20GUI%20v2.lua
local function killthem(target)
	local wasPlayerKilled = false
	while not wasPlayerKilled do
		task.wait()
		
		if lplr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated then
			lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
		end

		local poopyPlayerFrame = Vector3.new(-1.5, -3.5, 1.5)
		local characterh = target.Character.HumanoidRootPart
		local velocityPlayer = characterh.Velocity
		local targetPlayerLocation = Vector3.new(characterh.Position.x + (velocityPlayer.x * predictionintensity), characterh.Position.y, characterh.Position.z + (velocityPlayer.z * predictionintensity))

		local newtargetPlayerLocation = targetPlayerLocation + poopyPlayerFrame


		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(newtargetPlayerLocation, Vector3.new(0, 99999999, 0))

		--[[tool.Equipped:Connect(function()    
			tool:Activate()
		end)]]

		if target.Character.Humanoid.Health == 0 or lplr.Character.Humanoid.Health == 0 or not game.Players:FindFirstChild(target.Name) then -- stop when ded
			wasPlayerKilled = true
		end
	end
end

local Flux = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt")()
local Window = Flux:Window("Cage Players", "Press N to open/close", Color3.fromRGB(255, 110, 48), Enum.KeyCode.N)
local Tab1 = Window:Tab("main", "http://www.roblox.com/asset/?id=6023426915")
Tab1:Label("made by discord: nexitysecond, .nexity.")
Tab1:Label("pick up an axe, type the target name, click kill player and start swinging axe")
Tab1:Button("destroy this GUI", "does what it says", function()
	game:GetService("CoreGui").FluxLib:Destroy()
end)

local target = nil
Tab1:Button("kill player", "requires an axe", function()
	killthem(target)
end)


Tab1:Textbox("type player name to kill", "can accept shortened name", true, function(text)
	target = getPlayer(text)
end)

Tab1:Textbox("change prediction intensity", "default: 0.28", true, function(text)
	predictionintensity = tonumber(text)
end)

