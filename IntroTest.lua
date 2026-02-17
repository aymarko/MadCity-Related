--v4
local TweenService    = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local RunService      = game:GetService("RunService")

-- Bridge zum Hauptscript
local RL = _G.RubyHub_Loading

local blur = Instance.new("BlurEffect", game.Lighting)
blur.Size = 0

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

-- ============================================================
-- AUDIO
-- ============================================================
if not isfolder("Audio") then makefolder("Audio") end
local songPath = "Audio/RubyHub_IntroSound.mp3"
if not isfile(songPath) then
    local ok, content = pcall(function()
        return game:HttpGet("https://github.com/aymarko/MadCity-Related/raw/refs/heads/main/RubyHub_IntroSound.mp3")
    end)
    if ok then writefile(songPath, content) end
end
local sound = Instance.new("Sound")
sound.Parent = game.Workspace
sound.Volume = 10
if isfile(songPath) then sound.SoundId = getcustomasset(songPath) end
sound:Play()

-- ============================================================
-- FRAMES
-- ============================================================
local frames = {
    "113616397450765","113721642504853","128535637484055","83791463181225","86204986669970",
    "79153456781381","129965526741923","86347265176957","121895208874589","133515000822799",
    "134652694836524","107576170290221","80356244731476","134094134610253","99514221782400",
    "132390176876295","118781489305613","133958161546576","102417361783190","125435018646290",
    "116731841683482","113963670618033","98297127471217","87860734856839","124402794675967",
    "78486241325313","111595726141108","99760416608379","89211561753519","104813081112457",
    "100070997872319","102186833062915","112032903936569","80551546442332","121858023906119",
    "95381363726771","93020885534862","80994608121452","125199732635337","88328649401978",
    "108101659967674","138767423950365","111803605793754","77946126539866","111605264288433",
    "117375359104887","81150739072386","127583588815642","70823826431518","108878233710097",
    "113610525005858","102068961433925","113065386447058","94520155331360","111026756570537",
    "119657419818967","89229448650129","77879124396472","119757168913450","104743914170617",
    "132606469669487","89596616842063","99286731968108","129573230033068","81020624328066",
    "87169245216975","95565301524275","125822392989202","136486407394698","107075732465846",
    "102737382706816","114672830482269","103469272345597","71071129948125","73070889950237",
    "91338093785749","139310248629523","128304221544850","74308763248101","117722546756873",
    "130680293692812","100909884482987","93934081890932","115366620401315","82721507125623",
    "110494616491682","104784974315872","107766691380429","136288813203242","76222210904599",
    "131365815867108","105509015454109","139613628611676","103266603861155","120100862385768",
    "113716130239136","128760877735271","94621523698432","117802834500269","121136482552655",
    "111538982763190","82727394176229","120082042096892","129693434491234","124281299778686",
    "103627958150685","89059418340805","118152327571398","110590788842684","135559270985412",
    "133182294811079","73621285347640","137426605231936","108729609276576","73487996545174",
    "101578030785418","118954752197248","134396144960101","113007270443902","138111338271814",
    "76795417309718","82717263395195","101733796079271","84136228392416","91724745592162",
    "115564147156933","133416212684517","84086511568075","71178755821516","109495705403953",
    "111538537306228","124270194808743","71654606763569","124873946765062","79192376753203",
    "119985513809381","140474823132873","118087741136190","76027748403521","87949629582384",
    "91458954959422","131524616997412","120867099544054","133202993416900","129231618049594",
    "128940027405491","96730046334140","106096196877698","72664584522645","97570286233425",
    "100139160690483","72590191621790","80060226315046","85478943606880","80665491900367",
    "83435986416187","97550825068754","84715858407407","105627259516353","103119297520846",
    "108511078540099","85467929780587","96201295701282","77977493550026","86490206212936",
    "72548222545995","115763614397603","113669818092141","121194537546411","76152963387221",
    "116478020750977","131418407879711","137765009388246","99597603973468"
}

local assets = {}
for i=1,#frames do assets[i] = "rbxassetid://"..frames[i] end
pcall(function() ContentProvider:PreloadAsync(assets) end)
task.wait(0.5)

local frame_data = {}
local currentImageLabel = { Size = UDim2.new(0,0,0,0) }

