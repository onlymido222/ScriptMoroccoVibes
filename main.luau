--// Professional Fly Panel for Delta
if game:GetService("CoreGui"):FindFirstChild("FlyUI") then
    game:GetService("CoreGui").FlyUI:Destroy()
end

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "FlyUI"
gui.Parent = CoreGui

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "🚀 Fly Panel"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = frame

-- Speed Slider Label
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -20, 0, 30)
speedLabel.Position = UDim2.new(0, 10, 0, 40)
speedLabel.Text = "Fly Speed: 50"
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.BackgroundTransparency = 1
speedLabel.Font = Enum.Font.SourceSans
speedLabel.TextSize = 16
speedLabel.Parent = frame

-- Speed Value
local flySpeed = 50

-- Fly Toggle Button
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.5, -15, 0, 40)
flyBtn.Position = UDim2.new(0, 10, 0, 80)
flyBtn.Text = "Enable Fly"
flyBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
flyBtn.TextColor3 = Color3.new(1, 1, 1)
flyBtn.Font = Enum.Font.SourceSansBold
flyBtn.TextSize = 16
flyBtn.Parent = frame

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0.5, -15, 0, 40)
closeBtn.Position = UDim2.new(0.5, 5, 0, 80)
closeBtn.Text = "Close"
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 16
closeBtn.Parent = frame

-- Fly Logic
local flying = false
flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    flyBtn.Text = flying and "Disable Fly" or "Enable Fly"
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Movement
RunService.RenderStepped:Connect(function()
    if flying and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local moveDir = player.Character.Humanoid.MoveDirection
        if moveDir.Magnitude > 0 then
            hrp.Velocity = moveDir * flySpeed
        else
            hrp.Velocity = Vector3.new(0,0,0)
        end
    end
end)
