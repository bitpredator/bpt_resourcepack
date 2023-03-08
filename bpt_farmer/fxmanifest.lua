fx_version 'adamant'
game 'gta5'
description 'bpt_farmer, introduces various collection points for the crafting system (not a job)'
author'bitpredator'
version'0.0.4'

shared_script '@es_extended/imports.lua'

client_script {
    '@es_extended/locale.lua',
    'client/main.lua',
    'client/animated.lua'
}

server_scripts {
    '@es_extended/locale.lua',
    'server/main.lua',
    '@oxmysql/lib/MySQL.lua'
}