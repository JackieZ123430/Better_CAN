-- Protocol: Jackie_BMW_FSeries_Cluster
-- Author: Jackie
-- Version: 0.1.0
-- Description: BeamNG UDP protocol for BMW F-series instrument cluster over ESP32
-- https://github.com/JackieZ123430/Better_CAN

local M = {}

local gameTime = 0
local debugTimer = 0
local accum = 0
local interval = 0.02 -- 50Hz

local signalL_latched = 0
local signalR_latched = 0
local printedBreakGroups = {}

local damageState = {

  headlightFL = 0,
  headlightFR = 0,

  turnFL = 0,
  turnFR = 0,

  turnRL = 0,
  turnRR = 0,

  taillightOuterL = 0,
  taillightOuterR = 0,

  taillightInnerL = 0,
  taillightInnerR = 0
}


local function init()
end

local function reset()
  gameTime = 0
  debugTimer = 0
  accum = 0
  signalL_latched = 0
  signalR_latched = 0
  printedBreakGroups = {}

  -- damageState.headlightFL = 0
  -- damageState.headlightFR = 0

  -- damageState.turnFL = 0
  -- damageState.turnFR = 0
  -- damageState.turnRL = 0
  -- damageState.turnRR = 0

  -- damageState.taillightOuterL = 0
  -- damageState.taillightOuterR = 0
  -- damageState.taillightInnerL = 0
  -- damageState.taillightInnerR = 0
end

local function getAddress()
  return "192.168.50.59"
end

local function getPort()
  return 4444
end

local function getMaxUpdateRate()
  return 60
end

local function isTagDamaged(tagName, threshold)


  return false
end

local function dumpTagsForDeformedBeams()
end

local function dumpDamagedPartDamageData(threshold)
end

local function scanDeformGroupDamage()

end

local function scanDamage()
  damageState.headlightFL = 0
  damageState.headlightFR = 0
  damageState.turnFL = 0
  damageState.turnFR = 0
  damageState.turnRL = 0
  damageState.turnRR = 0
  damageState.taillightOuterL = 0
  damageState.taillightOuterR = 0
  damageState.taillightInnerL = 0
  damageState.taillightInnerR = 0
end
-- local function scanDamage()

--   for tag,_ in pairs(beamstate.tagBeamMap) do
--     log("I","TAG",tag)
--   end

--   log("I","SCAN","scanDamage called")
--   if not beamstate or not beamstate.tagBeamMap then
--     return
--   end

--   for tag,_ in pairs(beamstate.tagBeamMap) do

--     if isTagDamaged(tag) and not printedBreakGroups[tag] then
--       printedBreakGroups[tag] = true

--       log("I","BREAKGROUP", tag)

--       if tag:find("headlight") then
--         log("I","DAMAGE","前大灯损坏")

--       elseif tag:find("taillight") then
--         log("I","DAMAGE","尾灯损坏")

--       elseif tag:find("mirror") then
--         log("I","DAMAGE","后视镜损坏")

--       elseif tag:find("bumper") then
--         log("I","DAMAGE","保险杠损坏")

--       elseif tag:find("hood") then
--         log("I","DAMAGE","引擎盖损坏")

--       end
--     end
--   end
--   if isTagDamaged("headlight_L") and not printedBreakGroups["headlight_L"] then
--     printedBreakGroups["headlight_L"] = true
--     log("I","BREAKGROUP","headlight_L")
--     log("I","DAMAGE","左前大灯损坏")
--   end

--   if isTagDamaged("headlight_R_supportBeams") and not printedBreakGroups["headlight_R_supportBeams"] then
--     printedBreakGroups["headlight_R_supportBeams"] = true
--     log("I","BREAKGROUP","headlight_R_supportBeams")
--     log("I","DAMAGE","右前大灯损坏")
--   end

--   if isTagDamaged("taillight_a_L") and not printedBreakGroups["taillight_a_L"] then
--     printedBreakGroups["taillight_a_L"] = true
--     log("I","BREAKGROUP","taillight_a_L")
--     log("I","DAMAGE","左尾灯损坏")
--   end

