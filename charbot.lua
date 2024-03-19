-- Thank you for checking out CharBot Basic, for help setting up your API key and more check out the docs :  https://temps.gitbook.io/charbot-basic/
_G.BotConfig = {
    ["General Settings"] = {
        -- // -- // -- // -- 
        ["Owner"] = "Omarninjaa",
        -- // -- // -- // -- 
        ["Approval Words"] = {
            "yes","yea","sure","yeah","true","y","ye","confirm","yuh","yur","mhm","I love f3mb0ys so much!" 
        },
        -- // -- // -- // -- 
        ["DisapprovalWords"] = {
            "no","nope","don't","false","pass","deny","n","naw","na" 
        },
        -- // -- // -- // -- 
        ["Greetings"] = {
            "Have a great day!","I hope you have a fantastic day!","Have an excellent day!","Have a lovely time!","Yo! What's up?","Heyyy, how have u been?","Nice to see you!","How's it going?","This message has been delivered to you by dead!, How are you on this fine day?","Pleased to meet you!","Nice to see you!","This greeting message is an easter-egg! Please go to Omarninjaa / dead and report this sighting ASAP to get your reward! first one reaches me wins!","Hello from a bot fully powered by AI!","Heya there! It looks like you have found an easter-egg! Report this to Omarninjaa / dead ASAP to get your reward! The first one who reaches me wins!"
        },
        -- // -- // -- // -- 
        ["AutoJumpWhenSitting"] = true, 
        -- // -- // -- // -- 
        ["Error-Logging"] = true, 
        -- // -- // -- // -- 
        ["Log-Commands"] = true,
        -- // -- // -- // -- 
        -- // -- // -- // -- 
        ["NativeCurrency"] = "USD", 
        ["CurrencySymbol"] = "$", 
        -- // -- // -- // -- 
        ["PlayerLockBrickVector"] = Vector3.new(-3,0,5), 
        -- // -- // -- // -- 
        ["OwnerHighlight"] = { 
            FillColor1 = Color3.new(0, 1, 0.933333),
            OutlineColor1 = Color3.new(0, 1, 0),
            FillTrans1 = 0.75,
            OutlineTrans = 0,
        },
        -- // -- // -- // -- 
    },
    -- // -- // -- // -- 
    ["Chat Settings"] = {
        ChatPublicly = true, 
        ChatLoadingOutputs = true, 
        ChatStartupGreeting = true, 
        ChatErrorLogs = true, 

    },
    -- // -- // -- // -- 
    ["API Keys"] = {
        APININJA_KEY = "BRkeNssjbHjGEJZj3f29Iw==Z3IGJBlHZUnISrYU",
        RBLX_TRADE_SESS = ""
    },
    -- // -- // -- // -- 
    -- // DEBUG SETTINGS \\ --
    ["PT-MS-Assets"] = {
        13704365741,13642077826,13277618561,13272083779,13272082846,13704365741,13642077826,13277618561,13272083779,13272082846
    },
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/frickwtcb/OQALCharBot/main/CharBotBasic"))()
