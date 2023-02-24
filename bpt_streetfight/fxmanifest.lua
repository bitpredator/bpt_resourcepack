fx_version 'adamant'

game 'gta5'

description 'bpt_streetfight'

version '0.0.4'

server_script {
    'server/server.lua',
    'config.lua'
}

client_script {
    'client/client.lua',
    'config.lua'
}

dependencies {
    'es_extended'
}