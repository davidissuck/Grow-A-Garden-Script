local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

-- Silenciar todo el sonido del juego
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

local mensaje = Instance.new("TextLabel")
mensaje.Text = "ACCESSING MAINFRAME..."
mensaje.Font = Enum.Font.Code -- Fuente estilo hacker
mensaje.TextColor3 = Color3.fromRGB(255, 255, 150)
mensaje.TextScaled = true
mensaje.BackgroundTransparency = 1
mensaje.Size = UDim2.new(0.6, 0, 0.1, 0)
mensaje.Position = UDim2.new(0, 0, 0.05, 0)
mensaje.Parent = fondo

local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
TweenService:Create(mensaje, tweenInfo, {Position = UDim2.new(0.4, 0, 0.05, 0)}):Play()

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
porcentajeTexto.Font = Enum.Font.Code -- Fuente hacker aquí también
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

local sonido = Instance.new("Sound")
sonido.SoundId = "rbxassetid://9118823104"
sonido.Volume = 1
sonido.Parent = fondo
sonido:Play()

local mensajeFinal = Instance.new("TextLabel")
mensajeFinal.Text = "INTRUSION COMPLETE_ 🔓"
mensajeFinal.Font = Enum.Font.Code -- También con fuente hacker
mensajeFinal.TextColor3 = Color3.new(1, 0, 0)
mensajeFinal.TextScaled = true
mensajeFinal.BackgroundTransparency = 1
mensajeFinal.Size = UDim2.new(1, 0, 0.2, 0)
mensajeFinal.Position = UDim2.new(0, 0, 0.75, 0)
mensajeFinal.Parent = fondo

wait(5)

-- Restaurar sonido y cerrar
SoundService.Volume = 1
ScreenGui:Destroy()
