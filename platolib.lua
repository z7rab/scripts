local PlatoLib = {}

-- Function to initialize PlatoLib with configuration
function PlatoLib.init(config)
    config = config or {}

    -- Internal variables
    local fRequest = request or http.request or http_request or syn.request
    local fStringFormat = string.format
    local fSpawn = task.spawn
    local fWait = task.wait
    local localPlayerId = game:GetService("Players").LocalPlayer.UserId
    local rateLimit = false
    local rateLimitCountdown = 0
    local errorWait = false

    -- Function to generate Plato's link
    function PlatoLib.getLink()
        return fStringFormat("https://gateway.platoboost.com/a/%i?id=%i", config.accountId, localPlayerId)
    end

    -- Function to verify a key
    function PlatoLib.verify(key)
        -- Check for error conditions
        if errorWait or rateLimit then
            return false
        end

        print("Checking key...")

        -- Make API call to verify the key
        local status, result = pcall(function()
            return fRequest({
                Url = fStringFormat("https://api-gateway.platoboost.com/v1/public/whitelist/%i/%i?key=%s", config.accountId, localPlayerId, key),
                Method = "GET"
            })
        end)

        -- Handle response
        if status then
            if result.StatusCode == 200 then
                if string.find(result.Body, "true") then
                    print("Successfully whitelisted key!")
                    return true
                else
                    return false
                end
            elseif result.StatusCode == 204 then
                print("Account wasn't found, check accountId")
                return false
            elseif result.StatusCode == 429 then
                if not rateLimit then 
                    rateLimit = true
                    rateLimitCountdown = 10
                    fSpawn(function() 
                        while rateLimit do
                            print(("You are being rate-limited, please slow down. Try again in %i second(s)."):format(rateLimitCountdown))
                            fWait(1)
                            rateLimitCountdown = rateLimitCountdown - 1
                            if rateLimitCountdown < 0 then
                                rateLimit = false
                                rateLimitCountdown = 0
                                print("Rate limit is over, please try again.")
                            end
                        end
                    end)
                end
            else
                return config.allowPassThrough
            end    
        else
            return config.allowPassThrough
        end
    end

    return PlatoLib
end

return PlatoLib
