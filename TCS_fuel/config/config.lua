--[[
	SELECT THE LANGUAGE
]]--
lang = "en"

--[[
	DO NOT MODIFIY
]]--
VERSION = "0.0.1"

--[[
	MINIMUM AND MAXIMUM FUEL LEVEL FOR RANDOM, IN PERCENT
]]--
minFuelRandom = 15.0
maxFuelRandom = 75.0


-- In cents
minPrices = 100
maxPrices = 200
roundedPrices = false


--[[
	THE SPEED OF THE REFUEL, IN PERCENT
]]--
refuelSpeed = 1 -- Per seconds



electric_model = {
	"VOLTIC",
	"SURGE",
	"DILETTANTE",
	"KHAMELION",
	"CADDY",
	"CADDY2",
	"AIRTUG"
}



consumptionPerKmForVehicle = 6.07/100.0
consumptionPerKmForBoat = 12.0/100.0
consumptionPerKmForElectric = 5.02/100.0
consumptionPerKmForHeli = 17.05/100.0
consumptionPerKmForPlane = 4.5/100.0



--[[
	IF SET TO TRUE, IT WILL WORK WITH THE SEXYSPEEDOMETER BUT THE CAR WILL HAVE EFFECTS WHEN IT HAS LOW FUEL.
]]--
useFuelNative = false
