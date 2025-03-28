local screenshot = exports['screenshot-basic']
local screenshotRes = function(status, message, imageId, imageUrl)
    Print(status and 'info' or 'error', message)
    return { res = status or false, msg = message or '', imgId = imageId or '', imgUrl = imageUrl or '' }
end

function takeScreenshot(cb, forceService)
    local set = Config.MediaServiceToken[forceService or Config.MediaServices.Image]
    if not set then
        local res = screenshotRes(nil, 'Invalid Media Service.')
        if type(cb) == 'function' then cb(res) end
        return res
    end

    local newShot = promise.new()

    if Config.MediaServices.Image == 'imgbb' then
        if not set.Key or set.Key == '' or set.Key == 'YOUR_CLIENT_API_KEY' then
            local res = screenshotRes(nil, 'Media Service Token is not setted.')
            if type(cb) == 'function' then cb(res) end
            newShot:resolve(res)
        else
            set.Duration = set.Duration or 86400
            set.Duration = set.Duration > 15552000 and 15552000 or (set.Duration < 60 and 60 or set.Duration)
            screenshot:requestScreenshotUpload(('https://api.imgbb.com/1/upload?key=%s&expiration=%s'):format(set.Key, set.Duration), 'image', function(data)
                local resp = json.decode(data) or {}
                if resp.success then
                    local res = screenshotRes(true, 'Successfully captured the screen', resp.data.id, resp.data.image.url)
                    if type(cb) == 'function' then cb(res) end
                    newShot:resolve(res)
                else
                    local res = screenshotRes(nil, 'Failed to upload media (' .. json.encode(resp, {indent=true}) .. ').')
                    if type(cb) == 'function' then cb(res) end
                    newShot:resolve(res)
                end
            end)
        end
    elseif Config.MediaServices.Image == 'gkshop' then
        if not set['GKSHOP-Secret'] or set['GKSHOP-Secret'] == '' or set['GKSHOP-Secret'] == 'GKSHOP API Key' then
            local res = screenshotRes(nil, 'Media Service Token is not setted.')
            if type(cb) == 'function' then cb(res) end
            newShot:resolve(res)
        else
            screenshot:requestScreenshotUpload('https://servicemedia.gkshop.org/mediau', 'gks_image', { headers = { ['GKSHOP-Secret'] = set['GKSHOP-Secret'] } }, function(data)
                local resp = json.decode(data) or {}
                if resp.link then
                    Print('info', resp)
                    local res = screenshotRes(true, 'Successfully captured the screen', resp.id or '', resp.link)
                    if type(cb) == 'function' then cb(res) end
                    newShot:resolve(res)
                else
                    local res = screenshotRes(nil, 'Failed to upload media (' .. json.encode(resp, {indent=true}) .. ').')
                    if type(cb) == 'function' then cb(res) end
                    newShot:resolve(res)
                end
            end)
        end
    elseif Config.MediaServices.Image == 'discord' then
        if not set.Hook or set.Hook:sub(1, 33) ~= 'https://discord.com/api/webhooks/' then
            local res = screenshotRes(nil, 'Media Service Token is not setted.')
            if type(cb) == 'function' then cb(res) end
            newShot:resolve(res)
        else
            screenshot:requestScreenshotUpload(set.Hook, 'files[]', function(data)
                local resp = json.decode(data) or {}
                if resp.id then
                    local res = screenshotRes(true, 'Successfully captured the screen', resp.id, resp.attachments[1].proxy_url or resp.attachments[1].url)
                    if type(cb) == 'function' then cb(res) end
                    newShot:resolve(res)
                else
                    local res = screenshotRes(nil, 'Failed to upload media (' .. json.encode(resp, {indent=true}) .. ').')
                    if type(cb) == 'function' then cb(res) end
                    newShot:resolve(res)
                end
            end)
        end
    elseif Config.MediaServices.Image == 'fivemerr' then
        if not set.Authorization or set.Authorization == '' or set.Authorization == 'YOUR_API_KEY' then
            local res = screenshotRes(nil, 'Media Service Token is not setted.')
            if type(cb) == 'function' then cb(res) end
            newShot:resolve(res)
        else
            screenshot:requestScreenshotUpload('https://api.fivemerr.com/v1/media/images', 'file', { headers = { Authorization = set.Authorization }, encoding = 'png' }, function(data)
                local resp = json.decode(data) or {}
                if resp.url then
                    local res = screenshotRes(true, 'Successfully captured the screen', resp.id, resp.url)
                    if type(cb) == 'function' then cb(res) end
                    newShot:resolve(res)
                else
                    local res = screenshotRes(nil, 'Failed to upload media (' .. json.encode(resp, {indent=true}) .. ').')
                    if type(cb) == 'function' then cb(res) end
                    newShot:resolve(res)
                end
            end)
        end
    elseif Config.MediaServices.Image == 'fivemanage' then
        if not set.Authorization or set.Authorization == '' or set.Authorization == 'YOUR_API_TOKEN' then
            local res = screenshotRes(nil, 'Media Service Token is not setted.')
            if type(cb) == 'function' then cb(res) end
            newShot:resolve(res)
        else
            screenshot:requestScreenshotUpload('https://api.fivemanage.com/api/image', 'file', { headers = { Authorization = set.Authorization } }, function(data)
                local resp = json.decode(data) or {}
                if resp.id then
                    local res = screenshotRes(true, 'Successfully captured the screen', resp.id, resp.url)
                    if type(cb) == 'function' then cb(res) end
                    newShot:resolve(res)
                else
                    local res = screenshotRes(nil, 'Failed to upload media (' .. json.encode(resp, {indent=true}) .. ').')
                    if type(cb) == 'function' then cb(res) end
                    newShot:resolve(res)
                end
            end)
        end
    else
        local res = screenshotRes(nil, 'Media Service is undefined.')
        if type(cb) == 'function' then cb(res) end
        newShot:resolve(res)
    end

    return Citizen.Await(newShot)
end
exports('takeScreenshot', takeScreenshot)

function deleteScreenshot(id, mediaService)
    TriggerServerEvent('kyg_api:deleteMedia', mediaService or Config.MediaServices.Image, { id = id })
end
exports('deleteScreenshot', deleteScreenshot)