--   if isTagDamaged("taillight_a_R") and not printedBreakGroups["taillight_a_R"] then
--     printedBreakGroups["taillight_a_R"] = true
--     log("I","BREAKGROUP","taillight_a_R")
--     log("I","DAMAGE","右尾灯损坏")
--   end

--   if isTagDamaged("mirror_L") and not printedBreakGroups["mirror_L"] then
--     printedBreakGroups["mirror_L"] = true
--     log("I","BREAKGROUP","mirror_L")
--     log("I","DAMAGE","左后视镜损坏")
--   end

--   if isTagDamaged("mirror_R") and not printedBreakGroups["mirror_R"] then
--     printedBreakGroups["mirror_R"] = true
--     log("I","BREAKGROUP","mirror_R")
--     log("I","DAMAGE","右后视镜损坏")
--   end

--   if isTagDamaged("bumper_F_supportBeams") and not printedBreakGroups["bumper_F_supportBeams"] then
--     printedBreakGroups["bumper_F_supportBeams"] = true
--     log("I","BREAKGROUP","bumper_F_supportBeams")
--     log("I","DAMAGE","前保险杠损坏")
--   end

--   if isTagDamaged("bumper_R_supportBeams") and not printedBreakGroups["bumper_R_supportBeams"] then
--     printedBreakGroups["bumper_R_supportBeams"] = true
--     log("I","BREAKGROUP","bumper_R_supportBeams")
--     log("I","DAMAGE","后保险杠损坏")
--   end

--   if isTagDamaged("hood_supportBeams") and not printedBreakGroups["hood_supportBeams"] then
--     printedBreakGroups["hood_supportBeams"] = true
--     log("I","BREAKGROUP","hood_supportBeams")
--     log("I","DAMAGE","引擎盖损坏")
--   end
local function onPhysicsStep(dt)
    accum = accum + dt
    scanDamage()
end

local function isPhysicsStepUsed()
  return true 
end

