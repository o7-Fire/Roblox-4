--lol
local randomPlayer = game.Players:GetPlayers()[math.random(1,#game.Players:GetPlayers())]

local args = {
    [1] = randomplayer,
    [2] = -99999999999999999
}

game:GetService("ReplicatedStorage").GiveEvent:FireServer(unpack(args))
