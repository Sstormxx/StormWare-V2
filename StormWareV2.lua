local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "⚡ StormWare V2 ⚡",
   LoadingTitle = "Loading StormWare...",
   LoadingSubtitle = "By StormWare",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "StormWare V2 Premium"
   },
   Discord = {
      Enabled = true,
      Invite = "discord.gg/CbEkTHDQrJ", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "StormWare | Key",
      Subtitle = "Ask owner for key",
      Note = "private script",
      FileName = "StormWare Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"rico2bandzz"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("Main", nil) -- Title, Image
local Section = MainTab:CreateSection("Player")

local Slider = MainTab:CreateSlider({
   Name = "Field Of View",
   Range = {0, 120},
   Increment = 1,
   Suffix = "Field Of View",
   CurrentValue = 70,
   Flag = "fovslider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        local FovNumber = (Value)
        local Camera = workspace.CurrentCamera
        Camera.FieldOfView = FovNumber

   end,
})

local Button = MainTab:CreateButton({
   Name = "Infinite Jump",
   Callback = function()
                --Toggles the infinite jump between on or off on every script run
_G.infinjump = not _G.infinjump

if _G.infinJumpStarted == nil then
    --Ensures this only runs once to save resources
    _G.infinJumpStarted = true

    --Notifies readiness
    game.StarterGui:SetCore("SendNotification", {Title="StormWare"; Text="Infinite Jump Activated!"; Duration=5;})

    --The actual infinite jump
    local plr = game:GetService('Players').LocalPlayer
    local m = plr:GetMouse()
    m.KeyDown:connect(function(k)
        if _G.infinjump then
            if k:byte() == 32 then
            humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
            humanoid:ChangeState('Jumping')
            wait()
            humanoid:ChangeState('Seated')
            end
        end
    end)
end
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "Speed",
   Range = {0, 300},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "JumpPower",
   Range = {0, 300},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
   end,
})

local Toggle = MainTab:CreateToggle({
   Name = "Noclip (B) ",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local noclipEnabled = false

-- Function to toggle collisions on all character parts
local function setCollision(state)
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = not state
		end
	end
end

-- Re-apply character when respawned
player.CharacterAdded:Connect(function(char)
	character = char
	char:WaitForChild("HumanoidRootPart")
	if noclipEnabled then
		wait(1) -- Wait for parts to load
		setCollision(true)
	end
end)

-- Key press toggle
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.B then
		noclipEnabled = not noclipEnabled
		setCollision(noclipEnabled)
		print("Noclip:", noclipEnabled and "Enabled" or "Disabled")
	end
end)

-- Ensure parts stay non-collidable while noclip is on
RunService.Stepped:Connect(function()
	if noclipEnabled and character then
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	end
end)

   end,
})

local Toggle = MainTab:CreateToggle({
   Name = "Fly (F)",
   CurrentValue = false,
   Flag = "Toggle", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local flying = false
local speed = 50 -- Adjust this value for the flying speed
local bodyGyro, bodyVelocity

-- Function to start flying
local function startFlying()
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.maxTorque = Vector3.new(9e4, 9e4, 9e4)
    bodyGyro.cframe = character.HumanoidRootPart.CFrame
    bodyGyro.Parent = character.HumanoidRootPart

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.velocity = Vector3.new(0, 0, 0)
    bodyVelocity.maxForce = Vector3.new(9e4, 9e4, 9e4)
    bodyVelocity.Parent = character.HumanoidRootPart

    flying = true
end

-- Function to stop flying
local function stopFlying()
    flying = false
    if bodyGyro then bodyGyro:Destroy() end
    if bodyVelocity then bodyVelocity:Destroy() end
end

-- Function to update flying direction
local function updateFlyDirection()
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    local flyDirection = Vector3.new(0, 0, 0)
    local camera = workspace.CurrentCamera

    if uis:IsKeyDown(Enum.KeyCode.W) then
        flyDirection = flyDirection + (camera.CFrame.LookVector * speed)
    end
    if uis:IsKeyDown(Enum.KeyCode.S) then
        flyDirection = flyDirection - (camera.CFrame.LookVector * speed)
    end
    if uis:IsKeyDown(Enum.KeyCode.A) then
        flyDirection = flyDirection - (camera.CFrame.RightVector * speed)
    end
    if uis:IsKeyDown(Enum.KeyCode.D) then
        flyDirection = flyDirection + (camera.CFrame.RightVector * speed)
    end
    if uis:IsKeyDown(Enum.KeyCode.Space) then
        flyDirection = flyDirection + Vector3.new(0, speed, 0)
    end
    if uis:IsKeyDown(Enum.KeyCode.LeftControl) then
        flyDirection = flyDirection - Vector3.new(0, speed, 0)
    end

    if bodyVelocity then
        bodyVelocity.velocity = flyDirection
    end
end

-- Main loop to update flying state
runService.RenderStepped:Connect(function()
    if flying then
        updateFlyDirection()
    end
end)

-- Toggle fly on key press
mouse.KeyDown:Connect(function(key)
    if key == "f" then
        if flying then
            stopFlying()
        else
            startFlying()
        end
    end
end)
   end,
})

