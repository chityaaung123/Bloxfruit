-- [[ ROYALD PRO HUB v37/v38: BUG FIXED & LAYOUT CORRECTED ]] --

local UIS = game:GetService("UserInputService")
local players = game:GetService("Players")
local player = players.LocalPlayer
local camera = workspace.CurrentCamera

-- UI ဟောင်းရှိရင် အမြန်ရှင်းထုတ်ခြင်း
if game.CoreGui:FindFirstChild("RoyaldProHubV38") then
    game.CoreGui.RoyaldProHubV38:Destroy()
end

-- ScreenGui ဆောက်ခြင်း
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RoyaldProHubV38"
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

-- Create Separate Frames for Each Page
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

-- Farm Page Needs Scrolling
FarmPage.Size = UDim2.new(1, 0, 1, 0)
FarmPage.Position = UDim2.new(0, 0, 0, 0)
FarmPage.BackgroundTransparency = 1
FarmPage.CanvasSize = UDim2.new(0, 0, 0, 280)
FarmPage.ScrollBarThickness = 3
FarmPage.Parent = ContentPage
FarmPage.Visible = false

local UIListLayoutFarm = Instance.new("UIListLayout")
UIListLayoutFarm.Parent = FarmPage
UIListLayoutFarm.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayoutFarm.Padding = UDim.new(0, 8)

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
SetupTab(ServerTabBtn, "🌐 Server", 5)

local FarmDropdownScroll = Instance.new("ScrollingFrame")
local PvpDropdownScroll = Instance.new("ScrollingFrame")

local function switchTab(activeBtn, activePage)
    HomePage.Visible = false
    FarmPage.Visible = false
    PvpPage.Visible = false
    ShopPage.Visible = false
    ServerPage.Visible = false
    PvpDropdownScroll.Visible = false
    FarmDropdownScroll.Visible = false
    
    HomeTabBtn.TextColor3 = Color3.fromRGB(140, 140, 140)
    HomeTabBtn.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
    FarmTabBtn.TextColor3 = Color3.fromRGB(140, 140, 140)
    FarmTabBtn.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
    PvpTabBtn.TextColor3 = Color3.fromRGB(140, 140, 140)
    PvpTabBtn.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
    ShopTabBtn.TextColor3 = Color3.fromRGB(140, 140, 140)
    ShopTabBtn.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
    ServerTabBtn.TextColor3 = Color3.fromRGB(140, 140, 140)
    ServerTabBtn.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
    
    activePage.Visible = true
    activeBtn.TextColor3 = Color3.fromRGB(0, 170, 255)
    activeBtn.BackgroundColor3 = Color3.fromRGB(30, 40, 60)
end

HomeTabBtn.MouseButton1Click:Connect(function() switchTab(HomeTabBtn, HomePage) end)
FarmTabBtn.MouseButton1Click:Connect(function() switchTab(FarmTabBtn, FarmPage) end)
PvpTabBtn.MouseButton1Click:Connect(function() switchTab(PvpTabBtn, PvpPage) end)
ShopTabBtn.MouseButton1Click:Connect(function() switchTab(ShopTabBtn, ShopPage) end)
ServerTabBtn.MouseButton1Click:Connect(function() switchTab(ServerTabBtn, ServerPage) end)

-- Default Open Page
switchTab(HomeTabBtn, HomePage)

----------------------------------------------------
-- [ COMING SOON GENERATOR (FIXED POSITION) ] --
----------------------------------------------------
local function createComingSoon(parentFrame, text)
    local Label = Instance.new("TextLabel")
    Label.Parent = parentFrame
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.Position = UDim2.new(0, 0, 0, 0)
    Label.Font = Enum.Font.GothamBold
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(0, 170, 255)
    Label.TextSize = 13
    Label.TextAlignment = Enum.TextAlignment.Center
end

createComingSoon(HomePage, "✨ Home Page\nComing Soon...")
createComingSoon(ShopPage, "🛒 Shop Features\nComing Soon...")
createComingSoon(ServerPage, "🌐 Server Options\nComing Soon...")

