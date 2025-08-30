c-- 🟢 Professional Fly Panel (Delta Compatible)

-- remove old panels if exist
local player = game:GetService("Players").LocalPlayer
if player.PlayerGui:FindFirstChild("GlobalFlyPanel") then
    player.PlayerGui.GlobalFlyPanel:Destroy()
end

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GlobalFlyPanel"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 200)
Frame.Position = UDim2.new(0.35, 0, 0.35, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Text = "⚡ Fly System"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = Frame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Fly Button
local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(0, 220, 0, 40)
FlyButton.Position = UDim2.new(0, 15, 0, 50)
FlyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FlyButton.Text = "🚀 Toggle Fly"
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.Font = Enum.Font.SourceSansBold
FlyButton.TextSize = 16
FlyButton.Parent = Frame

local BtnCorner1 = Instance.new("UICorner")
BtnCorner1.CornerRadius = UDim.new(0, 8)
BtnCorner1.Parent = FlyButton

-- Speed Label
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 220, 0, 20)
SpeedLabel.Position = UDim2.new(0, 15, 0, 100)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Fly Speed: 3"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextSize = 14
SpeedLabel.Parent = Frame

-- Speed Slider (basic)
local SpeedSlider = Instance.new("TextButton")
SpeedSlider.Size = UDim2.new(0, 220, 0, 20)
SpeedSlider.Position = UDim2.new(0, 15, 0, 130)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
SpeedSlider.Text = ""
SpeedSlider.Parent = Frame

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.3, 0, 1, 0) -- default 30%
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SpeedSlider

-- Hide Button
local HideButton = Instance.new("TextButton")
HideButton.Size = UDim2.new(0, 220, 0, 30)
HideButton.Position = UDim2.new(0, 15, 0, 160)
HideButton.BackgroundColor3 = Color3.fromRGB(170, 30, 30)
HideButton.Text = "❌ Hide Panel"
HideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HideButton.Font = Enum.Font.SourceSansBold
HideButton.TextSize = 14
HideButton.Parent = Frame

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.CornerRadius = UDim.new(0, 8)
BtnCorner2.Parent = HideButton

-- Fly System
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HumanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 3

-- Fly loop
RunService.RenderStepped:Connect(function()
    if flying then
        local moveDir = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDir = moveDir + workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDir = moveDir - workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDir = moveDir - workspace.CurrentCamera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDir = moveDir + workspace.CurrentCamera.CFrame.RightVector
        end
        HumanoidRootPart.Velocity = moveDir * speed * 10
    end
end)

-- Button logic
FlyButton.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        FlyButton.Text = "✅ Flying..."
    else
        FlyButton.Text = "🚀 Toggle Fly"
        HumanoidRootPart.Velocity = Vector3.new(0,0,0)
    end
end)

-- Speed slider control
SpeedSlider.MouseButton1Down:Connect(function(x,y)
    local uis = game:GetService("UserInputService")
    local conn
    conn = uis.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            local relativeX = math.clamp((input.Position.X - SpeedSlider.AbsolutePosition.X) / SpeedSlider.AbsoluteSize.X, 0, 1)
            SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            speed = math.floor(1 + relativeX * 10) -- speed 1–10
            SpeedLabel.Text = "Fly Speed: " .. speed
        end
    end)
    uis.InputEnded:Wait()
    conn:Disconnect()
end)

-- Hide Button
HideButton.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
    if Frame.Visible then
        HideButton.Text = "❌ Hide Panel"
    else
        HideButton.Text = "📂 Show Panel"
    end
end)
