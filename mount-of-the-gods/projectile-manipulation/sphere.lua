local plr = game.Players.LocalPlayer
local p = plr.Character.HumanoidRootPart.Position
local RS = game.ReplicatedStorage

local function makeProjectile(pos)
    RS.Resources.Remotes.MakeProjectile:FireServer("Dart", pos, 99999)
end

local samples = 150
for i=1, 5, 1 do
    local rnd = 1.0
    rnd = math.random() * samples
    local points = {}
    local offset = 2/samples
    local increment = math.pi * (3. - math.sqrt(5))

    for i=1, samples do
        y = ((i * offset) - 1) + (offset / 2)
        r = math.sqrt(1 - math.pow(y,2))

        phi = ((i + rnd) % samples) * increment

        x = math.cos(phi) * r
        z = math.sin(phi) * r
        coroutine.wrap(makeProjectile)(p + CFrame.new( (Vector3.new(x, y, z)) *10).Position)
    end

    task.wait(.1)
end
