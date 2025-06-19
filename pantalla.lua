local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Disable core GUI and mute game
StarterGui:SetCore("TopbarEnabled", false)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
SoundService.Volume = 0

-- Main UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadingUI"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Fullscreen animated glitch background
local background = Instance.new("ImageLabel")
background.AnchorPoint = Vector2.new(0.5, 0.5)
background.Position = UDim2.new(0.5, 0, 0.5, 0)
background.Size = UDim2.new(1.5, 0, 1.5, 0)
background.BackgroundTransparency = 1
background.Image = "rbxassetid://13081265373"
background.ImageTransparency = 0.1
background.ScaleType = Enum.ScaleType.Crop
background.ZIndex = 0
background.Parent = screenGui

-- Animated moving text
local movingText = Instance.new("TextLabel")
movingText.Text = "INITIALIZING SYSTEM..."
movingText.Font = Enum.Font.Code
movingText.TextColor3 = Color3.fromRGB(0, 255, 0)
movingText.TextScaled = true
movingText.BackgroundTransparency = 1
movingText.Size = UDim2.new(0.4, 0, 0.08, 0)
movingText.Position = UDim2.new(-0.4, 0, 0.15, 0)
movingText.ZIndex = 2
movingText.Parent = screenGui

TweenService:Create(
	movingText,
	TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
	{Position = UDim2.new(1, 0, 0.15, 0)}
):Play()

-- Progress bar
local barFrame = Instance.new("Frame")
barFrame.Size = UDim2.new(0.6, 0, 0.04, 0)
barFrame.Position = UDim2.new(0.2, 0, 0.5, 0)
barFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
barFrame.BorderSizePixel = 0
barFrame.ZIndex = 1
barFrame.Parent = screenGui

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
bar.BorderSizePixel = 0
bar.ClipsDescendants = true
bar.ZIndex = 2
bar.Parent = barFrame

-- Floating percentage text
local percentText = Instance.new("TextLabel")
percentText.Size = UDim2.new(0.3, 0, 1, 0)
percentText.BackgroundTransparency = 1
percentText.TextColor3 = Color3.fromRGB(0, 0, 0)
percentText.Font = Enum.Font.Code
percentText.TextScaled = true
percentText.Text = "0%"
percentText.Position = UDim2.new(0, 0, 0, 0)
percentText.ZIndex = 3
percentText.Parent = bar

-- Simulated loading (5 minutes)
local duration = 300
local start = tick()

while true do
	local elapsed = tick() - start
	if elapsed >= duration then
		bar.Size = UDim2.new(1, 0, 1, 0)
		percentText.Text = "100%"
		percentText.Position = UDim2.new(0.7, 0, 0, 0)
		break
	end

	local progress = elapsed / duration
	bar.Size = UDim2.new(progress, 0, 1, 0)
	percentText.Position = UDim2.new(math.clamp(progress - 0.15, 0, 0.7), 0, 0, 0)
	percentText.Text = tostring(math.floor(progress * 100)) .. "%"
	wait(0.1)
end

-- Final glitch message
local finalText = Instance.new("TextLabel")
finalText.Size = UDim2.new(1, 0, 0.2, 0)
finalText.Position = UDim2.new(0, 0, 0.75, 0)
finalText.BackgroundTransparency = 1
finalText.TextColor3 = Color3.fromRGB(255, 0, 0)
finalText.Font = Enum.Font.Code
finalText.TextScaled = true
finalText.Text = "ACCESS GRANTED_"
finalText.TextTransparency = 1
finalText.ZIndex = 3
finalText.Parent = screenGui

for i = 1, 3 do
	finalText.TextTransparency = 0
	wait(0.1)
	finalText.TextTransparency = 0.5
	wait(0.05)
end
finalText.TextTransparency = 0

wait(3)
screenGui:Destroy()

-- Restore volume and UI
StarterGui:SetCore("TopbarEnabled", true)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
SoundService.Volume = 1
