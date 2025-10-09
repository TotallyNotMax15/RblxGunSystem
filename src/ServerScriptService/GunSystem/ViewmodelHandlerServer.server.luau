local RS = game.ReplicatedStorage
local ViewModelRemote = RS.GunSystem.Viewmodels.ViewModelRemote
local RunService = game:GetService("RunService")

local function MatchArmsToPlayer(viewModel, player)
	local humanoid = player.Character:FindFirstChildOfClass('Humanoid')
	if not humanoid then return end

	local RightArmColor = humanoid:GetAppliedDescription().RightArmColor
	local LeftArmColor = humanoid:GetAppliedDescription().LeftArmColor
	local shirt = player.Character:FindFirstChild("Shirt")
	local ViewmodelShirt = viewModel:FindFirstChild("Shirt")

	if viewModel:FindFirstChild("Right Arm") then
		viewModel["Right Arm"].Color = RightArmColor
	end

	if viewModel:FindFirstChild("Left Arm") then
		viewModel["Left Arm"].Color = LeftArmColor
	end

	if shirt and ViewmodelShirt then
		ViewmodelShirt.ShirtTemplate = shirt.ShirtTemplate
	end
end

local function setArmsTransparency(player,transparency)
	local character = player.Character
	if not character then return end
	local RightArm = character:FindFirstChild("Right Arm")
	local LeftArm = character:FindFirstChild("Left Arm")

	if RightArm.Transparency then
		RightArm.Transparency = transparency
	end
	if LeftArm.Transparency then
		LeftArm.Transparency = transparency
	end
end

ViewModelRemote.OnServerEvent:Connect(function(player,ViewModelTP,equipped,GunName)	
	if equipped  then
		if not ViewModelTP then return end
		
		local newViewModelTPS = ViewModelTP:Clone()
		newViewModelTPS.Parent = player.Character
		newViewModelTPS.Name = GunName.."_TPServerViewmodel"
		MatchArmsToPlayer(newViewModelTPS,player)
		setArmsTransparency(player,1)

		local lastCf = player.Character.Head.CFrame
		local connection
		
		connection = RunService.Heartbeat:Connect(function()
			local character = player.Character
			if character and character:FindFirstChild("Head").CFrame then
				local targetCf = character.Head.CFrame
				lastCf = lastCf:Lerp(targetCf,0.15)
				newViewModelTPS:PivotTo(lastCf)
			else
				connection:Disconnect()
			end
		end)
	else
		local ViewModelTPS = player.Character:FindFirstChild(GunName.."_TPServerViewmodel")
		if ViewModelTPS then
			ViewModelTPS:Destroy()
			setArmsTransparency(player,0)
		end
	end	
end)