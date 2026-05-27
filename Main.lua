-- [[ ROYALD HUB: COMBINED LOADING SCREEN + GUN HUB v4 ]] --

local UIS = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- ပင်မ ScreenGui ဆောက်ခြင်း
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

----------------------------------------------------
-- [ အပိုင်း ၁ - ROYALD LOADING SCREEN ANIMATION ] --
----------------------------------------------------

local LoadingFrame = Instance.new("Frame")
local LoadingTitle = Instance.new("TextLabel")
local BarBackground = Instance.new("Frame")
local BarProgress = Instance.new("Frame")
local PercentageText = Instance.new("TextLabel")

-- Loading Frame ပုံစံဒီဇိုင်း
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Parent = ScreenGui
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
LoadingFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
LoadingFrame.Size = UDim2.new(0, 300, 0, 120)
LoadingFrame.BorderSizePixel = 0

local L_Corner = Instance.new("UICorner")
L_Corner.CornerRadius = UDim.new(0, 12)
L_Corner.Parent = LoadingFrame

local L_Stroke = Instance.new("UIStroke")
L_Stroke.Thickness = 2
L_Stroke.Color = Color3.fromRGB(0, 170, 255) -- အပြာရောင်လိုင်း
L_Stroke.Parent = LoadingFrame

-- Loading ခေါင်းစဉ်
LoadingTitle.Name = "LoadingTitle"
LoadingTitle.Parent = LoadingFrame
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Position = UDim2.new(0, 0, 0, 15)
LoadingTitle.Size = UDim2.new(1, 0, 0, 30)
LoadingTitle.Font = Enum.Font.GothamBold
LoadingTitle.Text = "🔵 ROYALD HUB LOADING..."
LoadingTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
LoadingTitle.TextSize = 16.000

-- Loading Bar နောက်ခံကွက်
BarBackground.Name = "BarBackground"
BarBackground.Parent = LoadingFrame
BarBackground.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
BarBackground.Position = UDim2.new(0.08, 0, 0.55, 0)
BarBackground.Size = UDim2.new(0, 250, 0, 10)
BarBackground.BorderSizePixel = 0
local B_Corner = Instance.new("UICorner")
B_Corner.Parent = BarBackground

-- တကယ် ရွေ့လျားမည့် အပြာရောင် Bar တန်းလေး
BarProgress.Name = "BarProgress"
BarProgress.Parent = BarBackground
BarProgress.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
BarProgress.Size = UDim2.new(0, 0, 1, 0) -- ၀% ကနေ စတင်မည်
BarProgress.BorderSizePixel = 0
local P_Corner = Instance.new("UICorner")
P_Corner.Parent = BarProgress

-- ရာခိုင်နှုန်းပြ စာသား
PercentageText.Name = "PercentageText"
PercentageText.Parent = LoadingFrame
PercentageText.BackgroundTransparency = 1
PercentageText.Position = UDim2.new(0, 0, 0, 85)
PercentageText.Size = UDim2.new(1, 0, 0, 20)
PercentageText.Font = Enum.Font.GothamBold
PercentageText.Text = "0%"
PercentageText.TextColor3 = Color3.fromRGB(255, 255, 255)
PercentageText.TextSize = 12.000

----------------------------------------------------
-- [ အပိုင်း ၂ - MAIN MENU UI & FUNCTION CODES ] --
----------------------------------------------------

local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleGunV1Btn = Instance.new("TextButton")
local ToggleGunV2Btn = Instance.new("TextButton")
local MenuToggleButton = Instance.new("ImageButton")
local ButtonCorner = Instance.new("UICorner")
local SliderFrame = Instance.new("Frame")
local SliderButton = Instance.new("TextButton")
local SliderTitle = Instance.new("TextLabel")

-- Menu Frame (အပြာရောင် Theme)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 230, 0, 240)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false -- စစချင်း ဖျောက်ထားမည် (Loading ပြီးမှ ပေါ်လာမည်)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(0, 170, 255)
MainStroke.Parent = MainFrame

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "🔵 ROYALD GUN HUB v4"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.TextSize = 16.000
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

-- Drag စနစ် Logic
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
MainFrame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
UIS.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)