local AimAssistTab = Window:CreateTab("AimAssist", nil) -- Title, Image
local Section = AimAssistTab:CreateSection("Combat")

local Toggle = AimAssistTab:CreateToggle({
    Name = "Aimbot (V) ",
    CurrentValue = false,
    Flag = "Toggle",
    Callback = function(Value)
        local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- SETTINGS
local aimbotEnabled = false
local rightClickHeld = false
local aimPartName = "Head"
local maxDistance = 1000
local fov = 70
local smoothness = 1
local targetIndicator = nil
local fovCircle = nil

-- Drawing API FOV Circle
local function createFovCircle()
    if not fovCircle then
        fovCircle = Drawing.new("Circle")
        fovCircle.Radius = fov
        fovCircle.Thickness = 2
        fovCircle.Color = Color3.fromRGB(255, 255, 255)
        fovCircle.Transparency = 0.5
        fovCircle.Visible = true
        fovCircle.Filled = false
        fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    end
end

local function removeFovCircle()
    if fovCircle then
        fovCircle:Remove()
        fovCircle = nil
    end
end

-- Create a target indicator part
local function createTargetIndicator()
    local indicator = Instance.new("Part")
    indicator.Size = Vector3.new(1, 1, 1)
    indicator.Shape = Enum.PartType.Ball
    indicator.Color = Color3.fromRGB(255, 0, 0)
    indicator.Anchored = true
    indicator.CanCollide = false
    indicator.Parent = Workspace
    return indicator
end

local function removeTargetIndicator()
    if targetIndicator then
        targetIndicator:Destroy()
        targetIndicator = nil
    end
end

-- Input handling
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    -- Toggle aimbot with V
    if input.KeyCode == Enum.KeyCode.V then
        aimbotEnabled = not aimbotEnabled
        if aimbotEnabled then
            createFovCircle()
            print("Aimbot Enabled")
        else
            removeFovCircle()
            removeTargetIndicator()
            print("Aimbot Disabled")
        end
    end

    -- Detect right click
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        rightClickHeld = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        rightClickHeld = false
        removeTargetIndicator()
    end
end)

-- Get closest target
local function getClosestTarget()
    local closestTarget = nil
    local closestDist = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(aimPartName) then
            local targetPart = player.Character[aimPartName]
            local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)

            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                local targetDistance = (Camera.CFrame.Position - targetPart.Position).Magnitude

                if dist < fov and targetDistance <= maxDistance then
                    local ray = Ray.new(Camera.CFrame.Position, (targetPart.Position - Camera.CFrame.Position).Unit * targetDistance)
                    local hitPart = Workspace:FindPartOnRay(ray, LocalPlayer.Character)

                    if not hitPart or hitPart:IsDescendantOf(player.Character) then
                        if dist < closestDist then
                            closestDist = dist
                            closestTarget = targetPart
                        end
                    end
                end
            end
        end
    end

    return closestTarget
end

