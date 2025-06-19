local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadingUI"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Fondo visual llamativo
local background = Instance.new("ImageLabel")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundTransparency = 1
background.Image = "rbxassetid://13081265373" -- glitch cyberpunk image
background.ImageTransparency = 0.1
background.ZIndex = 0
background.Parent = screenGui

-- Texto LOADING... animado
local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1, 0, 0.1, 0)
loadingText.Position = UDim2.new(0, 0, 0.1, 0)
loadingText.BackgroundTransparency = 1
loadingText.TextColor3 = Color3.fromRGB(0, 255, 0)
loadingText.Font = Enum.Font.Code
loadingText.TextScaled = true
loadingText.Text = ""
loadingText.ZIndex = 2
loadingText.Parent = background

local loadingBase = "LOADING"
for i = 0, 3 do
	wait(0.3)
	loadingText.Text = loadingBase .. string.rep(".", i)
end

-- Barra de carga
local barFrame = Instance.new("Frame")
barFrame.Size = UDim2.new(0.6, 0, 0.04, 0)
barFrame.Position = UDim2.new(0.2, 0, 0.5, 0)
barFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
barFrame.BorderSizePixel = 0
barFrame.ZIndex = 1
barFrame.Parent = background

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
bar.BorderSizePixel = 0
bar.ClipsDescendants = true
bar.ZIndex = 2
bar.Parent = barFrame

-- Texto porcentual que avanza dentro de la barra
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

-- Simulación de carga (5 minutos)
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

-- Mensaje final con efecto glitch
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
finalText.Parent = background

for i = 1, 3 do
	finalText.TextTransparency = 0
	wait(0.1)
	finalText.TextTransparency = 0.5
	wait(0.05)
end
finalText.TextTransparency = 0

wait(3)
screenGui:Destroy()
