-- https://testapi2becausereplsucksataccepting6568filessmhfuckyourepl.o7fire.repl.co/

function rgbToHex(rgb)
	local hexadecimal = ''

	for key, value in pairs(rgb) do
		local hex = ''

		while(value > 0)do
			local index = math.fmod(value, 16) + 1
			value = math.floor(value / 16)
			hex = string.sub('0123456789ABCDEF', index, index) .. hex			
		end

		if(string.len(hex) == 0)then
			hex = '00'

		elseif(string.len(hex) == 1)then
			hex = '0' .. hex
		end

		hexadecimal = hexadecimal .. hex
	end

	return hexadecimal
end

function split(str, character)
  result = {}

  index = 1
  for s in string.gmatch(str, "[^"..character.."]+") do
    result[index] = s
    index = index + 1
  end

  return result
end

print("starting")
plotnumber = ""
for x, y in pairs(game.Workspace.DrawBoards.DrawBoards:GetChildren()) do
    if y.name.Value == game.Players.LocalPlayer.Name then
        plotnumber = y.Name
    end
end
--print(rgbToHex({math.random(0, 255), math.random(0, 255), math.random(0, 255)}))
local totalframes = split(game:HttpGet("https://testapi2becausereplsucksataccepting6568filessmhfuckyourepl.o7fire.repl.co/frames"), "N")
for frame=0, 6568 do
    if frame > 60 then
        spawn(function()
            
            for i=1, 576 do
                local lastcharacter = totalframes[frame - 1]:sub(i, i)
                local character = totalframes[frame]:sub(i, i)
                if character == "A" and tostring(character) ~= tostring(lastcharacter) then
                    local args = {
                        [1] = "ApplyColor",
                        [2] = workspace.DrawBoards.DrawBoards:FindFirstChild(plotnumber).Pixels,
                        [3] = rgbToHex({0, 0, 0}),
                        [4] = '',
                        [5] = workspace.DrawBoards.DrawBoards:FindFirstChild(plotnumber).Pixels:FindFirstChild(i)
                    }
                    game:GetService("ReplicatedStorage").Port:FireServer(unpack(args))
                elseif character == "B" and tostring(character) ~= tostring(lastcharacter) then
                    local args = {
                        [1] = "ApplyColor",
                        [2] = workspace.DrawBoards.DrawBoards:FindFirstChild(plotnumber).Pixels,
                        [3] = rgbToHex({255, 255, 255}),
                        [4] = '',
                        [5] = workspace.DrawBoards.DrawBoards:FindFirstChild(plotnumber).Pixels:FindFirstChild(i)
                    }
                    game:GetService("ReplicatedStorage").Port:FireServer(unpack(args))
                end
            end
        end)
        wait(0.033)
    end
end
