-- ================== KYX HUB - COMBINED SCRIPT ==================
-- UI Style: KYX HUB (BF_normal style)
-- Includes: Main_Module + OtherModules + QuestModules + 403_3 features
-- ================================================================

-- ================== ENV ==================
local _ENV = (getgenv or getrenv or getfenv)()

-- ================== SERVICES ==================
local Players             = game:GetService("Players")
local TweenService        = game:GetService("TweenService")
local RunService          = game:GetService("RunService")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local VirtualUser         = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService    = game:GetService("UserInputService")
local CollectionService   = game:GetService("CollectionService")
local TeleportService     = game:GetService("TeleportService")
local CoreGui             = game:GetService("CoreGui")

-- ================== PLAYER ==================
local Player = Players.LocalPlayer
local function GetChar() return Player.Character or Player.CharacterAdded:Wait() end

-- ================== ANTI AFK ==================
Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- ================== WORLD ==================
local Enemies    = workspace:WaitForChild("Enemies")
local Characters = workspace:WaitForChild("Characters")
local SeaBeasts  = workspace:WaitForChild("SeaBeasts")
local Map        = workspace:WaitForChild("Map")
local Boats      = workspace:WaitForChild("Boats")
local ChestModels= workspace:WaitForChild("ChestModels")
local WorldOrigin= workspace:WaitForChild("_WorldOrigin")
local EnemySpawns= WorldOrigin:WaitForChild("EnemySpawns")
local Locations  = WorldOrigin:WaitForChild("Locations")

-- ================== REMOTES ==================
local Remotes   = ReplicatedStorage:WaitForChild("Remotes")
local CommF     = Remotes:WaitForChild("CommF_")
local CommE     = Remotes:WaitForChild("CommE")
local GunValidator = Remotes:WaitForChild("Validator2")
local Modules   = ReplicatedStorage:WaitForChild("Modules")
local Net       = Modules:WaitForChild("Net")
local RE_RegisterAttack = Net:WaitForChild("RE/RegisterAttack")
local RE_RegisterHit    = Net:WaitForChild("RE/RegisterHit")
local RE_ShootGunEvent  = Net:WaitForChild("RE/ShootGunEvent")

-- ================== DATA ==================
local Data      = Player:WaitForChild("Data")
local Level     = Data:WaitForChild("Level")
local Fragments = Data:WaitForChild("Fragments")
local Money     = Data:WaitForChild("Beli")

-- ================== EXPLOIT COMPAT ==================
local hookmetamethod   = hookmetamethod   or function(...) return ... end
local sethiddenproperty= sethiddenproperty or function(...) return ... end
local setupvalue       = setupvalue        or (debug and debug.setupvalue)
local getupvalue       = getupvalue        or (debug and debug.getupvalue)
local fireproximityprompt = fireproximityprompt or function() end
local fireclickdetector   = fireclickdetector   or function() end

-- ================== GLOBAL SETTINGS ==================
_G.AutoFarm        = false
_G.AutoChest       = false
_G.AutoEquipTool   = false
_G.FPSBoost        = false
_G.AutoBuyDarkStep = false

-- Farm mode globals (used by Main_Module logic)
Selected_Weapon           = "Melee"
Selected_Mode_Farm        = "Above"
Distance_Func             = 20
TweenSpeed_Func           = 250
BringDistance             = 250
BringMobs                 = true
SmoothMode                = true
Auto_Click_Func           = false
Ken_Haki_Func             = false
Buso_Haki_Func            = true
Spawn_Point_Func          = false
AudioDamage_Func          = false
Hide_Notification_Func    = false

-- Farm toggles
Level_Quest_Func          = false
Level_No_Quest_Func       = false
Nearest_Farm_Func         = false
Hearts_Farm_Func          = false
Selected_Monster          = nil
Select_Monster_Quest_Func = false
Select_Monster_No_Quest_Func = false
Selected_Material         = nil
Select_Materials_Func     = false
Mastery_Farm_Monster_Health_Set = 20
Selected_Type_Mastery     = "Blox Fruits"
Selected_Mode_Mastery     = "Quest"
Selected_Monster_Mastery  = nil
Selected_Skill            = {}
Mastery_Farming_Func      = false
Selected_Boss             = nil
Select_Boss_Quest_Func    = false
Select_Boss_No_Quest_Func = false
Elite_Hunter_Quest_Func   = false
Cake_Prince_Quest_Func    = false
Dough_King_Quest_Func     = false
Factory_Farming_Func      = false
Pirate_Raid_Farming_Func  = false
Farming_Chest_Func        = false
Berries_ESP_Func          = false
Berries_Farming_Func      = false
Farming_Observation_Func  = false
Get_Observation_V2_Func   = false

-- Quest toggles
Second_World_Quest_Func    = false
Third_World_Quest_Func     = false
Superhuman_Quest_Func      = false
Death_Step_Quest_Func      = false
Sharkman_Karate_Quest_Func = false
Electric_Claw_Quest_Func   = false
Dragon_Talon_Quest_Func    = false
Godhuman_Quest_Func        = false
Sangui_art_Quest_Func      = false
Saber_V1_Quest_Func        = false
Legendary_Sword_Dealer_Func= false
Rengoku_Quest_Func         = false
Buddy_Sword_Quest_Func     = false
Pole_1stForm_Quest_Func    = false
Cavander_Quest_Func        = false
Yama_Quest_Func            = false
Tushita_Quest_Func         = false
Dark_Dragger_Quest_Func    = false
Koko_Quest_Func            = false
Spikey_Trident_Quest_Func  = false
Hallow_Scythe_Quest_Func   = false
Bartilo_Quest_Func         = false
Citizen_Quest_Func         = false
Down_Swan_Quest_Func       = false
rip_indra_True_Form_Quest  = false
Rainbow_Haki_Quest_Func    = false
Pray_and_Tryluck_Quest_Func= false
Advanced_Dungeon_Phoenix_Quest_Func = false
Color_Haki_Quest_Func      = false
Venom_Bow_Quest_Func       = false
Hydra_Mob_Quest_Func       = false
Destroy_Tree_Quest_Func    = false
Upgrade_Dragon_Talon_Quest_Func = false
Dojo_Quest_Func            = false

-- Sea Event toggles
Sea_Event_Weapon_Selected_Func     = "Melee"
Sea_Event_Mode_Farm_Setting_Func   = "Above"
Sea_Event_Distance_Func            = 30
Sea_Event_TweenSpeed_Func          = 250
Sea_Event_Tween_Speed_Setting_Boats_Func = 250
Auto_W_Func                        = false
SeaEvent_Skill_Func                = {}
AimbotSkill_SeaEvent_Func          = false
Team_Selected_Func                 = "Pirates"
Boats_Selected_Func                = "Dinghy"
Sea_Danger_Selected_Func           = "Sea Danger 1"
Auto_Sails_Func                    = false
Fish_Farming_Func                  = false
Terrorshark_Farming_Func           = false
GhostShip_Farming_Func             = false
Sea_Beast_Farming_Func             = false

-- Island toggles
Mirage_Notification_Func     = false
Mirage_Esp_Func              = false
Mirage_Teleport_Func         = false
Mirage_Gear_Teleport_Func    = false
Fruit_Dealer_Teleport_Func   = false
Kitsune_Notification_Func    = false
Kitsune_Esp_Func             = false
Teleport_Kitsune_Func        = false
Collect_Azure_Kitsune_Func   = false
Prehistoric_Notification_Func= false
Prehistoric_Esp_Func         = false
Teleport_Prehistoric_Func    = false
Kill_Golem_Func              = false
Kill_Golem_Instantly_Func    = false
Collect_Dragon_Egg_Func      = false

-- Race toggles
Teleport_Race_Door_Func = false
Auto_Trial_Race_Func    = false
Auto_Train_Race_Func    = false

-- Raid toggles
Auto_Buy_Law_Chips_Func    = false
Auto_Start_Law_Raid_Func   = false
Auto_Kill_Law_Raid_Func    = false
Select_Chips_Raid_Func     = nil
Auto_Buy_Microchips_Func   = false
Auto_Start_Raid_Func       = false
Auto_Next_Island_Func      = false
Auto_Kill_Raid_Monster_Func= false
Auto_Raid_Aura_Func        = false

-- Bounty toggles
Farm_All_Boss_Func   = false
Selected_Player_Func = nil
Spectate_Player_Func = false
Player_ESP_Func      = false
Tween_Players_Func   = false
Aimbot_Skill_To_Player_Func = {}
Aimbot_Skill_Func    = false
Enable_Pvp_Func      = false

-- Stat toggles
Up_Stat_Req_Point_Func = 1
Stats_Listed_Func      = {}
Selected_Up_Stats_Func = false

-- Shop
Fruits_List_Func      = nil
Fighting_List_Func    = nil
Sword_List_Func       = nil
Gun_List_Func         = nil
Random_List_Func      = nil
Abilities_List_Func   = nil
Accessories_List_Func = nil

-- Misc toggles
Fruit_Notifications_Func      = true
Tween_To_Fruit_Func           = false
Buy_Random_Fruit_Func         = false
Auto_Stored_Fruit_Func        = false
Monster_ESP_Func              = false
Island_ESP_Func               = false
NPC_ESP_Func                  = false
Fruit_ESP_Func                = true
Chest_ESP_Func                = false
Flower_ESP_Func               = false
Dodge_Cooldown_Func           = false
Infinite_Energy_Func          = false
Geppo_Cooldown_Func           = false
Soru_Cooldown_Func            = false
Walk_ON_Water_Func            = false
Remove_Fog_Func               = false
Always_Day_Func               = false
White_Screen_Func             = false
Black_Screen_Func             = false

-- NPC/Location
NPC_Listed_Func = nil

-- Farm mode CFrame
Farm_Mode = CFrame.new(0, Distance_Func, 0)
Sea_Event_Farm_Mode = CFrame.new(0, Sea_Event_Distance_Func, 0)

-- Stopped Tween flags
Stopped_Tween       = false
Boats_Stopped_Tween = false

-- Lists (populated by QuestModules logic)
Monster_Listed = {}
Boss_Listed    = {}
Material_Listed= {}
MobBoss_Listed = {}
Boats_List     = {}

-- ================== STATE ==================
local IsFlying    = false
local IsEquipping = false
local LockTarget  = nil
local WaitingAtSpawn = false
local AutoAttacks    = true
local AutoShoot      = true
local AttackCooldown = 0

-- ================== CONNECTIONS CLEANUP ==================
local Connections = {} do
    if _ENV.bt_connections then
        for _, c in ipairs(_ENV.bt_connections) do c:Disconnect() end
    end
    _ENV.bt_connections = Connections
end

-- ================== UTIL ==================
local function IsAlive(m)
    return m and m:FindFirstChild("Humanoid") and m.Humanoid.Health > 0
end

local function HasQuest()
    local gui = Player.PlayerGui:FindFirstChild("Main")
    return gui and gui:FindFirstChild("Quest") and gui.Quest.Visible
end

-- ================== FLY ==================
local CurrentFlyTween = nil

local function FlyTo(cf)
    local hrp = GetChar():WaitForChild("HumanoidRootPart")
    local dist = (hrp.Position - cf.Position).Magnitude
    if dist <= 80 then hrp.CFrame = cf; return end
    if CurrentFlyTween then CurrentFlyTween:Cancel(); CurrentFlyTween = nil end
    IsFlying = true
    local tween = TweenService:Create(hrp, TweenInfo.new(dist/250, Enum.EasingStyle.Linear), {CFrame = cf})
    CurrentFlyTween = tween
    tween:Play()
    local done = false
    tween.Completed:Connect(function() done = true end)
    while not done do
        task.wait()
        if not _G.AutoFarm then tween:Cancel(); break end
    end
    CurrentFlyTween = nil
    IsFlying = false
end

local function FlyToGeneral(cf, stopFlag)
    local char = Player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dist = (hrp.Position - cf.Position).Magnitude
    if dist <= 10 then hrp.CFrame = cf; return end
    local arrived = false
    local tween = TweenService:Create(hrp, TweenInfo.new(dist/200, Enum.EasingStyle.Linear), {CFrame = cf})
    tween:Play()
    tween.Completed:Connect(function() arrived = true end)
    while not arrived do
        task.wait()
        if stopFlag and not _G[stopFlag] then tween:Cancel(); return end
    end
end

-- ================== TWEEN (Main_Module.Tween equivalent) ==================
local function TweenTo(P1)
    local char = Player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dist = (hrp.Position - P1.Position).Magnitude
    local tw = TweenService:Create(hrp, TweenInfo.new(dist / TweenSpeed_Func, Enum.EasingStyle.Linear), {CFrame = P1})
    tw:Play()
    local done = false
    tw.Completed:Connect(function() done = true end)
    while not done do
        task.wait()
        if Stopped_Tween then tw:Cancel(); break end
    end
end

-- ================== INVOKE REMOTE ==================
local function InvokeRemote(...)
    local ok, result = pcall(function(...) return CommF:InvokeServer(...) end, ...)
    return ok and result or nil
end