-- Aimbot loop
RunService.RenderStepped:Connect(function()
    if fovCircle then
        fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    end

    if not (aimbotEnabled and rightClickHeld) then return end

    local targetPart = getClosestTarget()
    if targetPart then
        local camPos = Camera.CFrame.Position
        local targetPos = targetPart.Position
        local currentLook = Camera.CFrame.LookVector

        local direction = (targetPos - camPos).Unit
        local newDirection = currentLook:Lerp(direction, smoothness)
        local newCFrame = CFrame.new(camPos, camPos + newDirection)

        Camera.CFrame = newCFrame

        if not targetIndicator then
            targetIndicator = createTargetIndicator()
        end
        targetIndicator.Position = targetPos
    else
        removeTargetIndicator()
    end
end)

   end,
})

local Toggle = AimAssistTab:CreateToggle({
   Name = "Kill All (E)",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        -- Import necessary libraries
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Boolean to toggle silent aim
local silentAimEnabled = false

-- Function to check if a player is on the same team
local function isOnSameTeam(player1, player2)
    if player1.Team and player2.Team then
        return player1.Team == player2.Team
    end
    return false
end

-- Silent aim function
local function silentAim(target)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = target.Character.HumanoidRootPart.Position
        local myCharacter = LocalPlayer.Character
        if myCharacter and myCharacter:FindFirstChild("HumanoidRootPart") then
            myCharacter.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
        end
    end
end

-- Toggle key function
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.E then -- 'E' key to toggle silent aim
        silentAimEnabled = not silentAimEnabled
        if silentAimEnabled then
            print("Kill All Enabled")
        else
            print("Kill All Disabled")
        end
    end
end)

-- Main loop
while true do
    wait(0.1)

    if silentAimEnabled then
        local closestTarget = nil
        local closestDistance = math.huge

        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                if not isOnSameTeam(LocalPlayer, player) then -- Check if they are not on the same team
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestTarget = player
                    end
                end
            end
        end

        if closestTarget then
            silentAim(closestTarget)
        end
    end
end
   end,
})

local Section = AimAssistTab:CreateSection("Visuals")

local Button = AimAssistTab:CreateButton({
   Name = "Tracers (g) ",
   Callback = function()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Tracer system state
local tracersEnabled = true
local tracers = {}

-- Function to create a tracer
local function createTracer(player)
    local tracer = Drawing.new("Line")
    tracer.Color = player.Team and player.Team.TeamColor.Color or Color3.new(1, 1, 1)
    tracer.Thickness = 1
    tracer.Transparency = 1
    tracer.Visible = false

    local function updateTracer()
        if not tracersEnabled then
            tracer.Visible = false
            return
        end

        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = player.Character.HumanoidRootPart
            local screenPos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
            tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
            tracer.To = Vector2.new(screenPos.X, screenPos.Y)
            tracer.Visible = onScreen
        else
            tracer.Visible = false
        end
    end

    RunService.RenderStepped:Connect(updateTracer)

    return tracer
end

-- Refresh all tracers
local function refreshTracers()
    -- Clear old tracers
    for _, tracer in pairs(tracers) do
        tracer:Remove()
    end
    tracers = {}

    -- Create new tracers
    if not tracersEnabled then return end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            tracers[player] = createTracer(player)
        end
    end
end

-- Refresh every 3 seconds while tracers are enabled
task.spawn(function()
    while true do
        if tracersEnabled then
            refreshTracers()
        end
        task.wait(3)
    end
end)

-- Toggle key (G)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.G then
        tracersEnabled = not tracersEnabled
        print("Tracers " .. (tracersEnabled and "Enabled" or "Disabled"))
        refreshTracers()
    end
end)

-- Clean up when players leave
Players.PlayerRemoving:Connect(function(player)
    if tracers[player] then
        tracers[player]:Remove()
        tracers[player] = nil
    end
end)

   end,
})