----------------------------------------------------
-- [ PVP CONTENT SETUP (FIXED POSITION) ] --
----------------------------------------------------
local isInvisible = false
local InvisBtn = Instance.new("TextButton")
InvisBtn.Parent = PvpPage
InvisBtn.BackgroundColor3 = Color3.fromRGB(110, 0, 180)
InvisBtn.Position = UDim2.new(0.05, 0, 0.05, 0)
InvisBtn.Size = UDim2.new(0, 285, 0, 35)
InvisBtn.Font = Enum.Font.GothamBold
InvisBtn.Text = "👻 CLICK TO GO INVISIBLE"
InvisBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InvisBtn.TextSize = 10
local IB_Corner = Instance.new("UICorner") IB_Corner.Parent = InvisBtn

InvisBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if not char then return end
    isInvisible = not isInvisible
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            if isInvisible then if v.Name ~= "HumanoidRootPart" then v.Transparency = 1 end
            else if v.Name ~= "HumanoidRootPart" then v.Transparency = 0 end end
        end
    end
    InvisBtn.Text = isInvisible and "✨ STATUS: INVISIBLE" or "👻 CLICK TO GO INVISIBLE"
    InvisBtn.BackgroundColor3 = isInvisible and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(110, 0, 180)
end)

local selectedPlayerName = ""
local isSpectating = false
_G.PvpBehind = false

local PvpDropdownButton = Instance.new("TextButton")
local RefreshButton = Instance.new("TextButton")

PvpDropdownButton.Parent = PvpPage
PvpDropdownButton.BackgroundColor3 = Color3.fromRGB(35, 40, 50)
PvpDropdownButton.Position = UDim2.new(0.05, 0, 0.28, 0)
PvpDropdownButton.Size = UDim2.new(0, 205, 0, 32)
PvpDropdownButton.Font = Enum.Font.GothamBold
PvpDropdownButton.Text = "👤 ရန်သူရွေးရန် ▼"
PvpDropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PvpDropdownButton.TextSize = 10
local PDB_C = Instance.new("UICorner") PDB_C.Parent = PvpDropdownButton

RefreshButton.Parent = PvpPage
RefreshButton.BackgroundColor3 = Color3.fromRGB(30, 45, 35)
RefreshButton.Position = UDim2.new(0.74, 0, 0.28, 0)
RefreshButton.Size = UDim2.new(0, 75, 0, 32)
RefreshButton.Font = Enum.Font.GothamBold
RefreshButton.Text = "🔄 အသစ်"
RefreshButton.TextColor3 = Color3.fromRGB(0, 255, 130)
RefreshButton.TextSize = 10
local RB_C = Instance.new("UICorner") RB_C.Parent = RefreshButton

PvpDropdownScroll.Parent = ScreenGui
PvpDropdownScroll.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
PvpDropdownScroll.Size = UDim2.new(0, 285, 0, 80)
PvpDropdownScroll.Visible = false
local PDS_C = Instance.new("UICorner") PDS_C.Parent = PvpDropdownScroll
local PDS_S = Instance.new("UIStroke") PDS_S.Color = Color3.fromRGB(0, 170, 255) PDS_S.Parent = PvpDropdownScroll

local function updatePvpScrollPos()
    PvpDropdownScroll.Position = UDim2.new(0, PvpDropdownButton.AbsolutePosition.X, 0, PvpDropdownButton.AbsolutePosition.Y + PvpDropdownButton.AbsoluteSize.Y + 5)
end

