local buildremote = game.Players.LocalPlayer.PlayerGui.MainGui.Events.Build

function place(x, z)
    buildremote:FireServer(0, Vector3.new(x, 1, z), Vector3.new(0, 0, 0))
end

function getplot()
    for i,v in pairs(game.Workspace.Boundaries:GetChildren()) do
        if tostring(v.Owner.Value) == game.Players.LocalPlayer.Name then
            return v
        end
    end
end

local p = getplot()
local lowx, lowz = p.Position.x - 62, p.Position.z - 125
local highx, highz = p.Position.x + 62, p.Position.z + 125

place(lowx, lowz)
place(highx, lowz)
place(lowx, highz)
place(highx, highz)