local Button = AimAssistTab:CreateButton({
   Name = "ESP (g) ",
   Callback = function()
-- 2D ESP Script (Fixed Size Based on Character Height, Toggle G)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local espBoxes = {}
local refreshInterval = 3
local lastRefresh = 0
local espEnabled = true

-- Create ESP box
local function createBox()
	local box = Drawing.new("Square")
	box.Thickness = 2
	box.Filled = false
	box.Transparency = 1
	box.Visible = false
	return box
end

-- Clear all boxes
local function clearBoxes()
	for _, box in pairs(espBoxes) do
		if box then
			box:Remove()
		end
	end
	espBoxes = {}
end

-- Refresh ESP boxes
local function refreshESP()
	clearBoxes()
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			espBoxes[player] = createBox()
		end
	end
end

-- Toggle ESP with G
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.G then
		espEnabled = not espEnabled
		for _, box in pairs(espBoxes) do
			if box then
				box.Visible = false
			end
		end
	end
end)

-- Initial setup
refreshESP()

-- Main render loop
RunService.RenderStepped:Connect(function(dt)
	-- Refresh every 3 seconds
	lastRefresh += dt
	if lastRefresh >= refreshInterval then
		lastRefresh = 0
		refreshESP()
	end

	if not espEnabled then return end

	for _, player in pairs(Players:GetPlayers()) do
		local box = espBoxes[player]
		if player ~= LocalPlayer and box and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local char = player.Character
			local hrp = char:FindFirstChild("HumanoidRootPart")

			local head = char:FindFirstChild("Head")
			local lowerTorso = char:FindFirstChild("LowerTorso") or hrp

			if head and lowerTorso then
				local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
				local torsoPos, torsoOnScreen = Camera:WorldToViewportPoint(lowerTorso.Position - Vector3.new(0, 2.5, 0))

				if headOnScreen and torsoOnScreen then
					local boxHeight = math.abs(torsoPos.Y - headPos.Y)
					local boxWidth = boxHeight / 2  -- Box is thinner than height

					box.Size = Vector2.new(boxWidth, boxHeight)
					box.Position = Vector2.new(headPos.X - boxWidth / 2, headPos.Y)
					box.Color = player.Team and player.Team.TeamColor.Color or Color3.new(1, 1, 1)
					box.Visible = true
				else
					box.Visible = false
				end
			else
				box.Visible = false
			end
		elseif box then
			box.Visible = false
		end
	end
end)

   end,
})

local Button = AimAssistTab:CreateButton({
   Name = "HealthBar (g) ",
   Callback = function()
-- Health Bar Only Script (Right Side of Player, Color Based on Health)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local healthBars = {}
local refreshInterval = 3
local lastRefresh = 0
local espEnabled = true

-- Color codes
local green = Color3.fromRGB(0, 255, 0)
local amber = Color3.fromRGB(255, 165, 0)
local red = Color3.fromRGB(255, 0, 0)

-- Create health bar
local function createHealthBar()
	local bar = Drawing.new("Line")
	bar.Thickness = 4
	bar.Transparency = 1
	bar.Visible = false
	return bar
end

-- Clear all bars
local function clearBars()
	for _, bar in pairs(healthBars) do
		if bar then bar:Remove() end
	end
	healthBars = {}
end

-- Refresh bar list
local function refreshBars()
	clearBars()
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			healthBars[player] = createHealthBar()
		end
	end
end

-- Toggle with G
UserInputService.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == Enum.KeyCode.G then
		espEnabled = not espEnabled
		for _, bar in pairs(healthBars) do
			if bar then
				bar.Visible = espEnabled
			end
		end
	end
end)

-- First refresh
refreshBars()

-- Main loop
RunService.RenderStepped:Connect(function(dt)
	lastRefresh += dt
	if lastRefresh >= refreshInterval then
		lastRefresh = 0
		refreshBars()
	end

	if not espEnabled then return end

	for _, player in pairs(Players:GetPlayers()) do
		local bar = healthBars[player]
		if player ~= LocalPlayer and bar and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local char = player.Character
			local humanoid = char:FindFirstChildOfClass("Humanoid")
			local head = char:FindFirstChild("Head")
			local torso = char:FindFirstChild("LowerTorso") or char:FindFirstChild("HumanoidRootPart")

			if humanoid and humanoid.Health > 0 and head and torso then
				local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
				local torsoPos, torsoOnScreen = Camera:WorldToViewportPoint(torso.Position - Vector3.new(0, 2.5, 0))

				if headOnScreen and torsoOnScreen then
					local barHeight = math.abs(torsoPos.Y - headPos.Y)
					local hpPercent = humanoid.Health / humanoid.MaxHealth
					local filledHeight = barHeight * hpPercent

					local x = headPos.X + 35 -- Adjust as needed to move right of player
					local y1 = headPos.Y + barHeight
					local y2 = y1 - filledHeight

					bar.From = Vector2.new(x, y1)
					bar.To = Vector2.new(x, y2)

					-- Set color
					if humanoid.Health >= 50 then
						bar.Color = green
					elseif humanoid.Health >= 25 then
						bar.Color = amber
					else
						bar.Color = red
					end

					bar.Visible = true
				else
					bar.Visible = false
				end
			else
				bar.Visible = false
			end
		elseif bar then
			bar.Visible = false
		end
	end
end)

   end,
})