-- ================== EQUIP WEAPON ==================
local function EquipTool(weaponType)
    if IsEquipping then return end
    local char = GetChar()
    if not char then return end
    if char:FindFirstChildOfClass("Tool") then return end
    IsEquipping = true
    for _, tool in ipairs(Player.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local tip = tool.ToolTip or ""
            if weaponType == "Melee" and tip == "Melee" then
                tool.Parent = char; break
            elseif weaponType == "Sword" and tip == "Sword" then
                tool.Parent = char; break
            elseif weaponType == "Gun" and tip == "Gun" then
                tool.Parent = char; break
            elseif weaponType == "Blox Fruit" and tip == "Blox Fruit" then
                tool.Parent = char; break
            end
        end
    end
    IsEquipping = false
end

-- ================== AUTO EQUIP MELEE ==================
local function EquipMelee()
    if IsEquipping then return end
    local char = GetChar()
    if char:FindFirstChildOfClass("Tool") then return end
    IsEquipping = true
    for _, tool in ipairs(Player.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("weapontype") and tool.weapontype:FindFirstChild("melee") then
            char.Humanoid:UnequipTools(); task.wait(0.05)
            tool.Parent = char; break
        end
    end
    IsEquipping = false
end

local function AutoEquipFromBackpack()
    if not _G.AutoEquipTool then return end
    if IsEquipping then return end
    local char = GetChar()
    if not char then return end
    if char:FindFirstChildOfClass("Tool") then return end
    local backpack = Player:FindFirstChild("Backpack")
    if not backpack then return end
    local tool = backpack:FindFirstChildOfClass("Tool")
    if not tool then return end
    IsEquipping = true
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum:UnequipTools(); task.wait(0.05) end
    tool.Parent = char
    IsEquipping = false
end

-- ================== LOCK TARGET ==================
RunService.Heartbeat:Connect(function()
    if IsFlying or IsEquipping then return end
    AutoEquipFromBackpack()
    if LockTarget and IsAlive(LockTarget) and LockTarget:FindFirstChild("HumanoidRootPart") then
        local char = GetChar()
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame =
                LockTarget.HumanoidRootPart.CFrame
                * CFrame.new(0, 15, 0)
                * CFrame.Angles(0, math.rad(180), 0)
        end
    end
end)

-- ================== FAST ATTACK SYSTEM ==================
local SUCCESS_FLAGS, COMBAT_REMOTE_THREAD = pcall(function()
    return require(Modules.Flags).COMBAT_REMOTE_THREAD or false
end)

local SUCCESS_SHOOT, SHOOT_FUNCTION = pcall(function()
    return getupvalue(require(ReplicatedStorage.Controllers.CombatController).Attack, 9)
end)

local SUCCESS_HIT, HIT_FUNCTION = pcall(function()
    return (getmenv or getsenv)(Net)._G.SendHitsToServer
end)

local FastAttack = {
    Distance = 80,
    attackMobs = true,
    attackPlayers = false,
    Equipped = nil,
    Debounce = 0,
    ComboDebounce = 0,
    ShootDebounce = 0,
    M1Combo = 0,
    ShootsPerTarget = { ["Dual Flintlock"] = 2 },
    SpecialShoots = {
        ["Skull Guitar"] = "TAP",
        ["Bazooka"]      = "Position",
        ["Cannon"]       = "Position"
    },
    HitboxLimbs = {"RightLowerArm","RightUpperArm","LeftLowerArm","LeftUpperArm","RightHand","LeftHand"}
}

function FastAttack:ShootInTarget(TargetPosition)
    local Equipped = IsAlive(Player.Character) and Player.Character:FindFirstChildOfClass("Tool")
    if Equipped and Equipped.ToolTip == "Gun" then
        if Equipped:FindFirstChild("Cooldown") and (tick() - self.ShootDebounce) >= Equipped.Cooldown.Value then
            if SUCCESS_SHOOT and SHOOT_FUNCTION then
                local ShootType = self.SpecialShoots[Equipped.Name] or "Normal"
                if ShootType == "Position" or (ShootType == "TAP" and Equipped:FindFirstChild("RemoteEvent")) then
                    Equipped:SetAttribute("LocalTotalShots", (Equipped:GetAttribute("LocalTotalShots") or 0) + 1)
                    GunValidator:FireServer(self:GetValidator2())
                    if ShootType == "TAP" then
                        Equipped.RemoteEvent:FireServer("TAP", TargetPosition)
                    else
                        RE_ShootGunEvent:FireServer(TargetPosition)
                    end
                    self.ShootDebounce = tick()
                end
            end
        end
    end
end

function FastAttack:CheckStun(ToolTip, Character, Humanoid)
    local Stun = Character:FindFirstChild("Stun")
    if Humanoid.Sit and (ToolTip == "Sword" or ToolTip == "Melee" or ToolTip == "Gun") then return false end
    if Stun and Stun.Value > 0 then return false end
    return true
end

function FastAttack:Process(assert, is_Enemies, BladeHits, Position, Distance)
    if not assert then return end
    local HitboxLimbs = self.HitboxLimbs
    for _, Enemy in is_Enemies:GetChildren() do
        local BasePart = Enemy:FindFirstChild(HitboxLimbs[math.random(#HitboxLimbs)]) or Enemy.PrimaryPart
        if not BasePart then continue end
        if Enemy ~= Player.Character and Enemy:FindFirstChild("CharacterReady") then
            if IsAlive(Enemy) and (Position - BasePart.Position).Magnitude <= Distance then
                if not self.EnemyRootPart then
                    self.EnemyRootPart = BasePart
                else
                    table.insert(BladeHits, {Enemy, BasePart})
                end
            end
        end
    end
end

function FastAttack:GetAllBladeHits(Character, Distance)
    local Position = Character:GetPivot().Position
    local BladeHits = {}
    Distance = Distance or self.Distance
    self:Process(self.attackMobs, Enemies, BladeHits, Position, Distance)
    self:Process(self.attackPlayers, Characters, BladeHits, Position, Distance)
    return BladeHits
end

function FastAttack:GetClosestEnemyPosition(Character, Distance)
    local Distance2, Closest = math.huge
    for enemy_1 = 1, 1 do
        local BladeHits = self:GetAllBladeHits(Character, Distance)
        if not BladeHits[enemy_1] then break end
        local Magnitude = Closest and (Closest.Position - BladeHits[enemy_1][2].Position).Magnitude or Distance2
        if Magnitude <= Distance2 then
            Distance2, Closest = Magnitude, BladeHits[enemy_1][2]
        end
    end
    return Closest and Closest.Position or nil
end

function FastAttack:GetGunHits(Character, Distance)
    local GunHits = {}
    for enemy_2 = 1, 1 do
        local BladeHits = self:GetAllBladeHits(Character, Distance)
        if not BladeHits[enemy_2] then break end
        if not GunHits[1] or (BladeHits[enemy_2][2].Position - GunHits[1].Position).Magnitude <= 10 then
            table.insert(GunHits, BladeHits[enemy_2][2])
        end
    end
    return GunHits
end

function FastAttack:GetCombo()
    local Combo = tick() - self.ComboDebounce <= 0.4 and self.M1Combo or 0
    Combo = Combo >= 2 and 1 or Combo + 1
    self.ComboDebounce = tick()
    self.M1Combo = Combo
    return Combo
end

function FastAttack:UseFruitM1(Character, Equipped, Combo)
    local Position = Character:GetPivot().Position
    for _, Enemy in ipairs(Enemies:GetChildren()) do
        local PrimaryPart = Enemy.PrimaryPart
        if IsAlive(Enemy) and PrimaryPart and (PrimaryPart.Position - Position).Magnitude <= 50 then
            local Direction = (PrimaryPart.Position - Position).Unit
            return Equipped.LeftClickRemote:FireServer(Direction, Combo)
        end
    end
end

function FastAttack:UseNormalClick(Humanoid, Character, Cooldown)
    self.EnemyRootPart = nil
    local BladeHits = self:GetAllBladeHits(Character)
    if self.EnemyRootPart then
        RE_RegisterAttack:FireServer(Cooldown)
        if SUCCESS_FLAGS and COMBAT_REMOTE_THREAD and SUCCESS_HIT and HIT_FUNCTION then
            HIT_FUNCTION(self.EnemyRootPart, BladeHits)
        else
            RE_RegisterHit:FireServer(self.EnemyRootPart, BladeHits)
        end
    end
end

function FastAttack:GetValidator2()
    local v1=getupvalue(SHOOT_FUNCTION,15); local v2=getupvalue(SHOOT_FUNCTION,13)
    local v3=getupvalue(SHOOT_FUNCTION,16); local v4=getupvalue(SHOOT_FUNCTION,17)
    local v5=getupvalue(SHOOT_FUNCTION,14); local v6=getupvalue(SHOOT_FUNCTION,12)
    local v7=getupvalue(SHOOT_FUNCTION,18)
    local v8=v6*v2; local v9=(v5*v2+v6*v1)%v3
    v9=(v9*v3+v8)%v4; v5=math.floor(v9/v3); v6=v9-v5*v3; v7=v7+1
    setupvalue(SHOOT_FUNCTION,15,v1); setupvalue(SHOOT_FUNCTION,13,v2)
    setupvalue(SHOOT_FUNCTION,16,v3); setupvalue(SHOOT_FUNCTION,17,v4)
    setupvalue(SHOOT_FUNCTION,14,v5); setupvalue(SHOOT_FUNCTION,12,v6)
    setupvalue(SHOOT_FUNCTION,18,v7)
    return math.floor(v9/v4*16777215), v7
end

function FastAttack:UseGunShoot(Character, Equipped)
    local ShootType = self.SpecialShoots[Equipped.Name] or "Normal"
    if ShootType == "Normal" then
        local Hits = self:GetGunHits(Character, 120)
        if #Hits > 0 then
            local Target = Hits[1].Position
            Equipped:SetAttribute("LocalTotalShots", (Equipped:GetAttribute("LocalTotalShots") or 0) + 1)
            GunValidator:FireServer(self:GetValidator2())
            for i = 1, (self.ShootsPerTarget[Equipped.Name] or 1) do
                RE_ShootGunEvent:FireServer(Target, Hits)
            end
        end
    elseif ShootType == "Position" or (ShootType == "TAP" and Equipped:FindFirstChild("RemoteEvent")) then
        local Target = self:GetClosestEnemyPosition(Character, 200)
        if Target then
            Equipped:SetAttribute("LocalTotalShots", (Equipped:GetAttribute("LocalTotalShots") or 0) + 1)
            GunValidator:FireServer(self:GetValidator2())
            if ShootType == "TAP" then
                Equipped.RemoteEvent:FireServer("TAP", Target)
            else
                RE_ShootGunEvent:FireServer(Target)
            end
        end
    end
end

function FastAttack.attack()
    if not AutoAttacks or (tick() - AttackCooldown) <= 1 then return end
    if not IsAlive(Player.Character) then return end
    local self = FastAttack
    local Character = Player.Character
    local Humanoid  = Character.Humanoid
    local Equipped  = Character:FindFirstChildOfClass("Tool")
    local ToolTip   = Equipped and Equipped.ToolTip
    if not Equipped or (ToolTip ~= "Gun" and ToolTip ~= "Melee" and ToolTip ~= "Blox Fruit" and ToolTip ~= "Sword") then return end
    local Cooldown = Equipped:FindFirstChild("Cooldown") and Equipped.Cooldown.Value or 0
    if (tick() - self.Debounce) >= Cooldown and self:CheckStun(ToolTip, Character, Humanoid) then
        local Combo = self:GetCombo()
        self.Equipped = Equipped
        self.Debounce = tick()
        if ToolTip == "Blox Fruit" then
            local ToolName = Equipped.Name
            if ToolName == "Ice-Ice" or ToolName == "Light-Light" then
                return self:UseNormalClick(Humanoid, Character, Cooldown)
            elseif Equipped:FindFirstChild("LeftClickRemote") then
                return self:UseFruitM1(Character, Equipped, Combo)
            end
        elseif ToolTip == "Gun" then
            if SUCCESS_SHOOT and SHOOT_FUNCTION and AutoShoot then
                return self:UseGunShoot(Character, Equipped)
            end
        else
            return self:UseNormalClick(Humanoid, Character, Cooldown)
        end
    end
end

table.insert(Connections, RunService.Stepped:Connect(FastAttack.attack))
AutoAttacks = true

-- ================== BRING ENEMIES (Main_Module:BringEnemies) ==================
local BRING_TAG    = _ENV._Bring_Tag    or ("b" .. math.random(80,2e4) .. "t")
local KILLAURA_TAG = _ENV._KillAura_Tag or ("k" .. math.random(120,2e4) .. "t")
_ENV._Bring_Tag    = BRING_TAG
_ENV._KillAura_Tag = KILLAURA_TAG

local function BringEnemies(ToEnemy, SuperBring)
    if not ToEnemy then return end
    local char = Player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if not ToEnemy:FindFirstChild("HumanoidRootPart") then return end
    local enemyHRP = ToEnemy.HumanoidRootPart
    if BringMobs then
        if (enemyHRP.Position - hrp.Position).Magnitude <= BringDistance or SuperBring then
            ToEnemy:AddTag(BRING_TAG)
            enemyHRP.CFrame = hrp.CFrame * Farm_Mode
            if SuperBring then
                enemyHRP.CanCollide = false
                if ToEnemy:FindFirstChild("Humanoid") then
                    ToEnemy.Humanoid:ChangeState(11)
                    ToEnemy.Humanoid:ChangeState(14)
                end
            end
        end
    end
end

-- ================== GAME DATA ==================
local GameData = {Sea = 1, MaxLevel = 700}

pcall(function()
    local lv = Data.Level.Value
    if lv >= 1500 then
        GameData.Sea = 3; GameData.MaxLevel = 2600
    elseif lv >= 700 then
        GameData.Sea = 2; GameData.MaxLevel = 1500
    else
        GameData.Sea = 1; GameData.MaxLevel = 700
    end
end)

-- ================== QUEST LEVEL DATA ==================
local Namemon, NameQuest, TP, QuestNum = nil, nil, nil, 1
local CFrameMonster, CFrameQuest

local QuestLevelData = {
    -- Sea 1
    { lv=10,   mon="Bandit",             quest="BanditQuest1",    tp=CFrame.new(1058.99,16.13,1551.73),     num=1, cf=CFrame.new(1038.55,41.30,1576.51) },
    { lv=15,   mon="Monkey",             quest="JungleQuest",     tp=CFrame.new(-1602,36.85,153.39),        num=1, cf=CFrame.new(-1448.14,50.85,63.61) },
    { lv=30,   mon="Gorilla",            quest="JungleQuest",     tp=CFrame.new(-1602,36.85,153.39),        num=2, cf=CFrame.new(-1142.65,40.46,-515.39) },
    { lv=40,   mon="Pirate",             quest="BuggyQuest1",     tp=CFrame.new(-1140.1,5.1,3828.1),        num=1, cf=CFrame.new(-1201.09,40.63,3857.60) },
    { lv=60,   mon="Brute",              quest="BuggyQuest1",     tp=CFrame.new(-1140.1,5.1,3828.1),        num=2, cf=CFrame.new(-1387.53,24.59,4100.96) },
    { lv=75,   mon="Desert Bandit",      quest="DesertQuest",     tp=CFrame.new(896.4,6.4,4390.2),          num=1, cf=CFrame.new(985.00,16.11,4417.91) },
    { lv=90,   mon="Desert Officer",     quest="DesertQuest",     tp=CFrame.new(896.4,6.4,4390.2),          num=2, cf=CFrame.new(1547.15,14.45,4381.80) },
    { lv=100,  mon="Snow Bandit",        quest="SnowQuest",       tp=CFrame.new(1385.3,87.2,-1297.6),       num=1, cf=CFrame.new(1356.30,105.77,-1328.24) },
    { lv=120,  mon="Snowman",            quest="SnowQuest",       tp=CFrame.new(1385.3,87.2,-1297.6),       num=2, cf=CFrame.new(1218.80,138.01,-1488.03) },
    { lv=150,  mon="Chief Petty Officer",quest="MarineQuest2",    tp=CFrame.new(-5035.4,28.7,4324.6),       num=1, cf=CFrame.new(-4931.16,65.79,4121.84) },
    { lv=175,  mon="Sky Bandit",         quest="SkyQuest",        tp=CFrame.new(-4842.1,717.7,-2623.3),     num=1, cf=CFrame.new(-4955.64,365.46,-2908.19) },
    { lv=190,  mon="Dark Master",        quest="SkyQuest",        tp=CFrame.new(-4842.1,717.7,-2623.3),     num=2, cf=CFrame.new(-5148.17,439.05,-2332.96) },
    { lv=210,  mon="Prisoner",           quest="PrisonerQuest",   tp=CFrame.new(5310.6,0.3,474.8),          num=1, cf=CFrame.new(4937.32,0.33,649.57) },
    { lv=250,  mon="Dangerous Prisoner", quest="PrisonerQuest",   tp=CFrame.new(5310.6,0.3,474.8),          num=2, cf=CFrame.new(5099.66,0.35,1055.76) },
    { lv=275,  mon="Toga Warrior",       quest="ColosseumQuest",  tp=CFrame.new(-1576.1,7.3,-2983.4),       num=1, cf=CFrame.new(-1872.52,49.08,-2913.81) },
    { lv=300,  mon="Gladiator",          quest="ColosseumQuest",  tp=CFrame.new(-1576.1,7.3,-2983.4),       num=2, cf=CFrame.new(-1521.37,81.20,-3066.31) },
    { lv=330,  mon="Military Soldier",   quest="MagmaQuest",      tp=CFrame.new(-5316.4,12.3,8515.3),       num=1, cf=CFrame.new(-5369.00,61.24,8556.49) },
    { lv=375,  mon="Military Spy",       quest="MagmaQuest",      tp=CFrame.new(-5316.4,12.3,8515.3),       num=2, cf=CFrame.new(-5787.00,75.83,8651.70) },
    { lv=400,  mon="Fishman Warrior",    quest="FishmanQuest",    tp=CFrame.new(61122.6,18.9,1569.4),       num=1, cf=CFrame.new(60844.11,98.46,1298.40) },
    { lv=450,  mon="Fishman Commando",   quest="FishmanQuest",    tp=CFrame.new(61122.6,18.9,1569.4),       num=2, cf=CFrame.new(61738.40,64.21,1433.84) },
    { lv=475,  mon="God's Guard",        quest="SkyExp1Quest",    tp=CFrame.new(-4721.9,845.3,-1954.7),     num=1, cf=CFrame.new(-4628.05,866.93,-1931.24) },
    { lv=525,  mon="Shanda",             quest="SkyExp1Quest",    tp=CFrame.new(-7863.1,5545.5,-379.3),     num=2, cf=CFrame.new(-7685.15,5601.08,-441.39) },
    { lv=550,  mon="Royal Squad",        quest="SkyExp2Quest",    tp=CFrame.new(-7902.6,5636.1,-1411.2),    num=1, cf=CFrame.new(-7654.25,5637.11,-1407.76) },
    { lv=625,  mon="Royal Soldier",      quest="SkyExp2Quest",    tp=CFrame.new(-7902.6,5636.1,-1411.2),    num=2, cf=CFrame.new(-7760.41,5679.91,-1884.81) },
    { lv=650,  mon="Galley Pirate",      quest="FountainQuest",   tp=CFrame.new(5259.8,38.5,4050.1),        num=1, cf=CFrame.new(5557.17,152.33,3998.78) },
    { lv=700,  mon="Galley Captain",     quest="FountainQuest",   tp=CFrame.new(5259.8,38.5,4050.1),        num=2, cf=CFrame.new(5677.68,92.79,4966.63) },
    -- Sea 2
    { lv=725,  mon="Raider",             quest="Area1Quest",      tp=CFrame.new(-427.72,72.99,1835.94),     num=1, cf=CFrame.new(68.87,93.64,2429.68) },
    { lv=775,  mon="Mercenary",          quest="Area1Quest",      tp=CFrame.new(-427.72,72.99,1835.94),     num=2, cf=CFrame.new(-864.85,122.47,1453.15) },
    { lv=800,  mon="Swan Pirate",        quest="Area2Quest",      tp=CFrame.new(635.61,73.09,917.81),       num=1, cf=CFrame.new(1065.37,137.64,1324.38) },
    { lv=875,  mon="Factory Staff",      quest="Area2Quest",      tp=CFrame.new(635.61,73.09,917.81),       num=2, cf=CFrame.new(533.22,128.47,355.63) },
    { lv=900,  mon="Marine Lieutenant",  quest="MarineQuest3",    tp=CFrame.new(-2440.99,73.04,-3217.70),   num=1, cf=CFrame.new(-2489.26,84.61,-3151.88) },
    { lv=950,  mon="Marine Captain",     quest="MarineQuest3",    tp=CFrame.new(-2440.99,73.04,-3217.70),   num=2, cf=CFrame.new(-2335.20,79.79,-3245.87) },
    { lv=975,  mon="Zombie",             quest="ZombieQuest",     tp=CFrame.new(-5494.34,48.50,-794.59),    num=1, cf=CFrame.new(-5536.50,101.09,-835.59) },
    { lv=1000, mon="Vampire",            quest="ZombieQuest",     tp=CFrame.new(-5494.34,48.50,-794.59),    num=2, cf=CFrame.new(-5806.11,16.72,-1164.44) },
    { lv=1050, mon="Snow Trooper",       quest="SnowMountainQuest",tp=CFrame.new(607.05,401.44,-5370.55),   num=1, cf=CFrame.new(535.21,432.74,-5484.92) },
    { lv=1100, mon="Winter Warrior",     quest="SnowMountainQuest",tp=CFrame.new(607.05,401.44,-5370.55),   num=2, cf=CFrame.new(1234.44,456.95,-5174.13) },
    { lv=1125, mon="Lab Subordinate",    quest="IceSideQuest",    tp=CFrame.new(-6061.84,15.92,-4902.03),   num=1, cf=CFrame.new(-5720.56,63.31,-4784.61) },
    { lv=1175, mon="Horned Warrior",     quest="IceSideQuest",    tp=CFrame.new(-6061.84,15.92,-4902.03),   num=2, cf=CFrame.new(-6292.75,91.18,-5502.65) },
    { lv=1200, mon="Magma Ninja",        quest="FireSideQuest",   tp=CFrame.new(-5429.04,15.97,-5297.96),   num=1, cf=CFrame.new(-5461.84,130.36,-5836.47) },
    { lv=1250, mon="Lava Pirate",        quest="FireSideQuest",   tp=CFrame.new(-5429.04,15.97,-5297.96),   num=2, cf=CFrame.new(-5251.19,55.16,-4774.41) },
    { lv=1275, mon="Ship Deckhand",      quest="ShipQuest1",      tp=CFrame.new(1040.29,125.08,32911.03),   num=1, cf=CFrame.new(921.12,125.98,33088.33) },
    { lv=1300, mon="Ship Engineer",      quest="ShipQuest1",      tp=CFrame.new(1040.29,125.08,32911.03),   num=2, cf=CFrame.new(886.28,40.48,32800.83) },
    { lv=1325, mon="Ship Steward",       quest="ShipQuest2",      tp=CFrame.new(971.42,125.08,33245.54),    num=1, cf=CFrame.new(943.86,129.58,33444.37) },
    { lv=1350, mon="Ship Officer",       quest="ShipQuest2",      tp=CFrame.new(971.42,125.08,33245.54),    num=2, cf=CFrame.new(955.38,181.08,33331.89) },
    { lv=1375, mon="Arctic Warrior",     quest="FrostQuest",      tp=CFrame.new(5668.13,28.20,-6484.60),    num=1, cf=CFrame.new(5935.45,77.26,-6472.76) },
    { lv=1425, mon="Snow Lurker",        quest="FrostQuest",      tp=CFrame.new(5668.13,28.20,-6484.60),    num=2, cf=CFrame.new(5628.48,57.58,-6618.35) },
    { lv=1450, mon="Sea Soldier",        quest="ForgottenQuest",  tp=CFrame.new(-3054.58,236.87,-10147.79), num=1, cf=CFrame.new(-3185.02,58.79,-9663.61) },
    { lv=1500, mon="Water Fighter",      quest="ForgottenQuest",  tp=CFrame.new(-3054.58,236.87,-10147.79), num=2, cf=CFrame.new(-3262.93,298.69,-10552.53) },
    -- Sea 3
    { lv=1525, mon="Pirate Millionaire", quest="PiratePortQuest", tp=CFrame.new(-289,44,5580),              num=1, cf=CFrame.new(-435.68,189.70,5551.08) },
    { lv=1575, mon="Pistol Billionaire", quest="PiratePortQuest", tp=CFrame.new(-289,44,5580),              num=2, cf=CFrame.new(-236.54,217.47,6006.09) },
    { lv=1600, mon="Dragon Crew Warrior",quest="DragonCrewQuest", tp=CFrame.new(6735,127,-711),             num=1, cf=CFrame.new(6301.998,104.77,-1082.61) },
    { lv=1625, mon="Dragon Crew Archer", quest="DragonCrewQuest", tp=CFrame.new(6735,127,-711),             num=2, cf=CFrame.new(6831.12,441.77,446.59) },
    { lv=1725, mon="Marine Commodore",   quest="MarineTreeIsland",tp=CFrame.new(2180,29,-6738),             num=1, cf=CFrame.new(2198.01,128.71,-7109.50) },
    { lv=1750, mon="Marine Rear Admiral",quest="MarineTreeIsland",tp=CFrame.new(2180,29,-6738),             num=2, cf=CFrame.new(3294.31,385.41,-7048.63) },
    { lv=1825, mon="Reborn Skeleton",    quest="HauntedQuest1",   tp=CFrame.new(-9515,142,5535),            num=1, cf=CFrame.new(-8761.77,183.43,6168.33) },
    { lv=1850, mon="Living Zombie",      quest="HauntedQuest1",   tp=CFrame.new(-9515,142,5535),            num=2, cf=CFrame.new(-10103.75,238.57,6179.76) },
    { lv=1875, mon="Demonic Soul",       quest="HauntedQuest2",   tp=CFrame.new(-9515,142,5535),            num=1, cf=CFrame.new(-9712.03,204.70,6193.32) },
    { lv=1900, mon="Posessed Mummy",     quest="HauntedQuest2",   tp=CFrame.new(-9515,142,5535),            num=2, cf=CFrame.new(-9545.78,69.62,6339.56) },
    { lv=1925, mon="Peanut Scout",       quest="NutIslandQuest",  tp=CFrame.new(-2104,38,-10193),           num=1, cf=CFrame.new(-2150.59,122.50,-10358.99) },
    { lv=1950, mon="Peanut President",   quest="NutIslandQuest",  tp=CFrame.new(-2104,38,-10193),           num=2, cf=CFrame.new(-2150.59,122.50,-10358.99) },
    { lv=1975, mon="Ice Cream Chef",     quest="IceCreamIslandQuest",tp=CFrame.new(-821,65,-10965),         num=1, cf=CFrame.new(-789.94,209.38,-11009.98) },
    { lv=2000, mon="Ice Cream Commander",quest="IceCreamIslandQuest",tp=CFrame.new(-821,65,-10965),         num=2, cf=CFrame.new(-789.94,209.38,-11009.98) },
    { lv=2025, mon="Cookie Crafter",     quest="CakeQuest1",      tp=CFrame.new(-2021,36,-12030),           num=1, cf=CFrame.new(-2321.71,36.70,-12216.79) },
    { lv=2050, mon="Cake Guard",         quest="CakeQuest1",      tp=CFrame.new(-2021,36,-12030),           num=2, cf=CFrame.new(-1418.11,36.67,-12255.73) },
    { lv=2075, mon="Baking Staff",       quest="CakeQuest2",      tp=CFrame.new(-2021,36,-12030),           num=1, cf=CFrame.new(-2021,36,-12030) },
    { lv=2100, mon="Head Baker",         quest="CakeQuest2",      tp=CFrame.new(-2021,36,-12030),           num=2, cf=CFrame.new(-2021,36,-12030) },
    { lv=2125, mon="Cocoa Warrior",      quest="ChocolateQuest1", tp=CFrame.new(231,24,-12195),             num=1, cf=CFrame.new(231,24,-12195) },
    { lv=2150, mon="Chocolate Bar Battler",quest="ChocolateQuest1",tp=CFrame.new(231,24,-12195),            num=2, cf=CFrame.new(231,24,-12195) },
    { lv=2175, mon="Sweet Thief",        quest="ChocolateQuest2", tp=CFrame.new(151,24,-12774),             num=1, cf=CFrame.new(151,24,-12774) },
    { lv=2200, mon="Candy Rebel",        quest="ChocolateQuest2", tp=CFrame.new(151,24,-12774),             num=2, cf=CFrame.new(151,24,-12774) },
    { lv=2425, mon="Candy Pirate",       quest="CandyQuest1",     tp=CFrame.new(-1149,14,-14445),           num=1, cf=CFrame.new(-1149,14,-14445) },
    { lv=2450, mon="Snow Demon",         quest="CandyQuest1",     tp=CFrame.new(-1149,14,-14445),           num=2, cf=CFrame.new(-1149,14,-14445) },
    { lv=2475, mon="Isle Outlaw",        quest="TikiQuest1",      tp=CFrame.new(-16548,56,-173),            num=1, cf=CFrame.new(-16548,56,-173) },
    { lv=2500, mon="Island Boy",         quest="TikiQuest1",      tp=CFrame.new(-16548,56,-173),            num=2, cf=CFrame.new(-16548,56,-173) },
    { lv=2525, mon="Sun-kissed Warrior", quest="TikiQuest2",      tp=CFrame.new(-16541,55,1051),            num=1, cf=CFrame.new(-16541,55,1051) },
    { lv=2550, mon="Isle Champion",      quest="TikiQuest2",      tp=CFrame.new(-16541,55,1051),            num=2, cf=CFrame.new(-16541,55,1051) },
    { lv=2575, mon="Serpent Hunter",     quest="TikiQuest3",      tp=CFrame.new(-16665,105,1579),           num=1, cf=CFrame.new(-16665,105,1579) },
    { lv=2600, mon="Skull Slayer",       quest="TikiQuest3",      tp=CFrame.new(-16665,105,1579),           num=2, cf=CFrame.new(-16665,105,1579) },
    { lv=2625, mon="Reef Bandit",        quest="SubmergedQuest1", tp=CFrame.new(10882,-2086,10034),         num=1, cf=CFrame.new(10882,-2086,10034) },
    { lv=2650, mon="Coral Pirate",       quest="SubmergedQuest1", tp=CFrame.new(10882,-2086,10034),         num=2, cf=CFrame.new(10882,-2086,10034) },
    { lv=2675, mon="Sea Chanter",        quest="SubmergedQuest2", tp=CFrame.new(10882,-2086,10034),         num=1, cf=CFrame.new(10882,-2086,10034) },
    { lv=2700, mon="Ocean Prophet",      quest="SubmergedQuest2", tp=CFrame.new(10882,-2086,10034),         num=2, cf=CFrame.new(10882,-2086,10034) },
    { lv=2725, mon="High Disciple",      quest="SubmergedQuest3", tp=CFrame.new(9636,-1992,9609),           num=1, cf=CFrame.new(9636,-1992,9609) },
    { lv=9999, mon="Grand Devotee",      quest="SubmergedQuest3", tp=CFrame.new(9636,-1992,9609),           num=2, cf=CFrame.new(9636,-1992,9609) },
}

local function CheckQuest()
    local lv = Data.Level.Value
    local selected = nil
    for _, d in ipairs(QuestLevelData) do
        if lv < d.lv then
            selected = d
            break
        end
    end
    if not selected then selected = QuestLevelData[#QuestLevelData] end
    Namemon      = selected.mon
    NameQuest    = selected.quest
    TP           = selected.tp
    QuestNum     = selected.num
    CFrameMonster= selected.cf
    CFrameQuest  = selected.tp
end

-- ================== AUTO FARM MAIN LOOP (Quest mode) ==================
task.spawn(function()
    while true do
        task.wait(0.1)
        if not _G.AutoFarm then
            LockTarget = nil; WaitingAtSpawn = false; continue
        end
        pcall(function()
            CheckQuest()
            EquipMelee()
            if not HasQuest() and not WaitingAtSpawn then
                FlyTo(TP)
                CommF:InvokeServer("StartQuest", NameQuest, QuestNum)
            end
            local found = false
            for _, mob in ipairs(Enemies:GetChildren()) do
                if mob.Name == Namemon and IsAlive(mob) then
                    found = true; WaitingAtSpawn = false; LockTarget = mob
                    repeat
                        task.wait()
                        if not _G.AutoFarm then break end
                        FlyTo(mob.HumanoidRootPart.CFrame * CFrame.new(0,15,0))
                    until not IsAlive(mob) or not _G.AutoFarm
                    LockTarget = nil; break
                end
            end
            if _G.AutoFarm and not found and CFrameMonster then
                LockTarget = nil; WaitingAtSpawn = true
                FlyTo(CFrameMonster * CFrame.new(0,15,0))
            end
        end)
    end
end)

-- ================== AUTO FARM NEAREST ==================
task.spawn(function()
    while true do
        task.wait(0.1)
        if not Nearest_Farm_Func then continue end
        pcall(function()
            EquipTool(Selected_Weapon)
            local char = Player.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local closest, closestDist = nil, math.huge
            for _, enemy in ipairs(Enemies:GetChildren()) do
                if enemy:FindFirstChild("HumanoidRootPart") and IsAlive(enemy) then
                    local d = (hrp.Position - enemy.HumanoidRootPart.Position).Magnitude
                    if d < closestDist then closestDist = d; closest = enemy end
                end
            end
            if closest then
                Stopped_Tween = false
                TweenTo(closest.HumanoidRootPart.CFrame * Farm_Mode)
                BringEnemies(closest)
            end
        end)
    end
end)

-- ================== AUTO FARM SELECTED MONSTER (Quest) ==================
task.spawn(function()
    while true do
        task.wait(0.1)
        if not Select_Monster_Quest_Func or not Selected_Monster then continue end
        pcall(function()
            local monName = Selected_Monster:match("^([^%[]+)") -- strip level tag
            if monName then monName = monName:gsub("%s+$","") end
            EquipTool(Selected_Weapon)
            if not HasQuest() then
                CommF:InvokeServer("StartQuest", NameQuest, QuestNum)
            end
            for _, mob in ipairs(Enemies:GetChildren()) do
                if mob.Name == monName and IsAlive(mob) then
                    Stopped_Tween = false
                    TweenTo(mob.HumanoidRootPart.CFrame * Farm_Mode)
                    BringEnemies(mob)
                    break
                end
            end
        end)
    end
end)

-- ================== AUTO CHEST LOOT ==================
local chestStatusLbl, chestDot

local function GetAllChests()
    local chests = {}
    local function search(folder, depth)
        if depth > 8 then return end
        for _, obj in ipairs(folder:GetChildren()) do
            if obj.Name:lower():find("chest") then table.insert(chests, obj) end
            if obj:IsA("Folder") or obj:IsA("Model") or obj:IsA("BasePart") then search(obj, depth+1) end
        end
    end
    search(workspace, 0)
    return chests
end

local function GetClosestChest()
    local char = Player.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local chests = GetAllChests()
    local closest, closestDist = nil, math.huge
    for _, chest in ipairs(chests) do
        local part = chest:IsA("BasePart") and chest or chest:FindFirstChildWhichIsA("BasePart") or chest.PrimaryPart
        if part then
            local dist = (hrp.Position - part.Position).Magnitude
            if dist < closestDist then closestDist = dist; closest = {obj=chest, part=part, dist=dist} end
        end
    end
    return closest
end

task.spawn(function()
    while true do
        task.wait(0.5)
        if not _G.AutoChest then continue end
        pcall(function()
            local result = GetClosestChest()
            if not result then
                if chestStatusLbl then chestStatusLbl.Text = "Chest:  NO CHEST FOUND"; chestStatusLbl.TextColor3 = Color3.fromRGB(255,165,0) end
                return
            end
            local chest = result.obj; local part = result.part
            if chestStatusLbl then chestStatusLbl.Text = "Chest:  FLYING (" .. math.floor(result.dist) .. " studs)"; chestStatusLbl.TextColor3 = Color3.fromRGB(255,220,0) end
            FlyToGeneral(CFrame.new(part.Position + Vector3.new(0,3,0)), "AutoChest")
            if not _G.AutoChest then return end
            local opened = false
            local prompt = chest:FindFirstChildOfClass("ProximityPrompt", true) or part:FindFirstChildOfClass("ProximityPrompt")
            if prompt then fireproximityprompt(prompt); opened = true end
            if not opened then
                local cd = chest:FindFirstChildOfClass("ClickDetector", true) or part:FindFirstChildOfClass("ClickDetector")
                if cd then fireclickdetector(cd); opened = true end
            end
            if not opened then
                pcall(function() CommF:InvokeServer("OpenChest", chest) end)
                pcall(function() CommF:InvokeServer("Loot", chest) end)
            end
            if chestStatusLbl then chestStatusLbl.Text = "Chest:  LOOTED ✓"; chestStatusLbl.TextColor3 = Color3.fromRGB(0,220,120) end
            task.wait(0.5)
        end)
    end
end)

-- ================== HOP SERVER ==================
local function HopServer()
    local servers = {}
    local ok, data = pcall(function()
        return game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
    end)
    if ok and data then
        local decoded = game:GetService("HttpService"):JSONDecode(data)
        if decoded and decoded.data then
            for _, server in ipairs(decoded.data) do
                if server.id ~= game.JobId and server.playing < server.maxPlayers then
                    table.insert(servers, server.id)
                end
            end
        end
    end
    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(#servers)])
    end
end

-- ================== GLOW EFFECT ==================
local function ApplyGlowEffect(char)
    local hl = char:FindFirstChild("UserGlow") or Instance.new("Highlight")
    hl.Name = "UserGlow"; hl.Parent = char
    hl.FillColor = Color3.fromRGB(0,255,255)
    hl.OutlineColor = Color3.fromRGB(255,255,255)
    hl.FillTransparency = 0.4; hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
end
Player.CharacterAdded:Connect(function(char) ApplyGlowEffect(char) end)
if Player.Character then ApplyGlowEffect(Player.Character) end

-- ================== FPS BOOST ==================
local function ApplyFPSBoost(enabled)
    if enabled then
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").FogEnd = 999999
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = false
            end
        end
        pcall(function() setfpscap(math.huge) end)
    else
        game:GetService("Lighting").GlobalShadows = true
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = true
            end
        end
        pcall(function() setfpscap(60) end)
    end
end

-- ================== DARK STEP AUTO BUY ==================
local DarkStepBought = false
local DARKSTEP_PRICE = 150000
local dsStatusLbl, dsStatusDot

local function BuyDarkStep()
    if dsStatusLbl then dsStatusLbl.Text = "Dark Step:  FLYING TO NPC..."; dsStatusLbl.TextColor3 = Color3.fromRGB(255,200,0) end
    FlyToGeneral(CFrame.new(0.666,0.562,-0.491), "AutoBuyDarkStep")
    if not _G.AutoBuyDarkStep then return false end
    task.wait(1)
    if dsStatusLbl then dsStatusLbl.Text = "Dark Step:  BUYING..." end
    local success = pcall(function() CommF:InvokeServer("BuyBlackLeg") end)
    if success then
        DarkStepBought = true; _G.AutoBuyDarkStep = false
        if dsStatusLbl then dsStatusLbl.Text = "Dark Step:  BOUGHT! ✓"; dsStatusLbl.TextColor3 = Color3.fromRGB(0,220,120) end
        return true
    end
    if dsStatusLbl then dsStatusLbl.Text = "Dark Step:  FAILED — RETRYING..." end
    return false
end

task.spawn(function()
    while true do
        task.wait(1)
        if not _G.AutoBuyDarkStep or DarkStepBought then continue end
        pcall(function()
            local beli = Data.Beli.Value
            if beli >= DARKSTEP_PRICE then
                local bought = BuyDarkStep()
                if not bought then task.wait(3) end
            else
                local pct = math.floor(beli/DARKSTEP_PRICE*100)
                if dsStatusLbl then dsStatusLbl.Text = "Dark Step:  NEED BELI (" .. pct .. "%)"; dsStatusLbl.TextColor3 = Color3.fromRGB(255,165,0) end
            end
        end)
    end
end)

-- ================== AUTO W (Sea Event) ==================
task.spawn(function()
    while true do
        task.wait(0.1)
        if Auto_W_Func then
            VirtualInputManager:SendKeyEvent(true,"W",false,game); task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false,"W",false,game)
        end
    end
end)

-- ================== AUTO CLICK ==================
task.spawn(function()
    while true do
        task.wait(0.3)
        if Auto_Click_Func then
            VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,1); task.wait(0.1)
            VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,1)
        end
    end
end)

-- ================== KEN/BUSO HAKI ==================
task.spawn(function()
    while true do
        task.wait(0.5)
        if Ken_Haki_Func then
            if not Player.Character:FindFirstChild("Highlight") then
                VirtualInputManager:SendKeyEvent(true,"E",false,game); task.wait(0.1)
                VirtualInputManager:SendKeyEvent(false,"E",false,game)
            end
        end
        if Buso_Haki_Func then
            if not Player.Character:FindFirstChild("HasBuso") then
                CommF:InvokeServer("Buso")
            end
        end
    end
end)

-- ================== SPAWN POINT ==================
task.spawn(function()
    while true do
        task.wait(5)
        if Spawn_Point_Func then
            pcall(function() CommF:InvokeServer("SetSpawnPoint") end)
        end
    end
end)

-- ================== INFINITE ENERGY ==================
task.spawn(function()
    while true do
        task.wait(0.1)
        if Infinite_Energy_Func then
            pcall(function()
                local energy = Player.Character:FindFirstChild("Energy")
                if energy then energy.Value = energy.MaxValue end
            end)
        end
    end
end)

-- ================== REMOVE FOG ==================
task.spawn(function()
    while true do
        task.wait(1)
        if Remove_Fog_Func then
            game:GetService("Lighting").FogEnd   = 999999
            game:GetService("Lighting").FogStart = 999999
        end
        if Always_Day_Func then
            game:GetService("Lighting").TimeOfDay = "12:00:00"
            game:GetService("Lighting").Brightness = 2
        end
    end
end)

-- ================== REDEEM CODES ==================
local RedeemCodes = {
    "LIGHTNINGABUSE","1LOSTADMIN","ADMINFIGHT","GIFTING_HOURS","Chandler","kittgaming",
    "KITT_RESET","Fudd10","fudd10_v2","Bignews","Sub2CaptainMaui","Sub2Fer999",
    "Enyu_is_Pro","Magicbus","JCWK","Starcodeheo","Bluxxy","SUB2GAMERROBOT_EXP1",
    "Sub2NoobMaster123","Sub2UncleKizaru","Sub2Daigrock","Axiore","TantaiGaming",
    "StrawHatMaine","Sub2OfficialNoobie","TheGreatAce"
}
local seen_c, UniqueRedeemCodes = {}, {}
for _, c in ipairs(RedeemCodes) do
    if not seen_c[c] then seen_c[c] = true; table.insert(UniqueRedeemCodes, c) end
end
local CodesRedeemed = false

-- ================== TELEPORT DATA ==================
local Islands = {
    { name="Marine Starter",   pos=Vector3.new(-2708,15,707) },
    { name="Pirate Starter",   pos=Vector3.new(1037,15,1374) },
    { name="Jungle",           pos=Vector3.new(-1262,11,412) },
    { name="Pirate Village",   pos=Vector3.new(-1112,14,3850) },
    { name="Desert",           pos=Vector3.new(1094,6,4374) },
    { name="Frozen Village",   pos=Vector3.new(1128,6,-1263) },
    { name="Middle Town",      pos=Vector3.new(-650,15,1583) },
    { name="Marineford",       pos=Vector3.new(-2437,73,-3170) },
    { name="Skylands Lower",   pos=Vector3.new(461,868,-2313) },
    { name="Prison",           pos=Vector3.new(4806,5,730) },
    { name="Magma Village",    pos=Vector3.new(-5244,8,8467) },
    { name="Underwater City",  pos=Vector3.new(61163,18,1569) },
    { name="Skylands Upper",   pos=Vector3.new(-4728,895,-1899) },
    { name="Fountain City",    pos=Vector3.new(5121,5,4110) },
    { name="Kingdom of Rose",  pos=Vector3.new(-427,72,1835) },
    { name="Green Zone",       pos=Vector3.new(-3164,84,-9636) },
    { name="Flamingo Casino",  pos=Vector3.new(635,73,917) },
    { name="Zombie Island",    pos=Vector3.new(-5494,48,-794) },
    { name="Ice Castle",       pos=Vector3.new(607,401,-5370) },
    { name="Colosseum",        pos=Vector3.new(-1576,7,-2983) },
    { name="Hot & Cold",       pos=Vector3.new(-5429,15,-5297) },
    { name="Snow Mountain",    pos=Vector3.new(1385,87,-1297) },
    { name="Forgotten Island", pos=Vector3.new(-3054,236,-10147) },
    { name="Haunted Castle",   pos=Vector3.new(-9515,142,5535) },
    { name="Sea of Treats",    pos=Vector3.new(-821,65,-10965) },
    { name="Tiki Outpost",     pos=Vector3.new(-16548,56,-173) },
    { name="Dragonstone",      pos=Vector3.new(6735,127,-711) },
    { name="Hydra Island",     pos=Vector3.new(5195,1089,617) },
}

-- ============================================================
-- ================== GEMINI GUI SYSTEM =======================
-- ============================================================

local GeminiUI = {
    Visible   = true,
    Minimized = false,
    MainSize  = UDim2.new(0, 620, 0, 460),
    MinSize   = UDim2.new(0, 620, 0, 44),
    GUIConnections = {}
}

local Theme = {
    MainBG      = Color3.fromRGB(13, 13, 18),
    TopBar      = Color3.fromRGB(18, 18, 26),
    Accent      = Color3.fromRGB(0, 200, 255),
    AccentOff   = Color3.fromRGB(80, 80, 100),
    Text        = Color3.fromRGB(230, 235, 255),
    Secondary   = Color3.fromRGB(25, 25, 38),
    Close       = Color3.fromRGB(220, 60, 60),
    ToggleON    = Color3.fromRGB(0, 220, 120),
    ToggleOFF   = Color3.fromRGB(55, 55, 75),
    ToggleBall  = Color3.fromRGB(255, 255, 255),
    Border      = Color3.fromRGB(0, 200, 255),
    SubText     = Color3.fromRGB(120, 130, 160),
    BtnHover    = Color3.fromRGB(30, 30, 48),
    Warning     = Color3.fromRGB(255, 165, 0),
}

-- ===== ScreenGui =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KYX_HUB_V3"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- ===== Main Frame =====
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = GeminiUI.MainSize
MainFrame.Position = UDim2.new(0.5,-310,0.5,-230)
MainFrame.BackgroundColor3 = Theme.MainBG
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.BackgroundTransparency = 1
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,12)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Theme.Border; MainStroke.Thickness = 1.5; MainStroke.Transparency = 0.6

-- ===== Title Bar =====
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"; TitleBar.Size = UDim2.new(1,0,0,44)
TitleBar.BackgroundColor3 = Theme.TopBar; TitleBar.BorderSizePixel = 0; TitleBar.ZIndex = 2
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0,12)
local TFix = Instance.new("Frame", TitleBar)
TFix.Size = UDim2.new(1,0,0,10); TFix.Position = UDim2.new(0,0,1,-10)
TFix.BackgroundColor3 = Theme.TopBar; TFix.BorderSizePixel = 0; TFix.ZIndex = 2

local AccentLine = Instance.new("Frame", TitleBar)
AccentLine.Size = UDim2.new(1,0,0,2); AccentLine.Position = UDim2.new(0,0,1,0)
AccentLine.BackgroundColor3 = Theme.Accent; AccentLine.BorderSizePixel = 0; AccentLine.ZIndex = 3
local AccGrad = Instance.new("UIGradient", AccentLine)
AccGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(0,100,255)),
    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(0,220,255)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(0,100,255)),
})

