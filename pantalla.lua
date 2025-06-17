local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Crear ScreenGui principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "PantallaCarga"
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = game:GetService("CoreGui")

-- Fondo negro
local fondo = Instance.new("Frame")
fondo.BackgroundColor3 = Color3.new(0, 0, 0)
fondo.Size = UDim2.new(1, 0, 1, 0)
fondo.Parent = ScreenGui

-- Texto moviéndose arriba: "SCRIPT OP IN PROGRESS..."
local mensaje = Instance.new("TextLabel")
mensaje.Text = "SCRIPT OP IN PROGRESS..."
mensaje.Font = Enum.Font.GothamBold
mensaje.TextColor3 = Color3.new(1, 1, 1)
mensaje.TextScaled = true
mensaje.BackgroundTransparency = 1
mensaje.Size = UDim2.new(1, 0, 0.1, 0)
mensaje.Position = UDim2.new(0, 0, 0.05, 0)
mensaje.Parent = fondo

-- Animar el texto moviéndose de lado a lado
local dirección = 1 -- 1 = derecha, -1 = izquierda
local velocidad = 200 -- pixeles por segundo
local maxX = 0.7
local minX = 0
local function animarTexto(dt)
	local pos = mensaje.Position.X.Scale + dirección * velocidad * dt / fondo.AbsoluteSize.X
	if pos > maxX then
		pos = maxX
		dirección = -1
	elseif pos < minX then
		pos = minX
		dirección = 1
	end
	mensaje.Position = UDim2.new(pos, 0, mensaje.Position.Y.Scale, 0)
end

-- Barra de carga azul, más gruesa y centrada
local barraMarco = Instance.new("Frame")
barraMarco.Size = UDim2.new(0.6, 0, 0.05, 0) -- un poco más gruesa
barraMarco.Position = UDim2.new(0.2, 0, 0.45, 0) -- cerca del medio verticalmente
barraMarco.BackgroundColor3 = Color3.new(1, 1, 1)
barraMarco.BorderSizePixel = 0
barraMarco.Parent = fondo

local barra = Instance.new("Frame")
barra.Size = UDim2.new(0, 0, 1, 0)
barra.BackgroundColor3 = Color3.fromRGB(0, 120, 255) -- azul
barra.BorderSizePixel = 0
barra.Parent = barraMarco

-- Texto porcentaje dentro de la barra, con contraste blanco
local porcentajeTexto = Instance.new("TextLabel")
porcentajeTexto.Size = UDim2.new(1, 0, 1, 0)
porcentajeTexto.BackgroundTransparency = 1
porcentajeTexto.TextColor3 = Color3.new(1, 1, 1)
porcentajeTexto.Font = Enum.Font.GothamBold
porcentajeTexto.TextScaled = true
porcentajeTexto.Text = "0%"
porcentajeTexto.Parent = barra

-- Lógica de carga simulada (5 minutos total con distintas velocidades)
local duracionTotal = 300
local start = tick()

-- Función para calcular el progreso según los segmentos con velocidades varia
