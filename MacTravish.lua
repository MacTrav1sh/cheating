local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Rayfield Example Window",
    LoadingTitle = "Rayfield Interface Suite",
    LoadingSubtitle = "by Sirius",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Big Hub"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "Untitled",
        Subtitle = "Key System",
        Note = "No method of obtaining the key is provided",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Hello"}
    }
})

local MainTab = Window:CreateTab("op", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")

-- Anti-AFK Toggle
local Toggle = MainTab:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = false,
    Flag = "Antikick",
    Callback = function(Value)
        if Value then
            _G.antiAFKActive = true
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                vu:CaptureController()
                vu:ClickButton2(Vector2.new())
            end)

            while _G.antiAFKActive do
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
                
                wait(600) -- Set the time duration here (in seconds)
            end
        else
            _G.antiAFKActive = false
        end
    end,
})

-- Reduce Lag Toggle
local Toggle = MainTab:CreateToggle({
    Name = "Reduce Lag",
    CurrentValue = false,
    Flag = "ReduceLag",
    Callback = function(Value)
        if Value then
            -- Disable performance-heavy elements
            local lighting = game:GetService("Lighting")
            lighting.GlobalShadows = false
            lighting.FogEnd = 9e9
            lighting.Brightness = 0
            lighting.ClockTime = 14 -- Set to midday to reduce shadow complexity

            -- Disable particles, beams, trails, explosions, etc.
            for _, object in pairs(workspace:GetDescendants()) do
                if object:IsA("ParticleEmitter") or object:IsA("Trail") or object:IsA("Beam") or object:IsA("Smoke") or object:IsA("Fire") then
                    object.Enabled = false
                elseif object:IsA("Explosion") then
                    object:Destroy()
                end
            end

            -- Disable particles, beams, trails, explosions, etc. in ReplicatedStorage
            for _, object in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if object:IsA("ParticleEmitter") or object:IsA("Trail") or object:IsA("Beam") or object:IsA("Smoke") or object:IsA("Fire") then
                    object.Enabled = false
                elseif object:IsA("Explosion") then
                    object:Destroy()
                end
            end

            -- Disable textures
            for _, object in pairs(workspace:GetDescendants()) do
                if object:IsA("Texture") or object:IsA("Decal") then
                    object.Transparency = 1
                end
            end

            -- Optimize terrain settings
            local terrain = workspace:FindFirstChildOfClass("Terrain")
            if terrain then
                terrain.WaterWaveSize = 0
                terrain.WaterWaveSpeed = 0
                terrain.WaterReflectance = 0
                terrain.WaterTransparency = 1
            end

        else
            -- Re-enable performance-heavy elements
            local lighting = game:GetService("Lighting")
            lighting.GlobalShadows = true
            lighting.FogEnd = 100000
            lighting.Brightness = 2
            lighting.ClockTime = 14 -- Restore original settings if necessary

            -- Re-enable particles, beams, trails, explosions, etc.
            for _, object in pairs(workspace:GetDescendants()) do
                if object:IsA("ParticleEmitter") or object:IsA("Trail") or object:IsA("Beam") or object:IsA("Smoke") or object:IsA("Fire") then
                    object.Enabled = true
                end
            end

            -- Re-enable particles, beams, trails, explosions, etc. in ReplicatedStorage
            for _, object in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if object:IsA("ParticleEmitter") or object:IsA("Trail") or object:IsA("Beam") or object:IsA("Smoke") or object:IsA("Fire") then
                    object.Enabled = true
                end
            end

            -- Re-enable textures
            for _, object in pairs(workspace:GetDescendants()) do
                if object:IsA("Texture") or object:IsA("Decal") then
                    object.Transparency = 0
                end
            end

            -- Restore terrain settings if necessary
            local terrain = workspace:FindFirstChildOfClass("Terrain")
            if terrain then
                terrain.WaterWaveSize = 1
                terrain.WaterWaveSpeed = 1
                terrain.WaterReflectance = 0.5
                terrain.WaterTransparency = 0
            end
        end
    end,
})
