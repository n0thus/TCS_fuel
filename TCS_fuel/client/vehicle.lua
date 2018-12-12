function manageVehicle()

  local self = {}
  self.vehicle = -1
  self.plate = ""
  self.type = 0
  self.consumption = 0.0
  self.blacklisted = false
  self.fuel = 100.0



  self.isElectric = function(vehicle)
    local vehModel = GetEntityModel(vehicle)

    local cpt = 1
    while(cpt<=#electric_model and GetHashKey(electric_model[cpt])~=vehModel) do
      cpt = cpt+1
    end

    return (cpt<=#electric_model)
  end


  self.isBlacklisted = function()
    return self.blacklisted
  end

  self.getType = function()
    return self.type
  end


  self.getFuel = function()
    return round(self.fuel,2)
  end

  self.setFuel = function(newFuel)

    self.fuel = newFuel
    SendNUIMessage({
      setBar = true,
      fuel = round(self.fuel,2)
    })
  end

  self.addFuel = function(toAdd)
    self.fuel = self.fuel+toAdd

    if(self.fuel > 100.0) then
      self.fuel = 100.0
    end

    SendNUIMessage({
      setBar = true,
      fuel = round(self.fuel,2)
    })
  end

  self.init = function(vehicle)
    SetVehicleUndriveable(self.vehicle, false)
    SetVehicleEngineOn(self.vehicle, true, false, false)

    self.vehicle = vehicle
    self.plate = GetVehicleNumberPlateText(self.vehicle)
    local ped = PlayerPedId()

    if(IsPedInAnyHeli(ped)) then
      self.type = 5 -- Helicopters
      self.consumption = consumptionPerKmForHeli
    elseif(IsPedInAnyPlane(ped)) then
      self.type = 4 -- Planes
      self.consumption = consumptionPerKmForPlane
    elseif(IsPedInAnyBoat(ped)) then
      self.type = 3 -- Boats
      self.consumption = consumptionPerKmForBoat
    elseif(IsPedInAnyVehicle(ped, false) and (not IsPedOnAnyBike(ped) and not IsPedInAnyTrain(ped) and not IsPedInAnySub(ped))) then
      self.type = 1 -- Petrol Cars
      self.consumption = consumptionPerKmForVehicle

      if(self.isElectric(self.vehicle)) then
        self.type = 2 -- Electric Cars
        self.consumption = consumptionPerKmForElectric
      end
    else
      self.blacklisted = true
    end
  end


  self.manage = function()
    Citizen.CreateThread(function()

        while(IsPedInAnyVehicle(PlayerPedId()) and GetPedInVehicleSeat(self.vehicle, -1)) do
          Citizen.Wait(1000)

          if(not self.blacklisted) then
            local speed = GetEntitySpeed(self.vehicle)/100.0
            local toConsume = round(speed * self.consumption,4)
            self.fuel = self.fuel - toConsume



            if(self.fuel <= 0.0) then
              self.fuel = 0.0
              SetVehicleUndriveable(self.vehicle, true)
              SetVehicleEngineOn(self.vehicle, false, false, false)
            end

            if(useFuelNative) then
              SetVehicleFuelLevel(self.vehicle, self.fuel)
            end

            SendNUIMessage({
              setBar = true,
              fuel = round(self.fuel,2)
            })
          end
        end

        if(not self.blacklisted) then
          TriggerServerEvent("TCS_fuel:setFuelForVehicle", self.plate, self.fuel)
        end
        TriggerEvent("TCS_fuel:playerQuitVehicle")

    end)
  end



  self.refuel = function(toAdd)
    SetVehicleUndriveable(self.vehicle, true)
    local fuelBefore = self.fuel
    while(self.fuel < (fuelBefore+toAdd)) do
      Citizen.Wait(20)
      self.fuel = self.fuel + (refuelSpeed/1000)*20

      SendNUIMessage({
        setBar = true,
        fuel = round(self.fuel,2)
      })
    end
    self.fuel = fuelBefore + toAdd

    if(self.fuel > 100.0) then
      self.fuel = 100.0
    end
    SetVehicleUndriveable(self.vehicle, false)
  end

  return self
end