local function updatePlayerDropdown()
    for _, child in pairs(PvpDropdownScroll:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    local count = 0
    for _, p in pairs(players:GetPlayers()) do
        if p ~= player then
            count = count + 1
            local P_Btn = Instance.new("TextButton")
            P_Btn.Size = UDim2.new(1, -6, 0, 25)
            P_Btn.Position = UDim2.new(0, 3, 0, (count-1)*28)
            P_Btn.BackgroundColor3 = Color3.fromRGB(40, 45, 55)
            P_Btn.Font = Enum.Font.GothamBold
            P_Btn.Text = p.DisplayName .. " (@" .. p.Name .. ")"
            P_Btn.TextColor3 = Color3.fromRGB(230, 230, 230)
            P_Btn.TextSize = 10
            P_Btn.Parent = PvpDropdownScroll
            local p_c = Instance.new("UICorner") p_c.Parent = P_Btn
            
            P_Btn.MouseButton1Click:Connect(function()
                selectedPlayerName = p.Name
                PvpDropdownButton.Text = "🎯 Target: " .. p.DisplayName
                PvpDropdownScroll.Visible = false
            end)
        end
    end
    PvpDropdownScroll.CanvasSize = UDim2.new(0, 0, 0, count * 29)
end

PvpDropdownButton.MouseButton1Click:Connect(function() updatePvpScrollPos(); PvpDropdownScroll.Visible = not PvpDropdownScroll.Visible; if PvpDropdownScroll.Visible then updatePlayerDropdown() end end)
RefreshButton.MouseButton1Click:Connect(function() updatePvpScrollPos(); updatePlayerDropdown(); PvpDropdownScroll.Visible = true end)

local TrackBtn = Instance.new("TextButton")
TrackBtn.Parent = PvpPage
TrackBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 25)
TrackBtn.Position = UDim2.new(0.05, 0, 0.52, 0)
TrackBtn.Size = UDim2.new(0, 285, 0, 32)
TrackBtn.Font = Enum.Font.GothamBold
TrackBtn.Text = "⚔️ AUTO BEHIND PVP: OFF"
TrackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TrackBtn.TextSize = 10
local TB_Corner = Instance.new("UICorner") TB_Corner.Parent = TrackBtn

TrackBtn.MouseButton1Click:Connect(function()
    if selectedPlayerName == "" then PvpDropdownButton.Text = "⚠️ လူရွေးပါဦး!" return end
    _G.PvpBehind = not _G.PvpBehind
    TrackBtn.Text = _G.PvpBehind and "🟢 TRACKING TARGET..." or "⚔️ AUTO BEHIND PVP: OFF"
    TrackBtn.BackgroundColor3 = _G.PvpBehind and Color3.fromRGB(0, 150, 70) or Color3.fromRGB(40, 25, 25)
end)

local SpecBtn = Instance.new("TextButton")
SpecBtn.Parent = PvpPage
SpecBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
SpecBtn.Position = UDim2.new(0.05, 0, 0.76, 0)
SpecBtn.Size = UDim2.new(0, 285, 0, 32)
SpecBtn.Font = Enum.Font.GothamBold
SpecBtn.Text = "👁️ ကြည့်ရှုသည်: OFF"
SpecBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpecBtn.TextSize = 10
local SB_Corner = Instance.new("UICorner") SB_Corner.Parent = SpecBtn

SpecBtn.MouseButton1Click:Connect(function()
    if selectedPlayerName == "" then PvpDropdownButton.Text = "⚠️ လူရွေးပါဦး!" return end
    isSpectating = not isSpectating
    SpecBtn.Text = isSpectating and "👁️ ကြည့်ရှုသည်: ON" or "👁️ ကြည့်ရှုသည်: OFF"
    SpecBtn.BackgroundColor3 = isSpectating and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(45, 45, 50)
    if not isSpectating then camera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid") end
end)

----------------------------------------------------
-- [ FARM CONTENT SETUP (FIXED POSITION) ] --
----------------------------------------------------
local Spacer = Instance.new("Frame") Spacer.Size = UDim2.new(1, 0, 0, 2) Spacer.BackgroundTransparency = 1 Spacer.Parent = FarmPage

local FarmTitle = Instance.new("TextLabel")
FarmTitle.Parent = FarmPage
FarmTitle.BackgroundTransparency = 1
FarmTitle.Size = UDim2.new(0, 285, 0, 20)
FarmTitle.Font = Enum.Font.GothamBold
FarmTitle.Text = "🪓 AUTO MASTERY & ALL SEAS CHEST"
FarmTitle.TextColor3 = Color3.fromRGB(255, 200, 0)
FarmTitle.TextSize = 11

local FarmDropdownButton = Instance.new("TextButton")
FarmDropdownButton.Parent = FarmPage
FarmDropdownButton.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
FarmDropdownButton.Size = UDim2.new(0, 285, 0, 35)
FarmDropdownButton.Font = Enum.Font.GothamBold
FarmDropdownButton.Text = "📥 လက်နက်အမျိုးအစားရွေးရန် ▼"
FarmDropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmDropdownButton.TextSize = 10
local FDB_Corner = Instance.new("UICorner") FDB_Corner.Parent = FarmDropdownButton