local TitleDot = Instance.new("Frame", TitleBar)
TitleDot.Size = UDim2.new(0,8,0,8); TitleDot.Position = UDim2.new(0,14,0.5,-4)
TitleDot.BackgroundColor3 = Theme.Accent; TitleDot.BorderSizePixel = 0; TitleDot.ZIndex = 3
Instance.new("UICorner", TitleDot).CornerRadius = UDim.new(1,0)

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Text = "KYX HUB"; TitleText.Size = UDim2.new(1,-140,1,0); TitleText.Position = UDim2.new(0,28,0,0)
TitleText.BackgroundTransparency = 1; TitleText.TextColor3 = Theme.Text
TitleText.Font = Enum.Font.GothamBold; TitleText.TextSize = 14; TitleText.TextXAlignment = Enum.TextXAlignment.Left; TitleText.ZIndex = 3

local SubTitleText = Instance.new("TextLabel", TitleBar)
SubTitleText.Text = "mwtdmjg  •  v3.0  •  ALL-IN-ONE"
SubTitleText.Size = UDim2.new(1,-140,1,0); SubTitleText.Position = UDim2.new(0,28,0,14)
SubTitleText.BackgroundTransparency = 1; SubTitleText.TextColor3 = Theme.SubText
SubTitleText.Font = Enum.Font.Gotham; SubTitleText.TextSize = 10; SubTitleText.TextXAlignment = Enum.TextXAlignment.Left; SubTitleText.ZIndex = 3