-- local function getStructDefinition()
--   return [[
--     unsigned       time;
--     float          speedKmh;
--     float          rpm;
--     char           gearLetter;   // P R N D S M
--     unsigned char  gearIndex;       // 0-8 only

--     unsigned char  ignition;
--     unsigned char  engineRunning;

--     unsigned char  doorFL;
--     unsigned char  doorFR;
--     unsigned char  doorRL;
--     unsigned char  doorRR;

--     unsigned char  parkingBrake;

--     unsigned char  absAvailable;
--     unsigned char  absActive;
--     unsigned char  escAvailable;
--     unsigned char  escActive;
--     unsigned char  tcsAvailable;
--     unsigned char  tcsActive;

--     unsigned char  abs;
--     unsigned char  isABSBrakeActive;
--     unsigned char  hasABS;
--     unsigned char  hasESC;
--     unsigned char  hasTCS;
--     unsigned char  esc;
--     unsigned char  tcs;
--     unsigned char  isTCBrakeActive;
--     unsigned char  isYCBrakeActive;

--     unsigned char  highBeam;
--     unsigned char  lowBeam;
--     unsigned char  fog;
--     unsigned char  signalL;
--     unsigned char  signalR;
--     unsigned char  hazard;
--     unsigned char  brakelights;
--     unsigned char  battery;
--     unsigned char  oil;
--     unsigned char  checkengine;
--     unsigned char  lowfuel;

--     unsigned char  cruiseControlActive;
--     float          cruiseControlTarget;

--     float          fuel;
--     float          waterTemp;
--     float          oilTemp;

--     unsigned char  tireDefFL;
--     unsigned char  tireDefFR;
--     unsigned char  tireDefRL;
--     unsigned char  tireDefRR;


--     unsigned char throttleInput;
--     unsigned char brakeInput;
--     unsigned char engineLoad;
--     unsigned char  driveMode;    
--     float          airspeedKmh;       // 空气速度

--     unsigned char  engineImpactDamage;
--     unsigned char  radiatorLeak;
--     unsigned char  oilpanLeak;
--     unsigned char  oilRadiatorLeak;
--     unsigned char  exhaustBroken;

--     unsigned char  mainEngineBroken;
--     unsigned char  gearboxBroken;
--     unsigned char  transfercaseBroken;
--     unsigned char  driveshaftBroken;
--     unsigned char  differentialRBroken;
--     unsigned char  spindleFLBroken;
--     unsigned char  spindleFRBroken;
--     unsigned char  spindleRLBroken;
--     unsigned char  spindleRRBroken;
--     unsigned char  wheelaxleRLBroken;
--     unsigned char  wheelaxleRRBroken;
--     unsigned char  torsionReactorRBroken;

--     float          brakeOverHeatFL;
--     float          brakeOverHeatFR;
--     float          brakeOverHeatRL;
--     float          brakeOverHeatRR;

--     unsigned char  engineDisabled;
--     unsigned char  engineLockedUp;
--     unsigned char  engineReducedTorque;
--     unsigned char  engineHydrolocked;
--     unsigned char  engineIsHydrolocking;
--     unsigned char  headGasketDamaged;
--     unsigned char  pistonRingsDamaged;
--     unsigned char  rodBearingsDamaged;
--     unsigned char  blockMelted;
--     unsigned char  cylinderWallsMelted;

--     unsigned char  coolantOverheating;
--     unsigned char  oilOverheating;
--     unsigned char  oilLevelCritical;
--     unsigned char  oilLevelTooHigh;
--     unsigned char  starvedOfOil;

--     unsigned char  overRevDanger;
--     unsigned char  mildOverrevDamage;
--     unsigned char  catastrophicOverrevDamage;
--     unsigned char  overTorqueDanger;
--     unsigned char  catastrophicOverTorqueDamage;

--     unsigned char headlightFL;
--     unsigned char headlightFR;

--     unsigned char turnFL;
--     unsigned char turnFR;

--     unsigned char turnRL;
--     unsigned char turnRR;

--     unsigned char taillightOuterL;
--     unsigned char taillightOuterR;

--     unsigned char taillightInnerL;
--     unsigned char taillightInnerR;
--   ]]
-- end

local function getStructDefinition()
  return [[
    unsigned       time;
    float          speedKmh;
    float          rpm;
    char           gearLetter;
    unsigned char  gearIndex;

    unsigned char  ignition;
    unsigned char  engineRunning;

    unsigned char  doorFL;
    unsigned char  doorFR;
    unsigned char  doorRL;
    unsigned char  doorRR;

    unsigned char  parkingBrake;

    unsigned char  absAvailable;
    unsigned char  absActive;
    unsigned char  escAvailable;
    unsigned char  escActive;
    unsigned char  tcsAvailable;
    unsigned char  tcsActive;

    unsigned char  abs;
    unsigned char  isABSBrakeActive;
    unsigned char  hasABS;
    unsigned char  hasESC;
    unsigned char  hasTCS;
    unsigned char  esc;
    unsigned char  tcs;
    unsigned char  isTCBrakeActive;
    unsigned char  isYCBrakeActive;

    unsigned char  highBeam;
    unsigned char  lowBeam;
    unsigned char  fog;
    unsigned char  signalL;
    unsigned char  signalR;
    unsigned char  hazard;
    unsigned char  brakelights;
    unsigned char  battery;
    unsigned char  oil;
    unsigned char  checkengine;
    unsigned char  lowfuel;

    unsigned char  cruiseControlActive;
    float          cruiseControlTarget;

    float          fuel;
    float          waterTemp;
    float          oilTemp;

    unsigned char  tireDefFL;
    unsigned char  tireDefFR;
    unsigned char  tireDefRL;
    unsigned char  tireDefRR;

    -- 这里开始，必须和旧 BeamNGGame 完全一致
    float          throttleInput;
    float          brakeInput;
    float          engineLoad;
    float          airspeedKmh;
  ]]
