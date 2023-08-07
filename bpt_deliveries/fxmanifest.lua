fx_version 'adamant'
game 'gta5'
description 'bpt_deliveries'
version '1.0'

client_scripts {
	'@es_extended/locale.lua',
	"locales/*.lua",
	"config.lua",
	"client/main.lua",
}

server_scripts {
	'@es_extended/locale.lua',
	"locales/*.lua",
	"config.lua",
	"server/main.lua",
}

dependency 'es_extended'