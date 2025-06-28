local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local players = game:GetService("Players")
local LocalPlayer = players.LocalPlayer
local mouse = LocalPlayer:GetMouse()
local Debris = workspace:WaitForChild("Debris")

-- // Clones
local CWorkspace = cloneref(game:GetService("Workspace"))
local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local CoreGui = cloneref(game:GetService("CoreGui"))

-- // Variables
local LocalPlayer = Players.LocalPlayer
local Camera = CWorkspace.CurrentCamera
local Weapons = ReplicatedStorage:FindFirstChild("Weapons")
local WeaponClone = Weapons:Clone()
local Holder
local HolderName = tostring(math.random(100000, 999999))
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local currentCharacter
local currentHRP
local currentHumanoid

if LocalPlayer.Character then
    currentCharacter = LocalPlayer.Character
    currentHRP = currentCharacter:FindFirstChild("HumanoidRootPart")
    currentHumanoid = currentCharacter:FindFirstChild("Humanoid")
end

local ControlTurnArguments = {
    [1] = -1,
    [2] = false
}
local AdjustADSRemoteArguments = {
    [1] = false,
    [2] = false
}
local PlantC4Arguments = {
    [1] = "A"
}

local DefuseC4Arguments = {
    Instance.new("Model")
}

local Legit12 = {
    Legit_silent_aim_wall_check = false,
    Legit_silent_aim_fov = false,
    Legit_silent_aim_fov_radius = 100,
    Legit_silent_aim_hit_chance = 100,
    Legit_silent_aim_hit_parts = {"Head", "Torso", "Arms", "Legs"},
    Legit_silent_aim_enabled = false,
    misc_instant_plant = false,
    misc_instant_defuse = false,
    silent_aim_magic_bullet = false,
    Doubletap = false,
    Tripletap = false,
    prediction_enabled = false,
    prediction_strength = 1,
    auto_prediction_enabled = false,
    lag_comp_enabled = false,
    lag_comp_ms = 100,
    
}

local world1 = {
    hitmarkerEnabled = false,
    hitmarkerColor = Color3.new(1, 1, 1),

    mollyRadiusEnabled = false,
    mollyRadiusTransparency = 0.5,
    mollyRadiusColor = Color3.new(1, 0, 0),

    smokeRadiusEnabled = false,
    smokeRadiusColor = Color3.new(0.5, 0.5, 0.5),

    bulletTracersEnabled = false,
    bulletTracersColor = Color3.new(0.5, 0.5, 0.5),

    BulletImpacts = false,
    BulletImpactsColor = Color3.new(0.5, 0.5, 0.5),

    hitChams = {
        Toggle = false,
        Color = Color3.new(1, 0, 0) -- red by default
    },
}

local Decimals = 4
local Clock = os.clock()
local ValueText = "Value Is Now :"

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/drillygzzly/Roblox-UI-Libs/main/1%20Tokyo%20Lib%20(FIXED)/Tokyo%20Lib%20Source.lua"))({
    cheatname = "iridescent.yaw", -- watermark text
    gamename = "Counter Blox", -- watermark text
})

library:init()

local Window1  = library.NewWindow({
    title = "iridescent.yaw | v1.0", -- Mainwindow Text
    size = UDim2.new(0, 510, 0.5, 6
)})

local silentaimTick = false
local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 0.5
fovCircle.NumSides = 100
fovCircle.Radius = 100
fovCircle.Filled = false
fovCircle.Visible = false
fovCircle.ZIndex = 999
fovCircle.Transparency = 1
fovCircle.Color = Color3.fromRGB(255, 255, 255)

local Events = ReplicatedStorage:FindFirstChild("Events")

local KickRemote = Events:FindFirstChild("RemoteEvent")

local ControlTurnRemote = Events:FindFirstChild("ControlTurn")

local AdjustADSRemote = Events:FindFirstChild("AdjustADS")

local ReplicateSoundRemote = Events:FindFirstChild("ReplicateSound")

local PlantC4Remote = Events:WaitForChild("PlantC4")

local DefuseC4Remote = Events:WaitForChild("Defuse")

local StatusFolder = CWorkspace:FindFirstChild("Status")

local PreparationValue = StatusFolder:FindFirstChild("Preparation")

local CompareInstances = (CompareInstances and function(Instance1, Instance2)
        if typeof(Instance1) == "Instance" and typeof(Instance2) == "Instance" then
            return CompareInstances(Instance1, Instance2)
        end
    end) or function(Instance1, Instance2)
        return (typeof(Instance1) == "Instance" and typeof(Instance2) == "Instance")
    end

local CanCastToSTDString = function(...)
    return pcall(FindFirstChild, game, ...)
end

-- // client AC bypass
local __namecall_kick
__namecall_kick =
    hookmetamethod(
    game,
    "__namecall",
    newcclosure(
        function(self, ...)
            local method = getnamecallmethod()

            if
                not checkcaller() and CompareInstances(self, LocalPlayer) and
                    string.gsub(method, "^%l", string.upper) == "Kick"
             then
                return
            end

            return __namecall_kick(self, ...)
        end
    )
)

local __hookfunction_kick
__hookfunction_kick =
    hookfunction(
    LocalPlayer.Kick,
    newcclosure(
        function(self, ...)
            if not checkcaller() and CompareInstances(self, LocalPlayer) and CanCastToSTDString(...) then
                return
            end
        end
    )
)

local __namecall_kick_remote
__namecall_kick_remote =
    hookmetamethod(
    game,
    "__namecall",
    newcclosure(
        function(self, ...)
            local method = getnamecallmethod()

            if not checkcaller() and self == KickRemote and method == "FireServer" then
                return
            end

            return __namecall_kick_remote(self, ...)
        end
    )
)

library:SendNotification(
    "Welocome to iri.yaw"
)

library:SendNotification(
    "Version:1.0"
)

local legit = Window1:AddTab("Aimbot")
local aa = Window1:AddTab("Anti Aim")
local misc = Window1:AddTab("Misc")
local visuals = Window1:AddTab("Visuals")
local SettingsTab = library:CreateSettingsTab(Window1)

local LeftGroupBox = legit:AddSection("Aimbot")

local RightAimbot = legit:AddSection("Extra", 2)

RightAimbot:AddToggle({
    text = "Double Tap",
    flag = "Double_Tap",
    default = false,
    visible = true,
    risky = true,
    callback = function(state)
        Legit12.Doubletap = state
    end
})

RightAimbot:AddToggle({
    text = "Triple Tap",
    flag = "Triple_Tap",
    default = false,
    visible = true,
    risky = true,
    callback = function(state)
        Legit12.Tripletap = state
    end
})

RightAimbot:AddToggle({
    text = "Magic Bullet",
    flag = "Magic_Bullet",
    default = false,
    visible = true,
    risky = true,
    callback = function(state)
        Legit12.silent_aim_magic_bullet = state
    end
})

-- // Anti-Aim
local aa = aa:AddSection("Anti Aim")

local RunService = game:GetService("RunService")

