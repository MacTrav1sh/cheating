local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Pet Simulator 99",
   LoadingTitle = "Tired AF",
   LoadingSubtitle = "by MacTravish",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "petsimhub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("op", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")

-- Anti-AFK script for Roblox
local VirtualUser = game:service('VirtualUser')
local isRunning = false  -- Variable to track if the anti-AFK is currently running

-- Connect the virtual user input to simulate user activity
game:service('Players').LocalPlayer.Idled:connect(function()
    if isRunning then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- Function to prevent the client script from kicking the player
local function preventKick()
    -- Replace '60' with the appropriate interval (in seconds) if needed
    while isRunning do
        wait(60) -- Wait for 60 seconds
        -- Simulate a small jump to show activity
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChildOfClass("Humanoid") then
            character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end

local Toggle = MainTab:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = false,
    Flag = "Toggle1", -- Unique identifier for configuration
    Callback = function(Value)
        if Value then
            isRunning = true  -- Start the anti-AFK function
            spawn(preventKick)
        else
            isRunning = false  -- Stop the anti-AFK function
        end
    end,
})

local function optimizeFPS()
    -- Set graphics settings to the lowest
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

    -- Disable unnecessary effects
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    lighting.FogEnd = 9e9
    lighting.Brightness = 0

    -- Remove decorations
    for _, desc in pairs(workspace:GetDescendants()) do
        if desc:IsA("ParticleEmitter") or desc:IsA("Trail") then
            desc.Lifetime = NumberRange.new(0)
        elseif desc:IsA("Explosion") then
            desc.Visible = false
        elseif desc:IsA("BasePart") then
            desc.Material = Enum.Material.Plastic
            desc.Reflectance = 0
        end
    end

    -- Optimize workspace
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.CastShadow = false
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        end
    end
end

local Button = MainTab:CreateButton({
    Name = "FPS Booster",
    Callback = function()
        optimizeFPS()
    end,
})

-- Function to disable hatching animation and results
local function disableHatching()
    -- Example: Find the script responsible for egg hatching
    local EggOpeningFrontend = game.Players.LocalPlayer.PlayerScripts.Scripts.Game['Egg Opening Frontend']
    
    -- Example: Disable the function that plays the egg animation
    getsenv(EggOpeningFrontend).PlayEggAnimation = function() return end
    
    -- Example: Disable the function that gives the result of hatching
    getsenv(EggOpeningFrontend).GiveEggResult = function() return end
    
    -- Example: Prevent spawning of pets or items resulting from hatching
    EggOpeningFrontend:WaitForChild("EggModel").ChildAdded:Connect(function(child)
        child:Destroy()
    end)
end

-- Function to apply extreme FPS booster and disable hatching
local function extremeOptimizeFPSAndDisableHatching()
    -- Set graphics settings to the lowest
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

    -- Disable unnecessary effects
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    lighting.FogEnd = 9e9
    lighting.Brightness = 0
    lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    lighting.ClockTime = 12
    lighting.GeographicLatitude = 0
    lighting.ExposureCompensation = -4

    -- Remove decorations and set simpler properties
    for _, desc in pairs(workspace:GetDescendants()) do
        if desc:IsA("ParticleEmitter") or desc:IsA("Trail") or desc:IsA("Smoke") or desc:IsA("Fire") or desc:IsA("Sparkles") then
            desc.Lifetime = NumberRange.new(0)
        elseif desc:IsA("Explosion") then
            desc.Visible = false
        elseif desc:IsA("BasePart") then
            desc.Material = Enum.Material.Plastic
            desc.Reflectance = 0
            desc.CastShadow = false
        elseif desc:IsA("Decal") or desc:IsA("Texture") then
            desc:Destroy()
        elseif desc:IsA("SurfaceAppearance") then
            desc:Destroy()
        end
    end

    -- Optimize workspace
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.CastShadow = false
            obj.Material = Enum.Material.SmoothPlastic
        elseif obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SurfaceAppearance") then
            obj:Destroy()
        elseif obj:IsA("MeshPart") then
            obj.TextureID = ""
        elseif obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") then
            for _, v in pairs(obj:GetChildren()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                    v.CastShadow = false
                end
            end
        end
    end

    -- Disable accessories and hats
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        for _, accessory in pairs(player.Character:GetChildren()) do
            if accessory:IsA("Accessory") then
                accessory:Destroy()
            end
        end
    end

    -- Disable egg hatching animation and results
    disableHatching()
end

local Button = MainTab:CreateButton({
    Name = "Extreme FPS Booster & Disable Hatching",
    Callback = function()
        extremeOptimizeFPSAndDisableHatching()
    end,
})