end

local function fillStruct(o, dtSim)
  scanDamage()

  -- if beamstate and beamstate.tagBeamMap then
  --   for tag,_ in pairs(beamstate.tagBeamMap) do
  --     log("I","TAG",tag)
  --   end
  -- end


  if not electrics or not electrics.values then
    o.speedKmh = 0
    o.rpm = 0
    return
  end
  local e = electrics.values

  -- time (ms)
  gameTime = gameTime + dtSim
  debugTimer = debugTimer + dtSim
  o.time = math.floor(gameTime * 1000)

  -- speed (km/h)
  o.speedKmh = (e.wheelspeed or 0) * 3.6

  -- rpm (filter tiny float garbage)
  local rpm = e.rpm or 0
  if rpm < 10 then rpm = 0 end
  o.rpm = rpm



    local gearStr = tostring(e.gear or "N")
    local gearIndex = tonumber(e.gearIndex or 0)

    o.gearIndex = gearIndex

    local firstChar = gearStr:sub(1,1)

    if firstChar == "P" then
        o.gearLetter = string.byte("P")

    elseif firstChar == "R" then
        o.gearLetter = string.byte("R")

    elseif firstChar == "N" then
        o.gearLetter = string.byte("N")

    elseif firstChar == "S" then
        o.gearLetter = string.byte("S")

    elseif firstChar == "M" then
        o.gearLetter = string.byte("M")

    else
        o.gearLetter = string.byte("D")
    end

  -- ignition / engine
  o.ignition = (e.ignitionLevel and e.ignitionLevel > 0) and 1 or 0
  o.engineRunning = (e.engineRunning == 1) and 1 or 0

  -- doors
  -- ===============================
  -- Door state (robust version)
  -- ===============================

  local function doorFromElectrics(key)
    local v = e[key]
    if v == nil then return nil end
    return (v ~= 0) and 1 or 0
  end

  local function doorFromCoupler(key)
    local v = e[key]
    if v == nil then return nil end
    return (v ~= 0) and 1 or 0
  end

  local function getDoor(flKey1, flKey2)
    local v = doorFromElectrics(flKey1)
    if v ~= nil then return v end

    v = doorFromCoupler(flKey2)
    if v ~= nil then return v end

    return 0
  end



o.doorFL = getDoor("doorFLCoupler_notAttached", "door_L_coupler_notAttached")
o.doorFR = getDoor("doorFRCoupler_notAttached", "door_R_coupler_notAttached")
o.doorRL = getDoor("doorRLCoupler_notAttached", "door_RL_coupler_notAttached")
o.doorRR = getDoor("doorRRCoupler_notAttached", "door_RR_coupler_notAttached")



  -- parking brake
  o.parkingBrake = (e.parkingbrake ~= 0) and 1 or 0

-- ===============================
-- BMW style ABS / DSC logic
-- ===============================

-- ===============================
-- SIMPLE DIRECT MAPPING
-- esc=1 tcs=1 abs=1 亮灯
-- 0 不亮
-- ===============================

local escVal = (e.esc and e.esc ~= 0) and 1 or 0
local tcsVal = (e.tcs and e.tcs ~= 0) and 1 or 0
local absVal = (e.abs and e.abs ~= 0) and 1 or 0

o.hasABS = 1
o.absAvailable = 1
o.absActive = absVal
o.abs = absVal
o.isABSBrakeActive = absVal

o.hasESC = 1
o.escAvailable = 1
o.escActive = escVal
o.esc = escVal

o.hasTCS = 1
o.tcsAvailable = 1
o.tcsActive = tcsVal
o.tcs = tcsVal

o.isTCBrakeActive = tcsVal
o.isYCBrakeActive = escVal


o.highBeam = (e.highbeam ~= 0) and 1 or 0
o.lowBeam = (e.lowbeam ~= 0) and 1 or 0
o.fog = (e.fog ~= 0) and 1 or 0
-- use driver input instead of blinking electrics
local sigL = e.signal_left_input or 0
local sigR = e.signal_right_input or 0