FarmDropdownScroll.Parent = ScreenGui
FarmDropdownScroll.BackgroundColor3 = Color3.fromRGB(22, 26, 35)
FarmDropdownScroll.Size = UDim2.new(0, 285, 0, 100)
FarmDropdownScroll.Visible = false
local FDS_Corner = Instance.new("UICorner") FDS_Corner.Parent = FarmDropdownScroll
local FDS_Stroke = Instance.new("UIStroke") FDS_Stroke.Color = Color3.fromRGB(255, 200, 0) FDS_Stroke.Parent = FarmDropdownScroll

local function updateFarmScrollPos()
    FarmDropdownScroll.Position = UDim2.new(0, FarmDropdownButton.AbsolutePosition.X, 0, FarmDropdownButton.AbsolutePosition.Y + FarmDropdownButton.AbsoluteSize.Y + 5)
end

local weapons = {"Fruit 🥭", "Sword 🗡", "Melee 👊🏻", "Gun 🔫"}
local selectedWeapon = ""

for count, weaponName in pairs(weapons) do
    local W_Btn = Instance.new("TextButton")
    W_Btn.Size = UDim2.new(1, -6, 0, 24)
    W_Btn.Position = UDim2.new(0, 3, 0, (count-1)*26)
    W_Btn.BackgroundColor3 = Color3.fromRGB(35, 40, 50)
    W_Btn.Font = Enum.Font.GothamBold
    W_Btn.Text = weaponName
    W_Btn.TextColor3 = Color3.fromRGB(235, 235, 235)
    W_Btn.TextSize = 10
    W_Btn.Parent = FarmDropdownScroll
    local wc = Instance.new("UICorner") wc.Parent = W_Btn
    
    W_Btn.MouseButton1Click:Connect(function()
        selectedWeapon = weaponName
        FarmDropdownButton.Text = "🎯 လက်နက်: " .. weaponName
        FarmDropdownScroll.Visible = false
    end)
end

FarmDropdownButton.MouseButton1Click:Connect(function() updateFarmScrollPos(); FarmDropdownScroll.Visible = not FarmDropdownScroll.Visible end)

_G.LevelFarmActive = false
local LevelFarmBtn = Instance.new("TextButton")
LevelFarmBtn.Parent = FarmPage
LevelFarmBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 40)
LevelFarmBtn.Size = UDim2.new(0, 285, 0, 36)
LevelFarmBtn.Font = Enum.Font.GothamBold
LevelFarmBtn.Text = "🚜 LEVEL FARM: OFF"
LevelFarmBtn.TextColor3 = Color3.fromRGB(160, 160, 160)
LevelFarmBtn.TextSize = 10
local LFB_Corner = Instance.new("UICorner") LFB_Corner.Parent = LevelFarmBtn
local LFB_Stroke = Instance.new("UIStroke") LFB_Stroke.Thickness = 1 LFB_Stroke.Color = Color3.fromRGB(50, 55, 65) LFB_Stroke.Parent = LevelFarmBtn

_G.NearestAttackActive = false
local NearestAttackBtn = Instance.new("TextButton")
NearestAttackBtn.Parent = FarmPage
NearestAttackBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 40)
NearestAttackBtn.Size = UDim2.new(0, 285, 0, 36)
NearestAttackBtn.Font = Enum.Font.GothamBold
NearestAttackBtn.Text = "🎯 NEAREST ATTACK: OFF"
NearestAttackBtn.TextColor3 = Color3.fromRGB(160, 160, 160)
NearestAttackBtn.TextSize = 10
local NAB_Corner = Instance.new("UICorner") NAB_Corner.Parent = NearestAttackBtn
local NAB_Stroke = Instance.new("UIStroke") NAB_Stroke.Thickness = 1 NAB_Stroke.Color = Color3.fromRGB(50, 55, 65) NAB_Stroke.Parent = NearestAttackBtn

