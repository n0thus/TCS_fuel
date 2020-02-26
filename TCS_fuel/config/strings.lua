local strings = {}


strings["en"] = {
	["key_open_menu_keyboard"] = "Press ~INPUT_CONTEXT~ to buy fuel.",
	["key_open_menu_controller"] = "Press ~INPUT_SCRIPT_RLEFT~ to buy fuel.",
	["key_select_fuel_keyboard"] = "Press ~INPUT_CELLPHONE_UP~ or ~INPUT_CELLPHONE_DOWN~ to select the amount of fuel.",
	["key_select_fuel_controller"] = "Press ~INPUT_SCRIPT_PAD_UP~ or ~INPUT_SCRIPT_PAD_DOWN to select the amount of fuel.",
	["not_in_the_right_place"] = "~r~You're not in the right place for this type of vehicles.",
	["not_enough_money"] = "~r~You do not have enough money for that",
	["fuel_station"] = "Fuel station (#VALUE#)",
	["station_name_draw"] = "~g~#VALUE# - Fuel Station (#VALUE#)",
	["vehicle"] = "Vehicle",
	["vehicle_fuel"] = "Petrol car",
	["vehicle_electric"] = "Electric car",
	["vehicle_boat"] = "Boat",
	["vehicle_plane"] = "Plane",
	["vehicle_heli"] = "Helicopter",
	["price_per_liters_draw"] = "~b~#VALUE# $/L",
	["new_version_available"] = "^8A new version of TCS_fuel is available (actual version : #VALUE#, new version : #VALUE#). Check it here : https://github.com/n0thus/TCS_fuel^7\n",
	["new_version_patchnote"] = "^2The patchnote of this new version is :\n#VALUE#^7",
	["cant_get_version"] = "The verification of the version of TCS_fuel is currently not available."
}

strings["zh_CN"] = {
	["key_open_menu_keyboard"] = "按下 ~INPUT_CONTEXT~ 来加油",
	["key_open_menu_controller"] = "按下 ~INPUT_SCRIPT_RLEFT~ 来加油",
	["key_select_fuel_keyboard"] = "按下 ~INPUT_CELLPHONE_UP~ 和 ~INPUT_CELLPHONE_DOWN~ 来选择要加多少油",
	["key_select_fuel_controller"] = "按下 ~INPUT_SCRIPT_PAD_UP~ 和 ~INPUT_SCRIPT_PAD_DOWN 来选择要加多少油",
	["not_in_the_right_place"] = "~r~你不在正确的位置上",
	["not_enough_money"] = "~r~你没有足够的金额",
	["fuel_station"] = "加油站 (#VALUE#)",
	["station_name_draw"] = "~g~#VALUE# - 加油站 (#VALUE#)",
	["vehicle"] = "车辆",
	["vehicle_fuel"] = "汽油车",
	["vehicle_electric"] = "电动汽车",
	["vehicle_boat"] = "船",
	["vehicle_plane"] = "飞机",
	["vehicle_heli"] = "直升机",
	["price_per_liters_draw"] = "~b~#VALUE# $/升",
	["new_version_available"] = "^8A new version of TCS_fuel is available (actual version : #VALUE#, new version : #VALUE#). Check it here : https://github.com/n0thus/TCS_fuel^7\n",
	["new_version_patchnote"] = "^2The patchnote of this new version is :\n#VALUE#^7",
	["cant_get_version"] = "The verification of the version of TCS_fuel is currently not available."
}

strings["zh_TW"] = {
	["key_open_menu_keyboard"] = "按下 ~INPUT_CONTEXT~ 來加油",
	["key_open_menu_controller"] = "按下 ~INPUT_SCRIPT_RLEFT~ 來加油",
	["key_select_fuel_keyboard"] = "按下 ~INPUT_CELLPHONE_UP~ 和 ~INPUT_CELLPHONE_DOWN~ 來選擇要加多少油",
	["key_select_fuel_controller"] = "按下 ~INPUT_SCRIPT_PAD_UP~ 和 ~INPUT_SCRIPT_PAD_DOWN 來選擇要加多少油",
	["not_in_the_right_place"] = "~r~你不在正確的位置上",
	["not_enough_money"] = "~r~你沒有足夠的金額",
	["fuel_station"] = "加油站 (#VALUE#)",
	["station_name_draw"] = "~g~#VALUE# - 加油站 (#VALUE#)",
	["vehicle"] = "車輛",
	["vehicle_fuel"] = "汽油車",
	["vehicle_electric"] = "電動汽車",
	["vehicle_boat"] = "船",
	["vehicle_plane"] = "飛機",
	["vehicle_heli"] = "直升機",
	["price_per_liters_draw"] = "~b~#VALUE# $/升",
	["new_version_available"] = "^8A new version of TCS_fuel is available (actual version : #VALUE#, new version : #VALUE#). Check it here : https://github.com/n0thus/TCS_fuel^7\n",
	["new_version_patchnote"] = "^2The patchnote of this new version is :\n#VALUE#^7",
	["cant_get_version"] = "The verification of the version of TCS_fuel is currently not available."
}

strings["fr"] = {
	["key_open_menu_keyboard"] = "Appuyez sur ~INPUT_CONTEXT~ pour acheter de l'essence.",
	["key_open_menu_controller"] = "Appuyez sur ~INPUT_SCRIPT_RLEFT~ pour acheter de l'essence.",
	["key_select_fuel_keyboard"] = "Appuyez sur ~INPUT_CELLPHONE_UP~ ou ~INPUT_CELLPHONE_DOWN~ pour choisir la quantité d'essence.",
	["key_select_fuel_controller"] = "Appuyez sur ~INPUT_SCRIPT_LEFT_AXIS_Y~ pour choisir la quantité d'essence.",
	["not_in_the_right_place"] = "~r~Vous n'êtes pas au bon endroit pour ce type de véhicules.",
	["not_enough_money"] = "~r~Vous n'avez pas assez d'argent pour cela.",
	["fuel_station"] = "Station essence (#VALUE#)",
	["station_name_draw"] = "~g~#VALUE# - #VALUE# (#VALUE#)",
	["vehicle"] = "Véhicule",
	["vehicle_fuel"] = "Voiture essence",
	["vehicle_electric"] = "Voiture électrique",
	["vehicle_boat"] = "Bateau",
	["vehicle_plane"] = "Avion",
	["vehicle_heli"] = "Hélicoptère",
	["price_per_liters_draw"] = "~b~#VALUE# €/L",
	["new_version_available"] = "^8Une nouvelle version de TCS_fuel est disponible (version actuelle : #VALUE#, nouvelle version : #VALUE#). Retrouvez la ici : https://github.com/n0thus/TCS_fuel^7\n",
	["new_version_patchnote"] = "^2Le patchnote de la nouvelle version est :\n#VALUE#^7",
	["cant_get_version"] = "La vérification de la version de TCS_fuel n'est pour l'instant pas disponible."
}




function getText(id)
	if(strings[lang] ~= nil) then
		if(strings[lang][id] ~= nil) then
			return strings[lang][id]
		else
			return "#INVALID : "..id
		end
	else
		return "#INVALID LANGUAGE#"
	end
end



function replaceString(str, args)
	for i=1,#args do
		str = string.gsub(str, "#VALUE#", args[i], 1)
	end

	return str
end
