local waitingpayment = false
local waitingpaymentuser = ""
local waitingpaymentamount = 0 

function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function say(message)
    local args = {
        [1] = message,
        [2] = "All"
    }
    
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
end

function PlayerAdded(plr)
    plr.Chatted:Connect(function(msg)
        if string.find(msg, "!coinflip ") and waitingpayment == false then
           print("Coinflip in bound", tostring(Split(msg, "!coinflip ")[2]), plr.Name)
           waitingpaymentuser = plr.Name
           waitingpaymentamount = tonumber(Split(msg, "!coinflip ")[2])
           waitingpayment = true
           say("/ad " .. plr.Name .. " wagered " .. tostring(waitingpaymentamount) .. "! Awaiting transaction . . .")
        end
    end)
end

game.Players.PlayerAdded:Connect(PlayerAdded) -- connect each time someone joins
for i,v in pairs(game.Players:GetPlayers()) do --players that were already in game
   PlayerAdded(v)
end

local lastmoney
local numcount = 0
local normalcount = 0
spawn(function()
    while true do
        wait(0.1)
        if waitingpayment then
            numcount = numcount + 1
            local money = game.Players.LocalPlayer.PlayerData.Currency.Value
            if numcount == 250 then
                say(waitingpaymentuser .. " waited too long. Play by using '!coinflip <amount>'")
                waitingpayment = false
                numcount = 0
            end
            if numcount == 50 then
                say("/ad Press T > Give money to player > [Amount: " .. tostring(waitingpaymentamount) .. ", Player Name: " .. game.Players.LocalPlayer.Name .. "]")
            end
            if money >= lastmoney + waitingpaymentamount then
                print("payment received", tostring(waitingpaymentamount), waitingpaymentuser)
                waitingpayment = false
                if waitingpaymentamount > 1500 then
                    if math.random(1, 1000) > 700 then
                        local args = {
                            [1] = 2,
                            [2] = tostring(waitingpaymentamount * 2),
                            [3] = waitingpaymentuser
                        }
                        
                        game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(unpack(args))
                        say("/ad " .. waitingpaymentuser .. " has won $" .. tostring(waitingpaymentamount) .. "! To play yourself, type !coinflip <amount>")
                    else
                        say("/ad " .. waitingpaymentuser .. " has lost. To play yourself, type !coinflip <amount>")
                    end
                elseif waitingpaymentamount < 1500 then
                    if math.random(1, 1000) > 500 then
                        local args = {
                            [1] = 2,
                            [2] = tostring(waitingpaymentamount * 2),
                            [3] = waitingpaymentuser
                        }
                        
                        game:GetService("ReplicatedStorage").Events.MenuActionEvent:FireServer(unpack(args))
                        say("/ad " .. waitingpaymentuser .. " has won $" .. tostring(waitingpaymentamount) .. "! To play yourself, type !coinflip <amount>")
                    else
                        say("/ad " .. waitingpaymentuser .. " has lost. To play yourself, type !coinflip <amount>")
                    end
                end
            end
        else
            normalcount = normalcount + 1
            if normalcount == 600 then
                say("/ad Hello! To play type '!coinflip <amount>'!")
                normalcount = 0
            end
            lastmoney = game.Players.LocalPlayer.PlayerData.Currency.Value
        end
    end
end)