local antiaim = {
    randomPitchMin = -1,
    randomPitchMax = 1,
    YawType = "Static",
    YawEnabled = false,
    YawOffset = 0,
    currentYaw = 0,
    lastJitter = 0,
    jitterSwitch = false,
    desyncDelay = 0.5,
    desyncEnabled = false,
    lastDesync = 0,
    turnDirection = 1,
    desyncOffsetYaw = 30,
    desyncType = "Static",
    pitchEnabled = false,
    pitchMode = "Static",
    pitchLoop = nil,
    customPitchValue = 0,
    desyncHighlightParts = {},
    desyncChamsEnabled = false,
    desyncChamsColor = Color3.fromRGB(255, 0, 0),
    freestandingEnabled = false,
    freestandingYaw = 0,
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function removeChamsHighlight()
    for _, part in pairs(antiaim.desyncHighlightParts) do
        if part and part.Parent then
            part:Destroy()
        end
    end
    antiaim.desyncHighlightParts = {}
end

local function removeDesyncLines()
    removeChamsHighlight()
end

local function applyChamsHighlight(character, angle)
    removeChamsHighlight()
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            local ghost = Instance.new("Part")
            ghost.Name = "DesyncHighlight"
            ghost.Size = part.Size
            ghost.CFrame = root.CFrame * CFrame.Angles(0, angle, 0) * root.CFrame:ToObjectSpace(part.CFrame)
            ghost.Anchored = true
            ghost.CanCollide = false
            ghost.Material = Enum.Material.ForceField
            ghost.Transparency = 0.5
            ghost.Color = antiaim.desyncChamsColor
            ghost.Parent = workspace
            table.insert(antiaim.desyncHighlightParts, ghost)
        end
    end
end

local function IsOnSameTeam(player)
    return player and player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team
end

RunService.RenderStepped:Connect(function(dt)
    local char = LocalPlayer.Character
    if not char then removeDesyncLines() return end
    local humanoid = char:FindFirstChild("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root or humanoid.Health <= 0 then removeDesyncLines() return end

    local now = tick()
    local basePos = root.Position
    local closestEnemy, shortestDist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and not IsOnSameTeam(p) then
            local eRoot = p.Character:FindFirstChild("HumanoidRootPart")
            local eHum = p.Character:FindFirstChild("Humanoid")
            if eRoot and eHum and eHum.Health > 0 then
                local dist = (eRoot.Position - basePos).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    closestEnemy = eRoot
                end
            end
        end
    end

    if antiaim.freestandingEnabled then
        antiaim.YawEnabled = true
        antiaim.YawType = "Static"
        if closestEnemy then
            local rootCF = root.CFrame
            local enemyPos = closestEnemy.Position
            local lookVector = (enemyPos - basePos).Unit
            local angles = math.atan2(lookVector.X, lookVector.Z)
            local leftYaw = angles + math.rad(-90)
            local rightYaw = angles + math.rad(90)

            local leftPos = basePos + Vector3.new(math.cos(leftYaw), 0, math.sin(leftYaw)) * 3
            local rightPos = basePos + Vector3.new(math.cos(rightYaw), 0, math.sin(rightYaw)) * 3

            local rayParams = RaycastParams.new()
            rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
            rayParams.FilterType = Enum.RaycastFilterType.Blacklist

            local leftRay = workspace:Raycast(basePos, (leftPos - basePos).Unit * 3, rayParams)
            local rightRay = workspace:Raycast(basePos, (rightPos - basePos).Unit * 3, rayParams)

            if leftRay and not rightRay then
                antiaim.YawOffset = math.deg(leftYaw)
            elseif rightRay and not leftRay then
                antiaim.YawOffset = math.deg(rightYaw)
            else
                antiaim.YawOffset = math.deg(angles + math.rad(180))
            end
        else
            antiaim.YawOffset = 0
        end
    end

    if antiaim.YawEnabled and not antiaim.freestandingEnabled then
        if closestEnemy then
            humanoid.AutoRotate = false
            local dir = (closestEnemy.Position - basePos).Unit
            local yaw = math.atan2(dir.X, dir.Z)
            local offset = math.rad(tonumber(antiaim.YawOffset) or 0)
            if antiaim.YawType == "Static" then
                root.CFrame = CFrame.new(basePos) * CFrame.Angles(0, yaw + offset, 0)
            elseif antiaim.YawType == "Jitter" then
                if now - antiaim.lastJitter > 0.1 then
                    antiaim.jitterSwitch = not antiaim.jitterSwitch
                    antiaim.lastJitter = now
                end
                local jitter = antiaim.jitterSwitch and math.rad(90) or math.rad(-90)
                root.CFrame = CFrame.new(basePos) * CFrame.Angles(0, yaw + jitter + offset, 0)
            elseif antiaim.YawType == "Spin" then
                antiaim.currentYaw = (antiaim.currentYaw + offset * dt * 60) % (2 * math.pi)
                root.CFrame = CFrame.new(basePos) * CFrame.Angles(0, antiaim.currentYaw, 0)
            elseif antiaim.YawType == "UnHit" then
                root.CFrame = CFrame.new(basePos) * CFrame.Angles(math.rad(180), yaw, 0)
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") and part ~= root then
                        part.Velocity = Vector3.new(math.random(-50,50), math.random(100,200), math.random(-50,50))
                    end
                end
            end
        else
            humanoid.AutoRotate = true
        end
    elseif not antiaim.YawEnabled then
        humanoid.AutoRotate = true
    end

    if antiaim.desyncEnabled then
        if now - antiaim.lastDesync > antiaim.desyncDelay then
            antiaim.turnDirection = -antiaim.turnDirection
            antiaim.lastDesync = now
        end
        local offsetYaw = math.rad(tonumber(antiaim.desyncOffsetYaw) or 0)
        local fakeAngle = 0
        if antiaim.desyncType == "Static" then
            fakeAngle = offsetYaw * antiaim.turnDirection
        elseif antiaim.desyncType == "Jitter" then
            fakeAngle = offsetYaw * ((now % 0.2 < 0.1) and 1 or -1)
        elseif antiaim.desyncType == "Extended Jitter" then
            fakeAngle = math.rad(90) * ((now % 0.4 < 0.2) and 1 or -1)
        end
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") and part ~= root then
                local offset = root.CFrame:ToObjectSpace(part.CFrame)
                part.CFrame = root.CFrame * CFrame.Angles(0, fakeAngle, 0) * offset
            end
        end

        if antiaim.desyncChamsEnabled then
            applyChamsHighlight(char, fakeAngle)
        else
            removeChamsHighlight()
        end
    else
        removeChamsHighlight()
    end
end)

aa:AddToggle({
    text = "Yaw",
    flag = "Yaw",
    default = false,
    visible = true,
    risky = true,
    callback = function(state)
        antiaim.YawEnabled = state
    end
})

aa:AddList({
    enabled = true,
    text = "Yaw Type",
    flag = "Yaw_Type",
    selected = "Static",
    multi = false,
    open = false,
    max = 4,
    values = {"Static", "Jitter", "Spin", "UnHit"},
    risky = true,
    callback = function(value)
        antiaim.YawType = value
    end
})

aa:AddSlider({
    enabled = true,
    text = "Yaw Amount",
    flag = "Yaw_Amount",
    suffix = "",
    dragging = true,
    min = 0,
    max = 180,
    increment = 1,
    risky = true,
    callback = function(value)
        antiaim.YawOffset = value
    end
})

aa:AddToggle({
    text = "Desync",
    flag = "Desync",
    default = false,
    visible = true,
    risky = true,
    callback = function(state)
        antiaim.desyncEnabled = state
        if not state then
            removeChamsHighlight()
            removeDesyncLines()
        end
    end
})

aa:AddToggle({
    text = "Desync Chams",
    flag = "Desync_Chams",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        antiaim.desyncChamsEnabled = state
        if not state then
            removeChamsHighlight()
        end
    end
})

:AddColor({
    enabled = true,
    tooltip = "",
    color = antiaim.desyncChamsColor,
    flag = "Desync_Chams_Color",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        antiaim.desyncChamsColor = color
    end
})

aa:AddList({
    enabled = true,
    text = "Desync Type",
    flag = "Desync_Type",
    selected = "Static",
    multi = false,
    open = false,
    max = 3,
    values = {"Static", "Jitter", "Extended Jitter"},
    risky = true,
    callback = function(value)
        antiaim.desyncType = value
    end
})

aa:AddSlider({
    enabled = true,
    text = "Desync Delay",
    flag = "Desync_Delay",
    suffix = "",
    dragging = true,
    min = 0,
    max = 1,
    increment = 0.1,
    risky = true,
    callback = function(value)
        antiaim.desyncDelay = value
    end
})

aa:AddSlider({
    enabled = true,
    text = "Desync Yaw Offset",
    flag = "Desync_Yaw_Offset",
    suffix = "",
    dragging = true,
    min = 0,
    max = 180,
    increment = 1,
    risky = true,
    callback = function(value)
        antiaim.desyncOffsetYaw = value
    end
})

aa:AddToggle({
    text = "Pitch",
    flag = "Pitch",
    default = false,
    visible = true,
    risky = true,
    callback = function(state)
        antiaim.pitchEnabled = state
        if antiaim.pitchEnabled then
            if not antiaim.pitchLoop then
                antiaim.pitchLoop = task.spawn(function()
                    while antiaim.pitchEnabled do
                        local direction
                        if antiaim.pitchMode == "Random" then
                            direction = math.random() * (antiaim.randomPitchMax - antiaim.randomPitchMin) + antiaim.randomPitchMin
                        elseif antiaim.pitchMode == "Up" then
                            direction = 1
                        elseif antiaim.pitchMode == "Down" then
                            direction = -1
                        elseif antiaim.pitchMode == "Zero" then
                            direction = 0
                        elseif antiaim.pitchMode == "Custom" then
                            direction = antiaim.customPitchValue
                        end
                        local args = {[1] = direction, [2] = false}
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ControlTurn"):FireServer(unpack(args))
                        task.wait()
                    end
                    antiaim.pitchLoop = nil
                end)
            end
        else
            antiaim.pitchEnabled = false
        end
    end
})

aa:AddList({
    enabled = true,
    text = "Pitch Type",
    flag = "Pitch_Type",
    selected = "Static",
    multi = false,
    open = false,
    max = 5,
    values = {"Up", "Down", "Zero", "Random", "Custom"},
    risky = true,
    callback = function(value)
        antiaim.pitchMode = value
    end
})

aa:AddSlider({
    enabled = true,
    text = "Custom Pitch Value",
    flag = "Custom_Pitch_Value",
    suffix = "",
    dragging = true,
    min = -1,
    max = 1,
    increment = 0.1,
    risky = true,
    callback = function(value)
        antiaim.customPitchValue = value
    end
})

aa:AddSlider({
    enabled = true,
    text = "Random Pitch Min",
    flag = "Random_Pitch_Min",
    suffix = "",
    dragging = true,
    min = -1,
    max = 1,
    increment = 0.1,
    risky = true,
    callback = function(value)
        antiaim.randomPitchMin = value
    end
})

aa:AddSlider({
    enabled = true,
    text = "Random Pitch Max",
    flag = "Random_Pitch_Max",
    suffix = "",
    dragging = true,
    min = -1,
    max = 1,
    increment = 0.1,
    risky = true,
    callback = function(value)
        antiaim.randomPitchMax = value
    end
})

local originalYawOffset = antiaim.YawOffset

aa:AddBind({
    enabled = true,
    text = "Force Yaw Left",
    tooltip = "",
    mode = "toggle",
    bind = "None",
    flag = "Force_Yaw_Left",
    state = false,
    nomouse = false,
    risky = true,
    noindicator = false,
    callback = function(state)
        if antiaim.YawEnabled then
            if state then
                originalYawOffset = antiaim.YawOffset
                antiaim.YawOffset = -90
            else
                if not aa.flags.Force_Yaw_Right then
                    antiaim.YawOffset = 0
                end
            end
        end
    end,
})

aa:AddBind({
    enabled = true,
    text = "Force Yaw Right",
    tooltip = "",
    mode = "toggle",
    bind = "None",
    flag = "Force_Yaw_Right",
    state = false,
    nomouse = false,
    risky = true,
    noindicator = false,
    callback = function(state)
        if antiaim.YawEnabled then
            if state then
                originalYawOffset = antiaim.YawOffset
                antiaim.YawOffset = 90
            else
                if not aa.flags.Force_Yaw_Left then
                    antiaim.YawOffset = 0
                end
            end
        end
    end,
})

aa:AddBind({
    enabled = true,
    text = "Reset Yaw",
    tooltip = "",
    mode = "toggle",
    bind = "None",
    flag = "Reset_Yaw",
    state = false,
    nomouse = false,
    risky = true,
    noindicator = false,
    callback = function()
        if antiaim.YawEnabled then
            antiaim.YawOffset = 0
        end
    end,
})

local LeftMisc = misc:AddSection("Gun Mods", 1)
local RightMisc = misc:AddSection("Extra", 2)
local RightMisc2 = misc:AddSection("Chat Stuff", 2)

RightMisc:AddToggle({
    text = "Bhop",
    flag = "Bhop",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        Bhop = state
    end
})

RightMisc:AddSlider({
    enabled = true,
    text = "Bhop Speed",
    flag = "B_s",
    suffix = "",
    dragging = true,
    focused = false,
    min = 1,
    max = 100,
    increment = 1,
    risky = false,
    callback = function(Value)
        BhopSpeed = value
    end
})

local NoSpreadEnabled = false
local NoRecoilEnabled = false
local NoSpread = 0
local Recoil = 0

LeftMisc:AddToggle({
    text = "Spread",
    flag = "ns",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        NoSpreadEnabled = state
        if NoSpreadEnabled then
            updateSpreadValues(NoSpread)
        end
    end
})

LeftMisc:AddSlider({
    enabled = true,
    text = "Spread Value",
    flag = "nsv",
    suffix = "",
    dragging = true,
    focused = false,
    min = 0,
    max = 100,
    increment = 0.10,
    risky = false,
    callback = function(Value)
        NoSpread = Value
        if NoSpreadEnabled then
            updateSpreadValues(NoSpread)
        end
    end
})

function setNumberValuesSkippingRecoil(instance, val)
    if instance.Name == "Recoil" then return end
    for _, child in ipairs(instance:GetChildren()) do
        if child.Name ~= "Recoil" and child:IsA("NumberValue") then
            child.Value = val
        end
        setNumberValuesSkippingRecoil(child, val)
    end
end

function updateSpreadValuesForInstance(instance, spreadValue)
    if instance.Name == "Recoil" then return end
    for _, child in ipairs(instance:GetChildren()) do
        if child.Name == "Spread" then
            setNumberValuesSkippingRecoil(child, spreadValue / 10)
        elseif child.Name ~= "Recoil" then
            updateSpreadValuesForInstance(child, spreadValue)
        end
    end
end

function updateSpreadValues(spreadValue)
    if Weapons then
        for _, weapon in ipairs(Weapons:GetChildren()) do
            updateSpreadValuesForInstance(weapon, spreadValue)
        end
    end
end

LeftMisc:AddToggle({
    text = "Recoil",
    flag = "nr",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        NoRecoilEnabled = state
    end
})

LeftMisc:AddSlider({
    enabled = true,
    text = "Recoil",
    flag = "nrv",
    suffix = "",
    dragging = true,
    focused = false,
    min = 0,
    max = 100,
    increment = 0.10,
    risky = false,
    callback = function(Value)
        Recoil = Value
        if NoRecoilEnabled and Weapons then
            for _, Weapon in ipairs(Weapons:GetChildren()) do
                local Spread = Weapon:FindFirstChild("Spread")
                if Spread then
                    local RecoilInstance = Spread:FindFirstChild("Recoil")
                    if RecoilInstance and RecoilInstance:IsA("NumberValue") then
                        RecoilInstance.Value = Value
                        for _, child in ipairs(RecoilInstance:GetChildren()) do
                            if child:IsA("NumberValue") then
                                child.Value = Value
                            end
                        end
                    end
                end
            end
        end
    end
})

RightMisc:AddToggle({
    text = "Instant Plant",
    flag = "Instant_Plant",
    default = false,
    visible = true,
    risky = true,
    callback = function(state)
        Legit12.misc_instant_plant = state
    end
})

RightMisc:AddToggle({
    text = "Instant Defuse",
    flag = "Instant_Defuse",
    default = false,
    visible = true,
    risky = true,
    callback = function(state)
        Legit12.misc_instant_defuse = state
    end
})
local player = game:GetService("Players").LocalPlayer
local pingValue = player:FindFirstChild("Ping")

if not pingValue then
    pingValue = Instance.new("NumberValue")
    pingValue.Name = "Ping"
    pingValue.Parent = player
end

local settingInternally = false
local fakePingEnabled = false
local originalPing = pingValue.Value

function setPing(value)
    settingInternally = true
    pingValue.Value = value
    settingInternally = false
end

local conn
conn =
    pingValue.Changed:Connect(
    function(newValue)
        if fakePingEnabled then
            if not settingInternally and newValue ~= 999 then
                setPing(999999999999)
            end
        end
    end
)

RightMisc:AddToggle({
    text = "Fake Ping",
    flag = "Fake_Ping",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        fakePingEnabled = state
        if fakePingEnabled then
            originalPing = pingValue.Value
            setPing(999999999999)
        else
            setPing(originalPing)
        end
    end
})

local hitLogsEnabled = false

RightMisc:AddToggle({
    text = "Hit Logs",
    flag = "Hit_Logs",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        hitLogsEnabled = state
    end
})

local meta = getrawmetatable(game)
setreadonly(meta, false)
local oldNamecall = meta.__namecall

meta.__namecall = newcclosure(function(self, ...)
    local argsCount = select("#", ...)
    local args = { ... }
    local method = getnamecallmethod()

    if hitLogsEnabled and method == "FireServer" and self.Name == "HitPart" then
        spawn(function()
            local hitPart = args[1]
            local weaponName = tostring(args[3])

            local targetModel = hitPart:FindFirstAncestorWhichIsA("Model")
            local targetPlayer = targetModel and Players:GetPlayerFromCharacter(targetModel)
            if not targetPlayer then return end

            local targetName = targetPlayer.Name
            local partName = hitPart.Name

            if partName ~= "Unknown" then
                local msg = string.format("[!] Hit %s in the %s with %s", targetName, partName, weaponName)
                library:SendNotification(msg, 4)
            end
        end)
    end

    return oldNamecall(self, table.unpack(args, 1, argsCount))
end)

setreadonly(meta, true)

local killSayEnabled = false

local messages = {
    Default = "ⓖⓖ⧸ⓝⓚⓦⓝⓖⓟⓖⓒ",
    "ⓖⓖ⧸ⓝⓚⓦⓝⓖⓟⓖⓒ",
    Kiwi = "ⓖⓖ⧸ⓝⓚⓦⓝⓖⓟⓖⓒ",
    "ⓖⓖ⧸ⓝⓚⓦⓝⓖⓟⓖⓒ"
}

RightMisc2:AddToggle({
    text = "Kill Say",
    flag = "Kill_Say",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        killSayEnabled = state
    end
})

LocalPlayer.Status.Kills:GetPropertyChangedSignal("Value"):Connect(
    function()
        if not killSayEnabled then
            return
        end

        local kills = LocalPlayer.Status.Kills.Value
        if kills == 0 then
            return
        end

        local msg =
            (LocalPlayer.DisplayName == "iri.yaw" or LocalPlayer.Name == "iri.yaw") and messages.Kiwi or
            messages.Default

        ReplicatedStorage:WaitForChild("Events"):WaitForChild("PlayerChatted"):FireServer(msg, false)
    end
)

local noFilterEnabled = false

RightMisc2:AddToggle({
    text = "No Chat Filter",
    flag = "No_filter",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        noFilterEnabled = state
    end
})

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if method == "InvokeServer" then
        if self.Name == "Moolah" then
            return
        elseif self.Name == "Hugh" then
            return
        elseif self.Name == "Filter" and noFilterEnabled then
            return args[1]
        end
    end

    return oldNamecall(self, ...)
end

setreadonly(mt, true)

local originalName = LocalPlayer.Name
local newName = "iri.yaw"

RightMisc:AddToggle({
    text = "Name spoof",
    flag = "Name_spoof",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        if state then
            LocalPlayer.Name = newName
        else
            LocalPlayer.Name = originalName
        end
    end
})

local originalValues = {
    RapidFire = {},
    InstantEquip = {},
    NoFireRate = {},
    NoReloadTime = {},
    InfiniteAmmo = {},
    ArmorPenetration = {},
    WallBang = {},
    InfiniteRange = {}
}

LeftMisc:AddToggle({
    text = "Rapid Fire",
    flag = "Rapid_Fire",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            local Auto = Weapon:FindFirstChild("Auto")
            if Auto and Auto:IsA("BoolValue") then
                if state then
                    if originalValues.RapidFire[Weapon] == nil then
                        originalValues.RapidFire[Weapon] = Auto.Value
                    end
                    Auto.Value = true
                else
                    if originalValues.RapidFire[Weapon] ~= nil then
                        Auto.Value = originalValues.RapidFire[Weapon]
                    end
                end
            end
        end
        if not state then
            originalValues.RapidFire = {}
        end
    end
})

LeftMisc:AddToggle({
    text = "Instant Equip",
    flag = "Instant_Equip",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            local Equip = Weapon:FindFirstChild("EquipTime")
            if Equip and Equip:IsA("NumberValue") then
                if state then
                    if originalValues.InstantEquip[Weapon] == nil then
                        originalValues.InstantEquip[Weapon] = Equip.Value
                    end
                    Equip.Value = 0.01
                else
                    if originalValues.InstantEquip[Weapon] ~= nil then
                        Equip.Value = originalValues.InstantEquip[Weapon]
                    end
                end
            end
        end
            if not state then
            originalValues.InstantEquip = {}
        end
    end
})

LeftMisc:AddToggle({
    text = "No Fire Rate",
    flag = "No_Fire_Rate",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            local fireRate = Weapon:FindFirstChild("FireRate")
            if fireRate and fireRate:IsA("NumberValue") then
                if state then
                    if originalValues.NoFireRate[Weapon] == nil then
                        originalValues.NoFireRate[Weapon] = fireRate.Value
                    end
                    fireRate.Value = 0
                else
                    if originalValues.NoFireRate[Weapon] ~= nil then
                        fireRate.Value = originalValues.NoFireRate[Weapon]
                    end
                end
            end
        end
        if not state then
            originalValues.NoFireRate = {}
        end
    end
})

LeftMisc:AddToggle({
    text = "Infinite Ammo",
    flag = "Infinite_Ammo",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        if state then
            for _, weapon in next, Weapons:GetChildren() do
                pcall(function()
                    if weapon:FindFirstChild("Ammo") and weapon:FindFirstChild("StoredAmmo") then
                        weapon.Ammo.Value = 99999
                        weapon.StoredAmmo.Value = 99999
                    end
                end)
            end
        else
            for _, curr in next, Weapons:GetChildren() do
                for _, original in next, WeaponClone:GetChildren() do
                    if curr.Name == original.Name then
                        pcall(function()
                            if curr:FindFirstChild("Ammo") and curr:FindFirstChild("StoredAmmo")
                               and original:FindFirstChild("Ammo") and original:FindFirstChild("StoredAmmo") then
                                curr.Ammo.Value = original.Ammo.Value
                                curr.StoredAmmo.Value = original.StoredAmmo.Value
                            end
                        end)
                    end
                end
            end
        end
    end
})

LeftMisc:AddToggle({
    text = "No Reload Time",
    flag = "No_Reload_Time",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            local reloadTime = Weapon:FindFirstChild("ReloadTime")
            if reloadTime and reloadTime:IsA("NumberValue") then
                if state then
                    if originalValues.NoReloadTime[Weapon] == nil then
                        originalValues.NoReloadTime[Weapon] = reloadTime.Value
                    end
                    reloadTime.Value = 0.05
                else
                    if originalValues.NoReloadTime[Weapon] ~= nil then
                        reloadTime.Value = originalValues.NoReloadTime[Weapon]
                    end
                end
            end
        end
        if not state then
            table.clear(originalValues.NoReloadTime)
        end
    end
})

LeftMisc:AddToggle({
    text = "Armor Penetration",
    flag = "Armor_Penetration",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            local ArmorPen = Weapon:FindFirstChild("ArmorPenetration")
            if ArmorPen and ArmorPen:IsA("NumberValue") then
                if state then
                    if originalValues.ArmorPenetration[Weapon] == nil then
                        originalValues.ArmorPenetration[Weapon] = ArmorPen.Value
                    end
                    ArmorPen.Value = 999999
                else
                    if originalValues.ArmorPenetration[Weapon] ~= nil then
                        ArmorPen.Value = originalValues.ArmorPenetration[Weapon]
                    end
                end
            end
        end
        if not state then
            table.clear(originalValues.ArmorPenetration)
        end
    end
})

LeftMisc:AddToggle({
    text = "Infinite Range",
    flag = "Infinite_Range",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            local Range = Weapon:FindFirstChild("Range")
            if Range then
                if state then
                    if originalValues.InfiniteRange[Weapon] == nil then
                        originalValues.InfiniteRange[Weapon] = Range.Value
                    end
                    Range.Value = 9999999999
                else
                    if originalValues.InfiniteRange[Weapon] ~= nil then
                        Range.Value = originalValues.InfiniteRange[Weapon]
                    end
                end
            end
        end
        if not state then
            table.clear(originalValues.InfiniteRange)
        end
    end
})

LeftMisc:AddToggle({
    text = "Wall Bang",
    flag = "Wall_Bang",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            local Pen = Weapon:FindFirstChild("Penetration")
            if Pen then
                if state then
                    if originalValues.WallBang[Weapon] == nil then
                        originalValues.WallBang[Weapon] = Pen.Value
                    end
                    Pen.Value = 999999999999
                else
                    if originalValues.WallBang[Weapon] ~= nil then
                        Pen.Value = originalValues.WallBang[Weapon]
                    end
                end
            end
        end
        if not state then
            table.clear(originalValues.WallBang)
        end
    end
})

RightMisc:AddToggle({
    text = "Unlock All",
    flag = "UA",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        local LocalPlayer = game.Players.LocalPlayer
        local Client = getsenv(LocalPlayer.PlayerGui.Client)

        local allSkins = loadstring(game:HttpGet("https://raw.githubusercontent.com/huiewhxiuewxjnoiuwed/skins/main/skins.lua"))()

        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        setreadonly(mt, false)

        local isUnlocked

        mt.__namecall = newcclosure(function(self, ...)
            local args = { ... }
            local method = getnamecallmethod()

            if method == "InvokeServer" and tostring(self) == "Hugh" then
                return
            end

            if method == "FireServer" then
                if args[1] == LocalPlayer.UserId then
                    return
                end

                if #tostring(self) == 38 then
                    if not isUnlocked then
                        isUnlocked = true
                        for _, v in pairs(allSkins) do
                            local doSkip
                            for _, v2 in pairs(args[1]) do
                                if v[1] == v2[1] then
                                    doSkip = true
                                    break
                                end
                            end
                            if not doSkip then
                                table.insert(args[1], v)
                            end
                        end
                    end
                    return
                end

                if tostring(self) == "DataEvent" and args[1][4] then
                    local currentSkin = string.split(args[1][4][1], "_")[2]
                    if args[1][2] == "Both" then
                        LocalPlayer.SkinFolder.CTFolder[args[1][3]].Value = currentSkin
                        LocalPlayer.SkinFolder.TFolder[args[1][3]].Value = currentSkin
                    else
                        LocalPlayer.SkinFolder[args[1][2] .. "Folder"][args[1][3]].Value = currentSkin
                    end
                end
            end

            return oldNamecall(self, ...)
        end)

        setreadonly(mt, true)

        Client.CurrentInventory = allSkins

        local TClone = LocalPlayer.SkinFolder.TFolder:Clone()
        local CTClone = LocalPlayer.SkinFolder.CTFolder:Clone()
        LocalPlayer.SkinFolder.TFolder:Destroy()
        LocalPlayer.SkinFolder.CTFolder:Destroy()
        TClone.Parent = LocalPlayer.SkinFolder
        CTClone.Parent = LocalPlayer.SkinFolder
    end
})

local outlineColor = Color3.fromRGB(140, 80, 255)
local backgroundColor = Color3.fromRGB(15, 15, 15)
local specWidth, specMinHeight = 200, 20

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "SpectatorUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

function createTokyoFrame(position, size, titleText)
	local container = Instance.new("Frame")
	container.Position = position
	container.Size = size
	container.BackgroundColor3 = backgroundColor
	container.BorderSizePixel = 0
	container.BackgroundTransparency = 0
	container.Active = true
	container.Draggable = true
	container.ZIndex = 10
	container.Parent = ScreenGui

	local topLine = Instance.new("Frame")
	topLine.Size = UDim2.new(1, 0, 0, 1)
	topLine.Position = UDim2.new(0, 0, 0, 0)
	topLine.BackgroundColor3 = outlineColor
	topLine.BorderSizePixel = 0
	topLine.ZIndex = 11
	topLine.Parent = container

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 20)
	title.Position = UDim2.new(0, 0, 0, 1)
	title.BackgroundTransparency = 1
	title.Text = titleText
	title.Font = Enum.Font.SourceSansBold
	title.TextColor3 = Color3.new(1, 1, 1)
	title.TextSize = 15
	title.ZIndex = 11
	title.TextXAlignment = Enum.TextXAlignment.Center
	title.Parent = container

	return container
end

local specFrame = createTokyoFrame(UDim2.new(1, -210, 0, 40), UDim2.new(0, specWidth, 0, specMinHeight), "Spectators")
specFrame.Visible = false

local specList = Instance.new("TextLabel")
specList.Size = UDim2.new(1, -10, 1, -22)
specList.Position = UDim2.new(0, 5, 0, 22)
specList.BackgroundTransparency = 1
specList.TextColor3 = Color3.new(1, 1, 1)
specList.Font = Enum.Font.SourceSans
specList.TextSize = 14
specList.TextXAlignment = Enum.TextXAlignment.Left
specList.TextYAlignment = Enum.TextYAlignment.Top
specList.TextWrapped = false
specList.Text = ""
specList.ZIndex = 11
specList.Parent = specFrame

local function GetSpectators()
	local camPos = Camera.CFrame.Position
	local result = ""
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local character = player.Character
			if not character then
				local camCF = player:FindFirstChild("CameraCF")
				if camCF and camCF:IsA("CFrameValue") then
					local dist = (camCF.Value.Position - camPos).Magnitude
					if dist < 10 then
						result = result == "" and player.Name or result .. "\n" .. player.Name
					end
				end
			end
		end
	end
	return result
end

local function updateSpectatorList()
	local listText = GetSpectators()
	specList.Text = listText
	local lines = select(2, listText:gsub("\n", "\n")) + 1
	local height = math.max(40 + (lines * 15), 40)
	specFrame.Size = UDim2.new(0, specWidth, 0, height)
end

RightMisc:AddToggle({
	text = "Spectator List",
	flag = "Spec_List",
	default = false,
	callback = function(state)
		specFrame.Visible = state
	end
})

task.spawn(function()
	while true do
		task.wait(1)
		if specFrame.Visible then
			updateSpectatorList()
		end
	end
end)

RightMisc:AddToggle({
    text = "Hitmarker",
    flag = "Hitmarker",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        world1.hitmarkerEnabled = state
    end
})
:AddColor({
    enabled = true,
    tooltip = "",
    color = Color3.fromRGB(255, 0, 0),
    flag = "HMC",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        world1.hitmarkerColor = color
    end
})

RightMisc:AddToggle({
    text = "Crosshair Editor",
    flag = "CRE",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        crosshairEnabled = state
        UpdateCrosshair()
    end
})

RightMisc:AddSlider({
    enabled = true,
    text = "Crosshair Length",
    flag = "CRL",
    suffix = "",
    dragging = true,
    focused = false,
    value = 4,
    min = 0,
    max = 10,
    increment = 1,
    risky = false,
    callback = function(Value)
        crosshairLength = value
        UpdateCrosshair()
    end
})

local env = getgenv()

env.RemoveScope = env.RemoveScope or false
env.RemoveFlash = env.RemoveFlash or false
env.RemoveBulletsHoles = env.RemoveBulletsHoles or false
env.RemoveSmoke = env.RemoveSmoke or false
env.RemoveBlood = env.RemoveBlood or false
env.CustomScopeEnabled = env.CustomScopeEnabled or false
env.CustomScopeSize = env.CustomScopeSize or 50
env.CustomScopeColor = env.CustomScopeColor or Color3.fromRGB(255, 255, 255)
env.CustomScopeInverted = env.CustomScopeInverted or false

local NewScope, ScopeLine1, ScopeLine2
do
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local Frame_2 = Instance.new("Frame")

    ScreenGui.Enabled = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Name = "CustomScope"
    ScreenGui.ResetOnSpawn = false

    Frame.Name = "ScopeLine1"
    Frame.Parent = ScreenGui
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BackgroundColor3 = env.CustomScopeColor
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame.Size = UDim2.new(env.CustomScopeSize / 200, 0, 0, 1)

    local gradient1 = Instance.new("UIGradient", Frame)
    gradient1.Rotation = 0
    gradient1.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(0.5, env.CustomScopeColor),
        ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
    }

    Frame_2.Name = "ScopeLine2"
    Frame_2.Parent = ScreenGui
    Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame_2.BackgroundColor3 = env.CustomScopeColor
    Frame_2.BorderSizePixel = 0
    Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame_2.Size = UDim2.new(0, 1, env.CustomScopeSize / 200 * 2, 0)

    local gradient2 = Instance.new("UIGradient", Frame_2)
    gradient2.Rotation = 90
    gradient2.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(0.5, env.CustomScopeColor),
        ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
    }

    ScreenGui.Parent = game.CoreGui

    NewScope = ScreenGui
    ScopeLine1 = Frame
    ScopeLine2 = Frame_2