_G.AutoChestActive = false
local ChestFarmBtn = Instance.new("TextButton")
ChestFarmBtn.Parent = FarmPage
ChestFarmBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 40)
ChestFarmBtn.Size = UDim2.new(0, 285, 0, 36)
ChestFarmBtn.Font = Enum.Font.GothamBold
ChestFarmBtn.Text = "💰 AUTO CHEST FARM: OFF"
ChestFarmBtn.TextColor3 = Color3.fromRGB(160, 160, 160)
ChestFarmBtn.TextSize = 10
local CFB_Corner = Instance.new("UICorner") CFB_Corner.Parent = ChestFarmBtn
local CFB_Stroke = Instance.new("UIStroke") CFB_Stroke.Thickness = 1 CFB_Stroke.Color = Color3.fromRGB(50, 55, 65) CFB_Stroke.Parent = ChestFarmBtn

LevelFarmBtn.MouseButton1Click:Connect(function()
    if selectedWeapon == "" then FarmDropdownButton.Text = "⚠️ လက်နက်ရွေးပါဦး!" return end
    _G.LevelFarmActive = not _G.LevelFarmActive
    LevelFarmBtn.Text = _G.LevelFarmActive and "🚜 LEVEL FARMING..." or "🚜 LEVEL FARM: OFF"
    LevelFarmBtn.TextColor3 = _G.LevelFarmActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 160)
    LevelFarmBtn.BackgroundColor3 = _G.LevelFarmActive and Color3.fromRGB(0, 120, 180) or Color3.fromRGB(28, 32, 40)
    LFB_Stroke.Color = _G.LevelFarmActive and Color3.fromRGB(0, 180, 255) or Color3.fromRGB(50, 55, 65)
    if _G.LevelFarmActive then 
        _G.NearestAttackActive = false; NearestAttackBtn.Text = "🎯 NEAREST ATTACK: OFF"; NearestAttackBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 40); NAB_Stroke.Color = Color3.fromRGB(50, 55, 65)
        _G.AutoChestActive = false; ChestFarmBtn.Text = "💰 AUTO CHEST FARM: OFF"; ChestFarmBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 40); CFB_Stroke.Color = Color3.fromRGB(50, 55, 65)
    end
end)

NearestAttackBtn.MouseButton1Click:Connect(function()
    if selectedWeapon == "" then FarmDropdownButton.Text = "⚠️ လက်နက်ရွေးပါဦး!" return end
    _G.NearestAttackActive = not _G.NearestAttackActive
    NearestAttackBtn.Text = _G.NearestAttackActive and "🎯 NEAREST ATTACKING..." or "🎯 NEAREST ATTACK: OFF"
    NearestAttackBtn.TextColor3 = _G.NearestAttackActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 160)
    NearestAttackBtn.BackgroundColor3 = _G.NearestAttackActive and Color3.fromRGB(150, 70, 0) or Color3.fromRGB(28, 32, 40)
    NAB_Stroke.Color = _G.NearestAttackActive and Color3.fromRGB(255, 130, 0) or Color3.fromRGB(50, 55, 65)
    if _G.NearestAttackActive then 
        _G.LevelFarmActive = false; LevelFarmBtn.Text = "🚜 LEVEL FARM: OFF"; LevelFarmBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 40); LFB_Stroke.Color = Color3.fromRGB(50, 55, 65)
        _G.AutoChestActive = false; ChestFarmBtn.Text = "💰 AUTO CHEST FARM: OFF"; ChestFarmBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 40); CFB_Stroke.Color = Color3.fromRGB(50, 55, 65)
    end
end)

ChestFarmBtn.MouseButton1Click:Connect(function()
    _G.AutoChestActive = not _G.AutoChestActive
    ChestFarmBtn.Text = _G.AutoChestActive and "💰 COLLECTING CHESTS..." or "💰 AUTO CHEST FARM: OFF"
    ChestFarmBtn.TextColor3 = _G.AutoChestActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 160)
    ChestFarmBtn.BackgroundColor3 = _G.AutoChestActive and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(28, 32, 40)
    CFB_Stroke.Color = _G.AutoChestActive and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(50, 55, 65)
    if _G.AutoChestActive then
        _G.LevelFarmActive = false; LevelFarmBtn.Text = "🚜 LEVEL FARM: OFF"; LevelFarmBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 40); LFB_Stroke.Color = Color3.fromRGB(50, 55, 65)
        _G.NearestAttackActive = false; NearestAttackBtn.Text = "🎯 NEAREST ATTACK: OFF"; NearestAttackBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 40); NAB_Stroke.Color = Color3.fromRGB(50, 55, 65)
    end