local MinBtn = Instance.new("TextButton", TitleBar)
MinBtn.Text = "−"; MinBtn.Size = UDim2.new(0,32,0,32); MinBtn.Position = UDim2.new(1,-76,0.5,-16)
MinBtn.BackgroundColor3 = Theme.Secondary; MinBtn.TextColor3 = Theme.Text
MinBtn.Font = Enum.Font.GothamBold; MinBtn.TextSize = 18; MinBtn.BorderSizePixel = 0; MinBtn.ZIndex = 4
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0,8)

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Text = "✕"; CloseBtn.Size = UDim2.new(0,32,0,32); CloseBtn.Position = UDim2.new(1,-38,0.5,-16)
CloseBtn.BackgroundColor3 = Theme.Close; CloseBtn.TextColor3 = Theme.Text
CloseBtn.Font = Enum.Font.GothamBold; CloseBtn.TextSize = 13; CloseBtn.BorderSizePixel = 0; CloseBtn.ZIndex = 4
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0,8)

-- ===== Content Area =====
local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Name = "ContentFrame"; ContentFrame.Size = UDim2.new(1,0,1,-46); ContentFrame.Position = UDim2.new(0,0,0,46)
ContentFrame.BackgroundTransparency = 1; ContentFrame.ClipsDescendants = true

