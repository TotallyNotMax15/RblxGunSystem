local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(script.Parent.Modules.Config)

local remote = ReplicatedStorage.GunSystem.remotes.ChangeState

local function getCacheFolder(plr:Player)
    local cachedAnims 
    if not plr.Character:FindFirstChild("CachedAnims") then
        cachedAnims = Instance.new("Folder",plr.Character)
        cachedAnims.Name = "CachedAnims"
    else
        cachedAnims = plr.Character:FindFirstChild("CachedAnims")
    end
    return cachedAnims
end

local function Animate(plr:Player, state:string, animName:string)
    local char = plr.Character
    local hum = char:WaitForChild("Humanoid")
    local animator = hum:FindFirstChild("Animator")
    local cachedAnims = getCacheFolder(plr)
    
end

function Stand(plr:Player)
    local hum = plr.Character:WaitForChild("Humanoid")
    Animate(plr, "Crouch")
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

remote.OnServerEvent:Connect(function(plr, state:string)
    if state == "Stand" then
        Stand(plr)
    elseif state == "Crouch" then
        Crouch(plr)
    elseif state == "Prone" then
        Prone(plr)
    end
end)