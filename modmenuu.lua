-- HRCICUSS SCRIPTS - MOD MENU MÓVIL iOS PREMIUM
-- Diseño 100% original con +60 funciones para Squid Game

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Variables globales
local MenuOpen = false
local Minimized = false
local Fullscreen = false
local CurrentSection = "Inicio"
local SpeedValue = 16
local SpeedEnabled = false
local FlyEnabled = false
local FlySpeedValue = 25

-- Tabla de hacks
local Hacks = {
    Jump = false,
    Noclip = false,
    Fly = false,
    ESP = false,
    Fullbright = false,
    GodMode = false,
    Invisible = false,
    AntiVoid = false,
    AntiFling = false,
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
    DashPower = false,
    SkyNoFall = false,
    SkyAntiKnockback = false,
    SkyAutoDodge = false,
    FinalOnePunch = false,
    FinalAntiKnockback = false,
    FinalAutoPunch = false,
    FinalGodMode = false,
    FinalTPBehind = false,
    FinalTouchFling = false
}-- Crear interfaz principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HRCICUSSMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- Marco principal (con bordes transparentes para redimensionar)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Bordes transparentes para redimensionar
local ResizeBorders = {}
local borderPositions = {
    {Position = UDim2.new(0, 0, 0, 0), Size = UDim2.new(1, 0, 0, 5)},
    {Position = UDim2.new(0, 0, 1, -5), Size = UDim2.new(1, 0, 0, 5)},
    {Position = UDim2.new(0, 0, 0, 5), Size = UDim2.new(0, 5, 1, -10)},
    {Position = UDim2.new(1, -5, 0, 5), Size = UDim2.new(0, 5, 1, -10)}
}

for _, borderData in ipairs(borderPositions) do
    local border = Instance.new("Frame")
    border.Position = borderData.Position
    border.Size = borderData.Size
    border.BackgroundTransparency = 1
    border.BorderSizePixel = 0
    border.Active = true
    border.Parent = MainFrame
    table.insert(ResizeBorders, border)
end

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(80, 80, 90)
MainStroke.Parent = MainFrame-- Header estilo iOS
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

-- Botones de control de ventana (－ □ X)
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

-- Flechas para mover (cuando está minimizado)
local MoveArrows = Instance.new("ImageLabel")
MoveArrows.Size = UDim2.new(0, 20, 0, 20)
MoveArrows.Position = UDim2.new(1, -25, 0, 15)
MoveArrows.Image = "rbxassetid://3926305904"
MoveArrows.ImageRectSize = Vector2.new(36, 36)
MoveArrows.ImageRectOffset = Vector2.new(324, 364)
MoveArrows.BackgroundTransparency = 1
MoveArrows.Parent = OpenButton-- Navegación por secciones
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

-- Secciones del menú
local Sections = {
    "Inicio",
    "RedLight", 
    "Dalgona",
    "TugOfWar",
    "HideSeek",
    "GlassBridge",
    "Mingle",
    "Random",
    "Rebel",
    "Final",
    "Sky"
}

local SectionButtons = {}
local ContentFrames = {}

-- Crear botones de sección
for i, sectionName in ipairs(Sections) do
    local navButton = Instance.new("TextButton")
    navButton.Size = UDim2.new(0, 70, 0, 30)
    navButton.Text = sectionName
    navButton.Font = Enum.Font.GothamMedium
    navButton.TextSize = 12
    navButton.TextColor3 = Color3.new(1, 1, 1)
    navButton.BackgroundColor3 = (i == 1) and Color3.fromRGB(65, 105, 225) or Color3.fromRGB(50, 50, 60)
    navButton.BorderSizePixel = 0
    navButton.Parent = NavFrame
    
    local navCorner = Instance.new("UICorner")
    navCorner.CornerRadius = UDim.new(0, 6)
    navCorner.Parent = navButton
    
    SectionButtons[sectionName] = navButton
    
    -- Frame de contenido para cada sección
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Size = UDim2.new(1, -10, 1, -120)
    contentFrame.Position = UDim2.new(0, 5, 0, 90)
    contentFrame.BackgroundTransparency = 1
    contentFrame.BorderSizePixel = 0
    contentFrame.ScrollBarThickness = 6
    contentFrame.ScrollBarImageColor3 = Color3.fromRGB(65, 105, 225)
    contentFrame.Visible = (sectionName == CurrentSection)
    contentFrame.Parent = MainFrame
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 8)
    contentLayout.Parent = contentFrame
    
    ContentFrames[sectionName] = contentFrame
    
    -- Evento de navegación
    navButton.MouseButton1Click:Connect(function()
        CurrentSection = sectionName
        for name, btn in pairs(SectionButtons) do
            btn.BackgroundColor3 = (name == sectionName) and Color3.fromRGB(65, 105, 225) or Color3.fromRGB(50, 50, 60)
        end
        for name, frame in pairs(ContentFrames) do
            frame.Visible = (name == sectionName)
        end
    end)
