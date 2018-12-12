local vehicles = {}

function init()
  local roundInt = 0

  if(not roundedPrices) then
    roundInt = 1
  end

  for i=1,#stationsText do
    stationsPrices[i] = round(math.random(minPrices, maxPrices)/100.0,roundInt)
  end
end


function checkVersion()
  PerformHttpRequest("https://raw.githubusercontent.com/n0thus/TCS_fuel/master/version.json", function(err, text, h)
    if err == 200 then
      local versionArray = json.decode(text)
      local gitVersion = versionArray.version

      if(VERSION ~= gitVersion) then
        print("\n=================================\n")
        local patchnoteArray = versionArray.patchnote
        local patchnote = ""
        for _, line in pairs(patchnoteArray) do
          patchnote = patchnote..line.."\n"
        end

        print(replaceString(getText("new_version_available"), {VERSION, gitVersion}))
        print(replaceString(getText("new_version_patchnote"), {patchnote}))
        print("\n=================================\n")
      end
    else
      print(getText("cant_get_version"))
    end
  end, "GET")
end



function round(num, dec)
  local mult = 10^(dec or 0)
  return math.floor(num * mult + 0.5) / mult
end



RegisterServerEvent("TCS_fuel:getFuelForVehicle")
RegisterServerEvent("TCS_fuel:setFuelForVehicle")
RegisterServerEvent("TCS_fuel:buyFuel")
RegisterServerEvent("TCS_fuel:getPricesForStations")

AddEventHandler("TCS_fuel:getFuelForVehicle", function(plate)
  local _source = source
  if(vehicles[plate] == nil) then
    vehicles[plate] = math.random(minFuelRandom, maxFuelRandom)
  end

  TriggerClientEvent("TCS_fuel:setFuelForVehicle", _source, vehicles[plate])
end)


AddEventHandler("TCS_fuel:setFuelForVehicle", function(plate, fuelLevel)
  vehicles[plate] = fuelLevel
end)



AddEventHandler("TCS_fuel:getPricesForStations", function()
  local _source = source
  TriggerClientEvent("TCS_fuel:setPricesForStations", _source, stationsPrices)
end)


AddEventHandler("TCS_fuel:buyFuel", function(price, amount)
  local _source = source

  TriggerEvent("core:getUser", _source, function(user)
    if(user ~= nil and user ~= false) then
      if(user.getMoney("money") >= price) then
        if(user.removeMoney("money", price, true)) then
          TriggerClientEvent("TCS_fuel:buyFuel", _source, amount)
        end
      elseif(user.getMoney("bank") >= price) then
        if(user.removeMoney("bank", price, true)) then
          TriggerClientEvent("TCS_fuel:buyFuel", _source, amount)
        end
      else
        TriggerClientEvent("showNotif", _source, getText("not_enough_money"))
      end
    end
  end)

end)


checkVersion()
init()