end

RightMisc:AddList({
    enabled = true,
    text = "Removals",
    tooltip = "Toggle what effects to remove",
    selected = "",
    flag = "Removals",
    multi = true,
    open = false,
    max = 6,
    values = {"RemoveScope", "RemoveFlash", "RemoveBulletsHoles", "RemoveSmoke", "RemoveBlood"},
    risky = false,
    callback = function(selectedValues)
        env.RemoveScope = false
        env.RemoveFlash = false
        env.RemoveBulletsHoles = false
        env.RemoveSmoke = false
        env.RemoveBlood = false
        for _, v in ipairs(selectedValues) do
            env[v] = true
        end
    end
})

RightMisc:AddToggle({
    text = "Enable Custom Scope",
    state = true,
    tooltip = "Toggle custom scope lines",
    flag = "CustomScope_Enabled",
    risky = false,
    callback = function(v)
        env.CustomScopeEnabled = v
        NewScope.Enabled = v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("AIMING") and true or false
    end
})
RightMisc:AddToggle({
    text = "Invert Scope Lines",
    state = false,
    tooltip = "Flip lines to outside center",
    flag = "CustomScope_Inverted",
    risky = false,
    callback = function(v)
        env.CustomScopeInverted = v
    end
})
:AddColor({
    enabled = true,
    text = "Scope Color",
    tooltip = "Change color of custom scope lines",
    color = env.CustomScopeColor,
    flag = "CustomScope_Color",
    trans = 0,
    open = false,
    risky = false,
    callback = function(v)
        env.CustomScopeColor = v
        ScopeLine1.BackgroundColor3 = v
        ScopeLine2.BackgroundColor3 = v
        ScopeLine1.UIGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
            ColorSequenceKeypoint.new(0.5, v),
            ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
        }
        ScopeLine2.UIGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
            ColorSequenceKeypoint.new(0.5, v),
            ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
        }
    end
})

