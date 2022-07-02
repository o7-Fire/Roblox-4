--lol, btw it only gives 100 mil so that you stay hidden, if you try to give more like 1 billion, the random player's money will be negative 1 bil
llocal giveeveryonecash = false

function givemoney(plr, amount)
    local args = {
        [1] = plr,
        [2] = amount
    }
    game:GetService("ReplicatedStorage").GiveEvent:FireServer(unpack(args))
end

local randomPlayer = game.Players:GetChildren()[math.random(1,#game.Players:GetChildren())]
givemoney(randomPlayer, 100000000)
givemoney(randomPlayer, -100000000)

if giveeveryonecash then
    for i,v in pairs(game.Players:GetChildren()) do
        local args = {
            [1] = v,
            [2] = math.random(10000000, 500000000)
        }
        
        game:GetService("ReplicatedStorage").GiveEvent:FireServer(unpack(args))
    end
end
