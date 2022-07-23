--Magic Code
old = hookmetamethod(game, "__namecall", function(self, ...)
    if getnamecallmethod() == "InvokeServer" and self.Name == "UpdateDamageKey" then
       a = {...}
       getgenv().id = a[1]
    end
    return old(self, ...)
    end)

--Money
for i = 1,10000 do
    coroutine.wrap(function()
        workspace.Baddies:GetChildren()[1].Humanoid.Damage:FireServer({["Knifed"] = true, ["BodyPart"] = workspace.Baddies:GetChildren()[1].HumanoidRootPart, ["Damage"] = -150}, id)
    end)()
 end

--Ammo
for i,v in pairs(getgc(true)) do
    if typeof(v) == "table" and rawget(v, "Spread") then
            rawset(v, "Ammo", 7777)
            rawset(v, "StoredAmmo", 7777)
    end
 end