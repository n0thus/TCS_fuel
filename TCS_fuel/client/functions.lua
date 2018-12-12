function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end



function showInfo(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, false, 1, 0)
end




function isNearStation()
  local stationId = -1
  local type = -1
  local name = ""
  local near = false
  local arrays = {{fuel_stations, 1}, {boat_stations,3}, {plane_stations, 4}, {heli_stations,5}}

  local cpt = 0
  while(cpt<#arrays and not near) do
    cpt = cpt+1
    for pId,coords in pairs(arrays[cpt][1]) do
      if(GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), coords.x, coords.y, coords.z, true) < 5.0) then
        stationId = coords.s

        type = arrays[cpt][2]

        local streetA, streetB = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        name = replaceString(getText("station_name_draw"), {GetStreetNameFromHashKey(streetA),GetStreetNameFromHashKey(streetB), getNameForType(type)})

        near = true
        break
      end
    end
  end
  return near, {stationId, type, name}
end


function isNearElectricStation()
  local stationId = -1
  local name = ""
  local near = false
  for pId,coords in pairs(electric_stations) do
    if(GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), coords.x, coords.y, coords.z, true) < 3.0) then
      pumpId = coords.s
      local streetA, streetB = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
      name = replaceString(getText("station_name_draw"), {GetStreetNameFromHashKey(streetA),GetStreetNameFromHashKey(streetB), getNameForType(2)})
      near = true
      break
    end
  end

  return near, {stationId, name}
end


function getNameForType(vType)
  if(vType == 1) then
    return getText("vehicle_fuel")
  elseif(vType == 2) then
    return getText("vehicle_electric")
  elseif(vType == 3) then
    return getText("vehicle_boat")
  elseif(vType == 4) then
    return getText("vehicle_plane")
  else
    return getText("vehicle_heli")
  end
end


function isKeyPressed(keyboard, controller)
  return ((IsInputDisabled(2) and IsControlJustPressed(1, keyboard)) or (not IsInputDisabled(2) and IsControlJustPressed(1, controller)))
end


function round(num, dec)
  local mult = 10^(dec or 0)
  return math.floor(num * mult + 0.5) / mult
end


function addBlips()
  for _,currBlip in pairs(blips) do
    local nBlip = AddBlipForCoord(currBlip.x,currBlip.y,currBlip.z)
    SetBlipSprite(nBlip, currBlip.id)
  	SetBlipAsShortRange(nBlip, true)
  	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(currBlip.name)
    EndTextCommandSetBlipName(nBlip)
  end
end
