-- Pantalla de carga personalizada en Roblox
-- Este script crea una pantalla negra con animaciones, mensajes y barra de progreso con porcentaje
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
mensaje.Size = UDim2.new(1, 0, 0.15, 0) -- menos alto para dar espacio abajo
mensaje.Position = UDim2.new(0, 0, 0.4, 0)  -- un poco más arriba
mensaje.Parent = fondo

-- Animación pulse y parpadeo del texto
local tweenInfo = TweenInfo.new(
	1.5,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.InOut,
	true,
	-1,
	0
)

local goals = {
	TextTransparency = 0.3,
	Size = UDim2.new(1.1, 0, 0.165, 0), -- un poco más grande en pulso
}

local tween = TweenService:Create(mensaje, tweenInfo, goals)
tween:Play()

-- Marco de la barra
local barraMarco = Instance.new("Frame")
barraMarco.Size = UDim2.new(0.6, 0, 0.04, 0)
barraMarco.Position = UDim2.new(0.2, 0, 0.575, 0)  -- un poco más abajo que antes, justo debajo del mensaje
barraMarco.BackgroundColor3 = Color3.new(1, 1, 1)
barraMarco.BorderSizePixel = 0
barraMarco.Parent = fondo

-- Barra de progreso azul
local barra = Instance.new("Frame")
barra.Size = UDim2.new(0, 0, 1, 0)
barra.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
barra.BorderSizePixel = 0
barra.Parent = barraMarco

-- Texto porcentaje dentro de la barra
local porcentajeTexto = Instance.new("TextLabel")
porcentajeTexto.Size = UDim2.new(1, 0, 1, 0)
porcentajeTexto.BackgroundTransparency = 1
porcentajeTexto.TextColor3 = Color3.new(1, 1, 1)
porcentajeTexto.Font = Enum.Font.GothamBold
porcentajeTexto.TextScaled = true
porcentajeTexto.Text = "0%"
porcentajeTexto.Parent = barraMarco

-- Simulación de carga con velocidad variable (5 minutos)
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
	
	local porcentaje = math.floor(progreso * 100)
	porcentajeTexto.Text = porcentaje .. "%"
	
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
