getgenv().doTrivia = true  -- on and off toggle / might not work if executed a second time

apiUrl = "https://the-trivia-api.com/api/questions?limit=1&difficulty=hard&tags=geography" -- if you want to make your own settings, go here (https://the-trivia-api.com/docs/) and paste the url / keep limit to 1 
getgenv().announceSkippingHastags = false -- if your booth has hashtags it will automatically skip - if you want to say in chat that is skipping, set this to true


getgenv().timeLeft = 0
getgenv().answered = false
getgenv().skipping = false
getgenv().scoreboard = {}
getgenv().round = 0




local events = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents")
local messageDoneFiltering = events:WaitForChild("OnMessageDoneFiltering")
local players = game:GetService("Players")


local Https = game:GetService('HttpService')
local hp = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or _senv.request or request or Https and Https.request

function getScore(player)
    for i,v in pairs(scoreboard) do
        if v[player] ~= nil then
            return v[player]
        end
    end
    return false
end

function addPoints(player, points)
    points = points or 3
    for i,v in pairs(scoreboard) do
        if v[player] ~= nil then
            v[player] = v[player] + 3
            return
        end
    end
    warn("player not found in scoreboard")
    return false
end

function getQuestion()
    content = hp(
        {
            Url = apiUrl,  
            Method = "GET"
        }
    )
    content = content.Body
    content = game:GetService("HttpService"):JSONDecode(content)
    return content
end

function setBooth(text, imageId)
    local args = {
        [1] = "Update",
        [2] = {
            ["DescriptionText"] = text,
            ["ImageId"] = imageId
        }
    }
    game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
end

function parseAnswers(table)
    answers = ""
    for _, answer in pairs(table) do
        if answers == "" then
            answers = answer
        else
            answers = answers .. "\n" .. answer
        end
    end
    return answers
end

function shuffle(array)
    math.randomseed(tick())
    local output = { }
    local random = math.random

    for index = 1, #array do
        local offset = index - 1
        local value = array[index]
        local randomIndex = offset*random()
        local flooredIndex = randomIndex - randomIndex%1

        if flooredIndex == offset then
            output[#output + 1] = value
        else
            output[#output + 1] = output[flooredIndex + 1]
            output[flooredIndex + 1] = value
        end
    end
    return output
    -- stole this from stack overflow, just used to shuffle all the answers
end

function getBooth()
    closestDistance = math.huge
    closestBooth = nil
    for _, booth in pairs(workspace:GetChildren()) do
        if booth.Name == "Booth" and booth:FindFirstChild("Banner") then
            distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - booth.Banner.Position).magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestBooth = booth
            end
        end
    end
    return closestBooth
end

getgenv().correctAnswer = "setting up"
getgenv().correctPlayer = nil
getgenv().correctPlayerScore = nil

messageDoneFiltering.OnClientEvent:Connect(function(message)
    local player = players:FindFirstChild(message.FromSpeaker)
    local message = message.Message or ""
    
    if player == game.Players.LocalPlayer and message == "pass" then
        skipping = true
        timeLeft = 0
    end
    
    if answered == false then
        if string.match(correctAnswer:lower(), message:lower()) then
            if string.len(string.match(correctAnswer:lower(), message:lower())) >= 4 then
                local playerScore = getScore(player.Name)
                
                answered = true
                correctPlayer = player.DisplayName
                
                if playerScore ~= false then
                    correctPlayerScore =  playerScore + 3
                    addPoints(player.Name)
                else
                    table.insert(scoreboard, {[player.Name] = 3})
                    correctPlayerScore = 3
                end
            end
        end
    end
end)


while wait() and doTrivia do


    if timeLeft <= 0 then
        
        if skipping == false then
            setBooth("The answer was " .. correctAnswer, 281338499)
            round = round + 1
            wait(3)
                        
        else
            skipping = false
        end
        
        timeLeft = 120
        
        query = getQuestion()[1]
        
        question = query["question"]
        correctAnswer = query["correctAnswer"]
        incorrectAnswers = query["incorrectAnswers"]
        
        allAnswers = incorrectAnswers
        table.insert(allAnswers, correctAnswer)
        allAnswers = shuffle(allAnswers)
    end
    
    if answered == true then
        setBooth(correctPlayer .. " answered correct and now has " .. correctPlayerScore .. " Vbucks", 6641087396)
        wait(3)
        answered = false
        timeLeft = 0
    end
    
    timeLeft = timeLeft - 1
    
    if timeLeft > 0 then
        combined = question .. " " .. "[" .. timeLeft .. "]".. "\n" .. parseAnswers(allAnswers)
        setBooth(combined, 10494071008)
    end
    
    
    
    wait(1)
    
    if string.match(getBooth().Banner.SurfaceGui.Frame.Description.Text, "#") then
        timeLeft = 0
        if announceSkippingHastags then
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Hashtags found - skipping", "All")
        end
        skipping = true
    end
    
    
end