RightMisc:AddSlider({
    enabled = true,
    text = "Scope Size",
    tooltip = "Adjust size of custom scope lines",
    flag = "CustomScope_Size",
    suffix = "%",
    dragging = true,
    focused = false,
    min = 0,
    max = 100,
    increment = 1,
    risky = false,
    callback = function(v)
        env.CustomScopeSize = v
        local size = v / 200
        if env.CustomScopeInverted then
            ScopeLine1.Position = UDim2.new(0.5, -v, 0.5, 0)
            ScopeLine2.Position = UDim2.new(0.5, 0, 0.5, -v)
        else
            ScopeLine1.Position = UDim2.new(0.5, 0, 0.5, 0)
            ScopeLine2.Position = UDim2.new(0.5, 0, 0.5, 0)
        end
        ScopeLine1.Size = UDim2.new(size, 0, 0, 1)
        ScopeLine2.Size = UDim2.new(0, 1, size * 2, 0)
    end
})

local Crosshairs = LocalPlayer.PlayerGui.GUI.Crosshairs

RunService.RenderStepped:Connect(function()
    if env.RemoveScope then
        local scope = Crosshairs.Scope
        scope.ImageTransparency = 1
        scope.Scope.ImageTransparency = 1
        scope.Scope.Size = UDim2.new(2, 0, 2, 0)
        scope.Scope.Position = UDim2.new(-0.5, 0, -0.5, 0)
        scope.Scope.Blur.ImageTransparency = 1
        scope.Scope.Blur.Blur.ImageTransparency = 1
        Crosshairs.Frame1.Transparency = 1
        Crosshairs.Frame2.Transparency = 1
        Crosshairs.Frame3.Transparency = 1
        Crosshairs.Frame4.Transparency = 1
    else
        local scope = Crosshairs.Scope
        scope.ImageTransparency = 0
        scope.Scope.ImageTransparency = 0
        scope.Scope.Size = UDim2.new(1, 0, 1, 0)
        scope.Scope.Position = UDim2.new(0, 0, 0, 0)
        scope.Scope.Blur.ImageTransparency = 0
        scope.Scope.Blur.Blur.ImageTransparency = 0
        Crosshairs.Frame1.Transparency = 0
        Crosshairs.Frame2.Transparency = 0
        Crosshairs.Frame3.Transparency = 0
        Crosshairs.Frame4.Transparency = 0
    end

    LocalPlayer.PlayerGui.Blnd.Enabled = not env.RemoveFlash

    if env.RemoveBulletsHoles then
        for _, v in pairs(Debris:GetChildren()) do
            if v.Name == "Bullet" then
                v:Destroy()
            end
        end
    end

    if env.RemoveSmoke then
        for _, v in pairs(RayIgnore.Smokes:GetChildren()) do
            if v.Name == "Smoke" then
                v:Destroy()
            end
        end
    end

    if env.RemoveBlood then
        for _, v in pairs(Debris:GetChildren()) do
            if v.Name == "SurfaceGui" then
                v:Destroy()
            end
        end
    end

    if env.CustomScopeEnabled then
        NewScope.Enabled = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("AIMING") and true or false
        Crosshairs.Scope.Visible = false
    else
        NewScope.Enabled = false
    end
end)

RightMisc:AddButton({
    enabled = true,
    text = "God Mode",
    tooltip = "",
    confirm = true,
    risky = false,
    callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.Name = "1"
            local clonedHumanoid = character["1"]:Clone()
            clonedHumanoid.Parent = character
            clonedHumanoid.Name = "Humanoid"

            task.wait()

            character["1"]:Destroy()
            workspace.CurrentCamera.CameraSubject = character.Humanoid

            if character:FindFirstChild("Animate") then
                character.Animate.Disabled = true
                task.wait()
                character.Animate.Disabled = false
            end
        end
    end
})


local esp = visuals:AddSection("Esp", 1)
local chams1 = visuals:AddSection("Chams", 2)
local csettings = visuals:AddSection("Color Settings", 1)

local chams = {
    InvisibleChamsEnabled = false,
    invisibleColor = Color3.fromRGB(255, 0, 0),
    VisibleChamsEnabled = false,
    visibleColor = Color3.fromRGB(0, 255, 0),
    fillTransparency = 0.3
}

chams1:AddToggle({
    text = "Visible Chams",
    flag = "VisibleChamsColor",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        chams.VisibleChamsEnabled = state
    end
})
:AddColor({
    enabled = true,
    text = "Chams Color",
    color = Color3.fromRGB(0, 255, 0),
    flag = "visibleColor",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        chams.visibleColor = color
    end
})

chams1:AddToggle({
    text = "Invisible Chams",
    flag = "Invisible_Chams",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        chams.InvisibleChamsEnabled = state
    end
})
:AddColor({
    enabled = true,
    text = "Chams Color",
    color = Color3.fromRGB(255, 0, 0),
    flag = "invisibleColor",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        chams.invisibleColor = color
    end
})

chams1:AddSlider({
    enabled = true,
    text = "Transparency",
    flag = "fill_Transparency",
    suffix = "",
    dragging = true,
    focused = false,
    min = 0,
    max = 1,
    increment = 0.1,
    risky = false,
    callback = function(Value)
        chams.fillTransparency = Value
    end
})

local highlights = {}

function IsOnSameTeam(player)
    return player.Team == LocalPlayer.Team
end

function isVisible(character)
    local head = character:FindFirstChild("Head")
    if not head then
        return false
    end

    local origin = Camera.CFrame.Position
    local direction = (head.Position - origin)

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.IgnoreWater = true

    local result = workspace:Raycast(origin, direction, raycastParams)

    return result and result.Instance and result.Instance:IsDescendantOf(character)
end

function createHighlight(player)
    if not player.Character then
        return nil
    end
    local highlight = Instance.new("Highlight")
    highlight.Name = "ChamsHighlight"
    highlight.Adornee = player.Character
    highlight.FillTransparency = chams.fillTransparency or 0.3
    highlight.OutlineTransparency = 1
    highlight.Parent = player.Character
    return highlight
end

function removeHighlightsForPlayer(player)
    local h = highlights[player]
    if h and typeof(h.Highlight) == "Instance" and h.Highlight.Destroy then
        h.Highlight:Destroy()
    end
    highlights[player] = nil
end

function updateChams(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        removeHighlightsForPlayer(player)
        return
    end

    if IsOnSameTeam(player) then
        removeHighlightsForPlayer(player)
        return
    end

    if
        not highlights[player] or not highlights[player].Highlight or
            not highlights[player].Highlight:IsDescendantOf(game)
     then
        removeHighlightsForPlayer(player)
        local newHighlight = createHighlight(player)
        if newHighlight then
            highlights[player] = {Highlight = newHighlight}
        else
            return
        end
    end

    local h = highlights[player].Highlight
    if not h then
        return
    end

    h.FillTransparency = chams.fillTransparency or 0.3
    h.OutlineTransparency = 1

    if chams.VisibleChamsEnabled and isVisible(player.Character) then
        h.FillColor = chams.visibleColor
        h.OutlineColor = chams.visibleColor
        h.DepthMode = Enum.HighlightDepthMode.Occluded
        h.Enabled = true
    elseif chams.InvisibleChamsEnabled then
        h.FillColor = chams.invisibleColor
        h.OutlineColor = chams.invisibleColor
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Enabled = true
    else
        h.Enabled = false
    end
end

Players.PlayerAdded:Connect(
    function(player)
        player.CharacterAdded:Connect(
            function()
                task.wait(1)
                updateChams(player)
            end
        )
    end
)

Players.PlayerRemoving:Connect(
    function(player)
        removeHighlightsForPlayer(player)
    end
)

RunService.RenderStepped:Connect(
    function()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                pcall(
                    function()
                        updateChams(player)
                    end
                )
            end
        end
    end
)

chams1:AddToggle({
    text = "Arms Chams",
    flag = "Arms_Chams",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        ArmsChams = state
    end
})

chams1:AddToggle({
    text = "View Model Chams",
    flag = "WMC",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        GunsChams = state
    end
})
:AddColor({
    enabled = true,
    text = "Chams Color",
    color = Color3.fromRGB(255, 255, 255),
    flag = "VMCC",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        ChamsColor = color
    end
})

local notifiedPlayers = {}

local Settings = {
    Box_Color = Color3.fromRGB(255, 0, 0),
    Tracer_Color = Color3.fromRGB(255, 0, 0),
    Name_Color = Color3.fromRGB(255, 0, 0),
    Distance_Color = Color3.fromRGB(255, 0, 0),
    Gun_Color = Color3.fromRGB(255, 0, 0),
    Box_Visible_Color = Color3.fromRGB(0, 255, 0),
    Tracer_Visible_Color = Color3.fromRGB(0, 255, 0),
    Name_Visible_Color = Color3.fromRGB(0, 255, 0),
    Distance_Visible_Color = Color3.fromRGB(0, 255, 0),
    Gun_Visible_Color = Color3.fromRGB(0, 255, 0),
    Tracer_Thickness = 1,
    Box_Thickness = 1,
    Tracer_Origin = "Bottom",
    Tracer_FollowMouse = false,
    Tracers = false,
    HealthBar = false,
    ArmorBar = false,
    ShowName = false,
    ShowDistance = false,
    ShowGun = false,
    ShowC4 = false,
    BoxESP = false,
    TeamCheck = true,
}

local player = game:GetService("Players").LocalPlayer
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()

local function IsOnSameTeam(plr)
    if not plr.Team or not player.Team then return false end
    return plr.Team == player.Team
end

local function IsVisible(targetPart)
    local origin = camera.CFrame.Position
    local direction = (targetPart.Position - origin).Unit * 500
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {player.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.IgnoreWater = true
    local raycastResult = workspace:Raycast(origin, direction, raycastParams)
    if raycastResult then
        if raycastResult.Instance:IsDescendantOf(targetPart.Parent) then return true else return false end
    else
        return true
    end
end

function NewQuad(thickness, color)
    local quad = Drawing.new("Quad")
    quad.Visible = false
    quad.PointA = Vector2.new(0, 0)
    quad.PointB = Vector2.new(0, 0)
    quad.PointC = Vector2.new(0, 0)
    quad.PointD = Vector2.new(0, 0)
    quad.Color = color
    quad.Filled = false
    quad.Thickness = thickness
    quad.Transparency = 1
    return quad
end

function NewLine(thickness, color)
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = color
    line.Thickness = thickness
    line.Transparency = 1
    return line
end

function NewText(size, color)
    local text = Drawing.new("Text")
    text.Visible = false
    text.Center = true
    text.Outline = true
    text.Font = 2
    text.Size = size
    text.Color = color
    return text
end

local black = Color3.fromRGB(0, 0, 0)

local function getEquippedToolName(character)
    local eq = character:FindFirstChild("EquippedTool")
    if eq then
        if eq:IsA("StringValue") then
            return eq.Value
        elseif eq:IsA("Tool") then
            return eq.Name
        elseif eq:FindFirstChildOfClass("Tool") then
            return eq:FindFirstChildOfClass("Tool").Name
        end
    end
    return "empty"
end

function ESP(plr)
    local library = {
        blacktracer = NewLine(Settings.Tracer_Thickness * 2, black),
        tracer = NewLine(Settings.Tracer_Thickness, Settings.Tracer_Color),
        black = NewQuad(Settings.Box_Thickness * 2, black),
        box = NewQuad(Settings.Box_Thickness, Settings.Box_Color),
        healthbar = NewLine(3, black),
        greenhealth = NewLine(1.5, black),
        armorbar = NewLine(3, black),
        bluearmor = NewLine(1.5, Color3.fromRGB(50, 150, 255)),
        nametext = NewText(11, Color3.fromRGB(255, 255, 255)),
        distancetext = NewText(13, Color3.fromRGB(200, 200, 200)),
        guntext = NewText(12, Color3.fromRGB(200, 200, 200)),
        cashtxt = NewText(10, Color3.fromRGB(173, 255, 47)),
        pingtext = NewText(10, Color3.fromRGB(255, 255, 255)),
        c4text = NewText(10, Color3.fromRGB(255, 0, 0)),
    }

    local function Size(item, HumPos, DistanceY)
        item.PointA = Vector2.new(HumPos.X + DistanceY, HumPos.Y - DistanceY * 2)
        item.PointB = Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY * 2)
        item.PointC = Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY * 2)
        item.PointD = Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY * 2)
    end

    local connection
    connection = game:GetService("RunService").RenderStepped:Connect(function()
        if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") or not plr.Character:FindFirstChild("Head") then
            for _, x in pairs(library) do
                x.Visible = false
            end
            return
        end

        local HumPos, OnScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
        local headPos = camera:WorldToViewportPoint(plr.Character.Head.Position)
        local DistanceY = math.clamp((Vector2.new(headPos.X, headPos.Y) - Vector2.new(HumPos.X, HumPos.Y)).Magnitude, 2, math.huge)

        if not OnScreen or (Settings.TeamCheck and IsOnSameTeam(plr)) then
            for _, x in pairs(library) do
                x.Visible = false
            end
            return
        end

        local visible = IsVisible(plr.Character.HumanoidRootPart)

        if Settings.BoxESP then
            Size(library.box, HumPos, DistanceY)
            Size(library.black, HumPos, DistanceY)
            library.box.Visible = true
            library.black.Visible = true
            library.box.Color = visible and Settings.Box_Visible_Color or Settings.Box_Color
        else
            library.box.Visible = false
            library.black.Visible = false
        end

        if Settings.Tracers then
            local fromPos = (Settings.Tracer_Origin == "Middle") and camera.ViewportSize * 0.5 or Vector2.new(camera.ViewportSize.X * 0.5, camera.ViewportSize.Y)
            if Settings.Tracer_FollowMouse then
                fromPos = Vector2.new(mouse.X, mouse.Y + 36)
            end
            local toPos = Vector2.new(HumPos.X, HumPos.Y + DistanceY * 2)
            library.tracer.From = fromPos
            library.tracer.To = toPos
            library.blacktracer.From = fromPos
            library.blacktracer.To = toPos
            library.tracer.Visible = true
            library.blacktracer.Visible = true
            library.tracer.Color = visible and Settings.Tracer_Visible_Color or Settings.Tracer_Color
        else
            library.tracer.Visible = false
            library.blacktracer.Visible = false
        end

        if Settings.HealthBar then
            local d = (Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY * 2) - Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY * 2)).Magnitude
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local healthPercent = humanoid.Health / humanoid.MaxHealth
                local healthoffset = healthPercent * d
                library.greenhealth.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY * 2)
                library.greenhealth.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY * 2 - healthoffset)
                library.healthbar.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY * 2)
                library.healthbar.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y - DistanceY * 2)
                local green = Color3.fromRGB(0, 255, 0)
                local red = Color3.fromRGB(255, 0, 0)
                library.greenhealth.Color = red:lerp(green, healthPercent)
                library.greenhealth.Visible = true
                library.healthbar.Visible = true
            end
        else
            library.greenhealth.Visible = false
            library.healthbar.Visible = false
        end

        if Settings.ArmorBar then
            local d = (Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY * 2) - Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY * 2)).Magnitude
            local kevlarValue = plr:FindFirstChild("Kevlar") and plr.Kevlar.Value or 0
            kevlarValue = math.clamp(kevlarValue, 0, 100)
            local armoroffset = (kevlarValue / 100) * d
            library.armorbar.From = Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY * 2 + 4)
            library.armorbar.To = Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY * 2 + 4)
            library.bluearmor.From = Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY * 2 + 4)
            library.bluearmor.To = Vector2.new(HumPos.X - DistanceY + armoroffset, HumPos.Y + DistanceY * 2 + 4)
            library.armorbar.Visible = true
            library.bluearmor.Visible = true
        else
            library.armorbar.Visible = false
            library.bluearmor.Visible = false
        end

        if Settings.ShowName then
            library.nametext.Text = plr.Name
            library.nametext.Position = Vector2.new(HumPos.X, HumPos.Y - DistanceY * 2 - 15)
            library.nametext.Visible = true
            library.nametext.Color = visible and Settings.Name_Visible_Color or Settings.Name_Color
        else
            library.nametext.Visible = false
        end

        if Settings.ShowDistance then
            local dist = (plr.Character.HumanoidRootPart.Position - camera.CFrame.Position).Magnitude
            library.distancetext.Text = tostring(math.floor(dist)) .. "m"
            library.distancetext.Position = Vector2.new(HumPos.X, HumPos.Y + DistanceY * 2 + 7)
            library.distancetext.Visible = true
            library.distancetext.Color = visible and Settings.Distance_Visible_Color or Settings.Distance_Color
        else
            library.distancetext.Visible = false
        end

        if Settings.ShowGun then
            local gunName = getEquippedToolName(plr.Character)
            library.guntext.Text = "(" .. gunName .. ")"
            library.guntext.Position = Vector2.new(HumPos.X, HumPos.Y + DistanceY * 2 + 20)
            library.guntext.Visible = true
            library.guntext.Color = visible and Settings.Gun_Visible_Color or Settings.Gun_Color
        else
            library.guntext.Visible = false
        end

        if Settings.ShowC4 then
            local hasC4 = plr:FindFirstChild("HasC4") and plr.HasC4.Value or false
            if hasC4 and not notifiedPlayers[plr.Name] then
                library:SendNotification(plr.Name .. " has the C4")
                notifiedPlayers[plr.Name] = true
            elseif not hasC4 then
                notifiedPlayers[plr.Name] = nil
            end
            library.c4text.Visible = false
        else
            library.c4text.Visible = false
        end
    end)
