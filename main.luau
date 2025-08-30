-- Professional Fly GUI (Delta Compatible)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Remove old GUI if it exists
if LocalPlayer.PlayerGui:FindFirstChild("GlobalPanel") then
    LocalPlayer.PlayerGui.GlobalPanel:Destroy()
end

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GlobalPanel"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 180)
Frame.Position = UDim2.new(0.35, 0, 0.35, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "🚀 Fly Control"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Frame

-- Fly Button
local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(0, 200, 0, 35)
FlyButton.Position = UDim2.new(0, 10, 0, 40)
FlyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.Text = "Toggle Fly"
FlyButton.Font = Enum.Font.Gotham
FlyButton.TextSize = 16
FlyButton.Parent = Frame

-- Speed Label
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 200, 0, 20)
SpeedLabel.Position = UDim2.new(0, 10, 0, 80)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: 3"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 14
SpeedLabel.Parent = Frame

-- Plus & Minus Buttons
local PlusButton = Instance.new("TextButton")
PlusButton.Size = UDim2.new(0, 95, 0, 30)
PlusButton.Position = UDim2.new(0, 10, 0, 105)
PlusButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
PlusButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusButton.Text = "+ Speed"
PlusButton.Font = Enum.Font.Gotham
PlusButton.TextSize = 14
PlusButton.Parent = Frame

local MinusButton = Instance.new("TextButton")
MinusButton.Size = UDim2.new(0, 95, 0, 30)
MinusButton.Position = UDim2.new(0, 115, 0, 105)
MinusButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinusButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusButton.Text = "- Speed"
MinusButton.Font = Enum.Font.Gotham
MinusButton.TextSize = 14
MinusButton.Parent = Frame

-- Hide/Unhide Button
local HideButton = Instance.new("TextButton")
HideButton.Size = UDim2.new(0, 200, 0, 30)
HideButton.Position = UDim2.new(0, 10, 0, 145)
HideButton.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
HideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HideButton.Text = "Hide Panel"
HideButton.Font = Enum.Font.Gotham
HideButton.TextSize = 14
HideButton.Parent = Frame

-- Fly System
local flying = false
local speed = 3
local HRP = LocalPlayer.Character:WaitForChild("HumanoidRootPart")

-- Single RenderStepped Loop (prevents multiple loops)
RunService.RenderStepped:Connect(function()
    if flying then
        local dir = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += workspace.CurrentCamera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= workspace.CurrentCamera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= workspace.CurrentCamera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += workspace.CurrentCamera.CFrame.RightVector end
        HRP.Velocity = dir * speed * 10
    end
end)

-- Button Connections
FlyButton.MouseButton1Click:Connect(function()
    flying = not flying
    FlyButton.Text = flying and "Flying..." or "Toggle Fly"
    if not flying then
        HRP.Velocity = Vector3.new(0,0,0)
    end
end)

PlusButton.MouseButton1Click:Connect(function()
    speed += 1
    SpeedLabel.Text = "Speed: " .. speed
end)

MinusButton.MouseButton1Click:Connect(function()
    if speed > 1 then
        speed -= 1
        SpeedLabel.Text = "Speed: " .. speed
    end
end)

HideButton.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
    HideButton.Text = Frame.Visible and "Hide Panel" or "Unhide Panel"
end)