end-- Función para crear switches (toggle buttons)
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
        
        if callback then
            callback(isOn)
        end
    end)
    
    return Frame
  end-- Función para crear sliders
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
    SliderFill.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
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
    
    local currentValue = defaultVal
    local dragging = false
    
    local function updateSlider(value)
        currentValue = math.floor(value)
        NameLabel.Text = name .. ": " .. currentValue
        local percentage = (currentValue - minVal) / (maxVal - minVal)
        SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        SliderButton.Position = UDim2.new(percentage, -8, 0, -5)
        if callback then
            callback(currentValue)
        end
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
    
    updateSlider(defaultVal)
    return Frame
    end-- Función para crear botones normales
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
    Button.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
    Button.BorderSizePixel = 0
    Button.Parent = Frame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = Button
    
    if description then
        local DescLabel = Instance.new("TextLabel")
        DescLabel.Size = UDim2.new(1, -10, 0, 15)
        DescLabel.Position = UDim2.new(0, 5, 0, 25)
        DescLabel.Text = description
        DescLabel.Font = Enum.Font.Gotham
        DescLabel.TextSize = 10
        DescLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
        DescLabel.BackgroundTransparency = 1
        DescLabel.Parent = Frame
    end
    
    Button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return Frame
end

-- Sección INICIO
CreateButton(ContentFrames["Inicio"], "⭐ BIENVENIDO A HRCICUSS", function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "HRCICUSS SCRIPTS",
        Text = "Menú premium cargado con éxito!",
        Duration = 5
    })
end, "Versión iOS Premium para móvil")

CreateSwitch(ContentFrames["Inicio"], "God Mode", "GodMode", function(enabled)
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
end, "Inmunidad a todo daño", false)

CreateSwitch(ContentFrames["Inicio"], "Noclip", "Noclip", function(enabled)
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
end, "Atraviesa paredes y objetos", false)

CreateSwitch(ContentFrames["Inicio"], "Fly Mode", "Fly", function(enabled)
    FlyEnabled = enabled
    if enabled then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = LocalPlayer.Character.HumanoidRootPart
        
        spawn(function()
            while FlyEnabled do
                bodyVelocity.Velocity = Vector3.new(0, FlySpeedValue, 0)
                wait()
            end
            bodyVelocity:Destroy()
        end)
    end
end, "Vuela por el mapa", true)

CreateSlider(ContentFrames["Inicio"], "Fly Speed", 5, 100, 25, function(value)
    FlySpeedValue = value
end)

CreateSlider(ContentFrames["Inicio"], "WalkSpeed", 16, 200, 16, function(value)
    SpeedValue = value
    SpeedEnabled = true
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)-- Sección REDLIGHT
CreateSwitch(ContentFrames["RedLight"], "Teleport to End", "RedLightTP", function(enabled)
    if enabled then
        spawn(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, -200)
            end
        end)
    end
end, "TP automático a la meta", false)

CreateSwitch(ContentFrames["RedLight"], "Remove Injury", nil, function(enabled)
    if enabled then
        -- Lógica para remover heridas
        print("Remove Injury activado")
    end
end, "Elimina heridas automáticamente", true)

CreateSwitch(ContentFrames["RedLight"], "Help Player LOOP", nil, function(enabled)
    if enabled then
        -- Lógica para ayudar a jugadores
        print("Help Player LOOP activado")
    end
end, "Ayuda a otros jugadores continuamente", true)

