RegisterNetEvent('kyg_api:deleteMedia', function(mediaService, mediaData)
    if not (mediaService and Config.MediaServiceToken[mediaService] and mediaData) then return end
    local set = Config.MediaServiceToken[mediaService] or {}

    if mediaService == 'imgbb' then
        Print('error', 'ImgBB does not support media deletion yet.')
    elseif mediaService == 'gkshop' then
        Print('error', 'GKShop does not support media deletion yet.')
    elseif mediaService == 'discord' then
        PerformHttpRequest(('%s/messages/%s'):format(set.Hook, mediaData.id), function(statusCode, body, headers, errorData)
            if statusCode == 204 then
                Print('info', 'Message ' .. mediaData.id .. ' on discord has been deleted.')
            else
                local json = json.decode(body) or {}
                Print('error', statusCode, ('%s:%s'):format(json.code or '0', json.message or 'UNKNOWN_ERROR'))
            end
        end, 'DELETE')
    elseif mediaService == 'fivemerr' then
        Print('error', 'Fivemerr does not support media deletion yet.')
    elseif mediaService == 'fivemanage' then
        PerformHttpRequest(('http://api.fivemanage.com/api/image/delete/%s?apiKey=%s'):format(mediaData.id, set.Authorization), function(statusCode, body, headers, errorData)
            if statusCode == 200 then
                Print('info', 'Media ' .. mediaData.id .. ' on FiveManage has been deleted.')
            else
                Print('error', statusCode, errorData)
            end
        end, 'DELETE')
    end
end)