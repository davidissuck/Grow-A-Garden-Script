local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

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
mensaje.Position = UDim2.new(0, 0, 0.05, 0) -- Arriba
mensaje.Parent = fondo

-- Animación mover de lado a lado (izquierda a derecha y vuelta)
local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local tween1 = TweenService:Create(mensaje, tweenInfo, {Position = UDim2.new(0.4, 0, 0.05, 0)})
tween1:Play()

-- Marco de barra (blanco) casi en medio
local barraMarco = Instance.new("Frame")
barraMarco.Size = UDim2.new(0.6, 0, 0.04, 0)
barraMarco.Position = UDim2.new(0.2, 0, 0.48, 0) -- casi en medio verticalmente
barraMarco.BackgroundColor3 = Color3.new(1, 1, 1)
barraMarco.BorderSizePixel = 0
barraMarco.Parent = fondo

-- Barra azul de progreso
local barra = Instance.new("Frame")
barra.Size = UDim2.new(0, 0, 1, 0)
barra.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
barra.BorderSizePixel = 0
barra.Parent = barraMarco

-- Texto porcentaje dentro de la barra (color blanco para contraste)
local porcentajeTexto = Instance.new("TextLabel")
porcentajeTexto.Size = UDim2.new(1, 0, 1, 0)
porcentajeTexto.BackgroundTransparency = 1
porcentajeTexto.TextColor3 = Color3.new(1, 1, 1)
porcentajeTexto.Font = Enum.Font.GothamBold
porcentajeTexto.TextScaled = true
porcentajeTexto.Text = "0%"
porcentajeTexto.Parent = barra

-- Contenedor para hongos interactivos
local hongosContainer = Instance.new("Frame")
hongosContainer.Size = UDim2.new(0.6, 0, 0.15, 0)
hongosContainer.Position = UDim2.new(0.2, 0, 0.55, 0) -- justo debajo de la barra
hongosContainer.BackgroundTransparency = 1
hongosContainer.Parent = fondo

-- Función para crear un hongo interactivo
local function crearHongo(position)
	local hongo = Instance.new("ImageButton")
	hongo.Size = UDim2.new(0, 50, 0, 50)
	hongo.Position = position
	hongo.BackgroundTransparency = 1
	hongo.Image = "rbxassetid://10813318822" -- Imagen de un hongo rojo
	hongo.Parent = hongosContainer
	hongo.AutoButtonColor = true
	
	hongo.MouseButton1Click:Connect(function()
		-- Al hacer clic: el hongo se "divide"
		-- Animar el hongo actual a 0.5 escala y crear uno nuevo al lado
		
		local tweenOut = TweenService:Create(hongo, TweenInfo.new(0.3), {Size = UDim2.new(0, 25, 0, 25)})
		tweenOut:Play()
		
		tweenOut.Completed:Wait()
		
		local tweenIn = TweenService:Create(hongo, TweenInfo.new(0.3), {Size = UDim2.new(0, 50, 0, 50)})
		tweenIn:Play()
		
		-- Crear un nuevo hongo a la derecha, si no está fuera del container
		local newPos = UDim2.new(hongo.Position.X.Scale + 0.1, hongo.Position.X.Offset, hongo.Position.Y.Scale, hongo.Position.Y.Offset)
		if newPos.X.Scale + 0.08 <= 1 then
			crearHongo(newPos)
		end
	end)
end

-- Crear tres hongos iniciales
crearHongo(UDim2.new(0, 0, 0, 0))
crearHongo(UDim2.new(0.15, 0, 0, 0))
crearHongo(UDim2.new(0.3, 0, 0, 0))

-- Simulación de carga 5 minutos (300 segundos) con velocidad variable
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

-- Al 100%: sonido y mensaje final
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

ScreenGui:Destroy()
