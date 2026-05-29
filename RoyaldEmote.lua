-- [[ ROYALD HUB v13: UNIVERSAL EMOTES BYPASS (FOR ALL GAMES) ]] --

local UIS = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

-- အရင်ပွင့်နေတဲ့ UI ဟောင်းတွေရှိရင် အမြန်ရှင်းထုတ်ခြင်း
if game.CoreGui:FindFirstChild("RoyaldUniversalEmotes") then
    game.CoreGui.RoyaldUniversalEmotes:Destroy()
end

-- ScreenGui အသစ်ဆောက်ခြင်း
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RoyaldUniversalEmotes"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

----------------------------------------------------
-- [ MAIN MENU UI SYSTEM (HORIZONTAL) ] --
----------------------------------------------------
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local MenuToggleButton = Instance.new("ImageButton")

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -55)
MainFrame.Size = UDim2.new(0, 450, 0, 110)
MainFrame.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner") MainCorner.CornerRadius = UDim.new(0, 10) MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke") MainStroke.Thickness = 2 MainStroke.Color = Color3.fromRGB(0, 170, 255) MainStroke.Parent = MainFrame

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "🔵 ROYALD ALL-GAMES EMOTES (v13)"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.TextSize = 13
local TitleCorner = Instance.new("UICorner") TitleCorner.CornerRadius = UDim.new(0, 10) TitleCorner.Parent = Title

-- Dragging Logic (Menu နေရာရွှေ့ရန်)
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
MainFrame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
UIS.InputChanged:Connect(function(input) if input == dragInput and dragging then local delta = input.Position - dragStart; MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)

-- Horizontal Scroll Frame (ဘယ်ညာ ပွတ်ဆွဲရမည့် နေရာ)
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Parent = MainFrame
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.Position = UDim2.new(0, 8, 0, 38)
ScrollFrame.Size = UDim2.new(1, -16, 1, -44)
ScrollFrame.CanvasSize = UDim2.new(0, 850, 0, 0) -- ဘယ်ညာပွတ်ဆွဲရန် Space ချဲ့ထားသည်
ScrollFrame.ScrollingDirection = Enum.ScrollingDirection.X
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.BorderSizePixel = 0

local UIGridLayout = Instance.new("UIGridLayout")
UIGridLayout.Parent = ScrollFrame
UIGridLayout.CellSize = UDim2.new(0, 130, 0, 45)
UIGridLayout.CellPadding = UDim2.new(0, 8, 0, 0)
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder

----------------------------------------------------
-- [ 100% UNIVERSAL EMOTE EXECUTOR LOGIC ] --
----------------------------------------------------
local function executeUniversalEmote(command)
    pcall(function()
        -- ဂိမ်းအသစ်တွေရဲ့ TextChatService ကို စစ်ဆေးပြီး လှမ်းအော်ခိုင်းခြင်း
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            local generalChannel = TextChatService:FindFirstChild("RBXGeneral", true)
            if generalChannel then
                generalChannel:SendAsync(command)
            else
                -- Channel တိုက်ရိုက်ရှာမတွေ့ရင် Chat Window ထဲကနေ Keyboard နဲ့ ရိုက်သလို အတင်းပို့ခြင်း
                local chatInput = TextChatService:FindFirstChild("ChatInputBarConfiguration", true)
                if chatInput then
                    game:GetService("Players").LocalPlayer.Chatted:Fire(command)
                end
            end
        else
            -- ဂိမ်းဟောင်းတွေရဲ့ Legacy Chat Remote ကို လှမ်းထုခြင်း
            local sayMessage = ReplicatedStorage:FindFirstChild("SayMessageRequest", true)
            if sayMessage and sayMessage:IsA("RemoteEvent") then
                sayMessage:FireServer(command, "All")
            end
        end
    end)
end

-- ခလုတ်ဆောက်ပေးမည့် စနစ်
local function createEmoteButton(name, command, order)
    local btn = Instance.new("TextButton")
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    btn.Font = Enum.Font.GothamBold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 10
    btn.LayoutOrder = order
    btn.Parent = ScrollFrame
    
    local c = Instance.new("UICorner") c.Parent = btn
    local stroke = Instance.new("UIStroke") stroke.Thickness = 1 stroke.Color = Color3.fromRGB(50, 50, 60) stroke.Parent = btn

    btn.MouseButton1Click:Connect(function()
        executeUniversalEmote(command)
    end)
end

-- [[ ဘယ်ဂိမ်းမဆို အလုပ်လုပ်မည့် အလန်းစား မူရင်းလှုပ်ရှားမှုများ ]] --
createEmoteButton("🕺 ကကွက် ပုံစံ (၁)", "/e dance", 1)
createEmoteButton("🕺 ကကွက် ပုံစံ (၂)", "/e dance2", 2)
createEmoteButton("🕺 ကကွက် ပုံစံ (၃)", "/e dance3", 3)
createEmoteButton("👋 နှုတ်ဆက်ခြင်း (Wave)", "/e wave", 4)
createEmoteButton("🙌 အောင်ပွဲခံခြင်း (Cheer)", "/e cheer", 5)
createEmoteButton("👉 လက်ညှိုးထိုးခြင်း (Point)", "/e point", 6)
createEmoteButton("ရယ်မောခြင်း (Laugh)", "/e laugh", 7)

-- Sanji Toggle Button (အပိတ်အဖွင့်ခလုတ်)
MenuToggleButton.Parent = ScreenGui
MenuToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MenuToggleButton.Position = UDim2.new(0.02, 0, 0.12, 0)
MenuToggleButton.Size = UDim2.new(0, 60, 0, 60)
MenuToggleButton.Image = "rbxassetid://18820067645"
local ButtonCorner = Instance.new("UICorner") ButtonCorner.CornerRadius = UDim.new(0, 12) ButtonCorner.Parent = MenuToggleButton
local ButtonStroke = Instance.new("UIStroke") ButtonStroke.Thickness = 2 ButtonStroke.Color = Color3.fromRGB(0, 170, 255) ButtonStroke.Parent = MenuToggleButton

local MenuVisible = true
MenuToggleButton.MouseButton1Click:Connect(function()
    MenuVisible = not MenuVisible
    MainFrame.Visible = MenuVisible
end)