-- hazard overrides everything
if (e.hazard ~= 0) then
  signalL_latched = 1
  signalR_latched = 1
else
  -- latch left
  if sigL ~= 0 then
    signalL_latched = 1
  elseif sigL == 0 and sigR == 0 then
    signalL_latched = 0
  end

  -- latch right
  if sigR ~= 0 then
    signalR_latched = 1
  elseif sigL == 0 and sigR == 0 then
    signalR_latched = 0
  end
end

o.signalL = signalL_latched
o.signalR = signalR_latched
o.hazard = (e.hazard ~= 0) and 1 or 0
o.brakelights = (e.brakelights ~= 0) and 1 or 0
o.battery = (e.battery ~= 0) and 1 or 0
o.oil = (e.oil ~= 0) and 1 or 0
o.checkengine = (e.checkengine == true) and 1 or 0
o.lowfuel = (e.lowfuel == true) and 1 or 0

-- ===============================
-- Cruise control (safe read)
-- ===============================

if e.cruiseControlActive ~= nil then
  o.cruiseControlActive =
    (e.cruiseControlActive ~= 0) and 1 or 0
else
  o.cruiseControlActive = 0
end

if e.cruiseControlTarget ~= nil then
  o.cruiseControlTarget = e.cruiseControlTarget * 3.6
else
  o.cruiseControlTarget = 0
end

o.fuel = (e.fuel or 0) * 100.0
o.waterTemp = e.watertemp or 0
o.oilTemp = e.oiltemp or 0
o.throttleInput = (e.throttle or 0)
o.brakeInput = (e.brake or 0)
o.engineLoad = (e.engineLoad or 0)



-- 空气速度（高速巡航时更真实）
o.airspeedKmh = (e.airspeed or 0) * 3.6

-- ===============================
-- Drive mode detection
-- ===============================

-- local mode = ""



-- local dm = controller.getController("driveModes")

-- if dm and dm.getCurrentDriveModeKey then
--   local key = dm:getCurrentDriveModeKey()
--   if key then
--     mode = string.lower(tostring(key))
--   end
-- end

-- if mode == "comfort" then
--   o.driveMode = 1

-- elseif mode == "sport" or mode == "ttsport" or mode == "race" then
--   o.driveMode = 2

-- elseif mode == "sport+" or mode == "race+" or mode == "ttsport+" then
--   o.driveMode = 3

-- elseif mode == "off" then
--   o.driveMode = 4

-- elseif mode == "2WD" or mode == "2wd" then
--   o.driveMode = 5

-- elseif mode == "drift" then
--   o.driveMode = 6

-- else
--   o.driveMode = 0
-- end

-- print("BeamNG driveMode =", o.driveMode)

-- ===============================
-- Tire deflation state (robust)
-- ===============================

local wheelInfo = nil
if obj and obj.getWheelInfo then
  wheelInfo = obj:getWheelInfo()
end

local function defFromElectrics(key)
  local v = e[key]
  if v == nil then return nil end
  return (v ~= 0) and 1 or 0
end

local function defFromWheelInfo(idx)
  if not wheelInfo then return nil end

  -- BeamNG 有时 wheelInfo 是 0-based，有时是 1-based；两种都试
  local w = wheelInfo[idx] or wheelInfo[idx + 1]
  if not w then return nil end

  if w.isTireDeflated ~= nil then
    return (w.isTireDeflated and 1 or 0)
  end
  if w.tireDeflated ~= nil then
    return (w.tireDeflated and 1 or 0)
  end
  if w.damage and w.damage.isTireDeflated ~= nil then
    return (w.damage.isTireDeflated and 1 or 0)
  end

  return nil
end

local function defFromWheelRotator(idx)
  if not wheels or not wheels.wheelRotators then return nil end
  local r = wheels.wheelRotators[idx]
  if r and r.isTireDeflated ~= nil then
    return (r.isTireDeflated and 1 or 0)
  end
  return nil
