fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'bitpredator'
description 'bpt_menu developed for fivem, compatible with esx'
version '0.0.2'

dependency 'es_extended'

shared_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}

client_scripts {
	"dependencies/RMenu.lua",

	"dependencies/components/*.lua",

	"dependencies/menu/RageUI.lua",
	"dependencies/menu/Menu.lua",
	"dependencies/menu/MenuController.lua",

	"dependencies/menu/elements/*.lua",
	"dependencies/menu/items/*.lua",

	'client/main.lua',
	'client/other.lua'
}

shared_script '@es_extended/imports.lua'
