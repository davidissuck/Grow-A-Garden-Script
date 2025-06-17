-- Pantalla de carga personalizada en Roblox
-- Este script crea una pantalla negra con animaciones, mensajes y barra de progreso visual
-- Se activa automáticamente cuando se ejecuta el script

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
mensaje.TextColor3 = Color3.new(1, 1, 1)
mensaje.TextScaled = true
mensaje.BackgroundTransparency = 1
mensaje.Size = UDim2.new(1, 0, 0.2, 0)
mensaje.Position = UDim2.new(0, 0, 0.05, 0)
mensaje.Parent = fondo

-- Crear barra de carga
local barraMarco = Instance.new("Frame")
barraMarco.Size = UDim2.new(0.6, 0, 0.03, 0)
barraMarco.Position = UDim2.new(0.2, 0, 0.9, 0)
barraMarco.BackgroundColor3 = Color3.new(1, 1, 1)
barraMarco.BorderSizePixel = 0
barraMarco.Parent = fondo

local barra = Instance.new("Frame")
barra.Size = UDim2.new(0, 0, 1, 0)
barra.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
barra.BorderSizePixel = 0
barra.Parent = barraMarco

-- Animación de palmeras
local palmeras = {}

for i = 1, 3 do
	local palmera = Instance.new("ImageLabel")
	palmera.Image = "rbxassetid://14718021337" -- Imagen de palmera
	palmera.Size = UDim2.new(0, 100, 0, 0)
	palmera.Position = UDim2.new(0.2 * i, 0, 0.5, 0)
	palmera.BackgroundTransparency = 1
	palmera.ImageTransparency = 1
	palmera.Parent = fondo
	table.insert(palmeras, palmera)
end

-- Animación de crecimiento de palmeras y aparición de cocos
for i, palmera in ipairs(palmeras) do
	task.delay(i * 1, function()
		palmera:TweenSize(UDim2.new(0, 100, 0, 150), "Out", "Quad", 2)
		palmera.ImageTransparency = 0
		wait(2)
		
		local coco = Instance.new("ImageLabel")
		coco.Image = "rbxassetid://14718024118" -- Imagen de coco
		coco.Size = UDim2.new(0, 30, 0, 30)
		coco.Position = UDim2.new(0.2 * i + 0.05, 0, 0.62, 0)
		coco.BackgroundTransparency = 1
		coco.Parent = fondo

		-- Animación de balanceo
		while true do
			coco.Rotation = math.sin(tick() * 3) * 15
			task.wait()
		end
	end)
end

-- Simulación de carga (barra de progreso de 5 minutos)
local duracion = 300 -- 5 minutos
local start = tick()

while tick() - start < duracion do
	local progreso = (tick() - start) / duracion
	barra.Size = UDim2.new(progreso, 0, 1, 0)
	wait(0.1)
end

-- Al 100%: cae un coco, suena algo gracioso, y mensaje de "CLOWN 🤡"
local sonido = Instance.new("Sound")
sonido.SoundId = "rbxassetid://9118823104" -- Sonido gracioso
sonido.Volume = 1
sonido.Parent = fondo
sonido:Play()

local cocoFinal = Instance.new("ImageLabel")
cocoFinal.Image = "rbxassetid://14718024118"
cocoFinal.Size = UDim2.new(0, 50, 0, 50)
cocoFinal.Position = UDim2.new(0.5, -25, 0, -50)
cocoFinal.BackgroundTransparency = 1
cocoFinal.Parent = fondo

cocoFinal:TweenPosition(UDim2.new(0.5, -25, 0.7, 0), "Out", "Bounce", 1)

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