end)

----------------------------------------------------
-- [ AUTOMATION LOOPS CORE ] --
----------------------------------------------------
task.spawn(function()
    while true do
        task.wait(0.01)
        if _G.PvpBehind and selectedPlayerName ~= "" then
            pcall(function()
                local targetPlayer = players:FindFirstChild(selectedPlayerName)
                local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if myRoot and targetPlayer and targetPlayer.Character then
                    local enemyRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if enemyRoot then myRoot.CFrame = enemyRoot.CFrame * CFrame.new(0, 0, 7) end
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if isSpectating and selectedPlayerName ~= "" then
            pcall(function()
                local targetPlayer = players:FindFirstChild(selectedPlayerName)
                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    camera.CameraSubject = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
                else camera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid") end
            end)
        end
    end
end)

local function getNearestEnemy()
    local nearest = nil; local maxDist = math.huge
    local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local folder = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("NPCs") or workspace
    for _, v in pairs(folder:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            if v.Name ~= player.Name then
                local dist = (myRoot.Position - v.HumanoidRootPart.Position).Magnitude
                if dist < maxDist then nearest = v; maxDist = dist end
            end
        end
    end
    return nearest
end

local function getNearestChest()
    local nearestChest = nil; local maxDist = math.huge
    local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name:find("Chest") or v.Name:lower():find("chest")) then
            local dist = (myRoot.Position - v.Position).Magnitude
            if dist < maxDist then nearestChest = v; maxDist = dist end
        end
    end
    return nearestChest
end

task.spawn(function()
    while true do
        task.wait(0.01)
        pcall(function()
            local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if myRoot then
                if _G.LevelFarmActive or _G.NearestAttackActive then
                    local targetNPC = getNearestEnemy()
                    if targetNPC and targetNPC:FindFirstChild("HumanoidRootPart") then
                        myRoot.CFrame = targetNPC.HumanoidRootPart.CFrame * CFrame.new(0, 4, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                        myRoot.Velocity = Vector3.new(0,0,0); myRoot.RotVelocity = Vector3.new(0,0,0)
                    end
                elseif _G.AutoChestActive then
                    local targetChest = getNearestChest()
                    if targetChest then
                        myRoot.CFrame = targetChest.CFrame * CFrame.new(0, 1.5, 0)
                        myRoot.Velocity = Vector3.new(0,0,0); myRoot.RotVelocity = Vector3.new(0,0,0)
                    end
                end
            end
        end)
    end
end)

----------------------------------------------------
-- [ 🌟 SANJI TOGGLE BUTTON (FIXED BUG) ] --
----------------------------------------------------
local MenuToggleButton = Instance.new("ImageButton")
MenuToggleButton.Name = "SanjiToggleButton"
MenuToggleButton.Parent = ScreenGui
MenuToggleButton.BackgroundColor3 = Color3.fromRGB(15, 17, 23) -- အနက်ရောင်နောက်ခံထည့်ထားလို့ ပုံမပွင့်ရင်တောင် ခလုတ်ဝိုင်းကို မြင်ရမယ်
MenuToggleButton.Position = UDim2.new(0.5, -30, 0, 5) -- မျက်နှာပြင်ရဲ့ အပေါ် အလယ်တည့်တည့်မှာ ထားပေးထားပါတယ်
MenuToggleButton.Size = UDim2.new(0, 60, 0, 60)
MenuToggleButton.Image = "rbxassetid://18820067645"
MenuToggleButton.ZIndex = 10

local ButtonCorner = Instance.new("UICorner") ButtonCorner.CornerRadius = UDim.new(0, 30) ButtonCorner.Parent = MenuToggleButton
local ButtonStroke = Instance.new("UIStroke") ButtonStroke.Thickness = 2 ButtonStroke.Color = Color3.fromRGB(0, 170, 255) ButtonStroke.Parent = MenuToggleButton

local MenuVisible = true
MenuToggleButton.MouseButton1Click:Connect(function()
    MenuVisible = not MenuVisible
    MainFrame.Visible = MenuVisible
    if not MenuVisible then PvpDropdownScroll.Visible = false; FarmDropdownScroll.Visible = false end
end)
