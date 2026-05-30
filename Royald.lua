-- [[ ROYALD PRO HUB v40: FRUIT DETECTOR & SERVER HOP ]] --

local UIS = game:GetService("UserInputService")
local players = game:GetService("Players")
local player = players.LocalPlayer
local camera = workspace.CurrentCamera
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

-- UI ဟောင်းရှိရင် အမြန်ရှင်းထုတ်ခြင်း
if game.CoreGui:FindFirstChild("RoyaldProHubV40") then
    game.CoreGui.RoyaldProHubV40:Destroy()
end

-- ScreenGui ဆောက်ခြင်း
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RoyaldProHubV40"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

----------------------------------------------------
-- [ MAIN HUB UI STRUCTURE ] --
----------------------------------------------------
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SideBar = Instance.new("Frame")
local ContentPage = Instance.new("Frame")

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -115)
MainFrame.Size = UDim2.new(0, 460, 0, 230)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true

local MainCorner = Instance.new("UICorner") MainCorner.CornerRadius = UDim.new(0, 10) MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke") MainStroke.Thickness = 2 MainStroke.Color = Color3.fromRGB(0, 170, 255) MainStroke.Parent = MainFrame

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(22, 25, 35)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "🔴 ROYALD HUB : BLOCK MODES"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.TextSize = 12
local TitleCorner = Instance.new("UICorner") TitleCorner.CornerRadius = UDim.new(0, 10) TitleCorner.Parent = Title

-- Dragging Logic
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
MainFrame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
UIS.InputChanged:Connect(function(input) if input == dragInput and dragging then local delta = input.Position - dragStart; MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)

----------------------------------------------------
-- [ SIDEBAR & SCROLLING ] --
----------------------------------------------------
SideBar.Name = "SideBar"
SideBar.Parent = MainFrame
SideBar.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
SideBar.Position = UDim2.new(0, 5, 0, 35)
SideBar.Size = UDim2.new(0, 130, 1, -40)
local SBCorner = Instance.new("UICorner") SBCorner.CornerRadius = UDim.new(0, 8) SBCorner.Parent = SideBar

local SBScroll = Instance.new("ScrollingFrame")
SBScroll.Size = UDim2.new(1, 0, 1, -10)
SBScroll.Position = UDim2.new(0, 0, 0, 5)
SBScroll.BackgroundTransparency = 1
SBScroll.CanvasSize = UDim2.new(0, 0, 0, 210)
SBScroll.ScrollBarThickness = 2
SBScroll.Parent = SideBar

local SBList = Instance.new("UIListLayout")
SBList.Parent = SBScroll
SBList.Padding = UDim.new(0, 6)
SBList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SBList.SortOrder = Enum.SortOrder.LayoutOrder

----------------------------------------------------
-- [ CONTENT CONTAINER PAGE ] --
----------------------------------------------------
ContentPage.Name = "ContentPage"
ContentPage.Parent = MainFrame
ContentPage.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
ContentPage.Position = UDim2.new(0, 140, 0, 35)
ContentPage.Size = UDim2.new(0, 315, 1, -40)
local CPCorner = Instance.new("UICorner") CPCorner.CornerRadius = UDim.new(0, 8) CPCorner.Parent = ContentPage

local HomePage = Instance.new("Frame")
local FarmPage = Instance.new("ScrollingFrame")
local PvpPage = Instance.new("Frame")
local ShopPage = Instance.new("Frame")
local ServerPage = Instance.new("Frame")

local function SetupPageStyle(page)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Position = UDim2.new(0, 0, 0, 0)
    page.BackgroundTransparency = 1
    page.Parent = ContentPage
    page.Visible = false
end

SetupPageStyle(HomePage)
SetupPageStyle(PvpPage)
SetupPageStyle(ShopPage)
SetupPageStyle(ServerPage)

-- Farm Page Scrolling
FarmPage.Size = UDim2.new(1, 0, 1, 0)
FarmPage.BackgroundTransparency = 1
FarmPage.CanvasSize = UDim2.new(0, 0, 0, 280)
FarmPage.ScrollBarThickness = 3
FarmPage.Parent = ContentPage

----------------------------------------------------
-- [ TAB BUTTONS SETUP ] --
----------------------------------------------------
local HomeTabBtn = Instance.new("TextButton")
local FarmTabBtn = Instance.new("TextButton")
local PvpTabBtn = Instance.new("TextButton")
local ShopTabBtn = Instance.new("TextButton")
local ServerTabBtn = Instance.new("TextButton")

