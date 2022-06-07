/*##############################################################################*/
/*###############         Clapz (SC-Devlopment) discord.gg/scdev      ################*/
/*##############################################################################*/

local ConfigFBlock = {
    ["fblock"] = {
        location = {x = -13.92, y = -1452.05, z = 30.54},
        location2 = {x = -222.96, y = -2652.35, z = 6.0},
        diameter = (22 * 3.25),
        visabilitydistance = 1000.0,
        color = {r = 255, g = 0, b = 0, a = 150},
        restrictions = {
            showinfo = true,
        },
        customrestrictions = {
            enabled = true,
            loop = false,
            run = function(zone)
            end, 
            stop = function(zone)
            end, 
        },
    },
}
  local inside_zone = false
  local greenzones = ConfigFBlock
  local function ShowInfo(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, false)
  end
  local function ShowFBlockInfo()
      local x = 1.0175
      local y = 1.2
      local width = 1.0
      local height = 0.5
      local scale = 0.5
      local text = "~w~You are in the ~g~F-Block ~r~Redzone~w~ (It's Kill On Sight)"
      SetTextCentre(true)
      SetTextFont(6)
      SetTextProportional(0)
      SetTextScale(scale, scale)
      SetTextColour(255, 0, 0, 255)
      SetTextDropShadow(0, 0, 0, 0,255)
      SetTextEntry("STRING")
      AddTextComponentString(text)
      DrawText(x - width/2, y - height/2 + 0.005)
  end
  Citizen.CreateThread(function()
    while true do
      local playerPed = PlayerPedId()
      local plyCoords = GetEntityCoords(playerPed, false)
      for k, v in pairs(greenzones) do
        local location = vector3(v.location.x, v.location.y, v.location.z)
        if #(plyCoords - location) < (v.diameter) - (v.diameter / 150) then
          if (not inside_zone) then
            local temp_append = ""
            inside_zone = true
            if (v.customrestrictions.enabled and v.customrestrictions.loop == false) then
              ConfigFBlock[k].customrestrictions.run(v)
            end
          end
          if (v.restrictions.showinfo) then
              ShowFBlockInfo(k)
          end
          if (v.customrestrictions.enabled and v.customrestrictions.loop == true) then
            ConfigFBlock[k].customrestrictions.run(v)
          end
        elseif (inside_zone) then
          ShowInfo("~r~Pussy, you left the F-Block Redzone. Go Back and shit on some people")
          SetEntityCanBeDamaged(playerPed, true)
          SetEntityMaxSpeed(GetVehiclePedIsIn(playerPed, false), 99999.9)
          ConfigFBlock[k].customrestrictions.stop(v)
          inside_zone = false
        end
      end
      Citizen.Wait(4)
    end
  end)
  Citizen.CreateThread(function()
    while true do
      local playerPed = PlayerPedId()
      local plyCoords = GetEntityCoords(playerPed, false)
      for k, v in pairs(greenzones) do
        local location = vector3(v.location.x, v.location.y, v.location.z)
        if #(plyCoords - location) < (v.diameter) - (v.diameter / 150) then
          DrawMarker(28, v.location.x, v.location.y, v.location.z, 0, 0, 0, 0, 0, 0, v.diameter + 0.0, v.diameter + 0.0, v.diameter + 0.0, v.color.r, v.color.g, v.color.b, 150, 0, 0, 0, 0)
        elseif (#(plyCoords - location) < (v.diameter) - (v.diameter / 150) + v.visabilitydistance) then
          DrawMarker(28, v.location.x, v.location.y, v.location.z, 0, 0, 0, 0, 0, 0, v.diameter + 0.0, v.diameter + 0.0, v.diameter + 0.0, v.color.r, v.color.g, v.color.b, v.color.a, 0, 0, 0, 0)
        end
      end
      Citizen.Wait(4)
    end
  end)

  Citizen.CreateThread(function()
    while true do
      local playerPed = PlayerPedId()
      local plyCoords = GetEntityCoords(playerPed, false)
      for k, v in pairs(greenzones) do
        local location2 = vector3(v.location2.x, v.location2.y, v.location2.z)
        if #(plyCoords - location2) < (v.diameter) - (v.diameter / 150) then
          DrawMarker(28, v.location2.x, v.location2.y, v.location2.z, 0, 0, 0, 0, 0, 0, v.diameter + 0.0, v.diameter + 0.0, v.diameter + 0.0, v.color.r, v.color.g, v.color.b, 150, 0, 0, 0, 0)
        elseif (#(plyCoords - location2) < (v.diameter) - (v.diameter / 150) + v.visabilitydistance) then
          DrawMarker(28, v.location2.x, v.location2.y, v.location2.z, 0, 0, 0, 0, 0, 0, v.diameter + 0.0, v.diameter + 0.0, v.diameter + 0.0, v.color.r, v.color.g, v.color.b, v.color.a, 0, 0, 0, 0)
        end
      end
      Citizen.Wait(4)
    end
  end)
