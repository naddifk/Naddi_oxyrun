fx_version 'cerulean'
game 'gta5'

author 'Your Name'
description 'Oxy Run Script for QBCore'
version '1.0.0'

shared_scripts {
    'config.lua',
    'locales/en.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    'qb-core',
    'qb-target',
    'qb-menu',
    'qb-vehiclekeys'
}