end

local function getDef(idx, eKey)
  -- 1) electrics（最稳定）
  local v = defFromElectrics(eKey)
  if v ~= nil then return v end

  -- 2) wheelInfo
  v = defFromWheelInfo(idx)
  if v ~= nil then return v end

  -- 3) wheelRotators
  v = defFromWheelRotator(idx)
  if v ~= nil then return v end

  return 0
end

-- local function dmgBool(group, name)
--   if damageTracker and damageTracker.getDamage then
--     return damageTracker.getDamage(group, name) and 1 or 0
--   end
--   return 0
-- end

-- local function dmgNum(group, name)
--   if damageTracker and damageTracker.getDamage then
--     local v = damageTracker.getDamage(group, name)
--     if type(v) == "number" then
--       return v
--     end
--   end
--   return 0
-- end

-- -- 引擎循坏的
-- local engineImpactDamage =
--   damageTracker and damageTracker.getDamage and
--   damageTracker.getDamage("engine", "impactDamage") or false

-- -- log("I", "UI_MATCH_DEBUG",
-- --   string.format(
-- --     "engineImpactDamage=%s hazard=%s",
-- --     tostring(engineImpactDamage),
-- --     tostring(e.hazard)
-- --   )
-- -- )

-- local function dumpAllDamageTracker()
--   log("I", "DT_ALL", "dumpAllDamageTracker called")

--   if not damageTracker then
--     log("I", "DT_ALL", "damageTracker=nil")
--     return
--   end

--   if not damageTracker.getDebugData then
--     log("I", "DT_ALL", "damageTracker.getDebugData missing")
--     return
--   end

--   local dbg = damageTracker.getDebugData()
--   if not dbg then
--     log("I", "DT_ALL", "dbg=nil")
--     return
--   end

--   for group, names in pairs(dbg) do
--     if type(names) == "table" then
--       for name, value in pairs(names) do
--         log("I", "DT_ALL",
--           string.format("%s.%s=%s", tostring(group), tostring(name), tostring(value))
--         )
--       end
--     end
--   end
-- end

-- -- 常见 electrics 键名（不同车/版本可能不同）
o.tireDefFL = getDef(0, "tireDeflatedFL")  -- 如果没有就继续兜底
o.tireDefFR = getDef(1, "tireDeflatedFR")
o.tireDefRL = getDef(2, "tireDeflatedRL")
o.tireDefRR = getDef(3, "tireDeflatedRR")


-- -- ===============================
-- -- DamageTracker -> protocol fields
-- -- ===============================

-- o.engineImpactDamage = dmgBool("engine", "impactDamage")
-- o.radiatorLeak = dmgBool("engine", "radiatorLeak")
-- o.oilpanLeak = dmgBool("engine", "oilpanLeak")
-- o.oilRadiatorLeak = dmgBool("engine", "oilRadiatorLeak")
-- o.exhaustBroken = dmgBool("engine", "exhaustBroken")

-- o.mainEngineBroken = dmgBool("powertrain", "mainEngine")
-- o.gearboxBroken = dmgBool("powertrain", "gearbox")
-- o.transfercaseBroken = dmgBool("powertrain", "transfercase")
-- o.driveshaftBroken = dmgBool("powertrain", "driveshaft")
-- o.differentialRBroken = dmgBool("powertrain", "differential_R")
-- o.spindleFLBroken = dmgBool("powertrain", "spindleFL")
-- o.spindleFRBroken = dmgBool("powertrain", "spindleFR")
-- o.spindleRLBroken = dmgBool("powertrain", "spindleRL")
-- o.spindleRRBroken = dmgBool("powertrain", "spindleRR")
-- o.wheelaxleRLBroken = dmgBool("powertrain", "wheelaxleRL")
-- o.wheelaxleRRBroken = dmgBool("powertrain", "wheelaxleRR")
-- o.torsionReactorRBroken = dmgBool("powertrain", "torsionReactorR")

