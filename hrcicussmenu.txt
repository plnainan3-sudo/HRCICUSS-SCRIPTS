-- HRCICUSS SCRIPTS - MOD MENU MÓVIL 100% FUNCIONAL
-- Compatible con Delta Mobile - Squid Game Edition v3.0

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Variables
local MenuOpen = false
local CurrentSection = "General"
local SpeedValue = 16
local SpeedEnabled = false

local Hacks = {
    -- General
    Jump = false,
    Noclip = false,
    Fly = false,
    ESP = false,
    Fullbright = false,
    GodMode = false,
    Invisible = false,
    -- Squid Game
    RedLightTP = false,
    DalgonaAuto = false,
    MingleAuto = false,
    HideSeekESP = false,
    TugOfWarHack = false,
    GlassBridgeESP = false,
    RebelGuardESP = false,
    AutoKillGuards = false,
    AntiPush = false,
    PhantomPower = false,
    DashPower = false
}

-- Crear ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HRCICUSSMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Botón de apertura
local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 100, 0, 45)
OpenButton.Position = UDim2.new(0, 10, 0, 10)
OpenButton.Text = "HRCICUSS"
OpenButton.TextScaled = true
OpenButton.Font = Enum.Font.GothamBold
OpenButton.TextColor3 = Color3.new(1, 1, 1)
OpenButton.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
OpenButton.BorderSizePixel = 0
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 12)
OpenCorner.Parent = OpenButton

-- Marco principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(138, 43, 226)
MainStroke.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 0, 35)
Title.Position = UDim2.new(0, 15, 0, 5)
Title.Text = "HRCICUSS SCRIPTS"
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -50, 0, 20)
Subtitle.Position = UDim2.new(0, 15, 0, 35)
Subtitle.Text = "Squid Game Mobile v3.0"
Subtitle.TextScaled = true
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextColor3 = Color3.fromRGB(200, 200, 255)
Subtitle.BackgroundTransparency = 1
Subtitle.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0, 10)
CloseButton.Text = "X"
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseButton

-- Navegación
local NavFrame = Instance.new("Frame")
NavFrame.Size = UDim2.new(1, -10, 0, 40)
NavFrame.Position = UDim2.new(0, 5, 0, 70)
NavFrame.BackgroundTransparency = 1
NavFrame.Parent = MainFrame

local NavLayout = Instance.new("UIListLayout")
NavLayout.FillDirection = Enum.FillDirection.Horizontal
NavLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
NavLayout.Padding = UDim.new(0, 3)
NavLayout.Parent = NavFrame

local Sections = {"General", "Teleport", "Games", "Powers"}
local SectionButtons = {}
local ContentFrames = {}

-- Crear navegación
for i, sectionName in ipairs(Sections) do
    local navButton = Instance.new("TextButton")
    navButton.Size = UDim2.new(0, 75, 0, 30)
    navButton.Text = sectionName
    navButton.Font = Enum.Font.Gotham
    navButton.TextSize = 12
    navButton.TextColor3 = Color3.new(1, 1, 1)
    navButton.BackgroundColor3 = (i == 1) and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(50, 50, 60)
    navButton.BorderSizePixel = 0
    navButton.Parent = NavFrame
    
    local navCorner = Instance.new("UICorner")
    navCorner.CornerRadius = UDim.new(0, 6)
    navCorner.Parent = navButton
    
    SectionButtons[sectionName] = navButton
    
    -- Frame de contenido
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Size = UDim2.new(1, -10, 1, -120)
    contentFrame.Position = UDim2.new(0, 5, 0, 115)
    contentFrame.BackgroundTransparency = 1
    contentFrame.BorderSizePixel = 0
    contentFrame.ScrollBarThickness = 6
    contentFrame.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
    contentFrame.Visible = (sectionName == CurrentSection)
    contentFrame.Parent = MainFrame
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 5)
    contentLayout.Parent = contentFrame
    
    ContentFrames[sectionName] = contentFrame
    
    -- Evento de navegación
    navButton.MouseButton1Click:Connect(function()
        CurrentSection = sectionName
        for name, btn in pairs(SectionButtons) do
            btn.BackgroundColor3 = (name == sectionName) and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(50, 50, 60)
        end
        for name, frame in pairs(ContentFrames) do
            frame.Visible = (name == sectionName)
        end
    end)