-- ===== Tab Bar =====
local TabBar = Instance.new("Frame", ContentFrame)
TabBar.Name = "TabBar"; TabBar.Size = UDim2.new(0,120,1,-10); TabBar.Position = UDim2.new(0,6,0,5)
TabBar.BackgroundColor3 = Theme.Secondary; TabBar.BorderSizePixel = 0
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0,10)
local TabList = Instance.new("UIListLayout", TabBar)
TabList.Padding = UDim.new(0,3); TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
local TabPad = Instance.new("UIPadding", TabBar)
TabPad.PaddingTop = UDim.new(0,8); TabPad.PaddingLeft = UDim.new(0,5); TabPad.PaddingRight = UDim.new(0,5)

-- ===== Panel =====
local PanelFrame = Instance.new("Frame", ContentFrame)
PanelFrame.Name = "PanelFrame"; PanelFrame.Size = UDim2.new(1,-136,1,-10); PanelFrame.Position = UDim2.new(0,130,0,5)
PanelFrame.BackgroundColor3 = Theme.Secondary; PanelFrame.BorderSizePixel = 0
Instance.new("UICorner", PanelFrame).CornerRadius = UDim.new(0,10)

local PanelContainer = Instance.new("Frame", PanelFrame)
PanelContainer.Name = "PanelContainer"; PanelContainer.Size = UDim2.new(1,-4,1,-4); PanelContainer.Position = UDim2.new(0,2,0,2)
PanelContainer.BackgroundTransparency = 1; PanelContainer.ClipsDescendants = true

-- ===== TAB SYSTEM =====
local TabPages = {}
local ActiveTab = nil

local function CreateTab(name, icon)
    local btn = Instance.new("TextButton")
    btn.Text = (icon and (icon.."  ") or "")..name
    btn.Size = UDim2.new(1,0,0,32); btn.BackgroundColor3 = Theme.MainBG
    btn.TextColor3 = Theme.SubText; btn.Font = Enum.Font.Gotham; btn.TextSize = 11
    btn.BorderSizePixel = 0; btn.TextXAlignment = Enum.TextXAlignment.Left; btn.ZIndex = 2
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,7)
    local BtnPad = Instance.new("UIPadding", btn); BtnPad.PaddingLeft = UDim.new(0,8)

    local page = Instance.new("ScrollingFrame")
    page.Name = "Page_"..name; page.Size = UDim2.new(1,0,1,0)
    page.BackgroundTransparency = 1; page.BorderSizePixel = 0; page.Visible = false
    page.ScrollBarThickness = 3; page.ScrollBarImageColor3 = Theme.Accent
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.CanvasSize = UDim2.new(0,0,0,0); page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Parent = PanelContainer

    local pageList = Instance.new("UIListLayout", page)
    pageList.Padding = UDim.new(0,6); pageList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    pageList.SortOrder = Enum.SortOrder.LayoutOrder
    local pagePad = Instance.new("UIPadding", page)
    pagePad.PaddingTop = UDim.new(0,8); pagePad.PaddingBottom = UDim.new(0,12)
    pagePad.PaddingLeft = UDim.new(0,8); pagePad.PaddingRight = UDim.new(0,8)

    TabPages[name] = {Button=btn, Page=page}
    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(TabPages) do
            t.Button.BackgroundColor3 = Theme.MainBG; t.Button.TextColor3 = Theme.SubText; t.Page.Visible = false
        end
        btn.BackgroundColor3 = Theme.TopBar; btn.TextColor3 = Theme.Accent; page.Visible = true; ActiveTab = name
        page.Position = UDim2.new(0.04,0,0,0)
        page:TweenPosition(UDim2.new(0,0,0,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.18, true)
    end)
    return page
end

-- ===== TOGGLE =====
local function CreateToggle(parent, labelText, description, defaultVal, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1,0,0,50); row.BackgroundColor3 = Theme.MainBG; row.BorderSizePixel = 0; row.Parent = parent
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,9)
    local RowStroke = Instance.new("UIStroke", row); RowStroke.Color = Theme.Border; RowStroke.Thickness = 1; RowStroke.Transparency = 0.85

    local lbl = Instance.new("TextLabel", row)
    lbl.Text = labelText; lbl.Size = UDim2.new(1,-68,0,20); lbl.Position = UDim2.new(0,10,0,7)
    lbl.BackgroundTransparency = 1; lbl.TextColor3 = Theme.Text; lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 12; lbl.TextXAlignment = Enum.TextXAlignment.Left

    if description then
        local desc = Instance.new("TextLabel", row)
        desc.Text = description; desc.Size = UDim2.new(1,-68,0,14); desc.Position = UDim2.new(0,10,0,28)
        desc.BackgroundTransparency = 1; desc.TextColor3 = Theme.SubText; desc.Font = Enum.Font.Gotham; desc.TextSize = 10; desc.TextXAlignment = Enum.TextXAlignment.Left
    end

    local track = Instance.new("Frame", row)
    track.Size = UDim2.new(0,44,0,22); track.Position = UDim2.new(1,-56,0.5,-11)
    track.BackgroundColor3 = defaultVal and Theme.ToggleON or Theme.ToggleOFF; track.BorderSizePixel = 0
    Instance.new("UICorner", track).CornerRadius = UDim.new(1,0)

    local ball = Instance.new("Frame", track)
    ball.Size = UDim2.new(0,16,0,16); ball.Position = defaultVal and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8)
    ball.BackgroundColor3 = Theme.ToggleBall; ball.BorderSizePixel = 0; ball.ZIndex = 2
    Instance.new("UICorner", ball).CornerRadius = UDim.new(1,0)
    local ballGlow = Instance.new("UIStroke", ball); ballGlow.Color = Theme.ToggleON; ballGlow.Thickness = 2; ballGlow.Transparency = defaultVal and 0.3 or 1

    local isOn = defaultVal
    local clickBtn = Instance.new("TextButton", row)
    clickBtn.Size = UDim2.new(1,0,1,0); clickBtn.BackgroundTransparency = 1; clickBtn.Text = ""; clickBtn.ZIndex = 5

    clickBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        local ti = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        if isOn then
            TweenService:Create(track, ti, {BackgroundColor3=Theme.ToggleON}):Play()
            TweenService:Create(ball, TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {Position=UDim2.new(1,-19,0.5,-8)}):Play()
            TweenService:Create(ballGlow, ti, {Transparency=0.3}):Play()
            TweenService:Create(RowStroke, ti, {Color=Theme.ToggleON, Transparency=0.5}):Play()
        else
            TweenService:Create(track, ti, {BackgroundColor3=Theme.ToggleOFF}):Play()
            TweenService:Create(ball, TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {Position=UDim2.new(0,3,0.5,-8)}):Play()
            TweenService:Create(ballGlow, ti, {Transparency=1}):Play()
            TweenService:Create(RowStroke, ti, {Color=Theme.Border, Transparency=0.85}):Play()
        end
        task.spawn(function()
            TweenService:Create(ball, TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {Size=UDim2.new(0,20,0,20)}):Play()
            task.wait(0.1)
            TweenService:Create(ball, TweenInfo.new(0.15,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {Size=UDim2.new(0,16,0,16)}):Play()
        end)
        if callback then callback(isOn) end
    end)
    return row
end

-- ===== SECTION HEADER =====
local function CreateSectionHeader(parent, text)
    local header = Instance.new("Frame", parent)
    header.Size = UDim2.new(1,0,0,22); header.BackgroundTransparency = 1
    local line = Instance.new("Frame", header)
    line.Size = UDim2.new(1,0,0,1); line.Position = UDim2.new(0,0,0.5,0)
    line.BackgroundColor3 = Theme.Accent; line.BackgroundTransparency = 0.7; line.BorderSizePixel = 0
    local lbl = Instance.new("TextLabel", header)
    lbl.Text = "  "..text.."  "; lbl.Size = UDim2.new(0,0,1,0); lbl.AutomaticSize = Enum.AutomaticSize.X
    lbl.Position = UDim2.new(0,10,0,0); lbl.BackgroundColor3 = Theme.Secondary
    lbl.TextColor3 = Theme.Accent; lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 10; lbl.ZIndex = 2
    return header
end

-- ===== ACTION BUTTON =====
local function CreateButton(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Text = text; btn.Size = UDim2.new(1,0,0,34); btn.BackgroundColor3 = Theme.TopBar
    btn.TextColor3 = Theme.Accent; btn.Font = Enum.Font.GothamBold; btn.TextSize = 12; btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    local bs = Instance.new("UIStroke", btn); bs.Color = Theme.Accent; bs.Thickness = 1; bs.Transparency = 0.7
    btn.MouseEnter:Connect(function() TweenService:Create(btn,TweenInfo.new(0.12),{BackgroundColor3=Theme.BtnHover}):Play() end)
    btn.MouseLeave:Connect(function() TweenService:Create(btn,TweenInfo.new(0.12),{BackgroundColor3=Theme.TopBar}):Play() end)
    btn.MouseButton1Click:Connect(function()
        TweenService:Create(btn,TweenInfo.new(0.08),{BackgroundColor3=Theme.Secondary}):Play()
        task.delay(0.1, function() TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=Theme.TopBar}):Play() end)
        if callback then callback() end
    end)
    return btn
end

-- ===== STATUS ROW =====
local function CreateStatusRow(parent, initText)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1,0,0,30); row.BackgroundColor3 = Theme.MainBG; row.BorderSizePixel = 0
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,8)
    local dot = Instance.new("Frame", row)
    dot.Size = UDim2.new(0,7,0,7); dot.Position = UDim2.new(0,10,0.5,-3.5)
    dot.BackgroundColor3 = Color3.fromRGB(70,70,80); dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
    local lbl = Instance.new("TextLabel", row)
    lbl.Text = initText or ""; lbl.Size = UDim2.new(1,-28,1,0); lbl.Position = UDim2.new(0,24,0,0)
    lbl.BackgroundTransparency = 1; lbl.TextColor3 = Theme.SubText; lbl.Font = Enum.Font.Gotham; lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return row, dot, lbl
end

