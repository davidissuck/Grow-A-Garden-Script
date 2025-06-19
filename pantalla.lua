local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local BackgroundImage = Instance.new("ImageLabel")
local ProgressText = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Frame.Parent = ScreenGui
BackgroundImage.Parent = Frame
ProgressText.Parent = Frame

-- Loading screen setup
Frame.Size = UDim2.new(1, 0, 1, 0)

BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
BackgroundImage.Image = "rbxassetid://106712592098365" -- Fondo personalizado

ProgressText.Size = UDim2.new(0.3, 0, 0.1, 0)
ProgressText.Position = UDim2.new(0.35, 0, 0.45, 0)
ProgressText.BackgroundTransparency = 1
ProgressText.TextColor3 = Color3.new(1, 1, 1) -- Texto blanco
ProgressText.TextScaled = true

local duration = 10 -- 10 segundos
local elapsedTime = 0

while elapsedTime <= duration do
    local percentage = (elapsedTime / duration) * 100
    ProgressText.Text = string.format("Loading... %.0f%%", percentage)
    wait(1) -- Esperar 1 segundo antes de actualizar
    elapsedTime = elapsedTime + 1
end

ProgressText.Text = "Loading complete"
wait(2)
ScreenGui:Destroy() -- Oculta la pantalla de carga
