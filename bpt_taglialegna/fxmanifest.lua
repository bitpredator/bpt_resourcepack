fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'bitpredator'

version '0.0.4'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/main.lua',
}

dependencies {
	'es_extended'
}
