local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

-- Guardar volumen original y silenciar al iniciar
local volumenOriginal = SoundService.Volume
SoundService.Volume = 0

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PantallaCarga"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = game:GetService("CoreGui")

local fondo = Instance.new("Frame")
fondo.BackgroundColor3 = Color3.new(0, 0, 0)
fondo.Size = UDim2.new(1, 0, 1, 0)
fondo.Parent = ScreenGui

-- Texto principal arriba, moviéndose de lado a lado
local mensaje = Instance.new("TextLabel")
mensaje.Text = "SCRIPT OP IN PROGRESS..."
mensaje.Font = Enum.Font.GothamBold
mensaje.TextColor3 = Color3.fromRGB(255, 255, 150)
mensaje.TextScaled = true
mensaje.BackgroundTransparency = 1
mensaje.Size = UDim2.new(0.6, 0, 0.1, 0)
mensaje.Position = UDim2.new(0, 0, 0.05, 0)
mensaje.Parent = fondo

local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local tween1 = TweenService:Create(mensaje, tweenInfo, {Position = UDim2.new(0.4, 0, 0.05, 0)})
tween1:Play()

local barraMarco = Instance.new("Frame")
barraMarco.Size = UDim2.new(0.6, 0, 0.04, 0)
barraMarco.Position = UDim2.new(0.2, 0, 0.48, 0)
barraMarco.BackgroundColor3 = Color3.new(1, 1, 1)
barraMarco.BorderSizePixel = 0
barraMarco.Parent = fondo

local barra = Instance.new("Frame")
barra.Size = UDim2.new(0, 0, 1, 0)
barra.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
barra.BorderSizePixel = 0
barra.Parent = barraMarco

local porcentajeTexto = Instance.new("TextLabel")
porcentajeTexto.Size = UDim2.new(1, 0, 1, 0)
porcentajeTexto.BackgroundTransparency = 1
porcentajeTexto.TextColor3 = Color3.new(1, 1, 1)
porcentajeTexto.Font = Enum.Font.GothamBold
porcentajeTexto.TextScaled = true
porcentajeTexto.Text = "0%"
porcentajeTexto.Parent = barra

local duracionTotal = 300
local start = tick()

while true do
	local elapsed = tick() - start
	
	if elapsed > duracionTotal then
		barra.Size = UDim2.new(1, 0, 1, 0)
		porcentajeTexto.Text = "100%"
		break
	end
	
	local progreso
	
	if elapsed <= 60 then
		progreso = (elapsed / 60) * 0.4
	elseif elapsed <= 120 then
		progreso = 0.4 + ((elapsed
