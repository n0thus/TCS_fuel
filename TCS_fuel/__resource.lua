resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
  'config/config.lua',
  'config/strings.lua',

  'client/stations.lua',
  'client/vehicle.lua',
  'client/functions.lua',
  'client/fuel.lua',
}


server_scripts {
  'config/strings.lua',
  'config/config.lua',
  'client/stations.lua',
  'server/fuel.lua'
}


ui_page('client/ui/ui.html')

files({
  'client/ui/ui.html',
  'client/ui/style.css',
  'client/ui/gasStation.png',
  'client/ui/BebasNeue_Bold.otf'
})