-- ===== INFO ROW =====
local function CreateInfoRow(parent, text)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1,0,0,30); row.BackgroundColor3 = Theme.MainBG; row.BorderSizePixel = 0
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,8)
    local lbl = Instance.new("TextLabel", row)
    lbl.Text = text or ""; lbl.Size = UDim2.new(1,-16,1,0); lbl.Position = UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency = 1; lbl.TextColor3 = Theme.Text; lbl.Font = Enum.Font.Gotham; lbl.TextSize = 11; lbl.TextXAlignment = Enum.TextXAlignment.Left
    return row, lbl
end

-- ============================================================
-- ================== BUILD TABS ==============================
-- ============================================================
local SettingsPage   = CreateTab("Settings",  "⚙")
local FarmPage       = CreateTab("Farm",      "🌾")
local QuestPage      = CreateTab("Quest",     "📋")
local SubFarmPage    = CreateTab("Sub Farm",  "⚡")
local SeaEventPage   = CreateTab("Sea Event", "🌊")
local IslandPage     = CreateTab("Island",    "🏝")
local RaidPage       = CreateTab("Raid",      "⚔")
local BountyPage     = CreateTab("Bounty",    "💀")
local TeleportPage   = CreateTab("Teleport",  "🗺")
local MiscPage       = CreateTab("Misc",      "🔧")

-- Activate first tab
TabPages["Settings"].Button.BackgroundColor3 = Theme.TopBar
TabPages["Settings"].Button.TextColor3 = Theme.Accent
SettingsPage.Visible = true; ActiveTab = "Settings"

-- ============================================================
-- ================== SETTINGS PAGE ===========================
-- ============================================================
CreateSectionHeader(SettingsPage, "SYSTEM")

CreateToggle(SettingsPage, "Anti AFK", "ป้องกัน Kick อัตโนมัติ", true, function() end)

CreateToggle(SettingsPage, "Fast Attack", "โจมตีเร็วอัตโนมัติ", true, function(v)
    AutoAttacks = v; AutoShoot = v
end)

CreateToggle(SettingsPage, "Auto Click", "คลิกเมาส์อัตโนมัติ", false, function(v)
    Auto_Click_Func = v
end)

-- Info hint
local hintFrame = Instance.new("Frame", SettingsPage)
hintFrame.Size = UDim2.new(1,0,0,34); hintFrame.BackgroundColor3 = Color3.fromRGB(0,25,45); hintFrame.BorderSizePixel = 0
Instance.new("UICorner", hintFrame).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke", hintFrame).Color = Theme.Accent
local hintLbl = Instance.new("TextLabel", hintFrame)
hintLbl.Text = "💡  [INSERT] = ซ่อน/แสดง UI"; hintLbl.Size = UDim2.new(1,-16,1,0); hintLbl.Position = UDim2.new(0,8,0,0)
hintLbl.BackgroundTransparency = 1; hintLbl.TextColor3 = Theme.Accent; hintLbl.Font = Enum.Font.Gotham; hintLbl.TextSize = 11; hintLbl.TextXAlignment = Enum.TextXAlignment.Left

CreateSectionHeader(SettingsPage, "COMBAT")

CreateToggle(SettingsPage, "Attack Mobs", "โจมตี Mob อัตโนมัติ", true, function(v)
    FastAttack.attackMobs = v
end)

CreateToggle(SettingsPage, "Attack Players", "โจมตีผู้เล่นอัตโนมัติ", false, function(v)
    FastAttack.attackPlayers = v
end)

CreateToggle(SettingsPage, "⚔  Auto Equip Tool", "ถือ Tool อัตโนมัติ", false, function(v)
    _G.AutoEquipTool = v
end)

CreateToggle(SettingsPage, "Ken Haki", "เปิด Ken Haki อัตโนมัติ", false, function(v)
    Ken_Haki_Func = v
end)

CreateToggle(SettingsPage, "Buso Haki", "เปิด Buso Haki อัตโนมัติ", true, function(v)
    Buso_Haki_Func = v
end)

CreateToggle(SettingsPage, "Spawn Point", "ตั้ง Spawn Point อัตโนมัติ", false, function(v)
    Spawn_Point_Func = v
end)

CreateSectionHeader(SettingsPage, "VISUAL")

CreateToggle(SettingsPage, "Player Glow", "แสงรอบตัวผู้เล่น (Cyan)", true, function(v)
    if Player.Character then
        local hl = Player.Character:FindFirstChild("UserGlow")
        if hl then hl.Enabled = v end
    end
end)

CreateToggle(SettingsPage, "⚡  FPS Boost", "ลด Effect เพิ่ม FPS", false, function(v)
    _G.FPSBoost = v; ApplyFPSBoost(v)
end)

CreateSectionHeader(SettingsPage, "EFFECTS")

CreateToggle(SettingsPage, "Disable Damage Effects", "ปิด Effect Damage/Audio", false, function(v)
    AudioDamage_Func = v
end)

CreateToggle(SettingsPage, "Disable Notifications", "ปิด Notification ในเกม", false, function(v)
    Hide_Notification_Func = v
end)

CreateButton(SettingsPage, "Reset Character", function()
    if Player.Character and Player.Character:FindFirstChild("Head") then
        Player.Character.Head:Destroy()
    end
end)

CreateButton(SettingsPage, "Destroy All Particles", function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") then obj:Destroy() end
    end
end)

CreateSectionHeader(SettingsPage, "REDEEM CODES")

local redeemFrame = Instance.new("Frame", SettingsPage)
redeemFrame.Size = UDim2.new(1,0,0,40); redeemFrame.BackgroundColor3 = Color3.fromRGB(0,45,25); redeemFrame.BorderSizePixel = 0
Instance.new("UICorner", redeemFrame).CornerRadius = UDim.new(0,8)
local redeemStroke = Instance.new("UIStroke", redeemFrame); redeemStroke.Color = Theme.ToggleON; redeemStroke.Thickness = 1.5; redeemStroke.Transparency = 0.4
local redeemBtn = Instance.new("TextButton", redeemFrame)
redeemBtn.Size = UDim2.new(1,0,1,0); redeemBtn.BackgroundTransparency = 1
redeemBtn.Text = "🎁  REDEEM ALL CODES  (" .. #UniqueRedeemCodes .. ")"
redeemBtn.TextColor3 = Theme.ToggleON; redeemBtn.Font = Enum.Font.GothamBold; redeemBtn.TextSize = 12; redeemBtn.ZIndex = 2

local pBG = Instance.new("Frame", redeemFrame)
pBG.Size = UDim2.new(1,-16,0,5); pBG.Position = UDim2.new(0,8,1,-8)
pBG.BackgroundColor3 = Color3.fromRGB(15,15,15); pBG.BorderSizePixel = 0; pBG.Visible = false; pBG.ZIndex = 3
Instance.new("UICorner", pBG).CornerRadius = UDim.new(1,0)
local pFill = Instance.new("Frame", pBG)
pFill.Size = UDim2.new(0,0,1,0); pFill.BackgroundColor3 = Theme.ToggleON; pFill.BorderSizePixel = 0; pFill.ZIndex = 4
Instance.new("UICorner", pFill).CornerRadius = UDim.new(1,0)

redeemBtn.MouseButton1Click:Connect(function()
    if CodesRedeemed then return end
    CodesRedeemed = true
    redeemBtn.Text = "🔄  REDEEMING..."; redeemBtn.TextColor3 = Theme.Warning; pBG.Visible = true
    local total = #UniqueRedeemCodes; local succ = 0
    task.spawn(function()
        for i, code in ipairs(UniqueRedeemCodes) do
            redeemBtn.Text = "🔄  " .. i .. "/" .. total .. "  (" .. code .. ")"
            TweenService:Create(pFill, TweenInfo.new(0.3), {Size=UDim2.new(i/total,0,1,0)}):Play()
            local ok = pcall(function() CommF:InvokeServer("EnterCode", code) end)
            if ok then succ = succ + 1 end
            task.wait(0.35)
        end
        redeemBtn.Text = "✅  DONE  " .. succ .. "/" .. total .. " SUCCESS"
        redeemBtn.TextColor3 = Theme.ToggleON
        TweenService:Create(pFill, TweenInfo.new(0.3), {Size=UDim2.new(1,0,1,0)}):Play()
    end)
end)

-- ============================================================
-- ================== FARM PAGE ===============================
-- ============================================================
CreateSectionHeader(FarmPage, "AUTO FARM")

CreateToggle(FarmPage, "🌾  Auto Farm (Quest)", "ฟาร์ม Quest อัตโนมัติตาม Level", false, function(v)
    _G.AutoFarm = v
end)

CreateToggle(FarmPage, "🎯  Farm Nearest", "ฟาร์ม Mob ที่ใกล้ที่สุด", false, function(v)
    Nearest_Farm_Func = v; Stopped_Tween = not v
end)

local farmStatusRow, farmDot, farmLbl = CreateStatusRow(FarmPage, "Status:  IDLE")
task.spawn(function()
    while true do
        task.wait(0.5)
        if _G.AutoFarm then
            farmDot.BackgroundColor3 = Theme.ToggleON; farmLbl.TextColor3 = Theme.ToggleON
            farmLbl.Text = "Status:  FARMING  •  " .. (Namemon or "...")
        elseif Nearest_Farm_Func then
            farmDot.BackgroundColor3 = Theme.Accent; farmLbl.TextColor3 = Theme.Accent
            farmLbl.Text = "Status:  NEAREST FARM"
        else
            farmDot.BackgroundColor3 = Color3.fromRGB(70,70,80); farmLbl.TextColor3 = Theme.SubText
            farmLbl.Text = "Status:  IDLE"
        end
    end
end)

CreateSectionHeader(FarmPage, "INFO")

local _, lvlLbl = CreateInfoRow(FarmPage, "Level:  --")
task.spawn(function()
    while true do
        task.wait(1)
        pcall(function() lvlLbl.Text = "Level:  " .. tostring(Data.Level.Value) .. "  •  Next Mob: " .. (Namemon or "?") end)
    end
end)

CreateSectionHeader(FarmPage, "AUTO CHEST")

CreateToggle(FarmPage, "📦  Auto Chest Loot", "วาปเก็บ Chest ใน Map", false, function(v)
    _G.AutoChest = v
end)

local chestSRow, cDot, cLbl = CreateStatusRow(FarmPage, "Chest:  IDLE")
chestDot = cDot; chestStatusLbl = cLbl

task.spawn(function()
    while true do
        task.wait(0.5)
        if not _G.AutoChest then
            chestDot.BackgroundColor3 = Color3.fromRGB(70,70,80); chestStatusLbl.TextColor3 = Theme.SubText
            chestStatusLbl.Text = "Chest:  IDLE"
        end
    end
end)

CreateSectionHeader(FarmPage, "AUTO BUY")

local _, beliLbl = CreateInfoRow(FarmPage, "Beli:  --")
task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            local b = Data.Beli.Value
            beliLbl.Text = "Beli:  " .. string.format("%d", b)
            beliLbl.TextColor3 = b >= DARKSTEP_PRICE and Theme.ToggleON or Theme.Text
        end)
    end
end)

CreateToggle(FarmPage, "⚡  Auto Buy Dark Step", "วาปซื้อ Dark Step อัตโนมัติ", false, function(v)
    _G.AutoBuyDarkStep = v
end)

local dsRow, dsDot, dsLbl = CreateStatusRow(FarmPage, "Dark Step:  IDLE")
dsStatusDot = dsDot; dsStatusLbl = dsLbl

-- ============================================================
-- ================== QUEST PAGE ==============================
-- ============================================================
CreateSectionHeader(QuestPage, "WORLD QUEST")

CreateToggle(QuestPage, "Second World", "ต้องการ Lv.700+", false, function(v) Second_World_Quest_Func = v end)
CreateToggle(QuestPage, "Third World",  "ต้องการ Lv.1500+", false, function(v) Third_World_Quest_Func = v end)

CreateSectionHeader(QuestPage, "FIGHTING STYLE")

CreateToggle(QuestPage, "Superhuman",    "Mastery 300+ ทุก Style, $3M",   false, function(v) Superhuman_Quest_Func = v; if v then InvokeRemote("BuySuperhuman") end end)
CreateToggle(QuestPage, "Death Step",    "Black Leg Mastery 400+, $2.5M", false, function(v) Death_Step_Quest_Func = v end)
CreateToggle(QuestPage, "Sharkman Karate","Water Kung Fu 400+, $2.5M",   false, function(v) Sharkman_Karate_Quest_Func = v end)
CreateToggle(QuestPage, "Electric Claw", "Electric 400+, $3M",            false, function(v) Electric_Claw_Quest_Func = v end)
CreateToggle(QuestPage, "Dragon Talon",  "Dragon Breath 400+, $3M",       false, function(v) Dragon_Talon_Quest_Func = v end)
CreateToggle(QuestPage, "Godhuman",      "Lv.1500+, All 400+, $5M",       false, function(v) Godhuman_Quest_Func = v end)
CreateToggle(QuestPage, "Sanguine Art",  "Leviathan Heart + Items",        false, function(v) Sangui_art_Quest_Func = v end)

CreateSectionHeader(QuestPage, "SWORD QUEST")

CreateToggle(QuestPage, "Saber V1",         "Lv.200+",              false, function(v) Saber_V1_Quest_Func = v end)
CreateToggle(QuestPage, "Rengoku",           "Hidden Key Required",  false, function(v) Rengoku_Quest_Func = v end)
CreateToggle(QuestPage, "Buddy Sword",       "Cake Queen Required",  false, function(v) Buddy_Sword_Quest_Func = v end)
CreateToggle(QuestPage, "Pole (1st Form)",   "Thunder God 6% Drop",  false, function(v) Pole_1stForm_Quest_Func = v end)
CreateToggle(QuestPage, "Cavander",          "Beautiful Pirate",     false, function(v) Cavander_Quest_Func = v end)
CreateToggle(QuestPage, "Yama",              "Yama Puzzle",          false, function(v) Yama_Quest_Func = v end)
CreateToggle(QuestPage, "Tushita",           "Tushita Puzzle",       false, function(v) Tushita_Quest_Func = v end)
CreateToggle(QuestPage, "Dark Dagger",       "rip_indra True 5%",    false, function(v) Dark_Dragger_Quest_Func = v end)
CreateToggle(QuestPage, "Koko",              "Defeat Order",         false, function(v) Koko_Quest_Func = v end)
CreateToggle(QuestPage, "Spikey Trident",    "Cake Prince/King",     false, function(v) Spikey_Trident_Quest_Func = v end)
CreateToggle(QuestPage, "Hallow Scythe",     "Soul Reaper 5%",       false, function(v) Hallow_Scythe_Quest_Func = v end)

CreateSectionHeader(QuestPage, "OTHER QUEST")

