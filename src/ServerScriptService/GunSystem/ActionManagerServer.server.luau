local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(script.Parent.Modules.Config)
local Anims = require(script.Parent.Modules.Anims)

local remote = ReplicatedStorage.GunSystem.remotes.ChangeState

local function Animate(plr:Player, animName:string)
    local char = plr.Character
    local plrAnimScript = char.Animate

    plrAnimScript:FindFirstChild("idle").Animation1.AnimationId = Anims.Idle[animName]
    plrAnimScript:FindFirstChild("idle").Animation2.AnimationId = Anims.Idle[animName]
    plrAnimScript:FindFirstChild("walk").WalkAnim.AnimationId = Anims.Move[animName]
end

function Stand(plr:Player)
    local hum = plr.Character:WaitForChild("Humanoid")
    hum.HipHeight = 0
    hum.WalkSpeed = Config.DefaultWalkSpeed
    hum.JumpHeight = Config.DefaultJumpHeight
    hum.JumpPower = Config.DefaultJumpPower
    Animate(plr, "Stand")
end

function Crouch(plr:Player)
    local hum = plr.Character:WaitForChild("Humanoid")
    hum.HipHeight = -1.5
    hum.WalkSpeed = Config.CrouchSpeed
    hum.JumpHeight = 0
    hum.JumpPower = 0
    Animate(plr, "Crouch")
end

function Prone(plr:Player)
    local hum = plr.Character:WaitForChild("Humanoid")
    hum.HipHeight = -2
    hum.WalkSpeed = Config.ProneSpeed
    hum.JumpHeight = 0
    hum.JumpPower = 0
end

remote.OnServerEvent:Connect(function(plr, state:string)
    if state == "Stand" then
        Stand(plr)
    elseif state == "Crouch" then
        Crouch(plr)
    elseif state == "Prone" then
        Prone(plr)
    end
end)