end

-- Función para crear switch
local function CreateSwitch(parent, name, hackName, callback, description, isBeta)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 55)
    Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 8)
    FrameCorner.Parent = Frame
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -70, 0, 25)
    NameLabel.Position = UDim2.new(0, 10, 0, 5)
    NameLabel.Text = name .. (isBeta and " (BETA)" or "")
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 14
    NameLabel.TextColor3 = isBeta and Color3.fromRGB(255, 200, 100) or Color3.new(1, 1, 1)
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.BackgroundTransparency = 1
    NameLabel.Parent = Frame
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -70, 0, 20)
    DescLabel.Position = UDim2.new(0, 10, 0, 30)
    DescLabel.Text = description
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextSize = 10
    DescLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.BackgroundTransparency = 1
    DescLabel.Parent = Frame
    
    -- Switch
    local SwitchBack = Instance.new("Frame")
    SwitchBack.Size = UDim2.new(0, 50, 0, 25)
    SwitchBack.Position = UDim2.new(1, -55, 0, 15)
    SwitchBack.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    SwitchBack.BorderSizePixel = 0
    SwitchBack.Parent = Frame
    
    local SwitchBackCorner = Instance.new("UICorner")
    SwitchBackCorner.CornerRadius = UDim.new(1, 0)
    SwitchBackCorner.Parent = SwitchBack
    
    local SwitchButton = Instance.new("TextButton")
    SwitchButton.Size = UDim2.new(0, 21, 0, 21)
    SwitchButton.Position = UDim2.new(0, 2, 0, 2)
    SwitchButton.Text = ""
    SwitchButton.BackgroundColor3 = Color3.new(1, 1, 1)
    SwitchButton.BorderSizePixel = 0
    SwitchButton.Parent = SwitchBack
    
    local SwitchButtonCorner = Instance.new("UICorner")
    SwitchButtonCorner.CornerRadius = UDim.new(1, 0)
    SwitchButtonCorner.Parent = SwitchButton
    
    local isOn = false
    
    SwitchButton.MouseButton1Click:Connect(function()
        isOn = not isOn
        if hackName then
            Hacks[hackName] = isOn
        end
        
        -- Animar switch
        local newPos = isOn and UDim2.new(0, 27, 0, 2) or UDim2.new(0, 2, 0, 2)
        local newColor = isOn and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(60, 60, 70)
        
        SwitchButton:TweenPosition(newPos, "Out", "Quad", 0.2, true)
        
        local tween = TweenService:Create(SwitchBack, TweenInfo.new(0.2), {BackgroundColor3 = newColor})
        tween:Play()
        
        callback(isOn)
    end)
    
    return Frame
end

-- Función para crear slider
local function CreateSlider(parent, name, minVal, maxVal, defaultVal, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 70)
    Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 8)
    FrameCorner.Parent = Frame
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, 0, 0, 20)
    NameLabel.Position = UDim2.new(0, 10, 0, 5)
    NameLabel.Text = name .. ": " .. defaultVal
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 14
    NameLabel.TextColor3 = Color3.new(1, 1, 1)
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.BackgroundTransparency = 1
    NameLabel.Parent = Frame
    
    local SliderBack = Instance.new("Frame")
    SliderBack.Size = UDim2.new(1, -20, 0, 6)
    SliderBack.Position = UDim2.new(0, 10, 0, 30)
    SliderBack.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    SliderBack.BorderSizePixel = 0
    SliderBack.Parent = Frame
    
    local SliderBackCorner = Instance.new("UICorner")
    SliderBackCorner.CornerRadius = UDim.new(1, 0)
    SliderBackCorner.Parent = SliderBack
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new(0, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBack
    
    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(1, 0)
    SliderFillCorner.Parent = SliderFill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(0, 16, 0, 16)
    SliderButton.Position = UDim2.new(0, -8, 0, -5)
    SliderButton.Text = ""
    SliderButton.BackgroundColor3 = Color3.new(1, 1, 1)
    SliderButton.BorderSizePixel = 0
    SliderButton.Parent = SliderBack
    
    local SliderButtonCorner = Instance.new("UICorner")
    SliderButtonCorner.CornerRadius = UDim.new(1, 0)
    SliderButtonCorner.Parent = SliderButton
    
    -- Botón de reset
    local ResetButton = Instance.new("TextButton")
    ResetButton.Size = UDim2.new(0, 80, 0, 20)
    ResetButton.Position = UDim2.new(1, -85, 0, 45)
    ResetButton.Text = "Reset Speed"
    ResetButton.Font = Enum.Font.Gotham
    ResetButton.TextSize = 10
    ResetButton.TextColor3 = Color3.new(1, 1, 1)
    ResetButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    ResetButton.BorderSizePixel = 0
    ResetButton.Parent = Frame
    
    local ResetCorner = Instance.new("UICorner")
    ResetCorner.CornerRadius = UDim.new(0, 4)
    ResetCorner.Parent = ResetButton
    
    local currentValue = defaultVal
    local dragging = false
    
    local function updateSlider(value)
        currentValue = math.floor(value)
        NameLabel.Text = name .. ": " .. currentValue
        local percentage = (currentValue - minVal) / (maxVal - minVal)
        SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        SliderButton.Position = UDim2.new(percentage, -8, 0, -5)
        callback(currentValue)
    end
    
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = input.Position.X
            local sliderPos = SliderBack.AbsolutePosition.X
            local sliderSize = SliderBack.AbsoluteSize.X
            local percentage = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
            local value = minVal + (percentage * (maxVal - minVal))
            updateSlider(value)
        end
    end)
    
    ResetButton.MouseButton1Click:Connect(function()
        SpeedEnabled = false
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
        updateSlider(16)
    end)
    
    updateSlider(defaultVal)
    return Frame
