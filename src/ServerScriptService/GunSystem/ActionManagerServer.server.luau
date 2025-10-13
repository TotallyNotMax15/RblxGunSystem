local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(script.Parent.Modules.Config)

local remote = ReplicatedStorage.GunSystem.remotes.ChangeState

remote.OnServerEvent:Connect(function(plr, state:string)
    if state == "Stand" then
        Stand(plr)
    elseif state == "Crouch" then
        Crouch(plr)
    elseif state == "Prone" then
        Prone(plr)
    end
end)

function Stand(plr:Player)
    local hum = plr.Character:WaitForChild("Humanoid")
    hum.HipHeight = 0
    hum.WalkSpeed = Config.DefaultWalkSpeed
    hum.JumpHeight = Config.DefaultJumpHeight
    hum.JumpPower = Config.DefaultJumpPower
end

function Crouch(plr:Player)
    local hum = plr.Character:WaitForChild("Humanoid")
    hum.HipHeight = -1
    hum.WalkSpeed = Config.CrouchSpeed
    hum.JumpHeight = 0
    hum.JumpPower = 0
end

function Prone(plr:Player)
    local hum = plr.Character:WaitForChild("Humanoid")
    hum.HipHeight = -2
    hum.WalkSpeed = Config.ProneSpeed
    hum.JumpHeight = 0
    hum.JumpPower = 0
end