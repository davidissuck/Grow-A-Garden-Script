-- Pantalla de carga personalizada en Roblox
-- Este script crea una pantalla negra con animaciones, mensajes y barra de progreso visual
-- Se activa automáticamente cuando se ejecuta el script

local TweenService = game:GetService("TweenService")

-- Crear pantalla negra
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "PantallaCarga"
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = game:GetService("CoreGui")

local fondo = Instance.new("Frame")
fondo.BackgroundColor3 = Color3.new(0, 0, 0)
fondo.Size = UDim2.new(1, 0, 1, 0)
fondo.Parent = ScreenGui

-- Mensaje principal: "SCRIPT OP IN PROGRESS..."
local mensaje = Instance.new("TextLabel")
mensaje.Text = "SCRIPT OP IN PROGRESS..."
mensaje.Font = Enum.Font.GothamBold
mensaje.TextColor3 = Color3.fromRGB(255, 255, 150)  -- Amarillo claro para contraste
mensaje.TextScaled = true
mensaje.BackgroundTransparency = 1
mensaje.Size = UDim2.new(1, 0, 0.2, 0)
mensaje.Position = UDim2.new(0, 0, 0.42, 0)          -- Justo encima de la barra
mensaje.Parent = fondo

-- Animación pulse y parpadeo del texto
local tweenInfo = TweenInfo.new(
	1.5,              -- duración de cada ciclo
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.InOut,
	true,             -- reversa (y vuelve a la posición original)
	-1,               -- repetir infinitamente
	0
)

local goals = {
	TextTransparency = 0.3,
	Size = UDim2.new(1.1, 0, 0.22, 0),
}

local tween = TweenService:Create(mensaje, tweenInfo, goals)
tween:Play()

-- Crear barra de carga (azul, centrada y más gruesa)
local barraMarco = Instance.new("Frame")
barraMarco.Size = UDim2.new(0.6, 0, 0.04, 0)
barraMarco.Position = UDim2.new(0.2, 0, 0.475, 0)
barraMarco.BackgroundColor3 = Color3.new(1, 1, 1)
barraMarco.BorderSizePixel = 0
barraMarco.Parent = fondo

local barra = Instance.new("Frame")
barra.Size = UDim2.new(0, 0, 1, 0)
barra.BackgroundColor3 = Color3.fromRGB(0, 120, 255) -- azul
barra.BorderSizePixel = 0
barra.Parent = barraMarco

-- Simulación de carga con velocidad variable (5 minutos)
local duracionTotal = 300
local start = tick()

while true do
	local elapsed = tick() - start
	
	if elapsed > duracionTotal then
		barra.Size = UDim2.new(1, 0, 1, 0)
		break
	end
	
	local progreso
	
	if elapsed <= 60 then
		-- Minuto 1: 0 a 0.4
		progreso = (elapsed / 60) * 0.4
	elseif elapsed <= 120 then
		-- Minuto 2: 0.4 a 0.65
		progreso = 0.4 + ((elapsed - 60) / 60) * 0.25
	elseif elapsed <= 180 then
		-- Minuto 3: 0.65 a 0.8
		progreso = 0.65 + ((elapsed - 120) / 60) * 0.15
	else
		-- Minutos 4 y 5: 0.8 a 1.0
		progreso = 0.8 + ((elapsed - 180) / 120) * 0.2
	end
	
	barra.Size = UDim2.new(progreso, 0, 1, 0)
	wait(0.1)
end

-- Al 100%: sonido gracioso y mensaje "CLOWN 🤡"
local sonido = Instance.new("Sound")
sonido.SoundId = "rbxassetid://9118823104"
sonido.Volume = 1
sonido.Parent = fondo
sonido:Play()

local mensajeFinal = Instance.new("TextLabel")
mensajeFinal.Text = "CLOWN 🤡"
mensajeFinal.Font = Enum.Font.GothamBlack
mensajeFinal.TextColor3 = Color3.new(1, 0, 0)
mensajeFinal.TextScaled = true
mensajeFinal.BackgroundTransparency = 1
mensajeFinal.Size = UDim2.new(1, 0, 0.2, 0)
mensajeFinal.Position = UDim2.new(0, 0, 0.75, 0)
mensajeFinal.Parent = fondo

wait(5)

-- Eliminar la pantalla
ScreenGui:Destroy()
