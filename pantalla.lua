local TweenService = game:GetService("TweenService")

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

-- Contenedor para los hongos interactuables
local hongosContainer = Instance.new("Frame")
hongosContainer.Size = UDim2.new(0.6, 0, 0.15, 0)
hongosContainer.Position = UDim2.new(0.2, 0, 0.55, 0)
hongosContainer.BackgroundTransparency = 1
hongosContainer.Parent = fondo

-- Función para crear un hongo interactuable
local function crearHongo(posX)
	local hongo = Instance.new("ImageButton")
	hongo.Size = UDim2.new(0, 50, 0, 50)
	hongo.Position = UDim2.new(posX, 0, 0, 0)
	hongo.BackgroundTransparency = 1
	hongo.Image = "rbxassetid://6023426915" -- Imagen de prueba (botón rojo)
	hongo.Parent = hongosContainer
	hongo.AutoButtonColor = true

	hongo.MouseButton1Click:Connect(function()
		-- Efecto al presionar: se encoge y vuelve a tamaño original
		local tweenOut = TweenService:Create(hongo, TweenInfo.new(0.3), {Size = UDim2.new(0, 25, 0, 25)})
		tweenOut:Play()
		tweenOut.Completed:Wait()
		local tweenIn = TweenService:Create(hongo, TweenInfo.new(0.3), {Size = UDim2.new(0, 50, 0, 50)})
		tweenIn:Play()
	end)
end

-- Crear 5 hongos distribuidos en hongosContainer horizontalmente
for i = 0, 4 do
	crearHongo(i * 0.2 + 0.05)
end

-- Lógica de carga simulada (5 minutos total con distintas velocidades)
local duracionTotal = 300
local start = tick()

-- Función para calcular el progreso según los segmentos con velocidades variables
local function progresoConVelocidadSegmentada(elapsed)
	if elapsed < 60 then -- primer minuto: rápido
		return elapsed / 60 * 0.4 -- 40% rápido
	elseif elapsed < 120 then -- segundo minuto: un poco más lento
		return 0.4 + (elapsed - 60) / 60 * 0.25 -- hasta 65%
	elseif elapsed < 180 then -- tercer minuto: un poco más lento
		return 0.65 + (elapsed - 120) / 60 * 0.15 -- hasta 80%
	else -- último 2 minutos: lento para completar 100%
		return 0.8 + (elapsed - 180) / 120 * 0.2 -- hasta 100%
	end
end

-- Loop para animar barra y texto
while true do
	local elapsed = tick() - start
	if elapsed > duracionTotal then break end
	local progreso = progresoConVelocidadSegmentada(elapsed)
	barra.Size = UDim2.new(progreso, 0, 1, 0)
	porcentajeTexto.Text = string.format("%d%%", progreso * 100)
	wait(0.1)
end

-- Al 100%: mensaje final y sonido gracioso
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

-- Destruir pantalla
ScreenGui:Destroy()

-- Animación del texto en RunService para que se mueva de lado a lado
local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(animarTexto)
