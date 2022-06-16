function RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end

local remote = game:GetService("ReplicatedStorage").remotes.entity.claimEgg
for i=1, 1000, 1 do
remote:FireServer(RandomVariable(20))
end
