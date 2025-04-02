fx_version 'cerulean'

game 'gta5'
name 'kyg_api'
lua54 'yes'
author 'ShennBoku'
version '1.0.0'
discord 'https://discord.gg/XGaNQZ8R2e'
description 'KYG API Connection'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

server_scripts {
    'server/*.lua',
}

client_scripts {
    'client/*.lua',
}

dependencies { 'ox_lib', 'screenshot-basic' }