end

-- Función para crear botón normal
local function CreateButton(parent, name, callback, description)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 8)
    FrameCorner.Parent = Frame
    
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 1, -5)
    Button.Position = UDim2.new(0, 5, 0, 2.5)
    Button.Text = name
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 14
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    Button.BorderSizePixel = 0
    Button.Parent = Frame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    
    return Frame
end

-- SECCIÓN GENERAL
CreateSlider(ContentFrames["General"], "Speed", 16, 200, 16, function(value)
    SpeedValue = value
    SpeedEnabled = true
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

CreateSwitch(ContentFrames["General"], "Super Jump", "Jump", function(enabled)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = enabled and 120 or 50
    end
end, "Salta más alto")

CreateSwitch(ContentFrames["General"], "Noclip", "Noclip", function(enabled)
    if enabled then
        spawn(function()
            while Hacks.Noclip do
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                end
                wait(0.1)
            end
        end)
    end
end, "Atraviesa paredes")

CreateSwitch(ContentFrames["General"], "God Mode", "GodMode", function(enabled)
    if enabled then
        spawn(function()
            while Hacks.GodMode do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
                end
                wait(0.1)
            end
        end)
    end
end, "Vida infinita", true)

CreateSwitch(ContentFrames["General"], "ESP Players", "ESP", function(enabled)
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "PlayerESP"
                highlight.Adornee = player.Character
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.7
                highlight.Parent = player.Character
            end
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("PlayerESP") then
                player.Character.PlayerESP:Destroy()
            end
        end
    end
end, "Ver jugadores resaltados")

-- SECCIÓN TELEPORT
CreateButton(ContentFrames["Teleport"], "TP +50 Blocks Up", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local pos = LocalPlayer.Character.HumanoidRootPart.Position
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y + 50, pos.Z)
    end
end, "Teletransportarse 50 bloques arriba")

CreateButton(ContentFrames["Teleport"], "TP +100 Blocks Up", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local pos = LocalPlayer.Character.HumanoidRootPart.Position
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y + 100, pos.Z)
    end
end, "Teletransportarse 100 bloques arriba")

-- SECCIÓN GAMES
CreateSwitch(ContentFrames["Games"], "Red Light Auto Win", "RedLightTP", function(enabled)
    if enabled then
        spawn(function()
            wait(1)
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, -200)
            end
        end)
    end
end, "Victoria automática en Red Light", true)

CreateSwitch(ContentFrames["Games"], "Dalgona Auto Complete", "DalgonaAuto", function(enabled)
    if enabled then
        spawn(function()
            while Hacks.DalgonaAuto do
                for _, remote in pairs(game:GetDescendants()) do
                    if remote:IsA("RemoteEvent") and (remote.Name:lower():find("dalgona") or remote.Name:lower():find("honeycomb")) then
                        remote:FireServer("complete")
                    end
                end
                wait(2)
            end
        end)
    end
end, "Completa automáticamente Dalgona", true)

