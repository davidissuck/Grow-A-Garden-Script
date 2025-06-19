local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ProgressText = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Frame.Parent = ScreenGui
ProgressText.Parent = Frame

-- Loading screen setup
Frame.BackgroundColor3 = Color3.new(0, 0, 0) -- Black background
Frame.Size = UDim2.new(1, 0, 1, 0)

ProgressText.Size = UDim2.new(0.3, 0, 0.1, 0)
ProgressText.Position = UDim2.new(0.35, 0, 0.45, 0)
ProgressText.BackgroundTransparency = 1
ProgressText.TextColor3 = Color3.new(1, 1, 1) -- White text
ProgressText.TextScaled = true

local duration = 10 -- 10 seconds
local elapsedTime = 0

while elapsedTime <= duration do
    local percentage = (elapsedTime / duration) * 100
    ProgressText.Text = string.format("Loading... %.0f%%", percentage)
    wait(1) -- Wait 1 second before updating
    elapsedTime = elapsedTime + 1
end

ProgressText.Text = "Loading complete"
wait(2)
ScreenGui:Destroy() -- Hide the loading screen
