-- Servicios
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- Variables de estado
local Hacks = {}
local FlyEnabled, FlySpeedValue = false, 25
local SpeedEnabled, SpeedValue = false, 16
local MenuOpen, Minimized, Fullscreen = false, false, false
local CurrentSection = "Inicio"

-- Crear interfaz principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HRCICUSSMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(80, 80, 90)
MainStroke.Parent = MainFrame

-- Header estilo iOS
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 0, 30)
Title.Position = UDim2.new(0.5, -100, 0, 5)
Title.Text = "HRCICUSS SCRIPTS"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Parent = Header

-- Botones de control de ventana
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(0, 10, 0, 5)
MinimizeButton.Text = "－"
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Parent = Header

local FullscreenButton = Instance.new("TextButton")
FullscreenButton.Size = UDim2.new(0, 30, 0, 30)
FullscreenButton.Position = UDim2.new(1, -70, 0, 5)
FullscreenButton.Text = "□"
FullscreenButton.Font = Enum.Font.GothamBold
FullscreenButton.TextSize = 14
FullscreenButton.TextColor3 = Color3.new(1, 1, 1)
FullscreenButton.BackgroundTransparency = 1
FullscreenButton.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.BackgroundTransparency = 1
CloseButton.Parent = Header

-- Botón de apertura cuando está minimizado
local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 120, 0, 40)
OpenButton.Position = UDim2.new(0, 10, 0, 10)
OpenButton.Text = "Open HRCICUSS SCRIPTS"
OpenButton.Font = Enum.Font.GothamBold
OpenButton.TextSize = 12
OpenButton.TextColor3 = Color3.new(1, 1, 1)
OpenButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
OpenButton.BorderSizePixel = 0
OpenButton.Visible = false
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 8)
OpenCorner.Parent = OpenButton

-- Navegación por secciones
local NavFrame = Instance.new("Frame")
NavFrame.Size = UDim2.new(1, -10, 0, 40)
NavFrame.Position = UDim2.new(0, 5, 0, 45)
NavFrame.BackgroundTransparency = 1
NavFrame.Parent = MainFrame

local NavLayout = Instance.new("UIListLayout")
NavLayout.FillDirection = Enum.FillDirection.Horizontal
NavLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
NavLayout.Padding = UDim.new(0, 5)
NavLayout.Parent = NavFrame

local Sections = {"Inicio","RedLight","Dalgona","TugOfWar","HideSeek","GlassBridge","Mingle","Random","Rebel","Final","Sky"}
local SectionButtons, ContentFrames = {}, {}

for i, sectionName in ipairs(Sections) do
    local navButton = Instance.new("TextButton")
    navButton.Size = UDim2.new(0, 70, 0, 30)
    navButton.Text = sectionName
    navButton.Font = Enum.Font.GothamMedium
    navButton.TextSize = 12
    navButton.TextColor3 = Color3.new(1,1,1)
    navButton.BackgroundColor3 = (i==1) and Color3.fromRGB(65,105,225) or Color3.fromRGB(50,50,60)
    navButton.BorderSizePixel = 0
    navButton.Parent = NavFrame
    
    local navCorner = Instance.new("UICorner")
    navCorner.CornerRadius = UDim.new(0,6)
    navCorner.Parent = navButton
    
    SectionButtons[sectionName] = navButton
    
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Size = UDim2.new(1,-10,1,-120)
    contentFrame.Position = UDim2.new(0,5,0,90)
    contentFrame.BackgroundTransparency = 1
    contentFrame.BorderSizePixel = 0
    contentFrame.ScrollBarThickness = 6
    contentFrame.ScrollBarImageColor3 = Color3.fromRGB(65,105,225)
    contentFrame.Visible = (sectionName == CurrentSection)
    contentFrame.Parent = MainFrame
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0,8)
    contentLayout.Parent = contentFrame
    
    ContentFrames[sectionName] = contentFrame
    
    navButton.MouseButton1Click:Connect(function()
        CurrentSection = sectionName
        for name, btn in pairs(SectionButtons) do
            btn.BackgroundColor3 = (name==sectionName) and Color3.fromRGB(65,105,225) or Color3.fromRGB(50,50,60)
        end
        for name, frame in pairs(ContentFrames) do
            frame.Visible = (name==sectionName)
        end
    end)
end

-- Funciones de creación de controles (Switch, Slider, Button)
local function CreateSwitch(parent, name, hackName, callback, description, isBeta)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1,-10,0,55)
    Frame.BackgroundColor3 = Color3.fromRGB(35,35,45)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0,8)
    FrameCorner.Parent = Frame
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1,-70,0,25)
    NameLabel.Position = UDim2.new(0,10,0,5)
    NameLabel.Text = name .. (isBeta and " (BETA)" or "")
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 14
    NameLabel.TextColor3 = isBeta and Color3.fromRGB(255,200,100) or Color3.new(1,1,1)
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.BackgroundTransparency = 1
    NameLabel.Parent = Frame
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1,-70,0,20)
    DescLabel.Position = UDim2.new(0,10,0,30)
    DescLabel.Text = description or ""
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextSize = 10
    DescLabel.TextColor3 = Color3.fromRGB(180,180,190)
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.BackgroundTransparency = 1
    DescLabel.Parent = Frame
    
    local SwitchBack = Instance.new("Frame")
    SwitchBack.Size = UDim2.new(0,50,0,25)
    SwitchBack.Position = UDim2.new(1,-55,0,15)
    SwitchBack.BackgroundColor3 = Color3.fromRGB(60,60,70)
    SwitchBack.BorderSizePixel = 0
    SwitchBack.Parent = Frame
    
    local SwitchBackCorner = Instance.new("UICorner")
    SwitchBackCorner.CornerRadius = UDim.new(1,0)
    SwitchBackCorner.Parent = SwitchBack
    
    local SwitchButton = Instance.new("TextButton")
    SwitchButton.Size = UDim2.new(0,21,0,21)