CreateSwitch(ContentFrames["Games"], "Mingle Auto Choke", "MingleAuto", function(enabled)
    if enabled then
        spawn(function()
            while Hacks.MingleAuto do
                -- Buscar botones de Mingle y presionarlos
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("ClickDetector") or (obj:IsA("Part") and obj.Name:lower():find("button")) then
                        if obj:IsA("ClickDetector") then
                            fireclickdetector(obj)
                        elseif obj:FindFirstChild("ClickDetector") then
                            fireclickdetector(obj.ClickDetector)
                        end
                    end
                end
                wait(0.5)
            end
        end)
    end
end, "Presiona automáticamente todos los botones", true)

CreateSwitch(ContentFrames["Games"], "Hide & Seek ESP", "HideSeekESP", function(enabled)
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "RoleESP"
                highlight.Adornee = player.Character
                
                if player.Team then
                    if player.Team.Name:lower():find("hide") then
                        highlight.FillColor = Color3.fromRGB(0, 0, 255)
                    elseif player.Team.Name:lower():find("seek") then
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    else
                        highlight.FillColor = Color3.fromRGB(255, 255, 0)
                    end
                else
                    highlight.FillColor = Color3.fromRGB(255, 255, 0)
                end
                
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.Parent = player.Character
            end
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("RoleESP") then
                player.Character.RoleESP:Destroy()
            end
        end
    end
end, "Azul=Hiders, Rojo=Seekers")

CreateSwitch(ContentFrames["Games"], "Glass Bridge ESP", "GlassBridgeESP", function(enabled)
    if enabled then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name:lower():find("glass") then
                local highlight = Instance.new("Highlight")
                highlight.Name = "GlassESP"
                highlight.Adornee = obj
                highlight.FillColor = obj.CanCollide and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.3
                highlight.Parent = obj
            end
        end
    else
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:FindFirstChild("GlassESP") then
                obj.GlassESP:Destroy()
            end
        end
    end
end, "Verde=Seguro, Rojo=Falso", true)

-- SECCIÓN POWERS
CreateButton(ContentFrames["Powers"], "Free Phantom Power", function()
    for _, remote in pairs(game:GetDescendants()) do
        if remote:IsA("RemoteEvent") and remote.Name:lower():find("phantom") then
            remote:FireServer("unlock")
        end
    end
end, "Desbloquear poder Phantom gratis")

CreateButton(ContentFrames["Powers"], "Free Dash Power", function()
    for _, remote in pairs(game:GetDescendants()) do
        if remote:IsA("RemoteEvent") and remote.Name:lower():find("dash") then
            remote:FireServer("unlock")
        end
    end
end, "Desbloquear poder Dash gratis")

-- Actualizar canvas size
local function updateCanvasSize()
    for _, frame in pairs(ContentFrames) do
        local layout = frame:FindFirstChild("UIListLayout")
        if layout then
            frame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
        end
    end
end

for _, frame in pairs(ContentFrames) do
    frame.ChildAdded:Connect(updateCanvasSize)
    frame.ChildRemoved:Connect(updateCanvasSize)
end
updateCanvasSize()

-- Eventos principales
OpenButton.MouseButton1Click:Connect(function()
    MenuOpen = not MenuOpen
    MainFrame.Visible = MenuOpen
end)

CloseButton.MouseButton1Click:Connect(function()
    MenuOpen = false
    MainFrame.Visible = false
end)

-- Auto aplicar speed al respawnear
LocalPlayer.CharacterAdded:Connect(function()
    wait(2)
    if SpeedEnabled and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = SpeedValue
    end
end)

-- Notificación
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🎮 HRCICUSS SCRIPTS";
    Text = "Mod Menu v3.0 cargado! Compatible con móvil.";
    Duration = 5;
})

print("✅ HRCICUSS MOD MENU v3.0 CARGADO")
print("📱 Compatible con Delta Mobile")
print("🎮 Funciones específicas para Squid Game")
print("💎 Controles con switches y sliders")
print("🔧 Toca 'HRCICUSS' para abrir el menú")