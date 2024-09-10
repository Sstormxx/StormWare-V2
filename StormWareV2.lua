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
   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "StormWare | Key",
      Subtitle = "Key In Discord",
      Note = "Join our server!",
      FileName = "StormWare Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"hY4kWWxjG2L9azQxL46j1"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
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
    Name = "Aimbot (C) ",
    CurrentValue = false,
    Flag = "Toggle",
    Callback = function(Value)
        local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local fovCircle = Drawing.new("Circle")
fovCircle.Radius = 70
fovCircle.Color = Color3.fromRGB(255, 255, 255)
fovCircle.Thickness = 1
fovCircle.NumSides = 100
fovCircle.Filled = false

local targetingActive = false

local function isPlayerVisible(target)
    local ray = Ray.new(Camera.CFrame.Position, (target.Character.Head.Position - Camera.CFrame.Position).unit * 100)
    local hitPart = workspace:FindPartOnRay(ray, LocalPlayer.Character)
    return hitPart == target.Character.Head
end

local function getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team and player.Character and player.Character:FindFirstChild("Head") then
            local distance = (Camera.CFrame.Position - player.Character.Head.Position).magnitude
            if distance < closestDistance and isPlayerVisible(player) then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end

    return closestPlayer
end

-- Toggle targeting mode using the "C" key
Mouse.KeyDown:Connect(function(key)
    if key:lower() == "c" then
        targetingActive = not targetingActive
        fovCircle.Visible = targetingActive
    end
end)

Mouse.Button2Down:Connect(function()
    if not targetingActive then return end

    while Mouse.Button2Down do
        fovCircle.Position = Vector2.new(Mouse.X, Mouse.Y)

        local targetPlayer = getClosestPlayer()
        if targetPlayer then
            local targetPosition = targetPlayer.Character.Head.Position
            local direction = (targetPosition - Camera.CFrame.Position).unit
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPosition)
        end

        wait()
    end
    fovCircle.Visible = false
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

local Button = AimAssistTab:CreateButton({
   Name = "SilentAim",
   Callback = function()

   end,
})

local Section = AimAssistTab:CreateSection("Visuals")

local Button = AimAssistTab:CreateButton({
   Name = "Tracers",
   Callback = function()
        local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Function to create a tracer
local function createTracer(player)
    local tracer = Drawing.new("Line")
    tracer.Color = Color3.new(1, 1, 1) -- White color
    tracer.Thickness = 1
    tracer.Transparency = 1
    tracer.Visible = false

    local function updateTracer()
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

-- Table to keep track of tracers
local tracers = {}

-- Function to refresh tracers
local function refreshTracers()
    -- Clear existing tracers
    for _, tracer in pairs(tracers) do
        tracer:Remove()
    end
    tracers = {}

    -- Create new tracers for enemies
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Team ~= localPlayer.Team then
            tracers[player] = createTracer(player)
        end
    end
end

-- Refresh tracers when a player respawns
local function onPlayerRespawn(player)
    if tracers[player] then
        tracers[player]:Remove()
        tracers[player] = createTracer(player)
    end
end

-- Set up initial tracers and connect events
Players.PlayerAdded:Connect(function(player)
    if player.Team ~= localPlayer.Team then
        tracers[player] = createTracer(player)
        player.CharacterAdded:Connect(function()
            onPlayerRespawn(player)
        end)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if tracers[player] then
        tracers[player]:Remove()
        tracers[player] = nil
    end
end)

-- Initial setup
refreshTracers()
Players.PlayerAdded:Connect(refreshTracers)
Players.PlayerRemoving:Connect(refreshTracers)
localPlayer.TeamChanged:Connect(refreshTracers)
   end,
})