-- o.brakeOverHeatFL = dmgNum("wheels", "brakeOverHeatFL")
-- o.brakeOverHeatFR = dmgNum("wheels", "brakeOverHeatFR")
-- o.brakeOverHeatRL = dmgNum("wheels", "brakeOverHeatRL")
-- o.brakeOverHeatRR = dmgNum("wheels", "brakeOverHeatRR")

-- o.engineDisabled = dmgBool("engine", "engineDisabled")
-- o.engineLockedUp = dmgBool("engine", "engineLockedUp")
-- o.engineReducedTorque = dmgBool("engine", "engineReducedTorque")
-- o.engineHydrolocked = dmgBool("engine", "engineHydrolocked")
-- o.engineIsHydrolocking = dmgBool("engine", "engineIsHydrolocking")
-- o.headGasketDamaged = dmgBool("engine", "headGasketDamaged")
-- o.pistonRingsDamaged = dmgBool("engine", "pistonRingsDamaged")
-- o.rodBearingsDamaged = dmgBool("engine", "rodBearingsDamaged")
-- o.blockMelted = dmgBool("engine", "blockMelted")
-- o.cylinderWallsMelted = dmgBool("engine", "cylinderWallsMelted")

-- o.coolantOverheating = dmgBool("engine", "coolantOverheating")
-- o.oilOverheating = dmgBool("engine", "oilOverheating")
-- o.oilLevelCritical = dmgBool("engine", "oilLevelCritical")
-- o.oilLevelTooHigh = dmgBool("engine", "oilLevelTooHigh")
-- o.starvedOfOil = dmgBool("engine", "starvedOfOil")

-- o.overRevDanger = dmgBool("engine", "overRevDanger")
-- o.mildOverrevDamage = dmgBool("engine", "mildOverrevDamage")
-- o.catastrophicOverrevDamage = dmgBool("engine", "catastrophicOverrevDamage")
-- o.overTorqueDanger = dmgBool("engine", "overTorqueDanger")
-- o.catastrophicOverTorqueDamage = dmgBool("engine", "catastrophicOverTorqueDamage")

-- -- ===============================
-- -- Lighting damage state
-- -- ===============================

-- o.headlightFL = damageState.headlightFL
-- o.headlightFR = damageState.headlightFR

-- o.turnFL = damageState.turnFL
-- o.turnFR = damageState.turnFR

-- o.turnRL = damageState.turnRL
-- o.turnRR = damageState.turnRR

-- o.taillightOuterL = damageState.taillightOuterL
-- o.taillightOuterR = damageState.taillightOuterR

