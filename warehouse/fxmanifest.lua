fx_version 'cerulean'
games {'gta5'}
author 'warfa'
lua54 'yes'

client_scripts {
    '@vrp/client/Tunnel.lua',
    '@vrp/client/Proxy.lua',
    'client.lua'
}

shared_scripts {
    'config.lua'
}

server_scripts {
    '@vrp/lib/utils.lua',
    'server.lua'
}