end

for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
    if v ~= player then
        ESP(v)
    end
end

game:GetService("Players").PlayerAdded:Connect(function(v)
    ESP(v)
end)

esp:AddToggle({
    text = "Box Esp",
    flag = "BoxESP",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        Settings.BoxESP = state
    end
})

esp:AddToggle({
    text = "Health Esp",
    flag = "HealthBar",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        Settings.HealthBar = state
    end
})

esp:AddToggle({
    text = "Armor Esp",
    flag = "ArmorBar",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        Settings.ArmorBar = state
    end
})

esp:AddToggle({
    text = "Name Esp",
    flag = "ShowName",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        Settings.ShowName = state
    end
})

esp:AddToggle({
    text = "Distance Esp",
    flag = "ShowDistance",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        Settings.ShowDistance = state
    end
})

esp:AddToggle({
    text = "Weapon Esp",
    flag = "ShowGun",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        Settings.ShowGun = state
    end
})

esp:AddToggle({
    text = "Snap Lines",
    flag = "Tracers",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        Settings.Tracers = state
    end
})

esp:AddToggle({
    text = "C4 Carrier",
    flag = "ShowC4",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        Settings.ShowC4 = state
    end
})

csettings:AddColor({
    enabled = true,
    text = "Visible Box",
    tooltip = "",
    color = Color3.fromRGB(0, 255, 0),
    flag = "Vis_Box",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        Settings.Box_Color = color
    end
})

csettings:AddColor({
    enabled = true,
    text = "Visible Tracer",
    tooltip = "",
    color = Color3.fromRGB(0, 255, 0),
    flag = "Vis_Trace",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        Settings.Tracer_Color = color
    end
})


csettings:AddColor({
    enabled = true,
    text = "Visible Name",
    tooltip = "",
    color = Color3.fromRGB(0, 255, 0),
    flag = "Vis_Name",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        Settings.Name_Color = color
    end
})

csettings:AddColor({
    enabled = true,
    text = "Visible Distance",
    tooltip = "",
    color = Color3.fromRGB(0, 255, 0),
    flag = "Vis_distance",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        Settings.Distance_Color = color
    end
})

csettings:AddColor({
    enabled = true,
    text = "Visible Weapon",
    tooltip = "",
    color = Color3.fromRGB(0, 255, 0),
    flag = "Vis_Weapon",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        Settings.Gun_Color = color
    end
})

csettings:AddSeparator({
    enabled = true,
    text = "Invisible Color"
})

csettings:AddColor({
    enabled = true,
    text = "Invisible Box",
    tooltip = "",
    color = Color3.fromRGB(255, 0, 0),
    flag = "Box_Invisible_Color",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        Settings.Box_Visible_Color = color
    end
})

csettings:AddColor({
    enabled = true,
    text = "Invisible Tracer",
    tooltip = "",
    color = Color3.fromRGB(255, 0, 0),
    flag = "Tracer_Invisible_Color",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        Settings.Tracer_Visible_Color = color
    end
})

csettings:AddColor({
    enabled = true,
    text = "Invisible Name",
    tooltip = "",
    color = Color3.fromRGB(255, 0, 0),
    flag = "Name_Invisible_Color",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        Settings.Name_Visible_Color = color
    end
})

csettings:AddColor({
    enabled = true,
    text = "Invisible Distance",
    tooltip = "",
    color = Color3.fromRGB(255, 0, 0),
    flag = "Distance_Invisible_Color",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        Settings.Distance_Visible_Color = color
    end
})

csettings:AddColor({
    enabled = true,
    text = "Invisible Weapon",
    tooltip = "",
    color = Color3.fromRGB(255, 0, 0),
    flag = "Weapon_Invisible_Color",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        Settings.Gun_Visible_Color = color
    end
})

local world = visuals:AddSection("World", 2)
local worlde = visuals:AddSection("Extra", 1)

getgenv().ThirdPerson = false
local ThirdPersonDistance = 10

world:AddToggle({
    text = "Third Person",
    flag = "TP",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        ThirdPerson = state
    end
}):AddBind({
    enabled = true,
    text = "Third Person Toggle",
    tooltip = "Toggle third person camera",
    mode = "toggle",
    bind = "None", 
    flag = "ThirdPersonToggleKey",
    state = false,
    callback = function(v)
        getgenv().ThirdPerson = v
    end,
    keycallback = function()
        getgenv().ThirdPerson = not getgenv().ThirdPerson
    end
})

world:AddSlider({
    enabled = true,
    text = "Third Person Distance",
    flag = "TPD",
    suffix = "",
    dragging = true,
    focused = false,
    value = 10,
    min = 0,
    max = 100,
    increment = 1,
    risky = false,
    callback = function(Value)
        ThirdPersonDistance = value
    end
})

world:AddSlider({
    enabled = true,
    text = "Fov Changer",
    flag = "TPD",
    suffix = "",
    dragging = true,
    focused = false,
    value = 80,
    min = 0,
    max = 120,
    increment = 1,
    risky = false,
    callback = function(Value)
        FieldOfView = Value
    end
})

RunService.RenderStepped:Connect(
    function()
        if Bhop == true then
            if
                LocalPlayer.Character and UserInputService:IsKeyDown(Enum.KeyCode.Space) and
                    not LocalPlayer.PlayerGui.GUI.Main.GlobalChat.Visible
             then
                LocalPlayer.Character.Humanoid.Jump = true
                local Speed = BhopSpeed or 100
                local Dir = Camera.CFrame.LookVector * Vector3.new(1, 0, 1)
                local Move = Vector3.new()

                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    Move = Move + Dir
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    Move = Move - Dir
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    Move = Move + Vector3.new(-Dir.Z, 0, Dir.X)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    Move = Move + Vector3.new(Dir.Z, 0, -Dir.X)
                end

                if Move.Magnitude > 0 then
                    Move = Move.Unit
                    LocalPlayer.Character.HumanoidRootPart.Velocity =
                        Vector3.new(Move.X * Speed, LocalPlayer.Character.HumanoidRootPart.Velocity.Y, Move.Z * Speed)
                end
            end
        end
    end
)

local Terrain = workspace:FindFirstChildOfClass("Terrain")
local Lighting = game:GetService("Lighting")
local NightModeEnabled = false
local NightModeColor = Color3.fromRGB(50, 50, 50)
local NightModeBrightness = 0.2

function updateNightMode()
    if NightModeEnabled then
        Lighting.Ambient = NightModeColor
        Lighting.OutdoorAmbient = NightModeColor
        Lighting.Brightness = NightModeBrightness
        Lighting.EnvironmentDiffuseScale = 0.1
        Lighting.EnvironmentSpecularScale = 0
    else
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 1
        Lighting.EnvironmentDiffuseScale = 1
        Lighting.EnvironmentSpecularScale = 1
    end
end

world:AddToggle({
    text = "Night Mode",
    flag = "NM",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        NightModeEnabled = state
        updateNightMode()
    end
})
:AddColor({
    enabled = true,
    tooltip = "",
    color = Color3.fromRGB(255, 0, 0),
    flag = "NMCP",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        NightModeColor = color
        if NightModeEnabled then
            updateNightMode()
        end
    end
})

world:AddSlider({
    enabled = true,
    text = "Night Mode Brightness",
    flag = "NMB",
    suffix = "",
    dragging = true,
    focused = false,
    min = 0,
    max = 10,
    increment = 1,
    risky = false,
    callback = function(Value)
        NightModeBrightness = Value / 100
        if NightModeEnabled then
            updateNightMode()
        end
    end
})

-- Fog
local FogEnabled = false
local FogStart = 500
local FogEnd = 1000
local FogColor = Color3.fromRGB(255, 0, 0)

function updateFog()
    if FogEnabled then
        Lighting.FogStart = FogStart
        Lighting.FogEnd = FogEnd
        Lighting.FogColor = FogColor
    else
        Lighting.FogStart = 0
        Lighting.FogEnd = 100000
        Lighting.FogColor = Color3.new(1, 1, 1)
    end
end

world:AddToggle({
    text = "Fog",
    flag = "Fog",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        FogEnabled = state
        updateFog()
    end
})
:AddColor({
    enabled = true,
    tooltip = "",
    color = Color3.fromRGB(255, 0, 0),
    flag = "FC",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        FogColor = color
        updateFog()
    end
})
world:AddSlider({
    enabled = true,
    text = "Fog Start",
    flag = "FS",
    suffix = "",
    dragging = true,
    focused = false,
    value = 500,
    min = 0,
    max = 10000,
    increment = 1,
    risky = false,
    callback = function(Value)
        FogStart = Value
        updateFog()
    end
})

world:AddSlider({
    enabled = true,
    text = "Fog End",
    flag = "FE",
    suffix = "",
    dragging = true,
    focused = false,
    value = 1000,
    min = 0,
    max = 10000,
    increment = 1,
    risky = false,
    callback = function(Value)
        FogEnd = Value
        updateFog()
    end
})

function setPotatoMode(state)
    if state then
        Lighting.GlobalShadows = false
        Lighting.Brightness = 0
        Lighting.FogStart = 0
        Lighting.FogEnd = 100000
        Lighting.FogColor = Color3.new(1, 1, 1)
        Lighting.Ambient = Color3.new(0, 0, 0)
    else
        Lighting.GlobalShadows = true
        updateNightMode()
        updateFog()
    end
end

world:AddToggle({
    text = "Potato Mode",
    flag = "PM",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        setPotatoMode = state
    end
})

Skyboxes = {
    ["Red Mountains"] = "rbxassetid://109507439405212",
    ["Red Galaxy"] = "rbxassetid://16553683517",
    ["Nebula"] = "rbxassetid://108530355323087",
    ["Purple Mountains"] = "rbxassetid://16932794531"
}

