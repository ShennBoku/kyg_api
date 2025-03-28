# 🦭 KYG API Connection

**KYG API connection** is a resource created to unify all api connection configurations and for easy invocation, you just need to set a key in this resource and just invoke this script on other scripts without having to enter the key in each resource.

## 🌴 Features

- Take a screenshot and upload it automatically to imgbb/gkshop/discord/fivemerr/fivemanage.

## 🦀 Screenshot Sample's (Client-side)

```lua
RegisterCommand('screenshot', function()
    local takeShot = exports.kyg_api:takeScreenshot()
    if takeShot.res then
        local alert = lib.alertDialog({
            header = 'Image ID: ' .. takeShot.imgId,
            content = '![Photo ID Image]('..takeShot.imgUrl..')\n\nDelete this photo?',
            centered = true,
            cancel = true
        })

        if alert == 'confirm' then
            exports.kyg_api:deleteScreenshot(takeShot.imgId)
        end
    else
        lib.notify({ description = takeShot.msg })
    end
end, false)
```

## 🏄🏻‍♀️ Dependencies

- Brain
- ox_lib (by [Overextended](https://github.com/overextended/ox_lib))
- screenshot-basic (by [Cfx.re](https://github.com/citizenfx/screenshot-basic))