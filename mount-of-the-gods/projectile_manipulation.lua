-- something cool i found
-- like that thing in murder mystery 2
local plr = game.Players.LocalPlayer
local p = plr.Character.HumanoidRootPart.Position
local RS = game.ReplicatedStorage

local function GetPositions(NumberOfPositions, Radius, RootPosition)
   local Positions = {}
   local angularDisplacement = 360 / NumberOfPositions

   for i=1, NumberOfPositions do
       local angleVector = Vector3.new(Radius * math.cos(math.rad(i * angularDisplacement)), 0, Radius * math.sin(math.rad(i * angularDisplacement)))
       Positions[#Positions + 1] = RootPosition + angleVector
   end

   return Positions
end

local function makeProjectile(pos)
    RS.Resources.Remotes.MakeProjectile:FireServer("Dart", pos, 11)
end

for i=1, 10, 1 do
    for i, pos in pairs(GetPositions(8, 20, p)) do
        coroutine.wrap(makeProjectile)(pos)
    end
    task.wait(.03)
    for i, pos in pairs(GetPositions(20, 20, p)) do
        coroutine.wrap(makeProjectile)(pos)
    end
end
