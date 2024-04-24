fx_version 'cerulean'
game 'gta5'
Author 'AutLaaw'

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'config.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

ui_page 'web/index.html'

files {
    'web/*.html',
    'web/*.css',
    'web/*.js'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
