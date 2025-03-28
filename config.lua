Config = {}

Config.Debug = true

Config.MediaServices = {
    Audio = 'discord', -- gkshop, discord, fivemerr, fivemanage (TODO)
    Image = 'gkshop', -- imgbb, gkshop, discord, fivemerr, fivemanage
    Video = 'discord', -- gkshop, discord, fivemerr, fivemanage (TODO)
}

Config.MediaServiceToken = {
    ['imgbb'] = { Key = 'YOUR_CLIENT_API_KEY', Duration = 600 --[[ in seconds 60 - 15552000 ]] },
    ['gkshop'] = { ['GKSHOP-Secret'] = 'GKSHOP API Key' },
    ['discord'] = { Hook = 'DISCORD_CHANNEL_WEBHOOK_URL' },
    ['fivemerr'] = { Authorization = 'YOUR_API_KEY' },
    ['fivemanage'] = { Authorization = 'YOUR_API_TOKEN' },
}

function Print(pType, ...)
    pType = Config.Debug and pType or 'debug'
    lib.print[pType](...)
end