local CustomSkyboxEnabled = false
local SelectedSkybox = "Purple Mountains"

function setSkybox(assetId)
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if not sky then
        sky = Instance.new("Sky")
        sky.Name = "CustomSky"
        sky.Parent = Lighting
    end

    sky.SkyboxBk = assetId
    sky.SkyboxDn = assetId
    sky.SkyboxFt = assetId
    sky.SkyboxLf = assetId
    sky.SkyboxRt = assetId
    sky.SkyboxUp = assetId
end

world:AddToggle({
    text = "Enable Custom Skybox",
    flag = "SkyboxE",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        CustomSkyboxEnabled = state
        if CustomSkyboxEnabled and Skyboxes[SelectedSkybox] then
            setSkybox(Skyboxes[SelectedSkybox])
        end
    end
})

world:AddList({
    enabled = true,
    text = "Skyboxes", 
    flag = "Skyboxes",
    tooltip = "",
    selected = "Purple Mountains",
    multi = false,
    open = false,
    max = 4,
    values = {"Red Mountains", "Red Galaxy", "Nebula", "Purple Mountains"},
    risky = false,
    callback = function(value)
        SelectedSkybox = Value
        if CustomSkyboxEnabled and Skyboxes[Value] then
            setSkybox(Skyboxes[Value])
        end
    end
})

local RayIgnore = workspace.Ray_Ignore

worlde:AddToggle({
    text = "Molly Radius",
    flag = "M_R",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        world1.mollyRadiusEnabled = state
    end
})
:AddColor({
    enabled = true,
    tooltip = "",
    color = Color3.fromRGB(255, 255, 255),
    flag = "MRC",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        world1.mollyRadiusColor = color
    end
})
worlde:AddToggle({
    text = "Smoke Radius",
    flag = "S_R",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        world1.smokeRadiusEnabled = state
    end
})
:AddColor({
    enabled = true,
    tooltip = "",
    color = Color3.fromRGB(255, 255, 255),
    flag = "SRC",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        world1.smokeRadiusColor = color
    end
})
worlde:AddToggle({
    text = "Bullet Tracers",
    flag = "BT",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        world1.bulletTracersEnabled = state
    end
})
:AddColor({
    enabled = true,
    tooltip = "",
    color = Color3.fromRGB(255, 255, 255),
    flag = "BTC",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        world1.bulletTracersColor = color
    end
})
worlde:AddToggle({
    text = "Bullet Impacts",
    flag = "BI",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        world1.BulletImpacts = state
    end
})
:AddColor({
    enabled = true,
    tooltip = "",
    color = Color3.fromRGB(255, 255, 255),
    flag = "BIC",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        world1.BulletImpactsColor = newColor
    end
})

worlde:AddToggle({
    text = "Hit Chams",
    flag = "HitChamsToggle",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        world1.hitChams.Toggle = state
    end
})
:AddColor({
    enabled = true,
    tooltip = "Hit Chams Color",
    color = world1.hitChams.Color or Color3.new(1, 0, 0), -- default red
    flag = "HitChamsColor",
    trans = 0,
    open = false,
    risky = false,
    callback = function(newColor)
        world1.hitChams.Color = newColor
    end
})

function decodePos(encodedPos)
    return Vector3.new(((encodedPos.X / 13 - 1325) / 4) + 74312,((encodedPos.Y + 4201432) / 4) - 3183421,((encodedPos.Z / 2 + 581357) / 41))
end

local tracerDebounce = false

function createTracer(to, from, color)
    color = color or world1.bulletTracersColor

    if not tracerDebounce then
        tracerDebounce = true
        spawn(
            function()
                wait()
                tracerDebounce = false
            end
        )

        to = from.Position + (to - from.Position).Unit * 100

        local part1 = Instance.new("Part")
        local part2 = Instance.new("Part")
        local beam = Instance.new("Beam")
        local beam2 = Instance.new("Beam")
        local attachment1 = Instance.new("Attachment")
        local attachment2 = Instance.new("Attachment")

        part1.Transparency = 1
        part1.Position = to
        part1.CanCollide = false
        part1.Anchored = true
        part1.Parent = workspace.Debris
        attachment1.Parent = part1

        part2.Transparency = 1
        part2.Position = from.Position
        part2.CanCollide = false
        part2.Anchored = true
        part2.Parent = workspace.Debris
        attachment2.Parent = part2

        beam.FaceCamera = true
        beam.Color = ColorSequence.new(color)
        beam.Transparency =
            NumberSequence.new {
            NumberSequenceKeypoint.new(0, 1 - 0.5),
            NumberSequenceKeypoint.new(1, 1 - 0.5)
        }
        beam.Width0 = 0.055
        beam.Width1 = 0.055
        beam.LightEmission = 1
        beam.LightInfluence = 0
        beam.Attachment0 = attachment1
        beam.Attachment1 = attachment2
        beam.Parent = part1

        beam2.FaceCamera = true
        beam2.Color = ColorSequence.new(Color3.new(1, 1, 1))
        beam2.Transparency =
            NumberSequence.new {
            NumberSequenceKeypoint.new(0, 1 - 0.75),
            NumberSequenceKeypoint.new(1, 1 - 0.75)
        }
        beam2.Width0 = 0.025
        beam2.Width1 = 0.025
        beam2.LightEmission = 1
        beam2.LightInfluence = 0
        beam2.Attachment0 = attachment1
        beam2.Attachment1 = attachment2
        beam2.Parent = part1

        spawn(
            function()
                wait(2)
                for i = 0.5, 0, -0.025 do
                    wait()
                    beam.Transparency =
                        NumberSequence.new {
                        NumberSequenceKeypoint.new(0, 1 - i),
                        NumberSequenceKeypoint.new(1, 1 - i)
                    }
                    beam2.Transparency =
                        NumberSequence.new {
                        NumberSequenceKeypoint.new(0, 0.75 - i),
                        NumberSequenceKeypoint.new(1, 0.75 - i)
                    }
                end
                for i = 0.25, 0, -0.025 do
                    wait()
                    beam2.Transparency =
                        NumberSequence.new {
                        NumberSequenceKeypoint.new(0, 1 - i),
                        NumberSequenceKeypoint.new(1, 1 - i)
                    }
                end
                beam:Destroy()
                beam2:Destroy()
            end
        )
    end
end

function impact(position)
    if not world1.BulletImpacts then return end

    local box = Instance.new("Part")
    box.Size = Vector3.new(0.3, 0.3, 0.3)
    box.Anchored = true
    box.CanCollide = false
    box.Position = position
    box.Color = world1.BulletImpactsColor
    box.Material = Enum.Material.ForceField
    box.Transparency = 0.5
    box.Parent = workspace.Debris

    task.delay(2.5, function()
        box:Destroy()
    end)
end

local meta = getrawmetatable(game)
setreadonly(meta, false)
local oldNamecall = meta.__namecall

meta.__namecall = newcclosure(function(self, ...)
    local argsCount = select("#", ...)
    local args = {...}
    local method = getnamecallmethod()

    if method == "FireServer" and self.Name == "HitPart" then
        spawn(function()
            local hitPos = decodePos(args[2])

            if world1.bulletTracersEnabled and LocalPlayer.Character and camera:FindFirstChild("Arms") then
                local from = camera.Arms:FindFirstChild("Flash")
                if from then
                    createTracer(hitPos, from)
                end
            end

            impact(hitPos)
        end)
    end

    return oldNamecall(self, table.unpack(args, 1, argsCount))
end)

setreadonly(meta, true)

local meta = getrawmetatable(game)
setreadonly(meta, false)
local oldNamecall = meta.__namecall

meta.__namecall = newcclosure(function(self, ...)
	local argsCount = select("#", ...)
	local args = {...}
	local method = getnamecallmethod()

	if method == "FireServer" and self.Name == "HitPart" then
		spawn(function()
			if world1.hitChams.Toggle then
				local hitPart = args[1]
				local hitCharacter = hitPart and hitPart.Parent
				local hitPlayer = Players:GetPlayerFromCharacter(hitCharacter)
				if hitPlayer and hitPlayer.Team ~= LocalPlayer.Team and hitCharacter then
					for _, part in pairs(hitCharacter:GetChildren()) do
						if part:IsA("BasePart") then
							local box = Instance.new("BoxHandleAdornment")
							box.Adornee = part
							box.AlwaysOnTop = true
							box.ZIndex = 10
							box.Size = part.Size
							box.Color3 = world1.hitChams.Color
							box.Transparency = 0.5
							box.Parent = part
							task.delay(2, function()
								if box and box.Parent then
									box:Destroy()
								end
							end)
						end
					end
				end
			end
		end)
	end

	return oldNamecall(self, table.unpack(args, 1, argsCount))
end)

setreadonly(meta, true)

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local GUI = PlayerGui:WaitForChild("GUI")
local Crosshairs = GUI:WaitForChild("Crosshairs")
local Crosshair = Crosshairs:WaitForChild("Crosshair")

local crosshairLength = 10
local crosshairEnabled = false
local borderEnabled = false

function UpdateCrosshair()
    local length = crosshairLength

    if crosshairEnabled then
        Crosshair.LeftFrame.Size = UDim2.new(0, length, 0, 2)
        Crosshair.RightFrame.Size = UDim2.new(0, length, 0, 2)
        Crosshair.TopFrame.Size = UDim2.new(0, 2, 0, length)
        Crosshair.BottomFrame.Size = UDim2.new(0, 2, 0, length)

        for _, frame in pairs(Crosshair:GetChildren()) do
            if string.find(frame.Name, "Frame") then
                frame.BorderColor3 = Color3.new(0, 0, 0)
                frame.BorderSizePixel = borderEnabled and 1 or 0
            end
        end
    else
        Crosshair.LeftFrame.Size = UDim2.new(0, 10, 0, 2)
        Crosshair.RightFrame.Size = UDim2.new(0, 10, 0, 2)
        Crosshair.TopFrame.Size = UDim2.new(0, 2, 0, 10)
        Crosshair.BottomFrame.Size = UDim2.new(0, 2, 0, 10)

        for _, frame in pairs(Crosshair:GetChildren()) do
            if string.find(frame.Name, "Frame") then
                frame.BorderSizePixel = 0
            end
        end
    end
end


local trail = {
    Enabled = false,
    Color = Color3.fromRGB(255, 255, 255),
    LastDropTime = 0,
    LastPosition = nil
}

function createTrailLine(startPos, endPos)
    local trailPart = Instance.new("Part")
    trailPart.Anchored = true
    trailPart.CanCollide = false
    trailPart.CastShadow = false
    trailPart.Material = Enum.Material.ForceField
    trailPart.Color = trail.Color
    trailPart.Transparency = 0
    trailPart.Name = "ForceFieldTrail"
    local distance = (endPos - startPos).Magnitude
    trailPart.Size = Vector3.new(0.1, 0.05, distance)
    trailPart.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -distance / 2)
    trailPart.Parent = workspace
    task.spawn(
        function()
            task.wait(1)
            for t = 0, 1, 0.05 do
                trailPart.Transparency = t
                task.wait(0.05)
            end
            trailPart:Destroy()
        end
    )
end

RunService.RenderStepped:Connect(
    function()
        if not trail.Enabled then
            return
        end
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then
            return
        end
        local now = tick()
        if now - trail.LastDropTime >= 0 then
            local root = character.HumanoidRootPart
            local footPos = root.Position - Vector3.new(0, root.Size.Y / 2 + 1, 0)
            if trail.LastPosition then
                createTrailLine(trail.LastPosition, footPos)
            end
            trail.LastPosition = footPos
            trail.LastDropTime = now
        end
    end
)

world:AddToggle({
    text = "Trail",
    flag = "Trail",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        trail.Enabled = state
    end
})
:AddColor({
    enabled = true,
    tooltip = "",
    color = Color3.fromRGB(255, 255, 255),
    flag = "TrailC",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        trail.Color = color
    end
})

LocalPlayer.Additionals.TotalDamage:GetPropertyChangedSignal("Value"):Connect(
    function(current)
        if current == 0 then
            return
        end
        coroutine.wrap(
            function()
                if world1.hitmarkerEnabled then
                    local Line = Drawing.new("Line")
                    local Line2 = Drawing.new("Line")
                    local Line3 = Drawing.new("Line")
                    local Line4 = Drawing.new("Line")
                    local x, y = Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2
                    Line.From = Vector2.new(x + 4, y + 4)
                    Line.To = Vector2.new(x + 10, y + 10)
                    Line.Color = world1.hitmarkerColor
                    Line.Visible = true
                    Line2.From = Vector2.new(x + 4, y - 4)
                    Line2.To = Vector2.new(x + 10, y - 10)
                    Line2.Color = world1.hitmarkerColor
                    Line2.Visible = true
                    Line3.From = Vector2.new(x - 4, y - 4)
                    Line3.To = Vector2.new(x - 10, y - 10)
                    Line3.Color = world1.hitmarkerColor
                    Line3.Visible = true
                    Line4.From = Vector2.new(x - 4, y + 4)
                    Line4.To = Vector2.new(x - 10, y + 10)
                    Line4.Color = world1.hitmarkerColor
                    Line4.Visible = true
                    Line.Transparency = 1
                    Line2.Transparency = 1
                    Line3.Transparency = 1
                    Line4.Transparency = 1
                    Line.Thickness = 1
                    Line2.Thickness = 1
                    Line3.Thickness = 1
                    Line4.Thickness = 1
                    wait(0.3)
                    for i = 1, 0, -0.1 do
                        wait()
                        Line.Transparency = i
                        Line2.Transparency = i
                        Line3.Transparency = i
                        Line4.Transparency = i
                    end
                    Line:Remove()
                    Line2:Remove()
                    Line3:Remove()
                    Line4:Remove()
                end
            end
        )()
    end
)

local ESPTexts = {}

local itemesp = {
    ItemESPEnabled = false,
    ItemEspColor = Color3.fromRGB(255, 255, 255)
}

