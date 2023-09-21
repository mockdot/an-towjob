fx_version 'cerulean'
game 'gta5'

description 'an-TowJob'
version '1.0.0'

shared_scripts {
    'config.lua',
    '@qbx-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    '@ox_lib/init.lua',
    '@qbx-core/import.lua',
}

modules {
    'qbx-core:core',
    'qbx-core:playerdata',
    'qbx-core:utils',
}

client_scripts {
    'client/*.lua'
}
server_scripts {
    'server/*.lua'
}

lua54 'yes'