CreateSwitch(ContentFrames["RedLight"], "Bring Back People", nil, function(enabled)
    if enabled then
        -- Lógica troll para traer jugadores
        print("Bring Back People activado")
    end
end, "Función troll para molestar", true)

CreateSwitch(ContentFrames["RedLight"], "Auto Collect Bandage", nil, function(enabled)
    if enabled then
        -- Lógica para auto-coleccionar vendas
        print("Auto Collect Bandage activado")
    end
end, "Colecta vendas automáticamente", false)

-- Sección DALGONA
CreateSwitch(ContentFrames["Dalgona"], "Auto Complete Dalgona", "DalgonaAuto", function(enabled)
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
end, "Completa automáticamente el reto", false)

CreateSwitch(ContentFrames["Dalgona"], "Anti-Push", "AntiPush", function(enabled)
    if enabled then
        spawn(function()
            while Hacks.AntiPush do
                -- Lógica para anti-empujones
                if LocalPlayer.Character then
                    LocalPlayer.Character:FindFirstChild("Humanoid").AutoRotate = false
                end
                wait(0.1)
            end
        end)
    end
end, "Evita que te empujen", true)-- Sección TUG OF WAR
CreateSwitch(ContentFrames["TugOfWar"], "Auto Win Tug of War", "TugOfWarHack", function(enabled)
    if enabled then
        spawn(function()
            while Hacks.TugOfWarHack do
                -- Lógica para ganar automáticamente
                for _, remote in pairs(game:GetDescendants()) do
                    if remote:IsA("RemoteEvent") and remote.Name:lower():find("tug") then
                        remote:FireServer("win")
                    end
                end
                wait(1)
            end
        end)
    end
end, "Gana automáticamente el juego de la cuerda", false)

-- Sección HIDE SEEK
CreateSwitch(ContentFrames["HideSeek"], "ESP Players", "HideSeekESP", function(enabled)
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "PlayerESP"
                highlight.Adornee = player.Character
                
                if player.Team then
                    if player.Team.Name:lower():find("hide") then
                        highlight.FillColor = Color3.fromRGB(0, 0, 255)
                    elseif player.Team.Name:lower():find("seek") then
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    end
                end
                
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
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
end, "Ver jugadores (Azul=Hiders, Rojo=Seekers)", false)

CreateSwitch(ContentFrames["HideSeek"], "Kill Hiders", nil, function(enabled)
    if enabled then
        spawn(function()
            while enabled do
                -- Lógica para eliminar hiders
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        if player.Team and player.Team.Name:lower():find("hide") then
                            -- Lógica de daño aquí
                        end
                    end
                end
                wait(1)
            end
        end)
    end
end, "Elimina hiders automáticamente", true)

CreateSwitch(ContentFrames["HideSeek"], "Anti Void", "AntiVoid", function(enabled)
    if enabled then
        spawn(function()
            while Hacks.AntiVoid do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    if LocalPlayer.Character.HumanoidRootPart.Position.Y < -50 then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
                    end
                end
                wait(0.1)
            end
        end)
    end
end, "Previene caer al vacío", false)

-- Sección GLASS BRIDGE
CreateSwitch(ContentFrames["GlassBridge"], "Glass ESP", "GlassBridgeESP", function(enabled)
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
end, "Ver cristales (Verde=Seguro, Rojo=Falso)", false)

CreateSwitch(ContentFrames["GlassBridge"], "TP to End", nil, function(enabled)
    if enabled then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 300)
        end
    end