local Button = AimAssistTab:CreateButton({
   Name = "ESP",
   Callback = function()
        -- ESP Box Script with Team Check and Health Bar
-- This script assumes you are using Roblox and have appropriate permissions to run it

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local camera = workspace.CurrentCamera
local runService = game:GetService("RunService")

-- Function to create a new ESP box with health bar
local function createESPBox(character)
    local box = Drawing.new("Square")
    box.Thickness = 2
    box.Color = Color3.new(1, 1, 1) -- White color
    box.Filled = false

    local healthBar = Drawing.new("Square")
    healthBar.Thickness = 1
    healthBar.Color = Color3.new(1, 0, 0) -- Red color for health bar
    healthBar.Filled = false
    healthBar.Visible = false

    local function update()
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local vector, onScreen = camera:WorldToViewportPoint(rootPart.Position)
            if onScreen then
                local head = character:FindFirstChild("Head")
                local size = (camera:WorldToViewportPoint(rootPart.Position + Vector3.new(2, 3, 0)) - camera:WorldToViewportPoint(rootPart.Position - Vector3.new(2, 3, 0))).magnitude
                box.Size = Vector2.new(size, size * 1)
                box.Position = Vector2.new(vector.X - size / 2, vector.Y - size * 1.5 / 3)
                box.Visible = true

                -- Update health bar position and size relative to the ESP box
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local maxHealth = humanoid.MaxHealth
                    local currentHealth = humanoid.Health

                    if maxHealth > 0 then
                        local healthRatio = currentHealth / maxHealth
                        local healthBarSize = Vector2.new(size, 2)
                        healthBar.Size = Vector2.new(healthBarSize.X * healthRatio, healthBarSize.Y)
                        healthBar.Position = Vector2.new(vector.X - size / 2, vector.Y + size * 0.75 / 2 + 5) -- Position below the ESP box
                        healthBar.Visible = false
                    else
                        healthBar.Visible = false
                    end
                else
                    healthBar.Visible = false
                end
            else
                box.Visible = false
                healthBar.Visible = false
            end
        else
            box.Visible = false
            healthBar.Visible = false
        end
    end

    runService.RenderStepped:Connect(update)

    character.AncestryChanged:Connect(function()
        if not character:IsDescendantOf(workspace) then
            box:Remove()
            healthBar:Remove()
        end
    end)
end

-- Function to add ESP boxes to all players on opposite teams
local function addESPToOppositeTeamPlayers()
    for _, player in pairs(players:GetPlayers()) do
        if player ~= localPlayer and player.Team ~= localPlayer.Team then
            player.CharacterAdded:Connect(createESPBox)
            if player.Character then
                createESPBox(player.Character)
            end
        end
    end
end

-- Add ESP boxes to players joining in the future if they are on the opposite team
players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if player.Team ~= localPlayer.Team then
            createESPBox(character)
        end
    end)
end)

-- Update ESP boxes when a player's team changes
localPlayer:GetPropertyChangedSignal("Team"):Connect(function()
    -- Remove all existing ESP boxes
    for _, drawing in pairs(Drawing.GetInstances()) do
        drawing:Remove()
    end

    -- Re-apply ESP boxes to opposite team players
    addESPToOppositeTeamPlayers()
end)

-- Initial setup
addESPToOppositeTeamPlayers()
   end,
})

local Button = AimAssistTab:CreateButton({
   Name = "HealthBar",
   Callback = function()
        
   end,
})

local Button = AimAssistTab:CreateButton({
   Name = "Distance",
   Callback = function()
        -- Replace with your Roblox username or player object if you want to measure distance from another player
local localPlayer = game.Players.LocalPlayer

-- Function to calculate distance between two points
local function distance(point1, point2)
    return (point1 - point2).magnitude
end

-- Update function to refresh the distance display periodically
local function updateDistances()
    -- Get all players in the game
    local players = game.Players:GetPlayers()

    -- Loop through each player
    for _, otherPlayer in ipairs(players) do
        -- Check if the other player is not the local player and is on the same team
        if otherPlayer ~= localPlayer and localPlayer.Team == otherPlayer.Team then
            -- Calculate distance
            local dist = distance(localPlayer.Character.HumanoidRootPart.Position, otherPlayer.Character.HumanoidRootPart.Position)
            
            -- Print distance (you can change this to display in UI or output)
            print(otherPlayer.Name .. " is " .. tostring(dist) .. " studs away.")
        end
    end
end

-- Update distances every 1 second (you can adjust this interval)
while true do
    updateDistances()
    wait(1)
end
   end,
})

local Button = AimAssistTab:CreateButton({
   Name = "Name",
   Callback = function()
        -- This script should be placed in a LocalScript in StarterPlayerScripts

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function createBillboard(player)
    -- Create a BillboardGui
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Adornee = player.Character:FindFirstChild("Head")
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.AlwaysOnTop = true

    -- Create a TextLabel to display the player's name
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.new(1, 1, 1) -- White color
    nameLabel.TextScaled = true

    nameLabel.Parent = billboardGui
    billboardGui.Parent = player.Character
end

local function onCharacterAdded(character)
    local player = Players:GetPlayerFromCharacter(character)
    if player and player ~= LocalPlayer then
        -- Team check
        if LocalPlayer.Team ~= player.Team then
            createBillboard(player)
        end
    end
end

local function onPlayerAdded(player)
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(onCharacterAdded)
        -- If the character already exists
        if player.Character then
            onCharacterAdded(player.Character)
        end
    end
end

-- Connect the PlayerAdded event
Players.PlayerAdded:Connect(onPlayerAdded)

-- Check existing players
for _, player in pairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end
   end,
})

local Button = AimAssistTab:CreateButton({
   Name = "Skeleton",
   Callback = function()
        
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

local AboutUsTab = Window:CreateTab("AboutUs", nil) -- Title, Image
local Section = AboutUsTab:CreateSection("INFO")

local Button = AboutUsTab:CreateButton({
   Name = "discord.gg/EbnPrecpQM",
   Callback = function()
   end,
})