world:AddToggle({
    text = "Item ESP",
    flag = "Item_ESP",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        itemesp.ItemESPEnabled = state
        if not state then
            for weapon in pairs(ESPTexts) do
                if ESPTexts[weapon] then
                    ESPTexts[weapon]:Destroy()
                    ESPTexts[weapon] = nil
                end
            end
        end
    end
})
:AddColor({
    enabled = true,
    tooltip = "",
    color = Color3.fromRGB(255, 255, 255),
    flag = "Item_C",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        itemesp.ItemEspColor = color
        for weapon, billboard in pairs(ESPTexts) do
            local label = billboard:FindFirstChildOfClass("TextLabel")
            if label then
                label.TextColor3 = color
            end
        end
    end
})

function createESPForWeapon(weapon, color)
    if ESPTexts[weapon] or not weapon:IsA("BasePart") then
        return
    end
    if not Weapons:FindFirstChild(weapon.Name) then
        return
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPText"
    billboard.Adornee = weapon
    billboard.Size = UDim2.new(0, 100, 0, 10)
    billboard.StudsOffset = Vector3.new(0, 0, 0)
    billboard.AlwaysOnTop = true
    billboard.LightInfluence = 0
    billboard.Parent = weapon

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = color
    textLabel.TextStrokeTransparency = 0.5
    textLabel.Text = weapon.Name
    textLabel.TextScaled = true
    textLabel.TextYAlignment = Enum.TextYAlignment.Bottom
    textLabel.TextXAlignment = Enum.TextXAlignment.Center
    textLabel.Parent = billboard

    ESPTexts[weapon] = billboard
end

function removeESPForWeapon(weapon)
    if ESPTexts[weapon] then
        ESPTexts[weapon]:Destroy()
        ESPTexts[weapon] = nil
    end
end

function isPlayerDead()
    local character = LocalPlayer and LocalPlayer.Character
    if not character then
        return true
    end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    return not humanoid or humanoid.Health <= 0
end

function updateESP()
    if not itemesp.ItemESPEnabled or isPlayerDead() then
        for weapon in pairs(ESPTexts) do
            removeESPForWeapon(weapon)
        end
        return
    end

    for weapon in pairs(ESPTexts) do
        if not weapon:IsDescendantOf(workspace) or not Debris:FindFirstChild(weapon.Name) then
            removeESPForWeapon(weapon)
        end
    end

    for _, weapon in pairs(Debris:GetChildren()) do
        if weapon:IsA("BasePart") and Weapons:FindFirstChild(weapon.Name) then
            if not ESPTexts[weapon] then
                createESPForWeapon(weapon, itemesp.ItemEspColor)
            end
        end
    end
end

spawn(
    function()
        while true do
            updateESP()
            task.wait(1)
        end
    end
)

local RunService = game:GetService("RunService")

RayIgnore.ChildAdded:Connect(function(obj) 
	if obj.Name == "Fires" then 
		obj.ChildAdded:Connect(function(fire) 
			if world1.mollyRadiusEnabled then 
				fire.Transparency = world1.mollyRadiusTransparency
				fire.Color = world1.mollyRadiusColor
			end 
		end) 
	end 
	if obj.Name == "Smokes" then 
		obj.ChildAdded:Connect(function(smoke) 
			RunService.RenderStepped:Wait() 
			local OriginalRate = Instance.new ("NumberValue") 
			OriginalRate.Value = smoke.ParticleEmitter.Rate 
			OriginalRate.Name = "OriginalRate" 
			OriginalRate.Parent = smoke 
			if world1.RemoveSmokes then 
				smoke.ParticleEmitter.Rate = 0 
			end 
			smoke.Material = Enum.Material.ForceField 
			if world1.smokeRadiusEnabled then 
				smoke.Transparency = 0 
				smoke.Color = world1.smokeRadiusColor
			end 
		end) 
	end 
end) 

if RayIgnore:FindFirstChild("Fires") then 
	RayIgnore:FindFirstChild("Fires").ChildAdded:Connect(function(fire) 
		if world1.mollyRadiusEnabled then 
			fire.Transparency = world1.mollyRadiusTransparency
			fire.Color = world1.mollyRadiusColor
		end 
	end) 
end 
if RayIgnore:FindFirstChild("Smokes") then 
	for _,smoke in pairs(RayIgnore:FindFirstChild("Smokes"):GetChildren()) do 
		local OriginalRate = Instance.new("NumberValue") 
		OriginalRate.Value = smoke.ParticleEmitter.Rate 
		OriginalRate.Name = "OriginalRate" 
		OriginalRate.Parent = smoke 
		smoke.Material = Enum.Material.ForceField 
	end 
	RayIgnore:FindFirstChild("Smokes").ChildAdded:Connect(function(smoke) 
		RunService.RenderStepped:Wait() 
		local OriginalRate = Instance.new("NumberValue") 
		OriginalRate.Value = smoke.ParticleEmitter.Rate 
		OriginalRate.Name = "OriginalRate" 
		OriginalRate.Parent = smoke 
		if world1.RemoveSmoke then 
			smoke.ParticleEmitter.Rate = 0 
		end 
		smoke.Material = Enum.Material.ForceField 
		if world1.smokeRadiusEnabled then 
			smoke.Transparency = 0 
			smoke.Color = world1.smokeRadiusColor
		end 
	end) 
end

local ArmColor = ArmColor or Color3.fromRGB(200, 200, 200)

RunService.RenderStepped:Connect(
    function()
        if GunsChams == true then
            for _, Stuff in ipairs(workspace.Camera:GetChildren()) do
                if Stuff:IsA("Model") and Stuff.Name == "Arms" then
                    for _, AnotherStuff in ipairs(Stuff:GetChildren()) do
                        if AnotherStuff:IsA("MeshPart") or AnotherStuff:IsA("BasePart") then
                            AnotherStuff.Color = ChamsColor or Color3.fromRGB(200, 200, 200)
                            AnotherStuff.Material = Enum.Material.ForceField
                        end
                    end
                end
            end
        else
            for _, Stuff in ipairs(workspace.Camera:GetChildren()) do
                if Stuff:IsA("Model") and Stuff.Name == "Arms" then
                    for _, AnotherStuff in ipairs(Stuff:GetChildren()) do
                        if AnotherStuff:IsA("MeshPart") or AnotherStuff:IsA("BasePart") then
                            AnotherStuff.Color = ChamsColor or Color3.fromRGB(200, 200, 200)
                            AnotherStuff.Material = Enum.Material.Plastic
                        end
                    end
                end
            end
        end
        task.wait()
    end
)

RunService.RenderStepped:Connect(
    function()
        if ArmsChams == true then
            for _, Stuff in ipairs(workspace.Camera:GetChildren()) do
                if Stuff:IsA("Model") and Stuff.Name == "Arms" then
                    for _, AnotherStuff in ipairs(Stuff:GetChildren()) do
                        if AnotherStuff:IsA("Model") and AnotherStuff.Name ~= "AnimSaves" then
                            for _, Arm in ipairs(AnotherStuff:GetChildren()) do
                                if Arm:IsA("BasePart") then
                                    Arm.Transparency = 1
                                    Arm.Color = ArmColor
                                    for _, StuffInArm in ipairs(Arm:GetChildren()) do
                                        if StuffInArm:IsA("BasePart") then
                                            StuffInArm.Material = Enum.Material.ForceField
                                            StuffInArm.Color = ArmColor or Color3.fromRGB(200, 200, 200)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            for _, Stuff in ipairs(workspace.Camera:GetChildren()) do
                if Stuff:IsA("Model") and Stuff.Name == "Arms" then
                    for _, AnotherStuff in ipairs(Stuff:GetChildren()) do
                        if AnotherStuff:IsA("Model") and AnotherStuff.Name ~= "AnimSaves" then
                            for _, Arm in ipairs(AnotherStuff:GetChildren()) do
                                if Arm:IsA("BasePart") then
                                    Arm.Transparency = 0
                                    Arm.Color = ArmColor
                                    for _, StuffInArm in ipairs(Arm:GetChildren()) do
                                        if StuffInArm:IsA("BasePart") then
                                            StuffInArm.Material = Enum.Material.Plastic
                                            StuffInArm.Color = ArmColor or Color3.fromRGB(200, 200, 200)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        task.wait()
    end
)

RunService.RenderStepped:Connect(function()
    if getgenv().ThirdPerson then
        LocalPlayer.CameraMinZoomDistance = ThirdPersonDistance
        LocalPlayer.CameraMaxZoomDistance = ThirdPersonDistance
        if workspace:FindFirstChild("ThirdPerson") then
            workspace.ThirdPerson.Value = true
        end
    else
        LocalPlayer.CameraMinZoomDistance = 0
        LocalPlayer.CameraMaxZoomDistance = 0
        if workspace:FindFirstChild("ThirdPerson") then
            workspace.ThirdPerson.Value = false
        end
    end
end)

RunService.RenderStepped:Connect(
    function()
        Camera.FieldOfView = FieldOfView or 80
        task.wait()
    end
)

local models = misc:AddSection("Model Changer", 1)

local Skins = ReplicatedStorage:WaitForChild("Skins")

local Models = game:GetObjects("rbxassetid://7285197035")[1]
repeat
    wait()
until Models ~= nil
local ChrModels = game:GetObjects("rbxassetid://7642937303")[1]
repeat
    wait()
until ChrModels ~= nil

local AllCharacters = {}

for i, v in pairs(ChrModels:GetChildren()) do
    table.insert(AllCharacters, v.Name)
end

local characterChangerEnabled = false
local selectedCharacter = AllCharacters[1] or nil
local OriginalCharacter = nil

models:AddToggle({
    text = "Character Changer",
    flag = "C_C",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        characterChangerEnabled = state

        if state then
            local character = LocalPlayer.Character
            if not character or not character:FindFirstChild("Gun") then return end

            if not OriginalCharacter then
                OriginalCharacter = Instance.new("Model")
                OriginalCharacter.Name = "OriginalCharacter"

                for _, item in pairs(character:GetChildren()) do
                    if item:IsA("Accessory") or item:IsA("BasePart") or item:IsA("Shirt") or item:IsA("Pants") then
                        item:Clone().Parent = OriginalCharacter
                    end
                end
            end

            if not selectedCharacter then return end
            local newChar = ChrModels:FindFirstChild(selectedCharacter)
            if newChar then
                ChangeCharacter(newChar)
            end
        else
            RestoreOriginal()
        end
    end
})

models:AddList({
    enabled = true,
    text = "Character Skin",
    flag = "C_S",
    tooltip = "",
    selected = "none",
    multi = true,
    open = false,
    values = AllCharacters,
    risky = false,
    callback = function(value)
        selectedCharacter = value

        if characterChangerEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Gun") then
            if not ChrModels then return end

            local newChar = ChrModels:FindFirstChild(selectedCharacter)
            if newChar then
                ChangeCharacter(newChar)
            end
        end
    end
})

SelfObj = {}

LocalPlayer.CharacterAdded:Connect(
    function(char)
        repeat
            RunService.RenderStepped:Wait()
        until char:FindFirstChild("Gun")

        if characterChangerEnabled then
            local newChar = ChrModels:FindFirstChild(selectedCharacter)
            if newChar then
                ChangeCharacter(newChar)
            end
        end
    end
)

function ChangeCharacter(NewCharacter)
    SelfObj = {}

    for _, Part in pairs(LocalPlayer.Character:GetChildren()) do
        if Part:IsA("Accessory") then
            Part:Destroy()
        end
        if Part:IsA("BasePart") then
            if NewCharacter:FindFirstChild(Part.Name) then
                Part.Color = NewCharacter:FindFirstChild(Part.Name).Color
                Part.Transparency = NewCharacter:FindFirstChild(Part.Name).Transparency
            end
            if Part.Name == "FakeHead" then
                Part.Color = NewCharacter:FindFirstChild("Head").Color
                Part.Transparency = NewCharacter:FindFirstChild("Head").Transparency
            end
        end

        if
            (Part.Name == "Head" or Part.Name == "FakeHead") and Part:FindFirstChildOfClass("Decal") and
                NewCharacter.Head:FindFirstChildOfClass("Decal")
         then
            Part:FindFirstChildOfClass("Decal").Texture = NewCharacter.Head:FindFirstChildOfClass("Decal").Texture
        end
    end

    if NewCharacter:FindFirstChildOfClass("Shirt") then
        if LocalPlayer.Character:FindFirstChildOfClass("Shirt") then
            LocalPlayer.Character:FindFirstChildOfClass("Shirt"):Destroy()
        end
        local Clone = NewCharacter:FindFirstChildOfClass("Shirt"):Clone()
        Clone.Parent = LocalPlayer.Character
    end

    if NewCharacter:FindFirstChildOfClass("Pants") then
        if LocalPlayer.Character:FindFirstChildOfClass("Pants") then
            LocalPlayer.Character:FindFirstChildOfClass("Pants"):Destroy()
        end
        local Clone = NewCharacter:FindFirstChildOfClass("Pants"):Clone()
        Clone.Parent = LocalPlayer.Character
    end

    for _, Part in pairs(NewCharacter:GetChildren()) do
        if Part:IsA("Accessory") then
            local Clone = Part:Clone()
            for _, Weld in pairs(Clone.Handle:GetChildren()) do
                if Weld:IsA("Weld") and Weld.Part1 ~= nil then
                    Weld.Part1 = LocalPlayer.Character[Weld.Part1.Name]
                end
            end
            Clone.Parent = LocalPlayer.Character
        end
    end

    if LocalPlayer.Character:FindFirstChildOfClass("Shirt") then
        local shirt = LocalPlayer.Character:FindFirstChildOfClass("Shirt")
        local String = Instance.new("StringValue")
        String.Name = "OriginalTexture"
        String.Value = shirt.ShirtTemplate
        String.Parent = shirt
    end

    if LocalPlayer.Character:FindFirstChildOfClass("Pants") then
        local pants = LocalPlayer.Character:FindFirstChildOfClass("Pants")
        local String = Instance.new("StringValue")
        String.Name = "OriginalTexture"
        String.Value = pants.PantsTemplate
        String.Parent = pants
    end

    for i, v in pairs(LocalPlayer.Character:GetChildren()) do
        if v:IsA("BasePart") and v.Transparency ~= 1 then
            table.insert(SelfObj, v)
            local Color = Instance.new("Color3Value")
            Color.Name = "OriginalColor"
            Color.Value = v.Color
            Color.Parent = v

            local String = Instance.new("StringValue")
            String.Name = "OriginalMaterial"
            String.Value = v.Material.Name
            String.Parent = v
        elseif v:IsA("Accessory") and v.Handle.Transparency ~= 1 then
            table.insert(SelfObj, v.Handle)
            local Color = Instance.new("Color3Value")
            Color.Name = "OriginalColor"
            Color.Value = v.Handle.Color
            Color.Parent = v.Handle

            local String = Instance.new("StringValue")
            String.Name = "OriginalMaterial"
            String.Value = v.Handle.Material.Name
            String.Parent = v.Handle
        end
    end
