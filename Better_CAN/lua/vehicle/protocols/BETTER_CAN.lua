local M = {}

local gameTime = 0
local debugTimer = 0

local function init() end
local function reset() gameTime = 0 end

local function getAddress()
  return "192.168.31.61"
end

local function getPort()
  return 4444
end

local function getMaxUpdateRate()
  return 60
end

local function isPhysicsStepUsed()
  return false 
end

local function getStructDefinition()
  return [[
    unsigned       time;
    float          speedKmh;
    float          rpm;
    char           gearLetter[2];

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
  ]]
end

local function fillStruct(o, dtSim)
  if not electrics or not electrics.values then return end

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

  -- gear mapping
  local gearIndex = e.gearIndex or 0
  local gearStr = e.gear or "N"

  if type(gearIndex) == "number" and gearIndex >= 1 then
    o.gearLetter = "D"
  elseif gearStr == "R" then
    o.gearLetter = "R"
  elseif gearStr == "P" then
    o.gearLetter = "P"
  else
    o.gearLetter = "N"
  end

  -- ignition / engine
  o.ignition = (e.ignitionLevel and e.ignitionLevel > 0) and 1 or 0
  o.engineRunning = (e.engineRunning == 1) and 1 or 0

  -- doors
  o.doorFL = (e.door_L_coupler_notAttached and e.door_L_coupler_notAttached ~= 0) and 1 or 0
  o.doorFR = (e.door_R_coupler_notAttached and e.door_R_coupler_notAttached ~= 0) and 1 or 0
  o.doorRL = 0
  o.doorRR = 0

  -- parking brake
  o.parkingBrake = (e.parkingbrake ~= 0) and 1 or 0

  o.absAvailable = e.hasABS and 1 or 0
  o.absActive = (e.absActive ~= 0) and 1 or 0

  o.escAvailable = e.hasESC and 1 or 0
  o.escActive = (e.escActive ~= 0) and 1 or 0

  o.tcsAvailable = e.hasTCS and 1 or 0
  o.tcsActive = (e.tcsActive ~= 0) and 1 or 0

  o.abs = (e.abs ~= 0) and 1 or 0
  o.isABSBrakeActive = (e.isABSBrakeActive ~= 0) and 1 or 0
  o.hasABS = e.hasABS and 1 or 0

  o.hasESC = e.hasESC and 1 or 0
  o.hasTCS = e.hasTCS and 1 or 0
  o.esc = (e.esc ~= 0) and 1 or 0
  o.tcs = (e.tcs ~= 0) and 1 or 0
  o.isTCBrakeActive = (e.isTCBrakeActive ~= 0) and 1 or 0
  o.isYCBrakeActive = (e.isYCBrakeActive ~= 0) and 1 or 0

  o.highBeam = (e.highbeam ~= 0) and 1 or 0
  o.lowBeam = (e.lowbeam ~= 0) and 1 or 0
  o.fog = (e.fog ~= 0) and 1 or 0
  o.signalL = (e.signal_L ~= 0) and 1 or 0
  o.signalR = (e.signal_R ~= 0) and 1 or 0
  o.hazard = (e.hazard ~= 0) and 1 or 0
  o.brakelights = (e.brakelights ~= 0) and 1 or 0
  o.battery = (e.battery ~= 0) and 1 or 0
  o.oil = (e.oil ~= 0) and 1 or 0
  o.checkengine = (e.checkengine == true) and 1 or 0
  o.lowfuel = (e.lowfuel == true) and 1 or 0

  o.cruiseControlActive = (e.cruiseControlActive ~= 0) and 1 or 0
  o.cruiseControlTarget = e.cruiseControlTarget or 0

  o.fuel = e.fuel or 0
  o.waterTemp = e.watertemp or 0
  o.oilTemp = e.oiltemp or 0

  if debugTimer >= 5 then
    debugTimer = 0
    log("I", "BMW_CAN_DEBUG",
      string.format(
        "SEND -> time=%d speed=%.2f rpm=%.0f gear=%s fuel=%.2f temp=%.1f",
        o.time,
        o.speedKmh or 0,
        o.rpm or 0,
        o.gearLetter or "?",
        o.fuel or 0,
        o.waterTemp or 0
      )
    )
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

return M