-- Gun Fast V1 ခလုတ်
local GunV1Enabled = false
ToggleGunV1Btn.Name = "ToggleGunV1Btn"
ToggleGunV1Btn.Parent = MainFrame
ToggleGunV1Btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ToggleGunV1Btn.Position = UDim2.new(0.06, 0, 0.20, 0)
ToggleGunV1Btn.Size = UDim2.new(0, 200, 0, 35)
ToggleGunV1Btn.Font = Enum.Font.GothamBold
ToggleGunV1Btn.Text = "Gun Fast V1: OFF"
ToggleGunV1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleGunV1Btn.TextSize = 12.000
local V1Corner = Instance.new("UICorner")
V1Corner.Parent = ToggleGunV1Btn

ToggleGunV1Btn.MouseButton1Click:Connect(function()
    GunV1Enabled = not GunV1Enabled
    ToggleGunV1Btn.BackgroundColor3 = GunV1Enabled and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
    ToggleGunV1Btn.Text = GunV1Enabled and "Gun Fast V1: ON" or "Gun Fast V1: OFF"
end)

-- Gun Fast V2 ခလုတ်
local GunV2Enabled = false
ToggleGunV2Btn.Name = "ToggleGunV2Btn"
ToggleGunV2Btn.Parent = MainFrame
ToggleGunV2Btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ToggleGunV2Btn.Position = UDim2.new(0.06, 0, 0.40, 0)
ToggleGunV2Btn.Size = UDim2.new(0, 200, 0, 35)
ToggleGunV2Btn.Font = Enum.Font.GothamBold
ToggleGunV2Btn.Text = "Gun Fast V2 (M1): OFF"
ToggleGunV2Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleGunV2Btn.TextSize = 12.000
local V2Corner = Instance.new("UICorner")
V2Corner.Parent = ToggleGunV2Btn

ToggleGunV2Btn.MouseButton1Click:Connect(function()
    GunV2Enabled = not GunV2Enabled
    ToggleGunV2Btn.BackgroundColor3 = GunV2Enabled and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
    ToggleGunV2Btn.Text = GunV2Enabled and "Gun Fast V2 (M1): ON" or "Gun Fast V2 (M1): OFF"
end)

-- Blue Speed Slider စနစ်
local SpeedValue = 3
local DelayTimes = {0.01, 0.05, 0.1, 0.15, 0.2}

SliderTitle.Name = "SliderTitle"
SliderTitle.Parent = MainFrame
SliderTitle.BackgroundTransparency = 1
SliderTitle.Position = UDim2.new(0.06, 0, 0.60, 0)
SliderTitle.Size = UDim2.new(0, 200, 0, 20)
SliderTitle.Font = Enum.Font.GothamBold
SliderTitle.Text = "⚡ Speed: Level 3 (Normal)"
SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SliderTitle.TextSize = 12.000

SliderFrame.Name = "SliderFrame"
SliderFrame.Parent = MainFrame
SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
SliderFrame.Position = UDim2.new(0.06, 0, 0.75, 0)
SliderFrame.Size = UDim2.new(0, 200, 0, 8)
local SCorner = Instance.new("UICorner")
SCorner.Parent = SliderFrame

SliderButton.Name = "SliderButton"
SliderButton.Parent = SliderFrame
SliderButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SliderButton.Position = UDim2.new(0.5, -10, 0, -6)
SliderButton.Size = UDim2.new(0, 30, 0, 20)
SliderButton.Text = ""
local BCorner = Instance.new("UICorner")
BCorner.Parent = SliderButton

local sliderDragging = false
SliderButton.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then sliderDragging = true end end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then sliderDragging = false end end)
UIS.InputChanged:Connect(function(input)
    if sliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local percentage = math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
        SpeedValue = math.floor(percentage * 4) + 1
        SliderButton.Position = UDim2.new(percentage, -15, 0, -6)
        local speedTexts = {"1 (Ultra)", "2 (Fast)", "3 (Normal)", "4 (Slow)", "5 (Safe)"}
        SliderTitle.Text = "⚡ Speed: Level " .. speedTexts[SpeedValue]
    end
end)