CreateToggle(QuestPage, "Bartilo",           "Lv.850+",      false, function(v) Bartilo_Quest_Func = v end)
CreateToggle(QuestPage, "Citizen",           "Lv.1800+",     false, function(v) Citizen_Quest_Func = v end)
CreateToggle(QuestPage, "Don Swan",          "Auto Don Swan",false, function(v) Down_Swan_Quest_Func = v end)
CreateToggle(QuestPage, "rip indra True Form","Auto Boss",   false, function(v) rip_indra_True_Form_Quest = v end)
CreateToggle(QuestPage, "Rainbow Haki",      "Lv.1950+",     false, function(v) Rainbow_Haki_Quest_Func = v end)
CreateToggle(QuestPage, "Venom Bow",         "Hydra Leader", false, function(v) Venom_Bow_Quest_Func = v end)
CreateToggle(QuestPage, "Dojo Quest",        "Belt System",  false, function(v) Dojo_Quest_Func = v end)

CreateSectionHeader(QuestPage, "DRAGON HUNTER")

CreateToggle(QuestPage, "Kill Hydra Mobs + Ember", "Dragon Hunter Quest", false, function(v) Hydra_Mob_Quest_Func = v end)
CreateToggle(QuestPage, "Destroy Trees + Ember",   "Dragon Hunter Quest", false, function(v) Destroy_Tree_Quest_Func = v end)
CreateToggle(QuestPage, "Upgrade Dragon Talon",    "Mastery 500 Required",false, function(v) Upgrade_Dragon_Talon_Quest_Func = v end)

-- ============================================================
-- ================== SUB FARM PAGE ===========================
-- ============================================================
CreateSectionHeader(SubFarmPage, "ELITE & SPECIAL")

CreateToggle(SubFarmPage, "Elite Hunter Farm",  "Auto Elite Hunter Quest",  false, function(v) Elite_Hunter_Quest_Func = v end)
CreateToggle(SubFarmPage, "Cake Prince Spawn",  "Defeat 500 Cake Mobs",     false, function(v) Cake_Prince_Quest_Func = v end)
CreateToggle(SubFarmPage, "Dough King Spawn",   "Sweet Chalice Required",   false, function(v) Dough_King_Quest_Func = v end)

if game.PlaceId == 4442272183 then
    CreateToggle(SubFarmPage, "Factory Raid", "Auto Factory Raid", false, function(v) Factory_Farming_Func = v end)
elseif game.PlaceId == 7449423635 then
    CreateToggle(SubFarmPage, "Pirate Raid",  "Auto Pirate Raid",  false, function(v) Pirate_Raid_Farming_Func = v end)
end

CreateSectionHeader(SubFarmPage, "MATERIALS & CHEST")

CreateToggle(SubFarmPage, "Auto Farm Chest (All)", "ฟาร์ม Chest ทั่วทั้งแมพ", false, function(v)
    Farming_Chest_Func = v
end)

CreateToggle(SubFarmPage, "Berry ESP",         "แสดง Berry บนแมพ", false, function(v) Berries_ESP_Func = v end)
CreateToggle(SubFarmPage, "Auto Collect Berry","เก็บ Berry อัตโนมัติ", false, function(v) Berries_Farming_Func = v end)

CreateSectionHeader(SubFarmPage, "OBSERVATION")

CreateToggle(SubFarmPage, "Auto Farm Observation",  "ฟาร์ม Observation Mastery",  false, function(v) Farming_Observation_Func = v end)
CreateToggle(SubFarmPage, "Get Observation V2",     "Auto Observation V2",          false, function(v) Get_Observation_V2_Func = v end)
CreateButton(SubFarmPage, "Hop Server", function() HopServer() end)

CreateSectionHeader(SubFarmPage, "MASTERY FARM")

CreateToggle(SubFarmPage, "Enable Mastery Farm", "ฟาร์ม Mastery Blox Fruit/Gun", false, function(v) Mastery_Farming_Func = v end)

-- ============================================================
-- ================== SEA EVENT PAGE ==========================
-- ============================================================
CreateSectionHeader(SeaEventPage, "CONFIGURATION")

local _, seaWeapLbl = CreateInfoRow(SeaEventPage, "Weapon: " .. Sea_Event_Weapon_Selected_Func)
CreateButton(SeaEventPage, "Toggle Weapon (Melee/Sword/Gun)", function()
    local list = {"Melee","Sword","Gun","Blox Fruit"}
    local idx = 1
    for i,v in ipairs(list) do if v == Sea_Event_Weapon_Selected_Func then idx = i break end end
    idx = idx % #list + 1
    Sea_Event_Weapon_Selected_Func = list[idx]
    seaWeapLbl.Text = "Weapon: " .. Sea_Event_Weapon_Selected_Func
end)

CreateToggle(SeaEventPage, "Auto W (Auto Run Boat)", "บังคับเรืออัตโนมัติ", false, function(v) Auto_W_Func = v end)
CreateToggle(SeaEventPage, "Aimbot Skill", "Auto Aim Skill Sea Event", false, function(v) AimbotSkill_SeaEvent_Func = v end)

CreateSectionHeader(SeaEventPage, "SEA EVENTS")

CreateToggle(SeaEventPage, "Auto Sails",         "แล่นเรืออัตโนมัติ",    false, function(v) Auto_Sails_Func = v; Stopped_Tween = not v end)
CreateToggle(SeaEventPage, "Attack Fish",         "โจมตี Shark/Fish",     false, function(v) Fish_Farming_Func = v end)
CreateToggle(SeaEventPage, "Attack Terrorshark",  "โจมตี Terrorshark",    false, function(v) Terrorshark_Farming_Func = v end)
CreateToggle(SeaEventPage, "Attack Ghost Ship",   "โจมตี Ghost Ship",     false, function(v) GhostShip_Farming_Func = v end)
CreateToggle(SeaEventPage, "Attack Sea Beast",    "โจมตี Sea Beast",      false, function(v) Sea_Beast_Farming_Func = v end)

CreateSectionHeader(SeaEventPage, "TEAM")

CreateButton(SeaEventPage, "Set Team: Pirates", function() InvokeRemote("SetTeam","Pirates") end)
CreateButton(SeaEventPage, "Set Team: Marines", function() InvokeRemote("SetTeam","Marines") end)
CreateButton(SeaEventPage, "Travel First World",  function() InvokeRemote("TravelMain") end)
CreateButton(SeaEventPage, "Travel Second World", function() InvokeRemote("TravelDressrosa") end)
CreateButton(SeaEventPage, "Travel Third World",  function() InvokeRemote("TravelZou") end)

-- ============================================================
-- ================== ISLAND PAGE =============================
-- ============================================================
CreateSectionHeader(IslandPage, "MIRAGE ISLAND")

CreateToggle(IslandPage, "Mirage Notification", "แจ้งเตือนเมื่อ Mirage ปรากฏ", false, function(v) Mirage_Notification_Func = v end)
CreateToggle(IslandPage, "Mirage ESP",           "แสดง ESP Mirage",             false, function(v) Mirage_Esp_Func = v end)
CreateToggle(IslandPage, "Teleport to Mirage",   "วาปไป Mirage Island",         false, function(v) Mirage_Teleport_Func = v end)
CreateToggle(IslandPage, "Collect Gear",          "เก็บ Gear บน Mirage",         false, function(v) Mirage_Gear_Teleport_Func = v end)
CreateToggle(IslandPage, "Teleport to Fruit Dealer","วาปไป Advanced Fruit Dealer",false, function(v) Fruit_Dealer_Teleport_Func = v end)

CreateSectionHeader(IslandPage, "KITSUNE ISLAND")

CreateToggle(IslandPage, "Kitsune Notification",  "แจ้งเตือน Kitsune Island",  false, function(v) Kitsune_Notification_Func = v end)
CreateToggle(IslandPage, "Kitsune ESP",            "แสดง ESP Kitsune",          false, function(v) Kitsune_Esp_Func = v end)
CreateToggle(IslandPage, "Teleport to Kitsune",    "วาปไป Kitsune Island",      false, function(v) Teleport_Kitsune_Func = v end)
CreateToggle(IslandPage, "Collect Azure Ember",    "เก็บ Azure Ember",          false, function(v) Collect_Azure_Kitsune_Func = v end)

CreateSectionHeader(IslandPage, "PREHISTORIC ISLAND")

CreateToggle(IslandPage, "Prehistoric Notification","แจ้งเตือน Prehistoric",   false, function(v) Prehistoric_Notification_Func = v end)
CreateToggle(IslandPage, "Prehistoric ESP",          "แสดง ESP Prehistoric",    false, function(v) Prehistoric_Esp_Func = v end)
CreateToggle(IslandPage, "Teleport to Prehistoric",  "วาปไป Prehistoric",       false, function(v) Teleport_Prehistoric_Func = v end)
CreateToggle(IslandPage, "Kill Lava Golem",          "โจมตี Lava Golem",        false, function(v) Kill_Golem_Func = v end)
CreateToggle(IslandPage, "Prehistoric Aura",         "Kill Golem Instantly",    false, function(v) Kill_Golem_Instantly_Func = v end)
CreateToggle(IslandPage, "Collect Dragon Eggs",      "เก็บ Dragon Egg",         false, function(v) Collect_Dragon_Egg_Func = v end)

CreateSectionHeader(IslandPage, "RACE V4")

CreateToggle(IslandPage, "Teleport to Race Door", "วาปไปประตู Race",          false, function(v) Teleport_Race_Door_Func = v end)
CreateToggle(IslandPage, "Trial Race",             "Auto Trial Race",          false, function(v) Auto_Trial_Race_Func = v end)
CreateToggle(IslandPage, "Training Race",          "Auto Train Race",          false, function(v) Auto_Train_Race_Func = v end)

CreateButton(IslandPage, "Temple of Time",    function() InvokeRemote("requestEntrance", Vector3.new(28286,14895,102)); task.wait(1); TweenTo(CFrame.new(28286,14895,102)) end)
CreateButton(IslandPage, "Ancient One Area",  function() InvokeRemote("requestEntrance", Vector3.new(28981,14888,-120)); task.wait(1); TweenTo(CFrame.new(28981,14888,-120)) end)
CreateButton(IslandPage, "Safe Zone (Race)",  function() TweenTo(CFrame.new(28273,14896,157)) end)
CreateButton(IslandPage, "PVP Zone (Race)",   function() TweenTo(CFrame.new(28766,14967,-164)) end)

-- ============================================================
-- ================== RAID PAGE ===============================
-- ============================================================
CreateSectionHeader(RaidPage, "LAW RAID")

CreateToggle(RaidPage, "Auto Buy Law Chips",  "ซื้อ Microchip อัตโนมัติ",  false, function(v) Auto_Buy_Law_Chips_Func = v end)
CreateToggle(RaidPage, "Auto Start Law Raid", "เริ่ม Law Raid อัตโนมัติ",  false, function(v) Auto_Start_Law_Raid_Func = v end)
CreateToggle(RaidPage, "Auto Kill Law Raid",  "โจมตี Order อัตโนมัติ",     false, function(v) Auto_Kill_Law_Raid_Func = v end)