local MiscTab = Window:CreateTab("Misc", nil) -- Title, Image
local Section = MiscTab:CreateSection("Extra")

local Button = MiscTab:CreateButton({
   Name = "Remove Textures",
   Callback = function()
        -- Function to remove textures from a part
local function removeTexturesFromPart(part)
    -- Remove Texture instances
    for _, child in ipairs(part:GetChildren()) do
        if child:IsA("Texture") or child:IsA("Decal") then
            child:Destroy()
        end
    end
end

-- Function to recursively remove textures from all descendants
local function removeTexturesFromDescendants(parent)
    for _, descendant in ipairs(parent:GetDescendants()) do
        if descendant:IsA("BasePart") then
            removeTexturesFromPart(descendant)
        end
    end
end

-- Initial removal from all parts in the game
removeTexturesFromDescendants(game.Workspace)

-- Listen for new parts being added to the game
game.Workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("BasePart") then
        removeTexturesFromPart(descendant)
    end
end)
   end,
})

local Button = MiscTab:CreateButton({
   Name = "Server Hop",
   Callback = function()
        -- Example script in a LocalScript (can be placed in a GUI or a part)

-- Replace with the place ID of the destination place you want to teleport to
local destinationPlaceId = 1234567890

-- Teleport function
local function teleportToPlace()
    -- Check if TeleportService is available
    if game:GetService("TeleportService") then
        -- Teleport the player to the specified place
        game:GetService("TeleportService"):Teleport(destinationPlaceId)
    else
        warn("TeleportService is not available.")
    end
end

-- Example usage: Bind this function to a UI button or a part's Touched event
teleportToPlace()
   end,
})

local Button = MiscTab:CreateButton({
   Name = "Rejoin",
   Callback = function()
        local player = game.Players.LocalPlayer
local teleportService = game:GetService("TeleportService")

local function rejoinServer()
    local success, errorMessage = pcall(function()
        teleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
    end)
    if not success then
        warn("Failed to rejoin server: " .. errorMessage)
    end
end

rejoinServer()
   end,
})

local Button = MiscTab:CreateButton({
   Name = "Anti AFK",
   Callback = function()
        -- This script is a LocalScript that should be placed in a player's GUI or StarterGui

-- Set the maximum allowed AFK time in seconds (adjust as needed)
local MAX_AFK_TIME = 2628002 -- 1 month

local player = game.Players.LocalPlayer
local lastActivityTime = tick() -- Initial activity time

-- Function to check player activity
local function checkActivity()
    local currentTime = tick()
    local elapsedTime = currentTime - lastActivityTime

    if elapsedTime > MAX_AFK_TIME then
        -- Player has been AFK for too long, display a message or take action
        -- Example: Display a warning message
        warn("You will be kicked for AFK soon. Move to stay active.")

        -- Example: Teleport the player to a lobby or respawn them
        -- game:GetService("TeleportService"):Teleport(lobbyPlaceId)

        -- You can implement your own AFK handling logic here
    end
end

-- Function to update last activity time
local function updateActivityTime()
    lastActivityTime = tick()
end

-- Connect updateActivityTime to player input events (e.g., mouse move, key press)
game:GetService("UserInputService").InputBegan:Connect(function(input)
    updateActivityTime()
end)

-- Check player activity periodically
while true do
    checkActivity()
    wait(10) -- Check activity every 10 seconds (adjust as needed)
end
   end,
})