-- Sanji Image Toggle Button (အဖွင့်အပိတ်ခလုတ်)
MenuToggleButton.Name = "MenuToggleButton"
MenuToggleButton.Parent = ScreenGui
MenuToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MenuToggleButton.Position = UDim2.new(0.02, 0, 0.12, 0)
MenuToggleButton.Size = UDim2.new(0, 70, 0, 70)
MenuToggleButton.Image = "rbxassetid://18820067645" -- Sanji Image ID
MenuToggleButton.ScaleType = Enum.ScaleType.Stretch
MenuToggleButton.Visible = false -- Loading ပြီးမှ ပေါ်လာစေရန်

ButtonCorner.CornerRadius = UDim.new(0, 12)
ButtonCorner.Parent = MenuToggleButton
local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Thickness = 2
ButtonStroke.Color = Color3.fromRGB(0, 170, 255)
ButtonStroke.Parent = MenuToggleButton

local MenuVisible = true
MenuToggleButton.MouseButton1Click:Connect(function()
    MenuVisible = not MenuVisible
    MainFrame.Visible = MenuVisible
    MenuToggleButton:TweenSize(UDim2.new(0, 65, 0, 65), "Out", "Quad", 0.1, true)
    task.wait(0.1)
    MenuToggleButton:TweenSize(UDim2.new(0, 70, 0, 70), "Out", "Quad", 0.1, true)
end)

-- Gun Fast Logic များ Background Processing
runService.Stepped:Connect(function()
    if GunV1Enabled then
        local character = player.Character
        if character then
            local tool = character:FindFirstChildOfClass("Tool")
            if tool then
                if tool:FindFirstChild("Cooldown") then tool.Cooldown.Value = DelayTimes[SpeedValue] end
                if tool:FindFirstChild("ReloadTime") then tool.ReloadTime.Value = DelayTimes[SpeedValue] end
            end
        end
    end
end)

local isSprinting = false
mouse.Button1Down:Connect(function()
    if GunV2Enabled then
        isSprinting = true
        while isSprinting and GunV2Enabled do
            local character = player.Character
            if character and character:FindFirstChildOfClass("Tool") then
                local tool = character:FindFirstChildOfClass("Tool")
                local remote = tool:FindFirstChildOfClass("RemoteEvent") or tool:FindFirstChild("Input")
                if remote then remote:FireServer(mouse.Hit.Position) end
            end
            task.wait(DelayTimes[SpeedValue]) 
        end
    end
end)
mouse.Button1Up:Connect(function() isSprinting = false end)

----------------------------------------------------
-- [ အပိုင်း ၃ - LOADING ANIMATION SYSTEM LOGIC ] --
----------------------------------------------------

task.spawn(function()
    -- စက္ကန့်အလိုက် အပြာရောင်တန်းလေး တိုးလာမည့် စနစ်
    for i = 1, 100 do
        local progress = i / 100
        -- Smooth ဖြစ်အောင် Tween နဲ့ Bar ကို ချဲ့ခြင်း
        TweenService:Create(BarProgress, TweenInfo.new(0.03, Enum.EasingStyle.Linear), {Size = UDim2.new(progress, 0, 1, 0)}):Play()
        PercentageText.Text = tostring(i) .. "%"
        task.wait(0.03) -- Loading စုစုပေါင်း ကြာချိန် (၃ စက္ကန့်ဝန်းကျင်)
    end
    
    -- ၁၀၀% ပြည့်သွားလျှင် Loading Box အား သေသပ်စွာ ဖျောက်ခြင်း Effect
    LoadingTitle.Text = "✅ SUCCESSFUL!"
    task.wait(0.5)
    TweenService:Create(LoadingFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadingTitle, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
    TweenService:Create(PercentageText, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
    BarBackground.Visible = false
    task.wait(0.3)
    LoadingFrame:Destroy() -- Loading စနစ်ကို ဖျက်ချလိုက်ခြင်း
    
    -- ပင်မ Sanji Toggle ခလုတ်နှင့် Menu အား အသက်သွင်း ပေါ်လာစေခြင်း
    MenuToggleButton.Visible = true
    MainFrame.Visible = true
end)