for i=1,#frames do
    local f = Instance.new("ImageLabel")
    local c = Instance.new("UICorner")
    f.Parent             = ScreenGui
    f.BackgroundTransparency = 1
    f.Position           = UDim2.new(0.5,0,0.5,0)
    f.AnchorPoint        = Vector2.new(0.5,0.5)
    f.Size               = UDim2.new(0,0,0,0)
    f.ImageTransparency  = 1
    f.Image              = "rbxassetid://"..frames[i]
    f.ZIndex             = 1
    c.CornerRadius       = UDim.new(0.1,0)
    c.Parent             = f
    frame_data[i]        = f
end

-- Preload flash
for i=1,#frames do if frame_data[i] then frame_data[i].ImageTransparency=0 end end
task.wait(0.05)
for i=1,#frames do if frame_data[i] then frame_data[i].ImageTransparency=1 end end
task.wait(0.05)

local heartbeatConn = RunService.Heartbeat:Connect(function()
    local s = currentImageLabel.Size
    for i=1,#frame_data do
        if frame_data[i] and frame_data[i].Size ~= s then frame_data[i].Size = s end
    end
end)

-- ============================================================
-- UI ELEMENTE
-- ============================================================
local LoadingBarBG = Instance.new("Frame")
LoadingBarBG.Parent = ScreenGui
LoadingBarBG.BackgroundColor3 = Color3.fromRGB(40,40,40)
LoadingBarBG.BackgroundTransparency = 1
LoadingBarBG.Position = UDim2.new(0.5,0, 0.5, (263/2)+20)
LoadingBarBG.Size = UDim2.new(0,0,0,0)
LoadingBarBG.BorderSizePixel = 0
LoadingBarBG.AnchorPoint = Vector2.new(0.5,0)
local cc = Instance.new("UICorner"); cc.CornerRadius = UDim.new(1,0); cc.Parent = LoadingBarBG

local LoadingBar = Instance.new("Frame")
LoadingBar.Parent = LoadingBarBG
LoadingBar.BackgroundColor3 = Color3.new(1,1,1)
LoadingBar.Size = UDim2.new(0,0,1,0)
LoadingBar.BorderSizePixel = 0
local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(1,0); bc.Parent = LoadingBar

local PctLabel = Instance.new("TextLabel")
PctLabel.Parent = ScreenGui
PctLabel.BackgroundTransparency = 1
PctLabel.TextColor3 = Color3.fromRGB(255,255,255)
PctLabel.Font = Enum.Font.GothamBlack
PctLabel.TextSize = 16
PctLabel.Position = UDim2.new(0.5,-150, 0.5, (263/2)+32)
PctLabel.Size = UDim2.new(0,300,0,30)
PctLabel.Text = "0%"
PctLabel.TextTransparency = 1
PctLabel.TextXAlignment = Enum.TextXAlignment.Center

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = ScreenGui
InfoLabel.BackgroundTransparency = 1
InfoLabel.TextColor3 = Color3.fromRGB(255,255,255)
InfoLabel.Font = Enum.Font.GothamBlack
InfoLabel.TextSize = 20
InfoLabel.Position = UDim2.new(0.5,-150, 0.5, (263/2)+50)
InfoLabel.Size = UDim2.new(0,300,0,50)
InfoLabel.Text = ""
InfoLabel.TextTransparency = 1
InfoLabel.TextXAlignment = Enum.TextXAlignment.Center

-- ============================================================
-- TIMING — EXAKT WIE ORIGINAL
-- 160 frames * 0.025s = 4.0s Loading-Loop
-- ============================================================
local accentColor     = Color3.fromRGB(250,27,117)
local whiteColor      = Color3.new(1,1,1)
local frameUpdateRate = 0.025
local maxFrames       = #frames - 10   -- 160
local TICK_TIME       = frameUpdateRate  -- 0.025s pro Tick

-- ============================================================
-- FRAME ANIMATION (parallel, immer)
-- ============================================================
local currentFrame = 1
task.spawn(function()
    while currentFrame <= maxFrames and ScreenGui.Parent do
        for i=1,#frames do
            if frame_data[i] then
                frame_data[i].ImageTransparency = (i==currentFrame) and 0 or 1
            end
        end
        currentFrame = currentFrame + 1
        task.wait(frameUpdateRate)
    end
end)

