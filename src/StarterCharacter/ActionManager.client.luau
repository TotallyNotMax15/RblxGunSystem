-- Services
local CAS = game:GetService("ContextActionService")
local Players = game:GetService("Players")

-- Plr variables
local player = Players.LocalPlayer
local char = player.Character
local hum = char:WaitForChild("Humanoid")

-- State Check Vatiables
local crouchPos = 0 -- 0 - standing, 1 - crouching, 2 - crawling


function handleActions(action:string, inputState)
    if action == "Stand" and not hum.Sit and inputState == Enum.UserInputState.Begin then
        if crouchPos == 1 then
            crouchPos = 0
            Stand() 
        elseif crouchPos == 2 then
            crouchPos = 1
            Crouch()
        end
    end

    if action == "Crouch" and not hum.Sit and inputState == Enum.UserInputState.Begin then
        if crouchPos == 0 then
            crouchPos = 1
            Crouch()
        elseif crouchPos == 1 then
            crouchPos = 2
            Prone()
        end
    end

end

function Stand()
    print("Standing")
end

function Crouch()
    print("Crouching")
end

function Prone()
    print("Proning")
end

CAS:BindAction("Stand", handleActions, true, Enum.KeyCode.X)
CAS:BindAction("Crouch", handleActions, true,Enum.KeyCode.C)