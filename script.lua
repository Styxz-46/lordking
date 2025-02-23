local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local stats = game:GetService("Stats")

-- Buat GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 250)
frame.Position = UDim2.new(0.05, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- Merah
frame.BorderSizePixel = 2
frame.Parent = screenGui

-- Buat label "Takashi Tools"
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Takashi Tools"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = frame

-- Debug Section (Hitam)
local debugContainer = Instance.new("Frame")
debugContainer.Size = UDim2.new(1, 0, 0, 80)
debugContainer.Position = UDim2.new(0, 0, 0, 40)
debugContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
debugContainer.Parent = frame

local debugTitle = Instance.new("TextLabel")
debugTitle.Size = UDim2.new(1, 0, 0, 20)
debugTitle.BackgroundTransparency = 1
debugTitle.Text = "Debug"
debugTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
debugTitle.Font = Enum.Font.SourceSansBold
debugTitle.TextSize = 16
debugTitle.Parent = debugContainer

local debugInfo = Instance.new("TextLabel")
debugInfo.Size = UDim2.new(1, 0, 0, 60)
debugInfo.Position = UDim2.new(0, 0, 0, 20)
debugInfo.BackgroundTransparency = 1
debugInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
debugInfo.Font = Enum.Font.SourceSans
debugInfo.TextSize = 14
debugInfo.Parent = debugContainer

-- Position Section (Hitam)
local positionContainer = Instance.new("Frame")
positionContainer.Size = UDim2.new(1, 0, 0, 40)
positionContainer.Position = UDim2.new(0, 0, 0, 130)
positionContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
positionContainer.Parent = frame

local positionTitle = Instance.new("TextLabel")
positionTitle.Size = UDim2.new(1, 0, 0, 20)
positionTitle.BackgroundTransparency = 1
positionTitle.Text = "Position"
positionTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
positionTitle.Font = Enum.Font.SourceSansBold
positionTitle.TextSize = 16
positionTitle.Parent = positionContainer

local posLabel = Instance.new("TextButton")
posLabel.Size = UDim2.new(1, 0, 0, 20)
posLabel.Position = UDim2.new(0, 0, 0, 20)
posLabel.BackgroundTransparency = 1
posLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
posLabel.Font = Enum.Font.SourceSans
posLabel.TextSize = 14
posLabel.Parent = positionContainer

local copiedLabel = Instance.new("TextLabel")
copiedLabel.Size = UDim2.new(0, 200, 0, 30)
copiedLabel.Position = UDim2.new(0.5, -100, 0.8, 0)
copiedLabel.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
copiedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
copiedLabel.Font = Enum.Font.SourceSansBold
copiedLabel.TextSize = 16
copiedLabel.Text = "Copied!"
copiedLabel.Visible = false
copiedLabel.Parent = screenGui

local startTime = tick()
runService.RenderStepped:Connect(function()
    if character and rootPart then
        local pos = rootPart.Position
        posLabel.Text = string.format("📍 %d, %d, %d", pos.X, pos.Y, pos.Z)
    end
    
    local elapsedTime = tick() - startTime
    local hours = math.floor(elapsedTime / 3600)
    local minutes = math.floor((elapsedTime % 3600) / 60)
    local seconds = math.floor(elapsedTime % 60)
    local fps = math.floor(1 / runService.RenderStepped:Wait())
    local ping = stats.Network.ServerStatsItem["Data Ping"]:GetValue()
    
    debugInfo.Text = string.format("⌛ Time: %dH %dM %dS\n🟢 FPS: %d\n📶 Ping: %d ms\n😎 UID: %d", hours, minutes, seconds, fps, ping, player.UserId)
end)

posLabel.MouseButton1Click:Connect(function()
    if setclipboard then
        local coords = posLabel.Text:gsub("📍 ", "")
        setclipboard(coords)
    else
        warn("Clipboard tidak didukung di perangkat ini!")
    end
    copiedLabel.Visible = true
    wait(1)
    copiedLabel.Visible = false
end)