-- ============================================================
-- OPEN ANIMATION (~0.92s)
-- ============================================================
for i=1,15 do currentImageLabel.Size = UDim2.new(0,303*(i/15),0,263*(i/15)); task.wait(0.02) end
for i=1,60,3 do blur.Size=i; task.wait(0.01) end
for i=1,15 do LoadingBarBG.Size = UDim2.new(0,300*(i/15),0,8*(i/15)); task.wait(0.02) end
for i=1,8 do LoadingBarBG.BackgroundTransparency=1-(0.7*i/8); PctLabel.TextTransparency=1-(i/8); task.wait(0.015) end

-- ============================================================
-- LOADING LOOP — 4.0s TOTAL, KEINE PAUSEN
--
-- Das Intro läuft IMMER durch ohne zu stoppen.
-- Jeder Tick prüft ob RL.label sich geändert hat →
-- wenn ja: neuen Text mit Fade-In zeigen.
-- Die Bar läuft linear von 0% auf 100% in 4.0s.
-- Keine Wartezeit auf Checks — komplett smooth.
-- ============================================================
local totalTicks  = maxFrames   -- 160 Ticks = 4.0s (160 * 0.025s)
local lastLabel   = ""
local labelAlpha  = 1.0  -- 1.0 = unsichtbar, 0.0 = sichtbar

-- Label-Fade läuft asynchron damit es die Bar nicht blockiert
local fadingLabel = false
local function fadeInLabel(text)
    if fadingLabel and InfoLabel.Text == text then return end
    fadingLabel = true
    InfoLabel.Text = text
    InfoLabel.TextTransparency = 1
    task.spawn(function()
        for i=1,8 do
            InfoLabel.TextTransparency = 1 - (i/8)
            task.wait(TICK_TIME)
        end
        fadingLabel = false
    end)
end

for tick=1, totalTicks do
    local progress = tick / totalTicks

    -- Bar update
    TweenService:Create(LoadingBar, TweenInfo.new(TICK_TIME, Enum.EasingStyle.Linear), {
        Size = UDim2.new(progress, 0, 1, 0)
    }):Play()
    LoadingBar.BackgroundColor3 = whiteColor:Lerp(accentColor, progress)
    PctLabel.Text = math.floor(progress * 100).."%"

    -- Label: wenn sich RL.label geändert hat → sofort anzeigen
    local currentLabel = (RL and RL.label ~= "") and RL.label or ""
    if currentLabel ~= lastLabel and currentLabel ~= "" then
        lastLabel = currentLabel
        fadeInLabel(currentLabel)
    end

    task.wait(TICK_TIME)
end

-- ============================================================
-- WARTEN BIS CHECKS WIRKLICH FERTIG (max 8s Fallback)
-- Das Intro kann schneller durch sein als die Checks —
-- dann kurz warten. Normalerweise schon fertig.
-- ============================================================
do
    local w = 0
    while RL and not RL.done and w < 8 do task.wait(0.05); w=w+0.05 end
end

-- ============================================================
-- ABSCHLUSS
-- ============================================================
TweenService:Create(LoadingBar, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
    Size = UDim2.new(1,0,1,0)
}):Play()
LoadingBar.BackgroundColor3 = accentColor
PctLabel.Text = "100%"

InfoLabel.Text = "Done!"
InfoLabel.TextTransparency = 1
for i=1,8 do InfoLabel.TextTransparency = 1-(i/8); task.wait(0.02) end
task.wait(1)
for i=1,8 do
    InfoLabel.TextTransparency              = i/8
    LoadingBarBG.BackgroundTransparency     = LoadingBarBG.BackgroundTransparency + 0.125
    LoadingBar.BackgroundTransparency       = i/8
    PctLabel.TextTransparency               = i/8
    task.wait(0.01)
end

InfoLabel:Destroy()
LoadingBarBG:Destroy()
PctLabel:Destroy()
heartbeatConn:Disconnect()

local visibleFrame = nil
for i=1,#frame_data do
    if frame_data[i] and frame_data[i].ImageTransparency < 1 then
        visibleFrame = frame_data[i]; break
    end
end

for i=1,20 do
    if visibleFrame then visibleFrame.ImageTransparency = i/20 end
    blur.Size = 60*(1-i/20)
    task.wait(0.02)
end

for i=1,#frame_data do if frame_data[i] then frame_data[i]:Destroy() end end
table.clear(frame_data)

task.wait(0.2)
ScreenGui:Destroy()
sound:Stop()
task.wait(0.5)
blur:Destroy()