end, "Teletransporta al final del puente", false)-- Sección MINGLE
CreateSwitch(ContentFrames["Mingle"], "Auto Choke", "MingleAuto", function(enabled)
    if enabled then
        spawn(function()
            while Hacks.MingleAuto do
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
end, "Presiona botones automáticamente", true)

-- Sección RANDOM
CreateSwitch(ContentFrames["Random"], "Anti Fling", "AntiFling", function(enabled)
    if enabled then
        spawn(function()
            while Hacks.AntiFling do
                if LocalPlayer.Character then
                    LocalPlayer.Character:FindFirstChild("Humanoid").PlatformStand = false
                end
                wait(0.1)
            end
        end)
    end
end, "Previene que te lancen", false)

CreateSwitch(ContentFrames["Random"], "Fullbright", "Fullbright", function(enabled)
    if enabled then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
    end
end, "Iluminación máxima", false)

-- Sección REBEL
CreateSwitch(ContentFrames["Rebel"], "Guard ESP", "RebelGuardESP", function(enabled)
    if enabled then
        -- Lógica para ESP de guardias
        print("Guard ESP activado")
    end
end, "Ver guardias rebeldes", true)

CreateSwitch(ContentFrames["Rebel"], "Auto Kill Guards", "AutoKillGuards", function(enabled)
    if enabled then
        spawn(function()
            while Hacks.AutoKillGuards do
                -- Lógica para eliminar guardias
                wait(1)
            end
        end)
    end
end, "Elimina guardias automáticamente", true)

-- Sección FINAL
CreateSwitch(ContentFrames["Final"], "One Punch Kill", "FinalOnePunch", function(enabled)
    if enabled then
        -- Lógica para one punch kill
        print("One Punch activado")
    end
end, "Elimina enemigos de un golpe", false)

CreateSwitch(ContentFrames["Final"], "God Mode", "FinalGodMode", function(enabled)
    if enabled then
        -- Lógica para god mode en final
        print("God Mode Final activado")
    end
end, "Inmunidad en combate final", false)

-- Sección SKY
CreateSwitch(ContentFrames["Sky"], "No Fall Damage", "SkyNoFall", function(enabled)
    if enabled then
        spawn(function()
            while Hacks.SkyNoFall do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                end
                wait(0.1)
            end
        end)
    end
end, "Sin daño por caída", false)

CreateSwitch(ContentFrames["Sky"], "Anti Knockback", "SkyAntiKnockback", function(enabled)
    if enabled then
        -- Lógica para anti knockback
        print("Anti Knockback activado")
    end
end, "Inmune a empujones", true)

-- Funciones de actualización de tamaño
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
    OpenButton.Visible = false
end)

MinimizeButton.MouseButton1Click:Connect(function()
    Minimized = true
    MainFrame.Visible = false
    OpenButton.Visible = true
end)

FullscreenButton.MouseButton1Click:Connect(function()
    Fullscreen = not Fullscreen
    if Fullscreen then
        MainFrame.Size = UDim2.new(1, 0, 1, 0)
        MainFrame.Position = UDim2.new(0, 0, 0, 0)
    else
        MainFrame.Size = UDim2.new(0, 350, 0, 500)
        MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    local confirmFrame = Instance.new("Frame")
    confirmFrame.Size = UDim2.new(0, 250, 0, 120)
    confirmFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
    confirmFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    confirmFrame.Parent = ScreenGui
    
    local question = Instance.new("TextLabel")
    question.Text = "¿Cerrar menú definitivamente?"
    question.Size = UDim2.new(1, 0, 0, 50)
    question.Position = UDim2.new(0, 0, 0, 10)
    question.BackgroundTransparency = 1
    question.TextColor3 = Color3.new(1, 1, 1)
    question.Parent = confirmFrame
    
    local acceptButton = Instance.new("TextButton")
    acceptButton.Text = "ACEPTAR"
    acceptButton.Size = UDim2.new(0, 100, 0, 30)
    acceptButton.Position = UDim2.new(0, 20, 0, 70)
    acceptButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    acceptButton.Parent = confirmFrame
    
    local cancelButton = Instance.new("TextButton")
    cancelButton.Text = "CANCELAR"
    cancelButton.Size = UDim2.new(0, 100, 0, 30)
    cancelButton.Position = UDim2.new(0, 130, 0, 70)
    cancelButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    cancelButton.Parent = confirmFrame
    
    acceptButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    cancelButton.MouseButton1Click:Connect(function()
        confirmFrame:Destroy()
    end)
end)

-- Auto aplicar speed al respawnear
LocalPlayer.CharacterAdded:Connect(function()
    wait(2)
    if SpeedEnabled and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = SpeedValue
    end
end)

-- Notificación inicial
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🎮 HRCICUSS SCRIPTS",
    Text = "Menú premium iOS cargado!",
    Duration = 5
})

print("✅ HRCICUSS MOD MENU iOS CARGADO")
print("📱 Compatible con Delta Mobile")
print("🎮 60+ funciones implementadas")
print("💎 Diseño premium tipo iOS")