-- o.taillightInnerL = damageState.taillightInnerL
-- o.taillightInnerR = damageState.taillightInnerR

  if debugTimer >= 1 then   -- 每 5 秒打印一次
    debugTimer = 0
    dumpTagsForDeformedBeams()
    dumpDamagedPartDamageData(0.01)

    -- debug的 显示damagetrack所有的
    -- dumpAllDamageTracker()

    scanDamage()
    scanDeformGroupDamage()

    if not _G.__tpmsKeyDumped then
    _G.__tpmsKeyDumped = true
    log("I", "TPMS_KEYS",
      string.format(
        "keys: tireDeflatedFL=%s tireDeflatedFR=%s tireDeflatedRL=%s tireDeflatedRR=%s",
        tostring(e.tireDeflatedFL),
        tostring(e.tireDeflatedFR),
        tostring(e.tireDeflatedRL),
        tostring(e.tireDeflatedRR)
      )
    )
  end
    log("I", "BMW_CAN_DEBUG",
      string.format(
        "SPD=%.1f RPM=%.0f | FL=%d FR=%d RL=%d RR=%d",
        o.speedKmh or 0,
        o.rpm or 0,
        o.tireDefFL or 0,
        o.tireDefFR or 0,
        o.tireDefRL or 0,
        o.tireDefRR or 0
      )
    )
    -- log("I","LIGHT_PROTO_DEBUG",
    --   string.format(
    --     "HL_FL=%d HL_FR=%d | TL_L=%d TL_R=%d | TI_L=%d TI_R=%d",
    --     o.headlightFL,
    --     o.headlightFR,
    --     o.taillightOuterL,
    --     o.taillightOuterR,
    --     o.taillightInnerL,
    --     o.taillightInnerR
    --   )
    -- )
    -- log("I","DRIVE_MODE_DEBUG",
    --   string.format(
    --     "controllerMode=%s -> driveMode=%d",
    --     tostring(mode),
    --     o.driveMode
    --   )
    -- )
    log("I","ESC_MODE", tostring(e.escMode))
    log("I", "CRUISE_DEBUG",
      string.format(
        "CruiseActive=%d Target=%.1f",
        o.cruiseControlActive or 0,
        o.cruiseControlTarget or 0
      )
    )
    -- debug 用的！！
  --   log("I", "DBG", "beamstate = " .. tostring(beamstate))
  --   if beamstate then
  --     log("I", "DBG", "brokenBreakGroups = " .. tostring(beamstate.brokenBreakGroups))
  --     log("I", "DBG", "tagBeamMap = " .. tostring(beamstate.tagBeamMap))
  --     log("I", "DBG", "deformedBeams = " .. tostring(beamstate.deformedBeams))
  --     if beamstate.tagBeamMap then
  --       local count = 0
  --       for tag, ids in pairs(beamstate.tagBeamMap) do
  --         local s = ""
  --         if type(ids) == "table" then
  --           for i, id in ipairs(ids) do
  --             s = s .. tostring(id)
  --             if i < #ids then s = s .. "," end
  --             if i >= 10 then
  --               s = s .. "..."
  --               break
  --             end
  --           end
  --         end
  --         log("I", "TAGMAP_KEY", tostring(tag) .. " -> [" .. s .. "]")
  --         count = count + 1
  --         if count >= 200 then break end
  --       end
  --     end

  --     if beamstate.deformedBeams then
  --       local count = 0
  --       for k, v in pairs(beamstate.deformedBeams) do
  --         if v and v > 0 then
  --           log("I", "DEFORMED_HIT", tostring(k) .. "=" .. tostring(v))
  --           count = count + 1
  --           if count >= 30 then break end
  --         end
  --       end
  --     end
  --   end
  --   log("I", "FUEL_DEBUG", "raw fuel=" .. tostring(e.fuel))
  --   log("I", "DSC_DEBUG",
  --     string.format(
  --       "esc=%s tcs=%s abs=%s | escActive=%s tcsActive=%s absActive=%s",
  --       tostring(e.esc),
  --       tostring(e.tcs),
  --       tostring(e.abs),
  --       tostring(e.escActive),
  --       tostring(e.tcsActive),
  --       tostring(e.absActive)
  --     )
  --   )
  --   for k,v in pairs(e) do
  --     if string.find(k,"door") then
  --       log("I","DOOR_KEY",k .. "=" .. tostring(v))
  --     end
  --   end
  --   log("I", "GEAR_DEBUG",
  -- string.format(
  --   "e.gear=%s e.gearIndex=%s e.gearModeIndex=%s | SENT letter=%s index=%d",
  --   tostring(e.gear),
  --   tostring(e.gearIndex),
  --   tostring(e.gearModeIndex),
  --   tostring(string.char(o.gearLetter or 0)),
  --   o.gearIndex or 0
  --   )
  -- )
  end
end
M.init = init
M.reset = reset
M.getAddress = getAddress
M.getPort = getPort
M.getMaxUpdateRate = getMaxUpdateRate
M.getStructDefinition = getStructDefinition
M.fillStruct = fillStruct
M.isPhysicsStepUsed = isPhysicsStepUsed
M.onPhysicsStep = onPhysicsStep

local function onBeamBroke(id, energy)
  -- log("I","BEAM","beam broke id="..tostring(id))

  -- scanDamage()
  
end




M.onBeamBroke = onBeamBroke


return M