end

local playerGui = LocalPlayer:WaitForChild("PlayerGui")
local clientScript = playerGui:WaitForChild("Client")
local client = getsenv(clientScript)
local firebullet = client.firebullet

client.firebullet = function(self, ...)
    if not menu or not menu.Enabled then
        return firebullet(self, ...)
    end
end

if Legit12.Tripletap and Legit12.Doubletap then
    client.firebullet()
    client.firebullet()
    client.firebullet()
end

if Legit12.Tripletap and Legit12.Doubletap then
    Client.firebullet()

    local tool = LocalPlayer.Character.EquippedTool.Value
    local gun = LocalPlayer.Character.Gun
    local position = EndHit.Position
    local emptyVec = Vector3.new()

    local Arguments = {
		[1] = EndHit,
		[2] = EndHit.Position,
		[3] = LocalPlayer.Character.EquippedTool.Value,
		[4] = 100,
		[5] = LocalPlayer.Character.Gun,
		[8] = 1,
		[9] = false,
		[10] = false,
		[11] = Vector3.new(),
		[12] = 100,
		[13] = Vector3.new()
	}

    game.ReplicatedStorage.Events.HitPart:FireServer(unpack(Arguments))
end


--// Aimbot
LeftGroupBox:AddToggle({
    text = "Silent Aim",
    flag = "Silent_Aim",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        Legit12.Legit_silent_aim_enabled = state
    end
})
LeftGroupBox:AddToggle({
    text = "Vis Check",
    flag = "Vis_check",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        Legit12.Legit_silent_aim_wall_check = state
    end
})
LeftGroupBox:AddToggle({
    text = "Fov Circle",
    flag = "Fov_circle",
    default = false,
    visible = true,
    risky = false,
    callback = function(state)
        Legit12.Legit_silent_aim_fov = state
    end
})
:AddColor({
    enabled = true,
    text = "Fov Color",
    tooltip = "tooltip1",
    color = Color3.fromRGB(255, 255, 255),
    flag = "Fov_color",
    trans = 0,
    open = false,
    risky = false,
    callback = function(color)
        fovCircle.Color = color
    end
})
LeftGroupBox:AddSlider({
    enabled = true,
    text = "Fov Angle",
    flag = "Fov_Angle",
    suffix = "",
    dragging = true,
    focused = false,
    default = 20,
    min = 0,
    max = 180,
    increment = 1,
    risky = false,
    callback = function(Value)
        Legit12.Legit_silent_aim_fov_radius = Value
    end
})
LeftGroupBox:AddSlider({
    enabled = true,
    text = "Hit Chance",
    flag = "Hit_chance",
    suffix = "",
    dragging = true,
    focused = false,
    default = 100,
    min = 0,
    max = 100,
    increment = 1,
    risky = false,
    callback = function(Value)
        Legit12.Legit_silent_aim_hit_chance = Value
    end
})
LeftGroupBox:AddList({
    enabled = true,
    text = "Hit Boxes",
    flag = "SA_boxes",
    tooltip = "",
    selected = "Head",
    multi = true,
    open = false,
    max = 4,
    values = {"Head", "Torso", "Arms", "Legs"},
    risky = false,
    callback = function(value)
        Legit12.Legit_silent_aim_hit_parts = value
    end
})

RightAimbot:AddToggle({
    text = "Prediction",
    flag = "prediction_enabled",
    default = true,
    callback = function(state)
        Legit12.prediction_enabled = state
    end
})

RightAimbot:AddToggle({
    text = "Auto Prediction",
    flag = "auto_prediction_enabled",
    default = false,
    callback = function(state)
        Legit12.auto_prediction_enabled = state
    end
})

RightAimbot:AddSlider({
    text = "Prediction Strength",
    flag = "prediction_strength",
    default = 1,
    min = 0,
    max = 2,
    increment = 0.1,
    callback = function(v)
        Legit12.prediction_strength = v
    end
})

RightAimbot:AddToggle({
    text = "Lag Compensation",
    flag = "lag_comp_enabled",
    default = true,
    callback = function(state)
        Legit12.lag_comp_enabled = state
    end
})

RightAimbot:AddSlider({
    text = "Lag Comp (ms)",
    flag = "lag_comp_ms",
    default = 100,
    min = 0,
    max = 300,
    increment = 10,
    callback = function(v)
        Legit12.lag_comp_ms = v
    end
})

task.spawn(function()
    while task.wait(0.5) do
        local rayIgnore = CWorkspace:FindFirstChild("Ray_Ignore")
        local map = CWorkspace:FindFirstChild("Map")

        if rayIgnore and map then
            if Legit12.silent_aim_magic_bullet then
                local rayGeometry = rayIgnore:FindFirstChild("Geometry")
                if rayGeometry then
                    if #rayGeometry:GetChildren() == 0 then
                        rayGeometry:Destroy()
                    end
                else
                    local mapGeometry = map:FindFirstChild("Geometry")
                    if mapGeometry then
                        mapGeometry.Parent = rayIgnore
                        mapGeometry.Name = "Geometry"
                    end
                    if not map:FindFirstChild("Geometry") then
                        local newGeometry = Instance.new("Folder")
                        newGeometry.Name = "Geometry"
                        newGeometry.Parent = map
                    end
                end
            else
                local rayGeometry = rayIgnore:FindFirstChild("Geometry")
                if rayGeometry then
                    local mapGeometry = map:FindFirstChild("Geometry")
                    if mapGeometry then
                        mapGeometry:Destroy()
                    end
                    rayGeometry.Parent = map
                    rayGeometry.Name = "Geometry"
                end
            end
        end
    end
end)
local closest
local findPartOnRayWithIgnoreList = {
    ArgCountRequired = 3,
    Args = {
        "Instance",
        "Ray",
        "table",
        "boolean",
        "boolean"
    }
}
function getPositionOnScreen(vector)
    local vec3, onScreen = Camera:WorldToScreenPoint(vector)
    return Vector2.new(vec3.X, vec3.Y), onScreen
end
function validateArguments(arguments, rayMethod)
    local matches = 0
    if #arguments < rayMethod.ArgCountRequired then
        return false
    end
    for pos, argument in next, arguments do
        if typeof(argument) == rayMethod.Args[pos] then
            matches = matches + 1
        end
    end
    return matches >= rayMethod.ArgCountRequired
end
function getPredictedPosition(part)
    if not part then return Vector3.zero end
    local pos = part.Position
    local vel = part.Velocity or Vector3.zero
    if vel.Magnitude < 1 then return pos end 

    local predictionScale
    if Legit12.auto_prediction_enabled then
        predictionScale = (vel.Magnitude / 100)
    else
        predictionScale = (Legit12.prediction_enabled and Legit12.prediction_strength or 0)
    end
    local lagTime = (Legit12.lag_comp_enabled and (Legit12.lag_comp_ms or 0) / 1000) or 0
    return pos + vel * (predictionScale + lagTime)
end

function getDirection(origin, targetPart)
    local predictedPos = getPredictedPosition(targetPart)
    return (predictedPos - origin).Unit * 1000
end
function isPlayerVisible(player)
    local PlayerCharacter = player.Character
    local LocalPlayerCharacter = LocalPlayer.Character
    if not (PlayerCharacter or LocalPlayerCharacter) then
        return 1
    end
    local PlayerRoot = PlayerCharacter:FindFirstChild("HumanoidRootPart")
    if not PlayerRoot then
        return 1
    end
    local CastPoints = {PlayerRoot.Position}
    local IgnoreList = {LocalPlayerCharacter, PlayerCharacter}
    local ObscuringObjects = #Camera:GetPartsObscuringTarget(CastPoints, IgnoreList)
    return ObscuringObjects
end
local function getClosestPlayer()
    local closestPlayer = nil
    local smallestAngle = math.huge
    local cameraCFrame = workspace.CurrentCamera.CFrame
    local cameraPosition = cameraCFrame.Position
    local cameraLookVector = cameraCFrame.LookVector
    local maxFovDegrees = Legit12.Legit_silent_aim_fov_radius or 180
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Team ~= game.Players.LocalPlayer.Team then
            local character = player.Character
            if character then
                local hrp = character:FindFirstChild("HumanoidRootPart")
                local humanoid = character:FindFirstChild("Humanoid")
                if hrp and humanoid and humanoid.Health > 0 then
                    if not (Legit12.Legit_silent_aim_wall_check and isPlayerVisible(player) > 0) then
                        local directionToPlayer = (hrp.Position - cameraPosition).Unit
                        local angle = math.deg(math.acos(cameraLookVector:Dot(directionToPlayer)))
                        if maxFovDegrees == 180 or angle <= maxFovDegrees then
                            if angle < smallestAngle then
                                closestPlayer = player
                                smallestAngle = angle
                            end
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end
function calculateChance(Percentage)
    Percentage = math.floor(Percentage)
    local chance = math.random()
    return chance <= Percentage / 100
end

task.spawn(function()
    while task.wait() do
        local nevm = getClosestPlayer()
        if nevm and nevm.Character and type(Legit12.Legit_silent_aim_hit_parts) == "table" and #Legit12.Legit_silent_aim_hit_parts > 0 then
            local sector = Legit12.Legit_silent_aim_hit_parts[math.random(1, #Legit12.Legit_silent_aim_hit_parts)]
            local closestPart = nil
            if sector == "Head" then
                closestPart = nevm.Character:FindFirstChild("Head")
            elseif sector == "Torso" then
                local toros = {"UpperTorso", "LowerTorso"}
                closestPart = nevm.Character:FindFirstChild(toros[math.random(1, #toros)])
            elseif sector == "Arms" then
                local arms = {
                    "LeftHand", "LeftLowerArm", "LeftUpperArm",
                    "RightHand", "RightLowerArm", "RightUpperArm"
                }
                closestPart = nevm.Character:FindFirstChild(arms[math.random(1, #arms)])
            elseif sector == "Legs" then
                local legs = {
                    "LeftFoot", "LeftLowerLeg", "LeftUpperLeg",
                    "RightFoot", "RightLowerLeg", "RightUpperLeg"
                }
                closestPart = nevm.Character:FindFirstChild(legs[math.random(1, #legs)])
            end
            closest = closestPart
            if closest then
                AdjustADSRemote:FireServer(unpack(AdjustADSRemoteArguments))
            end
        else
            closest = nil
        end
    end
end)

local blockedTools = {
    ["Decoy Grenade"] = true,
    ["DefuseKit"] = true,
    ["HE Grenade"] = true,
    ["Smoke Grenade"] = true,
    ["C4"] = true
}
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    local eq = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if eq and blockedTools[eq.Name] then
        return
    end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        silentaimTick = true
    end
end)
UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    local eq = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if eq and blockedTools[eq.Name] then
        return
    end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        silentaimTick = false
    end
end)

local __c4_sound_event
__c4_sound_event = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local arguments = {...}
    local method = getnamecallmethod()

    if not checkcaller() and self == ReplicateSoundRemote and method == "FireServer" then
        if arguments[1].Name == "Planting" and Legit12.misc_instant_plant then
            PlantC4Arguments[1] = "A"
            PlantC4Remote:FireServer(unpack(PlantC4Arguments))

            PlantC4Arguments[1] = "B"
            PlantC4Remote:FireServer(unpack(PlantC4Arguments))
        end

        return __c4_sound_event(self, ...)
    end

    return __c4_sound_event(self, ...)
end))

local __namecall_silent
__namecall_silent = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local arguments = {...}
    local self = arguments[1]
    if self == workspace and not checkcaller() and silentaimTick and Legit12.Legit_silent_aim_hit_chance then
        local canHit = calculateChance(Legit12.Legit_silent_aim_hit_chance)
        if validateArguments(arguments, findPartOnRayWithIgnoreList) and canHit then
            local A_Ray = arguments[2]
            if closest then
                local origin = A_Ray.Origin
                local direction = getDirection(origin, closest)
                arguments[2] = Ray.new(origin, direction)
                return __namecall_silent(unpack(arguments))
            end
            return __namecall_silent(...)
        end
    end
    return __namecall_silent(...)
end))

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    task.wait(0.125)
    currentCharacter = newCharacter
    currentHRP = newCharacter:WaitForChild("HumanoidRootPart")
    currentHumanoid = newCharacter:WaitForChild("Humanoid")
    currentHumanoid.AutoRotate = false
end)
RunService.Heartbeat:Connect(function()
    if not (currentCharacter and currentHRP) then
        return
    end
    local closestPlayer = getClosestPlayer()
    if not (closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("HumanoidRootPart") and not PreparationValue.Value) then
        return
    end
end)
game:GetService("RunService").RenderStepped:Connect(function()
    if Legit12.Legit_silent_aim_fov then
        local camera = workspace.CurrentCamera
        local mousePos = game:GetService("UserInputService"):GetMouseLocation()
        fovCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
        local fovAngle = Legit12.Legit_silent_aim_fov_radius or 100
        local maxRadius = math.max(camera.ViewportSize.X, camera.ViewportSize.Y)
        local angleNormalized = fovAngle >= 180 and 1 or math.clamp(fovAngle / 180, 0, 1)
        local radiusPixels = maxRadius * angleNormalized
        fovCircle.Radius = math.clamp(radiusPixels, 10, maxRadius)
        fovCircle.Visible = true
    else
        fovCircle.Visible = false
    end
end)
