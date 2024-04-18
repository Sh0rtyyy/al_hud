fx_version 'cerulean'
game 'gta5'
lua54 'yes'
Author 'AutLaaw'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    '@qbx_core/modules/playerdata.lua',
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