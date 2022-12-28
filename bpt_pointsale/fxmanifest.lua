fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'bitpredator'
description 'bpt_pointsale for fivem, compatible with esx'
version '0.0.3'

description 'bpt_pointsale'

client_scripts {
    "config.lua",
    "client.lua"
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "config.lua",
    "server.lua"
}