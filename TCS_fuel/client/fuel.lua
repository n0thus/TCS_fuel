local vehObj = nil
local nearestStation = nil
local inSelection = false
Citizen.CreateThread(function()
  TriggerServerEvent("TCS_fuel:getPricesForStations")
  addBlips()

  local askedLiters = 0.0


  while true do
    Citizen.Wait(1)

    if(DoesEntityExist(GetVehiclePedIsIn(PlayerPedId())) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId()) then
      if(vehObj == nil) then
        local vehicle = GetVehiclePedIsIn(PlayerPedId())
        local vehiclePlate = GetVehicleNumberPlateText(vehicle)


        vehObj = manageVehicle()
        vehObj.init(vehicle)

        if(not vehObj.isBlacklisted()) then
          TriggerServerEvent("TCS_fuel:getFuelForVehicle", vehiclePlate)
        end

        vehObj.manage()
      end
    end


    if(vehObj ~= nil and not vehObj.isBlacklisted()) then

      if(nearestStation ~= nil) then
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
        local stationName = ""


        local stationCoords = {}
        local price = -1
        local rightPlace = false


        if(type(nearestStation) == "table") then
          local stationId, stationType, sName = nearestStation[1], nearestStation[2], nearestStation[3]

          if(vehObj.getType() == stationType) then
            stationCoords = stationsText[stationId]
            price = stationsPrices[stationId]
            stationName = sName
            rightPlace = true
          else
            showInfo(getText("not_in_the_right_place"))
          end
        else
          if(vehObj.getType() == 2) then
            stationCoords = stationsText[electricInfos[1]]
            stationName = stationsText[electricInfos[2]]
            rightPlace = true
          else
            showInfo(getText("not_in_the_right_place"))
          end
        end

        if(stationCoords.x ~= nil) then
          DrawText3D(stationCoords.x,stationCoords.y,stationCoords.z, stationName)

          if(price ~= -1) then
            DrawText3D(stationCoords.x,stationCoords.y,stationCoords.z-0.2, replaceString(getText("price_per_liters_draw"), {price}))
          end
        end

        if(rightPlace) then
          if(not inSelection) then
            if(IsInputDisabled(2)) then
              showInfo(getText("key_open_menu_keyboard"))
            else
              showInfo(getText("key_open_menu_controller"))
            end

            if(isKeyPressed(38, 224))then
              if(price ~= -1) then
                inSelection = true
                askedLiters = 0.0

                SendNUIMessage({
                  toggleFuelStation = true,
                  asked = askedLiters,
                  price = 0.0
                })
              else
                local toAdd = round(100.0-vehObj.getFuel(), 1)
                vehObj.refuel(toAdd)
              end
            end
          else


            if(IsInputDisabled(2)) then
              showInfo(getText("key_select_fuel_keyboard"))
            else
              showInfo(getText("key_select_fuel_controller"))
            end


            if(isKeyPressed(172, 232)) then
              askedLiters = askedLiters + 0.2

              if((vehObj.getFuel()+askedLiters) > 100.0) then
                askedLiters = 0.0
              end

              SendNUIMessage({
                setFuelStation = true,
                asked = askedLiters,
                price = round(askedLiters*price, 2)
              })

            end

            if(isKeyPressed(173, 232)) then
              askedLiters = askedLiters - 0.2

              if(askedLiters < 0.0) then
                askedLiters = round(100.0-vehObj.getFuel(), 1)
              end

              SendNUIMessage({
                setFuelStation = true,
                asked = askedLiters,
                price = round(askedLiters*price,2)
              })
            end



            if(isKeyPressed(201, 222)) then -- Accept
              TriggerServerEvent("TCS_fuel:buyFuel", round(askedLiters*price,2), askedLiters)
              inSelection = false
              SendNUIMessage({
                toggleFuelStation = false,
                asked = askedLiters,
                price = price
              })
            end

            if(isKeyPressed(202, 224)) then -- Cancel
              inSelection = false
              SendNUIMessage({
                toggleFuelStation = false,
                asked = askedLiters,
                price = price
              })
            end

          end
        end
      end
    end
  end

end)



Citizen.CreateThread(function()

  while true do
    Citizen.Wait(500)
    if(vehObj ~= nil) then
      local nearStation, stationInfos = isNearStation()
      local nearElectricStation, electricInfos = isNearElectricStation()

      if(nearStation) then
        nearestStation = stationInfos
      elseif(nearElectricStation) then
        nearestStation = electricInfos
      else
        if(nearestStation ~= nil) then
          nearestStation = nil
          if(inSelection) then
            SendNUIMessage({
              toggleFuelStation = false,
              asked = 0.0,
              price = 0.0
            })
            inSelection=false
          end
        end
      end
    else
      if(nearestStation ~= nil) then
        nearestStation = nil

        if(inSelection) then
          SendNUIMessage({
            toggleFuelStation = false,
            asked = 0.0,
            price = 0.0
          })
          inSelection=false
        end
      end
    end
  end

end)



RegisterNetEvent("TCS_fuel:setFuelForVehicle")
AddEventHandler("TCS_fuel:setFuelForVehicle", function(fuel)
  vehObj.setFuel(fuel)
  SendNUIMessage({
    toggleBar = true,
    fuel = fuel
  })
end)


RegisterNetEvent("TCS_fuel:buyFuel")
AddEventHandler("TCS_fuel:buyFuel", function(toAdd)
    vehObj.refuel(toAdd)
end)


RegisterNetEvent("TCS_fuel:playerQuitVehicle")
AddEventHandler("TCS_fuel:playerQuitVehicle", function()
  SendNUIMessage({
    toggleBar = true,
    fuel = 0
  })
  vehObj = nil
end)


RegisterNetEvent("TCS_fuel:setPricesForStations")
AddEventHandler("TCS_fuel:setPricesForStations", function(stationsArray)
  stationsPrices = stationsArray
end)