task.spawn(function()
    while true do
        task.wait(0.5)
        if Auto_Buy_Law_Chips_Func then
            pcall(function()
                if not Player.Backpack:FindFirstChild("Microchip") and not Player.Character:FindFirstChild("Microchip") and not Enemies:FindFirstChild("Order") then
                    CommF:InvokeServer("BlackbeardReward","Microchip","2")
                end
            end)
        end
        if Auto_Start_Law_Raid_Func then
            pcall(function()
                if Player.Character:FindFirstChild("Microchip") or Player.Backpack:FindFirstChild("Microchip") then
                    fireclickdetector(Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
                end
            end)
        end
        if Auto_Kill_Law_Raid_Func then
            pcall(function()
                for _, v in ipairs(Enemies:GetChildren()) do
                    if v.Name == "Order" and IsAlive(v) and v:FindFirstChild("HumanoidRootPart") then
                        EquipTool(Selected_Weapon)
                        v.HumanoidRootPart.CanCollide = false
                        TweenTo(v.HumanoidRootPart.CFrame * Farm_Mode)
                    end
                end
            end)
        end
    end
end)

CreateSectionHeader(RaidPage, "NORMAL RAID")

CreateToggle(RaidPage, "Auto Buy Microchips",   "ซื้อ Microchips อัตโนมัติ", false, function(v) Auto_Buy_Microchips_Func = v end)
CreateToggle(RaidPage, "Auto Start Raid",        "เริ่ม Raid อัตโนมัติ",      false, function(v) Auto_Start_Raid_Func = v end)
CreateToggle(RaidPage, "Auto Next Island (Raid)","ไป Island ถัดไปอัตโนมัติ",  false, function(v) Auto_Next_Island_Func = v end)
CreateToggle(RaidPage, "Auto Kill Raid Monsters","โจมตี Mob ใน Raid",          false, function(v) Auto_Kill_Raid_Monster_Func = v end)
CreateToggle(RaidPage, "Raid Aura",              "Instant Kill Raid Mobs",      false, function(v) Auto_Raid_Aura_Func = v end)

task.spawn(function()
    while true do
        task.wait(0.5)
        if Auto_Kill_Raid_Monster_Func then
            pcall(function()
                local raidTimer = Player.PlayerGui.Main.TopHUDList.RaidTimer
                if raidTimer.Visible then
                    for _, v in ipairs(Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and IsAlive(v) then
                            EquipTool(Selected_Weapon)
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                            v.HumanoidRootPart.Transparency = 1
                            TweenTo(v.HumanoidRootPart.CFrame * Farm_Mode)
                            BringEnemies(v, true)
                        end
                    end
                end
            end)
        end
        if Auto_Raid_Aura_Func then
            pcall(function()
                local raidTimer = Player.PlayerGui.Main.TopHUDList.RaidTimer
                if raidTimer.Visible then
                    for _, v in ipairs(Enemies:GetDescendants()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            EquipTool(Selected_Weapon)
                            v.Humanoid.Health = 0
                            v.HumanoidRootPart.CanCollide = false
                            sethiddenproperty(Player,"SimulationRadius",math.huge)
                        end
                    end
                end
            end)
        end
    end
end)

-- ============================================================
-- ================== BOUNTY PAGE =============================
-- ============================================================
CreateSectionHeader(BountyPage, "INFO")

local _, bountyLbl = CreateInfoRow(BountyPage, "Bounty:  --")
task.spawn(function()
    while true do
        task.wait(2)
        pcall(function()
            local b = Player.Data:FindFirstChild("Bounty")
            if b then bountyLbl.Text = "Bounty:  " .. string.format("%d", b.Value) end
        end)
    end
end)

CreateSectionHeader(BountyPage, "BOSS BOUNTY")

CreateToggle(BountyPage, "Farm All Boss", "โจมตี Boss ทุกตัวอัตโนมัติ", false, function(v)
    Farm_All_Boss_Func = v
end)

local AllBoss = {
    "The Gorilla King","Bobby","The Saw","Yeti","Mob Leader","Vice Admiral","Saber Expert",
    "Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God",
    "Cyborg","Ice Admiral","Greybeard","Diamond","Jeremy","Fajita","Don Swan","Smoke Admiral",
    "Awakened Ice Admiral","Tide Keeper","Darkbeard","Cursed Captain","Order","rip_indra",
    "Stone","Hydra Leader","Kilo Admiral","Captain Elephant","Beautiful Pirate","Cake Queen",
    "Longma","Soul Reaper","rip_indra True Form","Cursed Skeleton","Heaven's Guardian",
    "Hell's Messenger","Cake Prince","Dough King","Terrorshark","Leviathan","Deandre","Diablo","Urban"
}

task.spawn(function()
    while true do
        task.wait(0.5)
        if not Farm_All_Boss_Func then continue end
        pcall(function()
            for _, v in ipairs(Enemies:GetChildren()) do
                if table.find(AllBoss, v.Name) and IsAlive(v) and v:FindFirstChild("HumanoidRootPart") then
                    EquipTool(Selected_Weapon)
                    v.HumanoidRootPart.CanCollide = false
                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                    v.HumanoidRootPart.Transparency = 1
                    TweenTo(v.HumanoidRootPart.CFrame * Farm_Mode)
                    BringEnemies(v, true)
                end
            end
        end)
    end
end)

CreateSectionHeader(BountyPage, "PLAYER BOUNTY")

CreateToggle(BountyPage, "Player ESP",    "แสดง ESP ผู้เล่น",           false, function(v) Player_ESP_Func = v end)
CreateToggle(BountyPage, "Enable PvP",    "เปิดระบบ PvP อัตโนมัติ",     false, function(v) Enable_Pvp_Func = v end)

-- ============================================================
-- ================== TELEPORT PAGE ===========================
-- ============================================================
CreateSectionHeader(TeleportPage, "QUICK TELEPORT")

local function CreateTPButton(parent, islandName, targetPos)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1,0,0,36); btn.BackgroundColor3 = Theme.MainBG; btn.BorderSizePixel = 0; btn.Text = ""; btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    local bStroke = Instance.new("UIStroke", btn); bStroke.Color = Theme.Border; bStroke.Thickness = 1; bStroke.Transparency = 0.8

    local icon = Instance.new("TextLabel", btn)
    icon.Text = "📍"; icon.Size = UDim2.new(0,24,1,0); icon.Position = UDim2.new(0,6,0,0)
    icon.BackgroundTransparency = 1; icon.TextSize = 12; icon.ZIndex = 2

    local nameLbl = Instance.new("TextLabel", btn)
    nameLbl.Text = islandName; nameLbl.Size = UDim2.new(1,-100,1,0); nameLbl.Position = UDim2.new(0,30,0,0)
    nameLbl.BackgroundTransparency = 1; nameLbl.TextColor3 = Theme.Text; nameLbl.Font = Enum.Font.GothamBold; nameLbl.TextSize = 11; nameLbl.TextXAlignment = Enum.TextXAlignment.Left; nameLbl.ZIndex = 2

    local coordLbl = Instance.new("TextLabel", btn)
    coordLbl.Text = math.floor(targetPos.X)..", "..math.floor(targetPos.Y)..", "..math.floor(targetPos.Z)
    coordLbl.Size = UDim2.new(0,88,1,0); coordLbl.Position = UDim2.new(1,-92,0,0)
    coordLbl.BackgroundTransparency = 1; coordLbl.TextColor3 = Theme.SubText; coordLbl.Font = Enum.Font.Gotham; coordLbl.TextSize = 9; coordLbl.TextXAlignment = Enum.TextXAlignment.Right; coordLbl.ZIndex = 2

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn,TweenInfo.new(0.12),{BackgroundColor3=Theme.BtnHover}):Play()
        TweenService:Create(bStroke,TweenInfo.new(0.12),{Color=Theme.Accent, Transparency=0.4}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn,TweenInfo.new(0.12),{BackgroundColor3=Theme.MainBG}):Play()
        TweenService:Create(bStroke,TweenInfo.new(0.12),{Color=Theme.Border, Transparency=0.8}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        local char = Player.Character; if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        nameLbl.Text = "✈  Flying..."; nameLbl.TextColor3 = Theme.ToggleON
        task.spawn(function()
            local dist = (hrp.Position - targetPos).Magnitude
            local tw = TweenService:Create(hrp, TweenInfo.new(dist/300, Enum.EasingStyle.Linear), {CFrame=CFrame.new(targetPos)})
            tw:Play(); tw.Completed:Wait()
            nameLbl.Text = islandName; nameLbl.TextColor3 = Theme.Text
        end)
    end)
end

for _, island in ipairs(Islands) do
    CreateTPButton(TeleportPage, island.name, island.pos)
end

CreateSectionHeader(TeleportPage, "WORLD TRAVEL")

CreateButton(TeleportPage, "First World",  function() InvokeRemote("TravelMain") end)
CreateButton(TeleportPage, "Second World", function() InvokeRemote("TravelDressrosa") end)
CreateButton(TeleportPage, "Third World",  function() InvokeRemote("TravelZou") end)

-- ============================================================
-- ================== MISC PAGE ===============================
-- ============================================================
CreateSectionHeader(MiscPage, "FRUITS")

CreateToggle(MiscPage, "Fruit Notifications", "แจ้งเตือนเมื่อ Fruit Spawn",  true,  function(v) Fruit_Notifications_Func = v end)
CreateToggle(MiscPage, "Tween to Fruit",       "วาปไปเก็บ Fruit อัตโนมัติ", false, function(v) Tween_To_Fruit_Func = v end)
CreateToggle(MiscPage, "Auto Buy Random Fruit","ซื้อ Fruit สุ่มอัตโนมัติ",   false, function(v) Buy_Random_Fruit_Func = v end)
CreateToggle(MiscPage, "Auto Stored Fruit",    "เก็บ Fruit เข้า Storage",     false, function(v) Auto_Stored_Fruit_Func = v end)

task.spawn(function()
    while true do
        task.wait(3)
        if Fruit_Notifications_Func then
            pcall(function()
                for _, v in workspace:GetChildren() do
                    if (v:IsA("Tool") or v:IsA("Model")) and string.find(v.Name,"Fruit") then
                        if v:FindFirstChild("Handle") and Player.Character then
                            local dist = math.floor((Player.Character.HumanoidRootPart.Position - v.Handle.Position).Magnitude)
                            -- Notification via print (no external library)
                            print("[KYX HUB] Fruit Spawned: "..v.Name.." ("..dist.."m away)")
                        end
                    end
                end
            end)
        end
        if Buy_Random_Fruit_Func then
            pcall(function() InvokeRemote("Cousin","Buy") end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if Tween_To_Fruit_Func then
            pcall(function()
                local char = Player.Character; if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
                for _, v in workspace:GetChildren() do
                    if (v:IsA("Tool") or v:IsA("Model")) and string.find(v.Name,"Fruit") then
                        local handle = v:FindFirstChild("Handle")
                        if handle then
                            Stopped_Tween = false
                            TweenTo(CFrame.new(handle.Position))
                            break
                        end
                    end
                end
            end)
        end
    end
end)

CreateSectionHeader(MiscPage, "ESP")

CreateToggle(MiscPage, "Monster ESP", "แสดง ESP Mob",    false, function(v) Monster_ESP_Func = v end)
CreateToggle(MiscPage, "NPC ESP",     "แสดง ESP NPC",    false, function(v) NPC_ESP_Func = v end)
CreateToggle(MiscPage, "Fruit ESP",   "แสดง ESP Fruit",  true,  function(v) Fruit_ESP_Func = v end)
CreateToggle(MiscPage, "Chest ESP",   "แสดง ESP Chest",  false, function(v) Chest_ESP_Func = v end)

-- Simple ESP implementation
task.spawn(function()
    while true do
        task.wait(1)
        -- Monster ESP
        for _, v in ipairs(Enemies:GetChildren()) do
            local existing = v:FindFirstChild("_KYX_ESP")
            if Monster_ESP_Func and IsAlive(v) and v.PrimaryPart then
                if not existing then
                    local hl = Instance.new("BillboardGui")
                    hl.Name = "_KYX_ESP"; hl.Size = UDim2.new(0,80,0,20)
                    hl.AlwaysOnTop = true; hl.StudsOffset = Vector3.new(0,3,0)
                    hl.Adornee = v.PrimaryPart; hl.Parent = v
                    local lbl = Instance.new("TextLabel", hl)
                    lbl.Size = UDim2.new(1,0,1,0); lbl.BackgroundTransparency = 1
                    lbl.TextColor3 = Color3.fromRGB(255,80,80)
                    lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 11
                    lbl.Text = v.Name
                end
            elseif existing then
                existing:Destroy()
            end
        end
        -- Fruit ESP
        for _, v in workspace:GetChildren() do
            if (v:IsA("Tool") or v:IsA("Model")) and string.find(v.Name,"Fruit") then
                local handle = v:FindFirstChild("Handle")
                local existing = handle and handle:FindFirstChild("_KYX_FESP")
                if Fruit_ESP_Func and handle then
                    if not existing then
                        local bg = Instance.new("BillboardGui")
                        bg.Name = "_KYX_FESP"; bg.Size = UDim2.new(0,100,0,20)
                        bg.AlwaysOnTop = true; bg.StudsOffset = Vector3.new(0,3,0)
                        bg.Adornee = handle; bg.Parent = handle
                        local lbl = Instance.new("TextLabel", bg)
                        lbl.Size = UDim2.new(1,0,1,0); lbl.BackgroundTransparency = 1
                        lbl.TextColor3 = Color3.fromRGB(255,200,0)
                        lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 11; lbl.Text = v.Name
                    end
                elseif existing then
                    existing:Destroy()
                end
            end
        end
    end
end)

CreateSectionHeader(MiscPage, "MOVEMENT")

CreateToggle(MiscPage, "Infinite Energy",   "Energy ไม่หมด",         false, function(v) Infinite_Energy_Func = v end)
CreateToggle(MiscPage, "Remove Fog",        "ลบหมอกในเกม",           false, function(v) Remove_Fog_Func = v end)
CreateToggle(MiscPage, "Always Day",        "เวลากลางวันตลอด",       false, function(v) Always_Day_Func = v end)
CreateToggle(MiscPage, "Walk on Water",     "เดินบนน้ำได้",           false, function(v)
    Walk_ON_Water_Func = v
    if v then
        pcall(function()
            for _, part in ipairs(workspace.Map:GetDescendants()) do
                if part.Name == "Water" or part.Name == "Ocean" then
                    part.CanCollide = true
                end
            end
        end)
    end
end)

CreateButton(MiscPage, "Pirate Team",  function() InvokeRemote("SetTeam","Pirates") end)
CreateButton(MiscPage, "Marine Team",  function() InvokeRemote("SetTeam","Marines") end)
CreateButton(MiscPage, "Remove Lava",  function()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == "Lava" or (v:IsA("BasePart") and v.Material == Enum.Material.Neon and v.BrickColor == BrickColor.new("Bright red")) then
            pcall(function() v.CanCollide = false end)
        end
    end
end)
CreateButton(MiscPage, "Hop Server", function() HopServer() end)

-- ============================================================
-- ================== FPS COUNTER =============================
-- ============================================================
local FPSGui = Instance.new("ScreenGui")
FPSGui.Name = "__KYX_FPS"; FPSGui.ResetOnSpawn = false; FPSGui.Parent = CoreGui

local FPSLabel = Instance.new("TextLabel", FPSGui)
FPSLabel.Size = UDim2.new(0,85,0,26); FPSLabel.Position = UDim2.new(0,10,0,10)
FPSLabel.BackgroundColor3 = Color3.fromRGB(10,10,18); FPSLabel.BackgroundTransparency = 0.3
FPSLabel.TextColor3 = Color3.fromRGB(0,255,200); FPSLabel.TextSize = 13; FPSLabel.TextStrokeTransparency = 0.5
FPSLabel.Font = Enum.Font.GothamBold; FPSLabel.BorderSizePixel = 0; FPSLabel.Text = "  FPS  --"
Instance.new("UICorner", FPSLabel).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke", FPSLabel).Color = Color3.fromRGB(0,200,150)

task.spawn(function()
    while task.wait(0.5) do
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        FPSLabel.Text = "  FPS  "..fps
        FPSLabel.TextColor3 = fps >= 55 and Color3.fromRGB(0,255,200) or fps >= 30 and Color3.fromRGB(255,200,0) or Color3.fromRGB(255,80,80)
    end
end)

-- ============================================================
-- ================== WINDOW CONTROLS =========================
-- ============================================================
local function Shutdown()
    ScreenGui:Destroy(); FPSGui:Destroy()
    for _, c in pairs(GeminiUI.GUIConnections) do if c then c:Disconnect() end end
    print("[KYX HUB] Terminated & Cleaned up.")
end

CloseBtn.MouseButton1Click:Connect(Shutdown)

MinBtn.MouseButton1Click:Connect(function()
    GeminiUI.Minimized = not GeminiUI.Minimized
    local sz = GeminiUI.Minimized and GeminiUI.MinSize or GeminiUI.MainSize
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size=sz}):Play()
    MinBtn.Text = GeminiUI.Minimized and "+" or "−"
end)

-- Drag
local dragging, dragStart, startPos
table.insert(GeminiUI.GUIConnections, TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
    end
end))

table.insert(GeminiUI.GUIConnections, UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
    end
end))

table.insert(GeminiUI.GUIConnections, UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end))

table.insert(GeminiUI.GUIConnections, UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.Insert then
        GeminiUI.Visible = not GeminiUI.Visible
        if GeminiUI.Visible then
            MainFrame.Visible = true
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0,
                Size = GeminiUI.Minimized and GeminiUI.MinSize or GeminiUI.MainSize
            }):Play()
        else
            TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                BackgroundTransparency = 1
            }):Play()
            task.delay(0.22, function() MainFrame.Visible = false end)
        end
    end
end))

-- ============================================================
-- ================== OPEN ANIMATION ==========================
-- ============================================================
MainFrame.Size = UDim2.new(0,620,0,0)
MainFrame.BackgroundTransparency = 1
MainFrame.Visible = true

task.wait(0.1)

TweenService:Create(MainFrame, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = GeminiUI.MainSize,
    BackgroundTransparency = 0
}):Play()

task.delay(0.5, function()
    TweenService:Create(AccentLine, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 2, true), {BackgroundTransparency=0.7}):Play()
end)

task.delay(0.6, function()
    TweenService:Create(TitleDot, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 3, true), {BackgroundTransparency=0.5}):Play()
end)

print("[KYX HUB v3.0] Loaded ✓ | All-in-One | INSERT = Toggle | X = Close")
print("[KYX HUB] Tabs: Settings | Farm | Quest | Sub Farm | Sea Event | Island | Raid | Bounty | Teleport | Misc")
