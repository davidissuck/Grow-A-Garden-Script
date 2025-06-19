local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

-- Esperar a que el jugador esté disponible
local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
repeat wait() until player and player:FindFirstChild("PlayerGui")

-- Silenciar el juego
SoundService.Volume = 0

-- GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LoadingTerminal"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local fondo = Instance.new("Frame")
fondo.BackgroundColor3 = Color3.new(0, 0, 0)
fondo.BackgroundTransparency = 1
fondo.Size = UDim2.new(1, 0, 1, 0)
fondo.Parent = ScreenGui

TweenService:Create(fondo, TweenInfo.new(2), {BackgroundTransparency = 0}):Play()

-- Texto superior hacker
local mensaje = Instance.new("TextLabel")
mensaje.Text = "ACCESSING MAINFRAME..."
mensaje.Font = Enum.Font.Code
mensaje.TextColor3 = Color3.fromRGB(0, 255, 0)
mensaje.TextScaled = true
mensaje.BackgroundTransparency = 1
mensaje.Size = UDim2.new(0.6, 0, 0.1, 0)
mensaje.Position = UDim2.new(0, 0, 0.05, 0)
mensaje.Parent = fondo

TweenService:Create(mensaje, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
	Position = UDim2.new(0.4, 0, 0.05, 0)
}):Play()

-- Marco y barra de progreso
local barraMarco = Instance.new("Frame")
barraMarco.Size = UDim2.new(0.6, 0, 0.04, 0)
barraMarco.Position = UDim2.new(0.2, 0, 0.48, 0)
barraMarco.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
barraMarco.BorderSizePixel = 0
barraMarco.Parent = fondo

local barra = Instance.new("Frame")
barra.Size = UDim2.new(0, 0, 1, 0)
barra.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
barra.BorderSizePixel = 0
barra.Parent = barraMarco

local porcentajeTexto = Instance.new("TextLabel")
porcentajeTexto.Size = UDim2.new(1, 0, 1, 0)
porcentajeTexto.BackgroundTransparency = 1
porcentajeTexto.TextColor3 = Color3.fromRGB(0, 255, 0)
porcentajeTexto.Font = Enum.Font.Code
porcentajeTexto.TextScaled = true
porcentajeTexto.Text = "0%"
porcentajeTexto.Parent = barra

-- Simulación de carga
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
		progreso = 0.4 + ((elapsed - 60) / 60) * 0.25
	elseif elapsed <= 180 then
		progreso = 0.65 + ((elapsed - 120) / 60) * 0.15
	else
		progreso = 0.8 + ((elapsed - 180) / 120) * 0.2
	end

	barra.Size = UDim2.new(progreso, 0, 1, 0)
	porcentajeTexto.Text = math.floor(progreso * 100) .. "%"
	wait(0.1)
end

-- Sonido final tipo glitch
local sonido = Instance.new("Sound")
sonido.SoundId = "rbxassetid://1837635154"
sonido.Volume = 1
sonido.Parent = fondo
sonido:Play()

-- Mensaje final estilo consola
local mensajeFinal = Instance.new("TextLabel")
mensajeFinal.Text = "INTRUSION COMPLETE_ 🔓"
mensajeFinal.Font = Enum.Font.Code
mensajeFinal.TextColor3 = Color3.fromRGB(0, 255, 0)
mensajeFinal.TextTransparency = 1
mensajeFinal.TextScaled = true
mensajeFinal.BackgroundTransparency = 1
mensajeFinal.Size = UDim2.new(0.5, 0, 0.1, 0)
mensajeFinal.Position = UDim2.new(0.25, 0, 0.75, 0)
mensajeFinal.Parent = fondo

TweenService:Create(mensajeFinal, TweenInfo.new(2), {
	TextTransparency = 0,
	Size = UDim2.new(1, 0, 0.2, 0),
	Position = UDim2.new(0, 0, 0.75, 0)
}):Play()

wait(5)

-- Desvanecimiento final y restaurar audio
TweenService:Create(fondo, TweenInfo.new(2), {BackgroundTransparency = 1}):Play()
wait(2)

SoundService.Volume = 1
ScreenGui:Destroy()
