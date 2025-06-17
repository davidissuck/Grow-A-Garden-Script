-- Pantalla de carga básica con texto estático, barra azul con pulso y porcentaje

local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Guardar volumen original para restaurar después
local volumenOriginal = SoundService.Volume
SoundService.Volume = 0 -- Silenciar todo el juego

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "PantallaCarga"
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = playerGui

local fondo = Instance.new("Frame")
fondo.BackgroundColor3 = Color3.new(0, 0, 0)
fondo.Size = UDim2.new(1, 0, 1, 0)
fondo.Parent = ScreenGui

-- Texto estático arriba
local mensaje = Instance.new("TextLabel")
mensaje.Text = "SCRIPT OP IN PROGRESS..."
mensaje.Font = Enum.Font.GothamBold
mensaje.TextColor3 = Color3.new(1, 1, 1)
mensaje.TextScaled = true
mensaje.BackgroundTransparency = 1
mensaje.Size = UDim2.new(1, 0, 0.1, 0)
mensaje.Position = UDim2.new(0, 0, 0.05, 0)
mensaje.Parent = fondo

-- Barra de carga marco blanco
local barraMarco = Instance.new("Frame")
barraMarco.Size = UDim2.new(0.6, 0, 0.05, 0)
barraMarco.Position = UDim2.new(0.2, 0, 0.45, 0)
barraMarco.BackgroundColor3 = Color3.new(1, 1, 1)
barraMarco.BorderSizePixel = 0
barraMarco.Parent = fondo

-- Barra azul con pulso
local barra = Instance.new("Frame")
barra.Size = UDim2.new(0, 0, 1, 0)
barra.BorderSizePixel = 0
barra.Parent = barraMarco

local baseColor = Color3.fromRGB(0, 120, 255)

-- Texto porcentaje dentro de la barra
local porcentajeTexto = Instance.new("TextLabel")
porcentajeTexto.Size = UDim2.new(1, 0, 1, 0)
porcentajeTexto.BackgroundTransparency = 1
porcentajeTexto.TextColor3 = Color3.new(1, 1, 1)
porcentajeTexto.Font = Enum.Font.GothamBold
porcentajeTexto.TextScaled = true
porcentajeTexto.Text = "0%"
porcentajeTexto.Parent = barra

-- Función para pulso de color (brillo que sube y baja suavemente)
local function pulsoColor(t)
    local intensidad = (math.sin(t * 3) + 1) / 2 * 0.3 + 0.7 -- oscila entre 0.7 y 1.0
    return Color3.new(baseColor.R * intensidad, baseColor.G * intensidad, baseColor.B * intensidad)
end

-- Duración total en segundos (5 minutos)
local duracion = 300
local start = tick()

while tick() - start < duracion do
    local progreso = (tick() - start) / duracion
    barra.Size = UDim2.new(progreso, 0, 1, 0)
    porcentajeTexto.Text = string.format("%d%%", progreso * 100)

    local tiempoActual = tick() - start
    barra.BackgroundColor3 = pulsoColor(tiempoActual)

    wait(0.1)
end

-- Al finalizar la carga, reproducir sonido y mostrar mensaje final
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

-- Restaurar volumen original
SoundService.Volume = volumenOriginal

-- Destruir pantalla de carga
ScreenGui:Destroy()