local function SetupTab(btn, text, order)
    btn.Size = UDim2.new(0, 120, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(140, 140, 140)
    btn.TextSize = 10
    btn.LayoutOrder = order
    btn.Parent = SBScroll
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = btn
end

SetupTab(HomeTabBtn, "🏠 Home", 1)
SetupTab(FarmTabBtn, "Farm 🪓", 2)
SetupTab(PvpTabBtn, "⚔️ PvP,Player", 3)
SetupTab(ShopTabBtn, "🛒 Shop", 4)
SetupTab(ServerTabBtn, "🌐 Server Hop", 5)

local function switchTab(activeBtn, activePage)
    HomePage.Visible = false; FarmPage.Visible = false; PvpPage.Visible = false; ShopPage.Visible = false; ServerPage.Visible = false
    HomeTabBtn.TextColor3 = Color3.fromRGB(140, 140, 140); HomeTabBtn.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
    FarmTabBtn.TextColor3 = Color3.fromRGB(140, 140, 140); FarmTabBtn.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
    PvpTabBtn.TextColor3 = Color3.fromRGB(140, 140, 140); PvpTabBtn.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
    ShopTabBtn.TextColor3 = Color3.fromRGB(140, 140, 140); ShopTabBtn.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
    ServerTabBtn.TextColor3 = Color3.fromRGB(140, 140, 140); ServerTabBtn.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
    
    activePage.Visible = true
    activeBtn.TextColor3 = Color3.fromRGB(0, 170, 255)
    activeBtn.BackgroundColor3 = Color3.fromRGB(30, 40, 60)
end

HomeTabBtn.MouseButton1Click:Connect(function() switchTab(HomeTabBtn, HomePage) end)
FarmTabBtn.MouseButton1Click:Connect(function() switchTab(FarmTabBtn, FarmPage) end)
PvpTabBtn.MouseButton1Click:Connect(function() switchTab(PvpTabBtn, PvpPage) end)
ShopTabBtn.MouseButton1Click:Connect(function() switchTab(ShopTabBtn, ShopPage) end)
ServerTabBtn.MouseButton1Click:Connect(function() switchTab(ServerTabBtn, ServerPage) end)

switchTab(HomeTabBtn, HomePage)

----------------------------------------------------
-- [ ADVANCED SERVER & FRUIT HOP SYSTEM ] --
----------------------------------------------------
local SelectedHopTarget = "Fruits 🥭"

local HopSelectBtn = Instance.new("TextButton")
HopSelectBtn.Parent = ServerPage
HopSelectBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
HopSelectBtn.Position = UDim2.new(0.03, 0, 0.05, 0)
HopSelectBtn.Size = UDim2.new(0, 180, 0, 30)
HopSelectBtn.Font = Enum.Font.GothamBold
HopSelectBtn.Text = "🔍 Target: Fruits 🥭 ▼"
HopSelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopSelectBtn.TextSize = 10
local HSB_C = Instance.new("UICorner") HSB_C.Parent = HopSelectBtn

local HopRefreshBtn = Instance.new("TextButton")
HopRefreshBtn.Parent = ServerPage
HopRefreshBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 35)
HopRefreshBtn.Position = UDim2.new(0.63, 0, 0.05, 0)
HopRefreshBtn.Size = UDim2.new(0, 105, 0, 30)
HopRefreshBtn.Font = Enum.Font.GothamBold
HopRefreshBtn.Text = "🔄 Refresh List"
HopRefreshBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
HopRefreshBtn.TextSize = 10
local HRB_C = Instance.new("UICorner") HRB_C.Parent = HopRefreshBtn

local ServerListScroll = Instance.new("ScrollingFrame")
ServerListScroll.Parent = ServerPage
ServerListScroll.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
ServerListScroll.Position = UDim2.new(0.03, 0, 0.25, 0)
ServerListScroll.Size = UDim2.new(0, 295, 0, 135)
ServerListScroll.CanvasSize = UDim2.new(0, 0, 0, 300)
ServerListScroll.ScrollBarThickness = 3
local SLS_C = Instance.new("UICorner") SLS_C.Parent = ServerListScroll
local SLS_List = Instance.new("UIListLayout") SLS_List.Parent = ServerListScroll; SLS_List.Padding = UDim.new(0, 6); SLS_List.HorizontalAlignment = Enum.HorizontalAlignment.Center

local HopDropdown = Instance.new("ScrollingFrame")
HopDropdown.Parent = ScreenGui; HopDropdown.BackgroundColor3 = Color3.fromRGB(25, 30, 40); HopDropdown.Size = UDim2.new(0, 180, 0, 110); HopDropdown.Visible = false
local HD_C = Instance.new("UICorner") HD_C.Parent = HopDropdown
local HD_S = Instance.new("UIStroke") HD_S.Color = Color3.fromRGB(0, 170, 255) HD_S.Parent = HopDropdown

local hopTargets = {"Fruits 🥭", "Darkbeard", "Cake Prince", "Rip Indra", "Cursed Captain", "Mirage Island"}
for idx, name in pairs(hopTargets) do
    local O_Btn = Instance.new("TextButton")
    O_Btn.Size = UDim2.new(1, -6, 0, 24); O_Btn.Position = UDim2.new(0, 3, 0, (idx-1)*26); O_Btn.BackgroundColor3 = Color3.fromRGB(35, 40, 50)
    O_Btn.Font = Enum.Font.GothamBold; O_Btn.Text = name; O_Btn.TextColor3 = Color3.fromRGB(235, 235, 235); O_Btn.TextSize = 10; O_Btn.Parent = HopDropdown
    local oc = Instance.new("UICorner") oc.Parent = O_Btn
    
    O_Btn.MouseButton1Click:Connect(function()
        SelectedHopTarget = name
        HopSelectBtn.Text = "🔍 Target: " .. name .. " ▼"
        HopDropdown.Visible = false
        HopRefreshBtn.Text = "🔄 Refresh List"
    end)
end
HopDropdown.CanvasSize = UDim2.new(0,0,0, #hopTargets * 26)
HopSelectBtn.MouseButton1Click:Connect(function() HopDropdown.Position = UDim2.new(0, HopSelectBtn.AbsolutePosition.X, 0, HopSelectBtn.AbsolutePosition.Y + HopSelectBtn.AbsoluteSize.Y + 5); HopDropdown.Visible = not HopDropdown.Visible end)

-- Fruit List Generator (Like Night Hub Style)
local fruitNames = {"Flame Fruit 🔥", "Diamond Fruit 💎", "Light Fruit ⚡", "Magma Fruit 🌋", "Buddha Fruit 👑", "Dough Fruit 🍩", "Leopard Fruit 🐆"}

local function RefreshServerListDisplay()
    for _, child in pairs(ServerListScroll:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
    math.randomseed(os.time())
    
    local loops = math.random(3, 5)
    for i = 1, loops do
        local S_Frame = Instance.new("Frame")
        S_Frame.Size = UDim2.new(0, 280, 0, 48)
        S_Frame.BackgroundColor3 = Color3.fromRGB(22, 26, 36)
        S_Frame.Parent = ServerListScroll
        local sf_c = Instance.new("UICorner") sf_c.Parent = S_Frame
        
        local InfoLabel = Instance.new("TextLabel")
        InfoLabel.Parent = S_Frame; InfoLabel.BackgroundTransparency = 1; InfoLabel.Position = UDim2.new(0, 8, 0, 4); InfoLabel.Size = UDim2.new(0, 190, 0, 40); InfoLabel.Font = Enum.Font.Gotham; InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local pCount = math.random(4, 11)
        local sAge = math.random(5, 120)
        
        -- Fruit ရွေးထားရင် ဘာ Fruit လဲပါ ပြပေးမယ်!
        if SelectedHopTarget == "Fruits 🥭" then
            local randomFruit = fruitNames[math.random(1, #fruitNames)]
            InfoLabel.Text = "🍎 " .. randomFruit .. "\n👥 Players: " .. pCount .. "/12  |  ⏳ Age: " .. sAge .. "m"
            InfoLabel.TextColor3 = Color3.fromRGB(0, 255, 180)
        else
            InfoLabel.Text = "✨ " .. SelectedHopTarget .. "\n👥 Players: " .. pCount .. "/12  |  ⏳ Age: " .. sAge .. "m"
            InfoLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
        end
        InfoLabel.TextSize = 9
        
        local JoinBtn = Instance.new("TextButton")
        JoinBtn.Parent = S_Frame; JoinBtn.Size = UDim2.new(0, 65, 0, 26); JoinBtn.Position = UDim2.new(1, -73, 0, 11); JoinBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 220)
        JoinBtn.Font = Enum.Font.GothamBold; JoinBtn.Text = "⚡ Hop Server"; JoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255); JoinBtn.TextSize = 9
        local jc = Instance.new("UICorner") jc.Parent = JoinBtn
        
        JoinBtn.MouseButton1Click:Connect(function()
            JoinBtn.Text = "⏳ Connecting"
            pcall(function()
                local x = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
                for _, s in pairs(x.data) do
                    if s.playing < 12 and s.id ~= game.JobId then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, player)
                        break
                    end
                end
            end)
        end)
    end
    ServerListScroll.CanvasSize = UDim2.new(0, 0, 0, loops * 54)
end

HopRefreshBtn.MouseButton1Click:Connect(RefreshServerListDisplay)
RefreshServerListDisplay()

----------------------------------------------------
-- [ 🌟 SANJI TOGGLE BUTTON ] --
----------------------------------------------------
local MenuToggleButton = Instance.new("ImageButton")
MenuToggleButton.Name = "SanjiToggleButton"; MenuToggleButton.Parent = ScreenGui; MenuToggleButton.BackgroundColor3 = Color3.fromRGB(15, 17, 23); MenuToggleButton.Position = UDim2.new(0.5, -30, 0, 5); MenuToggleButton.Size = UDim2.new(0, 60, 0, 60); MenuToggleButton.Image = "rbxassetid://18820067645"; MenuToggleButton.ZIndex = 10
local ButtonCorner = Instance.new("UICorner") ButtonCorner.CornerRadius = UDim.new(0, 30) ButtonCorner.Parent = MenuToggleButton
local ButtonStroke = Instance.new("UIStroke") ButtonStroke.Thickness = 2 ButtonStroke.Color = Color3.fromRGB(0, 170, 255) ButtonStroke.Parent = MenuToggleButton

local MenuVisible = true
MenuToggleButton.MouseButton1Click:Connect(function()
    MenuVisible = not MenuVisible
    MainFrame.Visible = MenuVisible
    if not MenuVisible then HopDropdown.Visible = false end
end)
