local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/thunderisdead/bluefoxscript/main/background"))()
Window = Library.Main("Bluefox Script","RightShift")
_G.Rainbowwings = false
local Tab = Window.NewTab("Settings")
local Section = Tab.NewSection("Stuff")
_G.textboxes = {}
local isFocused = false
local function createTextBox()
    local textBox = Section.Newtextbox('Click to edit', function(self, value)      
        if value ~= "" then
            _G.textboxes[#_G.textboxes + 1] = value
        end
    end)   
    if not isFocused then
        textBox:SetFocus()
        isFocused = true
    end
    _G.textboxes[#_G.textboxes + 1] = ""
end
local EnabledToggle = Section.NewToggle("Click to add box", function(bool)
    if bool then
        createTextBox()
    else
      
        for _, textBox in ipairs(_G.textboxes) do
            textBox:ReleaseFocus()
        end
        isFocused = false
    end
end)
_G.move = {
    dmd = 15,
}
local timergb, RBW_COL = _G.move.dmd
local function updateRainbowColor()
    local hue = tick() % timergb / timergb
    if hue == 0 then
        -- Generate random RGB components when the hue is zero (black)
        RBW_COL = Color3.new(math.random(), math.random(), math.random())
    else
        RBW_COL = Color3.fromHSV(hue, 1, 1)
    end
end
local rgb1 = nil
local isRainbowEffectOn = false
local isManualColorSet = false
local currentSpeedSetting = "set" -- "set" or "random"
local targetSpeed = _G.move.dmd -- Store the target speed
local isBlackToWhiteMode = false
local currentBlackToWhiteModeColor = 0
local blackToWhiteStep = 0.01
local isCustomColorMode = false
local fromColor = Color3.new(1, 0, 0) -- Red color
local toColor = Color3.new(0, 1, 0) -- Green color
local customColorStep = 0
local customColorSpeed = 15
local function startRainbowEffect()
    if not isManualColorSet and not isRainbowEffectOn then
        rgb1 = game:GetService('RunService').Heartbeat:Connect(function()
            if isBlackToWhiteMode then
                currentBlackToWhiteModeColor = currentBlackToWhiteModeColor + blackToWhiteStep
                if currentBlackToWhiteModeColor >= 1 then
                    currentBlackToWhiteModeColor = 1
                    blackToWhiteStep = -blackToWhiteStep
                elseif currentBlackToWhiteModeColor <= 0 then
                    currentBlackToWhiteModeColor = 0
                    blackToWhiteStep = -blackToWhiteStep
                end
                RBW_COL = Color3.new(currentBlackToWhiteModeColor, currentBlackToWhiteModeColor, currentBlackToWhiteModeColor)
            elseif isCustomColorMode then
                customColorStep = customColorStep + (1 / customColorSpeed)
                if customColorStep >= 1 then
                    customColorStep = 0
                end
                local stepColor = Color3.new(
                    fromColor.r + (toColor.r - fromColor.r) * customColorStep,
                    fromColor.g + (toColor.g - fromColor.g) * customColorStep,
                    fromColor.b + (toColor.b - fromColor.b) * customColorStep
                )
                RBW_COL = stepColor
            else
                updateRainbowColor()
            end
        end)
        isRainbowEffectOn = true
    end
end
local function stopRainbowEffect()
    if isRainbowEffectOn then
        if rgb1 then
            rgb1:Disconnect()
            rgb1 = nil
        end
        isRainbowEffectOn = false
    end
end
local function smoothChangeSpeed(newSpeed)
    local currentSpeed = _G.move.dmd
    local timeToChange = 1.5 -- Transition time in seconds
    local steps = 60 -- Number of steps in the transition
    for i = 1, steps do
        local stepSpeed = currentSpeed + (newSpeed - currentSpeed) * (i / steps)
        _G.move.dmd = stepSpeed
        timergb = stepSpeed
        wait(timeToChange / steps)
    end
    _G.move.dmd = newSpeed
    timergb = newSpeed
end
local function smoothChangeColor(newRed, newGreen, newBlue)
    local currentColor = RBW_COL
    local timeToChange = 1.5 -- Transition time in seconds
    local steps = 60 -- Number of steps in the transition
    for i = 1, steps do
        local stepColor = Color3.new(
            currentColor.r + (newRed - currentColor.r) * (i / steps),
            currentColor.g + (newGreen - currentColor.g) * (i / steps),
            currentColor.b + (newBlue - currentColor.b) * (i / steps)
        )
        RBW_COL = stepColor
        wait(timeToChange / steps)
    end
    RBW_COL = Color3.new(newRed, newGreen, newBlue)
end
local speedChangeInterval = 5
local function randomizeRainbowSpeed()
    local seedGenerator = Random.new(tick())
    while true do
        if _G.randomSpeed and isRainbowEffectOn and currentSpeedSetting == "random" then
            local newSpeed = seedGenerator:NextInteger(1, 30)
            smoothChangeSpeed(newSpeed)
        end
        wait(speedChangeInterval) -- Wait for the specified interval before the next speed change
    end
end

Section.NewToggle("Rainbow Toggle", function(bool)
    _G.rainbow = bool
    if _G.rainbow then
        startRainbowEffect()
    else
        stopRainbowEffect()
    end
end)

local randomSpeedToggle = Section.NewToggle("Random Speed", function(bool)
    _G.randomSpeed = bool
    if bool then
        currentSpeedSetting = "random"
        stopRainbowEffect()
        startRainbowEffect()
    else
        currentSpeedSetting = "set"
        local newSpeed = tonumber(Section.GetText('Rainbow Speed'))
        if newSpeed then
            targetSpeed = newSpeed -- Update the target speed
            smoothChangeSpeed(targetSpeed) -- Use smooth change
            stopRainbowEffect()
            startRainbowEffect()
        end
    end
end)

Section.Newtextbox('Rainbow Speed', function(self, value)
    if tonumber(value) then
        local speed = tonumber(value)

        if not _G.randomSpeed then
            targetSpeed = speed -- Update the target speed
            smoothChangeSpeed(targetSpeed) -- Use smooth change
        end

        if _G.rainbow then
            stopRainbowEffect()
            startRainbowEffect()
        end
    end
end)

local redComponent = 255
local greenComponent = 0
local blueComponent = 0

local function setManualColor()
    if isManualColorSet then
        smoothChangeColor(redComponent / 255, greenComponent / 255, blueComponent / 255)
    end
end

local redTextbox = Section.Newtextbox('Red Component (0-255)', function(self, value)
    if tonumber(value) then
        redComponent = math.clamp(tonumber(value), 0, 255)
        if isManualColorSet then
            setManualColor()
        end
    end
end)

local greenTextbox = Section.Newtextbox('Green Component (0-255)', function(self, value)
    if tonumber(value) then
        greenComponent = math.clamp(tonumber(value), 0, 255)
        if isManualColorSet then
            setManualColor()
        end
    end
end)

local blueTextbox = Section.Newtextbox('Blue Component (0-255)', function(self, value)
    if tonumber(value) then
        blueComponent = math.clamp(tonumber(value), 0, 255)
        if isManualColorSet then
            setManualColor()
        end
    end
end)

local intervalTextbox = Section.Newtextbox('Speed Change Interval (seconds)', function(self, value)
    if tonumber(value) then
        speedChangeInterval = math.clamp(tonumber(value), 1, 50)
    end
end)

local customColorSpeedTextbox = Section.Newtextbox('Custom Color Speed (1-50)', function(self, value)
    if tonumber(value) then
        customColorSpeed = math.clamp(tonumber(value), 1, 50)
    end
end)

Section.NewToggle("Manual Color Setting", function(bool)
    isManualColorSet = bool
    if isManualColorSet then
        stopRainbowEffect()
        setManualColor()
    else
        startRainbowEffect()
    end
end)

Section.NewToggle("Black To White Mode", function(bool)
    if bool then
        isBlackToWhiteMode = true
        blackToWhiteStep = 0.01
        stopRainbowEffect()
        currentBlackToWhiteModeColor = 0
        RBW_COL = Color3.new(0, 0, 0)
        wait(0.5) -- Wait for a moment before starting the transition
        startRainbowEffect()
    else
        isBlackToWhiteMode = false
        startRainbowEffect()
    end
end)

local customColorToggle = Section.NewToggle("Custom Color Mode", function(bool)
    if bool then
        isCustomColorMode = true
        customColorStep = 0
        stopRainbowEffect()
        RBW_COL = fromColor
        wait(0.5) -- Wait for a moment before starting the transition
        startRainbowEffect()
    else
        isCustomColorMode = false
        startRainbowEffect()
    end
end)

local fromColorTextbox = Section.Newtextbox('From Color (R,G,B)', function(self, value)
    local components = {}
    for s in value:gmatch('%d+') do
        table.insert(components, tonumber(s))
    end

    if #components == 3 then
        fromColor = Color3.new(
            math.clamp(components[1] / 255, 0, 1),
            math.clamp(components[2] / 255, 0, 1),
            math.clamp(components[3] / 255, 0, 1)
        )
        if isCustomColorMode then
            stopRainbowEffect()
            RBW_COL = fromColor
            customColorStep = 0
            wait(0.5) -- Wait for a moment before starting the transition
            startRainbowEffect()
        end
    end
end)

local toColorTextbox = Section.Newtextbox('To Color (R,G,B)', function(self, value)
    local components = {}
    for s in value:gmatch('%d+') do
        table.insert(components, tonumber(s))
    end

    if #components == 3 then
        toColor = Color3.new(
            math.clamp(components[1] / 255, 0, 1),
            math.clamp(components[2] / 255, 0, 1),
            math.clamp(components[3] / 255, 0, 1)
        )
        if isCustomColorMode then
            stopRainbowEffect()
            customColorStep = 0
            wait(0.5) -- Wait for a moment before starting the transition
            startRainbowEffect()
        end
    end
end)

spawn(randomizeRainbowSpeed) -- Start the function in a separate thread to run concurrently


-- Function to send a message to the chat
local function sendChatMessageToChatBot(player, message)
    local prefix = "[Bot]"
    local fullMessage = prefix .. " " .. message

    -- Fire the SayMessageRequest event to send the message to the chat
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(fullMessage, "All")
end

-- Chatbot script
local Tab = Window.NewTab("Chatbot")
local Section = Tab.NewSection("Simple is only available atm")

local chatBotEnabled = false
local chatBotPrefix = "@"

Section.NewToggle("Chatbot", function(bool)
    chatBotEnabled = bool
end)

-- Table of intents and their corresponding responses
local chatResponses = {
    greetings = {
        "Hi, how are you?",
        "Hello!",
        "Hey there!",
        "Greetings!",
    },
    how_are_you = {
        "I'm doing well, thank you! How can I assist you?",
        "Feeling great! How can I help?",
        "I'm good, thanks for asking!",
    },
    name = {
        "My name is ThunderBot.",
        "I'm ThunderBot, nice to meet you!",
        "Call me ThunderBot!",
    },
    sad = {
        "I'm sorry to hear that. Is there anything I can do to make you feel better?",
        "I'm here for you. Let's talk and try to cheer you up!",
        "Remember, tough times don't last. Stay strong!",
    },
    happy = {
        "That's wonderful to hear! Keep spreading positivity!",
        "Great to know you're happy! Share the happiness with others too!",
        "Happiness is contagious! Keep smiling!",
    },
    bored = {
        "Boredom is an opportunity to try something new. What interests you?",
        "Let's find something fun to do together!",
        "Boredom is the mother of creativity. Let's explore new ideas!",
    },
    stressed = {
        "Take a deep breath and try to relax. Everything will be okay!",
        "Remember to take breaks and care for yourself.",
        "Stress is temporary. You've got this!",
    },
    lonely = {
        "Remember that you're not alone. There are people who care about you.",
        "Reach out to friends or family to connect.",
        "I'm here to keep you company!",
    },
    default = {
        "I'm not sure how to respond to that.",
        "Could you please clarify what you mean?",
        "I'm still learning, but I'm here to chat with you!",
    },
}

-- Function to handle chat messages from all players
local function onChatted(player, message)
    if chatBotEnabled then
        local lowercaseMessage = string.lower(message)
        if lowercaseMessage:sub(1, 1) == chatBotPrefix then
            local command = lowercaseMessage:sub(2)
            local response = nil

            -- Check for specific intents
            if string.find(command, "hello", 1, true) then
                response = chatResponses.greetings[math.random(1, #chatResponses.greetings)]
            elseif string.find(command, "how are you", 1, true) then
                response = chatResponses.how_are_you[math.random(1, #chatResponses.how_are_you)]
            elseif string.find(command, "name", 1, true) then
                response = chatResponses.name[math.random(1, #chatResponses.name)]
            elseif string.find(command, "sad", 1, true) then
                response = chatResponses.sad[math.random(1, #chatResponses.sad)]
            elseif string.find(command, "happy", 1, true) then
                response = chatResponses.happy[math.random(1, #chatResponses.happy)]
            elseif string.find(command, "bored", 1, true) then
                response = chatResponses.bored[math.random(1, #chatResponses.bored)]
            elseif string.find(command, "stress", 1, true) then
                response = chatResponses.stressed[math.random(1, #chatResponses.stressed)]
            elseif string.find(command, "lonely", 1, true) then
                response = chatResponses.lonely[math.random(1, #chatResponses.lonely)]
            end

            -- If the command does not match any intents, use the default response
            if not response then
                response = chatResponses.default[math.random(1, #chatResponses.default)]
            end

            sendChatMessageToChatBot(player, response)
        else
            -- Handle player's response to the chatbot
            if string.sub(lowercaseMessage, 1, #chatBotPrefix + 1) == chatBotPrefix .. " " then
                local playerResponse = string.sub(lowercaseMessage, #chatBotPrefix + 2)
                sendChatMessageToChatBot(player, "You said: \"" .. playerResponse .. "\"")
            end
        end
    end
end

-- Connect the onChatted function to the Chatted event for all players
for _, player in ipairs(game.Players:GetPlayers()) do
    player.Chatted:Connect(function(msg)
        onChatted(player, msg)
    end)
end

local Tab = Window.NewTab("Gamepasses")
local Section = Tab.NewSection("BE FREE")
local Button = Section.NewButton("Wings",function()
	local args = {[1] = "Wings",[2] = 0,[3] = "\230\139\154\230\136\172i\235\156\146(\238\138\155\201\172XD"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Ocean Skin",function()
	local args = {[1] = "Ocean",[2] = 0,[3] = "\230\139\154\230\136\172i\235\156\146(\238\138\155\201\172XD"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Dragon skin",function()
	local args = {[1] = "Dragon",[2] = 0,[3] = "\230\139\154\230\136\172i\235\156\146(\238\138\155\201\172XD"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Remove Wings",function()
	local args = {[1] = "Wings",[2] = 1,[3] = "\230\139\154\230\136\172i\235\156\146(\238\138\155\201\172XD"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Remove Ocean skin",function()
	local args = {[1] = "Ocean",[2] = 1,[3] = "\230\139\154\230\136\172i\235\156\146(\238\138\155\201\172XD"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Remove Dragon skin",function()
	local args = {[1] = "Dragon",[2] = 1,[3] = "\230\139\154\230\136\172i\235\156\146(\238\138\155\201\172XD"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Tab = Window.NewTab("VIW")
local Section = Tab.NewSection("Wana Be VIW")
local Button = Section.NewButton("VIW TAG",function()
	game.ReplicatedStorage.MasterKey:FireServer("AddVIWTag", nil, "\230\139\154\230\136\172i\235\156\146(\238\138\155\201\172XD")
end)
local Button = Section.NewButton("Remove Name tags",function()
	local args = {[1] = "ChangeDesc",[2] = "",[3] = "\226\128\153b%5m\226\128\176}0\195\1383t\195\154\226\149\147\195\146\226\148\140\226\128\166\226\151\153"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
	local args = {[1] = "ChangeName",[2] = "",[3] = "\226\128\153b%5m\226\128\176}0\195\1383t\195\154\226\149\147\195\146\226\148\140\226\128\166\226\151\153"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
game.Players.LocalPlayer.Character.Head.NameTag.Main.Pack:remove()
	game.Players.LocalPlayer.Character.Head.NameTag.Main.VIW:remove()
end)
local Button = Section.NewButton("Audio Player",function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/Syr0nix/Syr0nix-Audio-Player/main/Audio%20Player'))();
end)
_G.autoaudiomute = false
local EnabledToggle = Section.NewToggle("Mute VIW Music",function(bool)
	if _G.autoaudiomute then
		_G.autoaudiomute = false
		return
	else
		_G.autoaudiomute = true
	end
	while _G.autoaudiomute do
		task.wait()
		for _,v in next, game:GetService('Players'):GetPlayers()do
			if v.Character and v.Character.Parent ~= nil and v.Character:FindFirstChild('HumanoidRootPart') and v.Character:FindFirstChild('HumanoidRootPart'):FindFirstChild('RadioM') then
				v.Character:FindFirstChild('HumanoidRootPart'):FindFirstChild('RadioM'):Stop()
				v.Character:FindFirstChild('HumanoidRootPart'):FindFirstChild('RadioM').Playing = false
			end
		end
	end
end)
_G.cocktuning = {
	dmod = 1, -- mode 1-4
	desc = 'Example Title', -- auto description text
	wait = .2, -- text type speed
	wait2 = .8, -- time wait after done typing for other mods
	wait3 = .4 -- time wait after done typing for mode 3
	}
local text_ = Section.Newtextbox('Description Text',function(self,value)
	_G.cocktuning.desc = value
end)
local mode_ = Section.Newtextbox('Description Mode',function(self,value)
	if tonumber(value) ~= nil then
		_G.cocktuning.dmod = tonumber(value)
	end
end)
_G.PROVODASUKAB = false
local cfg = {key = "\226\128\153b%5m\226\128\176}0\195\1383t\195\154\226\149\147\195\146\226\148\140\226\128\166\226\151".."\153",eventname = "ChangeDesc",mk = game:GetService('ReplicatedStorage'):FindFirstChild('MasterKey')}
local Button = Section.NewToggle("Auto Description",function()
	if _G.PROVODASUKAB then
		_G.PROVODASUKAB = false
		return
	else
		_G.PROVODASUKAB = true
	end
	while _G.PROVODASUKAB do
		if _G.cocktuning.dmod==1 then
			for i = 1,#_G.cocktuning.desc do
				if not _G.PROVODASUKAB or _G.cocktuning.dmod~=1 then continue;end
				task.wait(_G.cocktuning.wait)
				local args = {[1] = cfg.eventname,[2] = string.sub(_G.cocktuning.desc,1,i)..'|',[3] = cfg.key}
				cfg.mk:FireServer(unpack(args))
			end;task.wait(_G.cocktuning.wait2)
		elseif _G.cocktuning.dmod==2 then
			for i = 1,#_G.cocktuning.desc do
				if not _G.PROVODASUKAB or _G.cocktuning.dmod~=2 then continue;end
				task.wait(_G.cocktuning.wait)
				local args = {[1] = cfg.eventname,[2] = string.sub(_G.cocktuning.desc,1,#_G.cocktuning.desc-i)..'|',[3] = cfg.key}
				cfg.mk:FireServer(unpack(args))
			end;task.wait(_G.cocktuning.wait2)
		elseif _G.cocktuning.dmod==3 then
			for i = 1,#_G.cocktuning.desc do
				if not _G.PROVODASUKAB or _G.cocktuning.dmod~=3 then continue;end
				task.wait(_G.cocktuning.wait)
				local fakea = _G.cocktuning.desc;fakea=string.sub(_G.cocktuning.desc,math.random(1,#fakea),math.random(1,#fakea)-i)..'|'
				local args = {[1] = cfg.eventname,[2] = fakea,[3] = cfg.key}
				cfg.mk:FireServer(unpack(args))
			end;task.wait(_G.cocktuning.wait3)
		elseif _G.cocktuning.dmod==4 then
			for i = 1,#_G.cocktuning.desc do
				if not _G.PROVODASUKAB or _G.cocktuning.dmod~=4 then continue;end
				task.wait(_G.cocktuning.wait)
				local args = {[1] = cfg.eventname,[2] = '|'..string.sub(_G.cocktuning.desc,#_G.cocktuning.desc-i,#_G.cocktuning.desc),[3] = cfg.key}
				cfg.mk:FireServer(unpack(args))
			end
		end;task.wait(_G.cocktuning.wait2)
	end
end)
local Tab = Window.NewTab("Admin")
local Section = Tab.NewSection("Wana Be Admin")
local Button = Section.NewButton("Crash Server",function()
    loadstring(game:HttpGet("https://pastebin.com/raw/c4vRHDfj"))()
end)
local Button = Section.NewButton("fates admin",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))()
end)
local Button = Section.NewButton("Inf Yeld",function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)
local Button = Section.NewButton("Strong Admin",function()
_G.CustomUI = false
loadstring(game:HttpGet(('https://raw.githubusercontent.com/BloodyBurns/Hex/main/Iv%20Admin%20v3.lua'),true))()
end)
local Button = Section.NewButton("Chat Logger",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Syr0nix/Chatlogger/main/e'))()
end)
local Button = Section.NewButton("Teleport all",function()
	for i,v in pairs(game.Players:GetChildren()) do
		game:GetService("ReplicatedStorage").CarryNewborn:FireServer(v)
		wait(0.2)
		local G_1 = "Spawn"
		local G_2 = "Adoption"
		game:GetService("ReplicatedStorage").MasterKey:FireServer(G_1, G_2)
		wait(0.2)
		local G_1 = "Kick Eggs"
		game:GetService("ReplicatedStorage").CarryNewborn:FireServer(G_1)
		wait(0.2)
	end
end)
local Button = Section.NewButton("INF CASH",function()
	local args = {[1] = "Coins",[2] = math.huge,[3] = "\226\135\154\225\155\157i\220\176\219\173\230\155\157u"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Anti Fling",function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/Syr0nix/Anti-Fling/main/Anti%20Fling'))();
end)
local Button = Section.NewButton("Anti pick up",function()
	game.Players.LocalPlayer.Character.Request:Destroy();
end)
_G.AntiAFK = false
local EnabledToggle = Section.NewToggle("Anti AFK",function(bool)
	if _G.AntiAFK then
		_G.AntiAFK = false
		print("Anti AFK Is Disabled")
		return
	else
		_G.AntiAFK = true
	end
	print("Anti AFK Is Enable")
	local vu = game:GetService("VirtualUser")
	game:GetService("Players").LocalPlayer.Idled:connect(function()
		vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		wait(1)
		vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end)
end)
local Tab = Window.NewTab("Local OC")
local Section = Tab.NewSection("Be Creative")
function playerCheck(p)
	if type(p)=='boolean'or p == nil then return false end
	if game:GetService('Players'):FindFirstChild(p)then
		return game:GetService('Players'):FindFirstChild(p)
	end
end
local function findPlayer(name)
	for _,p in next,game:GetService('Players'):GetPlayers()do
		local pn = string.lower(p.Name)
		local pd = string.lower(p.DisplayName)
		if (string.sub(name,1,#name)==string.sub(pn,1,#name) or string.sub(name,1,#name)==string.sub(pd,1,#name)) then
			return p
		end
	end
	return false
end
local NAME,USER = '',nil
local plr = Section.Newtextbox('Player Name',function(self,value)
	local find = findPlayer(value)
	if find then
		NAME,USER = find.Name,find
		self.Text = find.Name
	else
		self.Text = 'User not found'
	end
end)
local copyWolfVars = {HairF = {["Long"] = '1.1634',["Spiky"] = '0.53845',["Swiped Back"] = '0.71497',["Punk"] = '0.57207',["Lonely Woof"] = '1.0990',["Ewooftional"] = '1.0871',["Braided"] = '1.3539',["Scene"] = '0.94984',["Curly"] = '1.1623',["Long straight"] = '1.1057',["Bed Head"] = '1.2428',["Emo-Punk"] = '0.74069',["Spiky Punk"] = '0.54955',["Short Spiky"] = '1.4760',["Long Spiky"] = '1.4688',["Sidecut"] = '1.2984',["Long Sidecut"] = '0.74951',["Extreme-Edge"] = '1.1373'},TorsoF = {["Swords"] = '2.3725',["Cape"] = '1.6089',["Guitar"] = '1.7366',["Medic"] = '0.2127',["Flower"] = '1.1194',["Rope"] = '1.2306',["RippedShirt"] = '1.1532',["Bags"] = '1.2729',["SwordSet1"] = '0.21984',["SwordSet2"] = '3.3593',["Sword1"] = '0.24967',["Sword2"] = '0.080584',["Chains"] = '1.2260',["Leaves"] = '1.473',["Backpack"] = '1.2158',["Scars"] = '0.73279'},FeetF = {["Slider Bracelets"] = '0.49548',["Cross Bracelets"] = '0.48346',["Winter Boots"] = '0.56080',["Leaves"] = '0.6',["Double Bracelets"] = '0.36447'},fluffs = {'ChestFluff','BackFluff','EarFluff','JawFluff','TailFluff','LegFluff','Fat','ChubbyCheeks'}}
local VARS = {
	_fKEY = "\226\128\153b%5m\226\128\176}0\195\1383t\195\154\226\149\147\195\146\226\148\140\226\128\166\226\151".."\153",
	_tKEY = "\230\139\154\230\136\172i\235\156\146(\238\138\155\201\172XD",}
Section.NewButton('Copy Wolf',function()
	local _acesory = game:GetService('ReplicatedStorage').Accessories
	local _maKEY = game:GetService('ReplicatedStorage').MasterKey
	local _maKEY2 = game:GetService('ReplicatedStorage').MasterKey2
	local plr = playerCheck(NAME)
	if plr then
		coroutine.resume(coroutine.create(function()
			local char = plr.Character or false
			local spchar = game:GetService('Players').LocalPlayer.Character or false
			local head = char and char:FindFirstChild('Head') or false
			local sphead = spchar and spchar:FindFirstChild('Head') or false
			local nmt = head and head:FindFirstChild('NameTag') or false
			local spnmt = sphead and sphead:FindFirstChild('NameTag') or false
			local mnt = nmt and nmt:FindFirstChild('Main') or false
			local spmnt = spnmt and spnmt:FindFirstChild('Main') or false
			if spchar and sphead and char and head then
				local function arg(a,b,v)
					if a==1 then
						return unpack{[1] = "customize",[2] = {[1] = v.Name},[3] = v.Color,[4] = "Body"}
					elseif a==2 then
						return unpack{[1] = v,[2] = b,[3] = VARS._tKEY}
					elseif a==3 then
						return unpack{[1] = "Material",[2] = v.Material,[3] = {[1] = v.Name}}
					end
				end
				_acesory:FireServer("remove",'HairF')
				_acesory:FireServer("remove",'TorsoF')
				_acesory:FireServer("remove",'FeetF')task.wait()
				_maKEY2:FireServer("LeavePack")
				if(mnt and mnt:FindFirstChild('Pack') and mnt:FindFirstChild('Pack').Text~='No Pack')then
					task.delay(.4,function()
						local args = {
							[1] = "CreatePack",
							[2] = mnt:FindFirstChild('Pack')and mnt:FindFirstChild('Pack').Text..''or false
						}
						if(mnt:FindFirstChild('Pack')and mnt:FindFirstChild('Pack').Text:sub(1,8)=='[ALPHA] ')then
							args[2] = args[2]:sub(8,#args[2])..''
						end
						_maKEY2:FireServer(unpack(args))
					end)
				end
				if(mnt and mnt:FindFirstChild('Username'))then
					_maKEY:FireServer("ChangeName", mnt:FindFirstChild('Username')and mnt:FindFirstChild('Username').Text or false, VARS._fKEY)
				end
				if(mnt and mnt:FindFirstChild('Description'))then
					_maKEY:FireServer("ChangeDesc", mnt:FindFirstChild('Description')and mnt:FindFirstChild('Description').Text or false, VARS._fKEY)
				end
				if not mnt then task.wait(.1)
					_maKEY:FireServer("ChangeName", string.rep('HERE\nBYTE\n',200), VARS._fKEY)
					_maKEY:FireServer("ChangeDesc", string.rep('HERE\nBYTE\n',200), VARS._fKEY)
					_maKEY2:FireServer("CreatePack", string.rep('e\n\n',15))
				end
				if char:FindFirstChild("RightWing3") and char:FindFirstChild("RightWing3").Transparency == 0 then
					_maKEY:FireServer(arg(2,0,'Wings'))
				else _maKEY:FireServer(arg(2,1,'Wings'))end
				if char:FindFirstChild("OceanPrimary") and char:FindFirstChild("OceanPrimary").Transparency == 0 then
					_maKEY:FireServer(arg(2,0,'Ocean'))
				else _maKEY:FireServer(arg(2,1,'Ocean'))end
				if char:FindFirstChild("DragonThird") and char:FindFirstChild("DragonThird").Transparency == 0 then
					_maKEY:FireServer(arg(2,0,'Dragon'))
				else _maKEY:FireServer(arg(2,1,'Dragon'))end
				if char:FindFirstChild('HairF')then
					for c,v in next,char:FindFirstChild('HairF'):children()do
						if v:IsA('BasePart')then
							for b,a in next,copyWolfVars.HairF do
								if tostring(v.Size.X):sub(1,#a) == a then
									_acesory:FireServer('HairF',b)task.wait(.1)
									_maKEY:FireServer("Accessories",v.Color)
									_maKEY:FireServer("AccessoryMaterial",v.Material,"HairF")break
								end
							end
						end
					end
				end
				if char:FindFirstChild('TorsoF')then
					for c,v in next,char:FindFirstChild('TorsoF'):children()do
						if v:IsA('BasePart')or v.Name:find('Color1')then
							for b,a in next,copyWolfVars.TorsoF do
								if tostring(v.Size.X):sub(1,#a) == a then
									task.wait(.25)
									_acesory:FireServer('TorsoF',b)task.wait(.1)
									_maKEY:FireServer("Accessories",v.Color)
									_maKEY:FireServer("AccessoryMaterial",v.Material,"TorsoF")break
								end
							end
						end
					end
				end
				if char:FindFirstChild('FeetF')then
					for c,v in next,char:FindFirstChild('FeetF'):children()do
						if v:IsA('BasePart')or v.Name:find('Hat')then
							for b,a in next,copyWolfVars.FeetF do
								if tostring(v.Size.X):sub(1,#a) == a then
									task.wait(.25)
									_acesory:FireServer('FeetF',b)task.wait(.1)
									_maKEY:FireServer("Accessories",v.Color)
									_maKEY:FireServer("AccessoryMaterial",v.Material,"FeetF")break
								end
							end
						end
					end
				end
				for _,f in next, char:children()do
					if table.find(copyWolfVars.fluffs,f.Name)then
						if f:IsA('BasePart')then
							if f.Transparency==0 then
								_maKEY:FireServer("Fluff", f.Name, 0)
							else _maKEY:FireServer("Fluff", f.Name, 1)end
						end
					end
				end
				for _,v in next, char:GetChildren()do
					if v:IsA('BasePart')then
						_maKEY:FireServer("customize", {[1] = v.Name}, v.Color, "Body")
						_maKEY:FireServer("Material", v.Material, {[1] = v.Name})
					end
				end
			end
		end))
	end
end)
local enableSeats = Section.NewButton('Enable Sit',function()
    if USER then
        for i,v in pairs(USER.Character:GetChildren()) do
            if v:IsA('Seat') then
                v.Disabled = false
            end
        end
    end
end)
local Button = Section.NewButton("Female",function()
	local args = {[1] = "Female"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Male",function()
	local args = {[1] = "Male"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("File 1",function()
	local args = {[1] = "LoadFile1Colours",[2] = "1",[3] = "\195\137,\203\1561\194\181\195\154+t\226\149\165\195\1304\194\180\195\134\195\138\226\134\168\226\149\147"}
	game:GetService("ReplicatedStorage").Save:InvokeServer(unpack(args))
end)
local Button = Section.NewButton("File 2",function()
	local args = {[1] = "LoadFile1Colours",[2] = "2",[3] = "\195\137,\203\1561\194\181\195\154+t\226\149\165\195\1304\194\180\195\134\195\138\226\134\168\226\149\147"}
	game:GetService("ReplicatedStorage").Save:InvokeServer(unpack(args))
end)
local Button = Section.NewButton("File 3",function()
	local args = {[1] = "LoadFile1Colours",[2] = "3",[3] = "\195\137,\203\1561\194\181\195\154+t\226\149\165\195\1304\194\180\195\134\195\138\226\134\168\226\149\147"}
	game:GetService("ReplicatedStorage").Save:InvokeServer(unpack(args))
end)
local Button = Section.NewButton("Save 1",function()
	local args = {[1] = "SaveFile1Colours",[2] = "1",[3] = "\195\137,\203\1561\194\181\195\154+t\226\149\165\195\1304\194\180\195\134\195\138\226\134\168\226\149\147"}
	game:GetService("ReplicatedStorage").Save:InvokeServer(unpack(args))
end)
local Button = Section.NewButton("Save 2",function()
	local args = {[1] = "SaveFile1Colours",[2] = "2",[3] = "\195\137,\203\1561\194\181\195\154+t\226\149\165\195\1304\194\180\195\134\195\138\226\134\168\226\149\147"}
	game:GetService("ReplicatedStorage").Save:InvokeServer(unpack(args))
end)
local Button = Section.NewButton("Save 3",function()
	local args = {[1] = "SaveFile1Colours",[2] = "3",[3] = "\195\137,\203\1561\194\181\195\154+t\226\149\165\195\1304\194\180\195\134\195\138\226\134\168\226\149\147"}
	game:GetService("ReplicatedStorage").Save:InvokeServer(unpack(args))
end)
local Button = Section.NewButton("Explorer",function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/Syr0nix/DEX-Synapse-Edition/main/DEX'))();
end)
local Tab = Window.NewTab("rainbow")
local ToggleSection = Tab.NewSection("Toggle")
local PartSection = Tab.NewSection("Parts")
local partsToRainbow = {
    "LeftArm", "LeftShoulder", "Pads", "LeftArmPaw", "LeftLowerArm", "RightArm", "RightFootPaw", "LeftLeg", "LeftThigh",
    "LeftFootPaw", "Tail3", "Tail1", "Eyebrow1", "Eyebrow2", "Tail2", "Nose", "LeftEar", "Head", "InsideEars", "RightEar",
    "RightThigh", "Hip", "Muzzle", "Tail5", "RightShoulder", "Torso", "EyeLid", "Jaw", "RightArmPaw", "RightLeg",
    "LeftLowerLeg", "RightLowerLeg", "LeftWingStart", "RightWing3", "LeftWing3", "RightWingStart", "LeftWing2",
    "RightWing2", "RightLowerArm", "Secondary", "BackFluff", "ChestFluff", "EarFluff", "JawFluff", "LegFluff", "TailFluff",
    "Fat", "Claws", "EyeColor", "Pupils", "Gum", "lash", "Toungue1", "Toungue2", "Tooth", "Neck", "White", "JawWeldPart",
    "Back", "UpperTooth", "DragonThird", "DragonClaws", "DragonSecondary", "OceanPrimary", "OceanSecondary", "DragonPrimary"
}
local partToggles = {} -- Store toggles for each part
local originalColors = {} -- Store original colors for each part
local isNeon = {} -- Store whether each part is neon or not

local function getOriginalColor(part)
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild(part) then
        local partInstance = character[part]
        if partInstance:IsA("BasePart") then
            return partInstance.Color
        end
    end
    return Color3.new(1, 1, 1) -- Default white color
end
local function makePartNeon(part)
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild(part) then
        local partInstance = character[part]
        if partInstance:IsA("BasePart") then
            partInstance.Material = Enum.Material.Neon
            isNeon[part] = true
        end
    end
end
local function makePartRainbow(part)
    if isNeon[part] then
        local mk1 = game:service('ReplicatedStorage'):FindFirstChild('MasterKey')
        mk1:FireServer("customize", { part }, Color3.new(RBW_COL.R, RBW_COL.G, RBW_COL.B), "Body")
    end
end
for i, part in ipairs(partsToRainbow) do
    local partToggle = PartSection.NewToggle("Rainbow " .. part, function(bool)
        if bool then
            partToggles[part] = true
            if not isNeon[part] then
                makePartNeon(part)
            end
            if rainbowEnabled then
                makePartRainbow(part)
            end
        else
            partToggles[part] = false
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild(part) then
                local partInstance = character[part]
                if partInstance:IsA("BasePart") then
                    partInstance.Material = Enum.Material.Concrete
                    partInstance.Color = originalColors[part] or Color3.new(1, 1, 1) -- Set back to original color
                end
            end
        end
    end)
    partToggles[part] = false -- Initialize all toggles to false (disabled)
    originalColors[part] = getOriginalColor(part) -- Store the original color
    isNeon[part] = false -- Initialize all parts to not neon
end
local rainbowEnabled = false
local selectedNeonEnabled = false

local function enableRainbowEffect()
    local delayTime = 0.05 -- Time between transitions for each part
    while rainbowEnabled do
        for part, enabled in pairs(partToggles) do
            if enabled and isNeon[part] then
                makePartRainbow(part)
                task.wait(delayTime)
            end
        end
    end
end
ToggleSection.NewToggle("Rainbow Toggle", function(bool)
    rainbowEnabled = bool
    if rainbowEnabled then
        enableRainbowEffect()
    end
end)
PartSection.NewToggle("Selected Neon", function(bool)
    selectedNeonEnabled = bool
    if selectedNeonEnabled then
        for part, enabled in pairs(partToggles) do
            if enabled and not isNeon[part] then
                makePartNeon(part)
            end
        end
    else
        for part, enabled in pairs(partToggles) do
            if enabled and isNeon[part] then
                makePartNeon(part)
                makePartRainbow(part)
            end
        end
    end
end)
spawn(randomizeRainbowSpeed) -- Start the function in a separate thread to run concurrently
	local Tab = Window.NewTab("Random Rainbow")
	local Section = Tab.NewSection("Selection")
	local partsToRainbow = {
		"LeftArm", "LeftShoulder", "Pads", "LeftArmPaw", "LeftLowerArm", "RightArm", "RightFootPaw", "LeftLeg", "LeftThigh",
		"LeftFootPaw", "Tail3", "Tail1", "Eyebrow1", "Eyebrow2", "Tail2", "Nose", "LeftEar", "Head", "InsideEars", "RightEar",
		"RightThigh", "Hip", "Muzzle", "Tail5", "RightShoulder", "Torso", "EyeLid", "Jaw", "RightArmPaw", "RightLeg",
		"LeftLowerLeg", "RightLowerLeg", "LeftWingStart", "RightWing3", "LeftWing3", "RightWingStart", "LeftWing2",
		"RightWing2", "RightLowerArm", "Secondary", "BackFluff", "ChestFluff", "EarFluff", "JawFluff", "LegFluff", "TailFluff",
		"Fat", "Claws", "EyeColor", "Pupils", "Gum", "lash", "Toungue1", "Toungue2", "Tooth", "Neck", "White", "JawWeldPart",
		"Back", "UpperTooth", "DragonThird", "DragonClaws", "DragonSecondary", "OceanPrimary", "OceanSecondary", "DragonPrimary"
	}
	local partToggles = {} -- Store toggles for each part
	local originalColors = {} -- Store original colors for each part
	local isNeon = {} -- Store whether each part is neon or not
	
	local function getOriginalColor(part)
		local character = game.Players.LocalPlayer.Character
		if character and character:FindFirstChild(part) then
			local partInstance = character[part]
			if partInstance:IsA("BasePart") then
				return partInstance.Color
			end
		end
		return Color3.new(1, 1, 1) -- Default white color
	end
	local function makePartNeon(part)
		local character = game.Players.LocalPlayer.Character
		if character and character:FindFirstChild(part) then
			local partInstance = character[part]
			if partInstance:IsA("BasePart") then
				partInstance.Material = Enum.Material.Neon
				isNeon[part] = true
			end
		end
	end
	local function makePartRainbow(part)
		if isNeon[part] then
			local mk1 = game:service('ReplicatedStorage'):FindFirstChild('MasterKey')
			mk1:FireServer("customize", { part }, Color3.new(RBW_COL.R, RBW_COL.G, RBW_COL.B), "Body")
		end
	end
	for i, part in ipairs(partsToRainbow) do
		local partToggle = Section.NewToggle("Rainbow " .. part, function(bool)
			if bool then
				partToggles[part] = true
				if not isNeon[part] then
					makePartNeon(part)
				end
				if rainbowEnabled then
					makePartRainbow(part)
				end
			else
				partToggles[part] = false
				local character = game.Players.LocalPlayer.Character
				if character and character:FindFirstChild(part) then
					local partInstance = character[part]
					if partInstance:IsA("BasePart") then
						partInstance.Material = Enum.Material.Concrete
						partInstance.Color = originalColors[part] or Color3.new(1, 1, 1) -- Set back to original color
					end
				end
			end
		end)
		partToggles[part] = false -- Initialize all toggles to false (disabled)
		originalColors[part] = getOriginalColor(part) -- Store the original color
		isNeon[part] = false -- Initialize all parts to not neon
	end
	local rainbowEnabled = false
	
	local function enableRainbowEffect()
		while rainbowEnabled do
			task.wait()
	
			local mk1 = game:service('ReplicatedStorage'):FindFirstChild('MasterKey')
			local partArgs = {}
	
			for part, enabled in pairs(partToggles) do
				if enabled and isNeon[part] then
					partArgs[#partArgs + 1] = part
				end
			end
	
			if #partArgs > 0 then
				mk1:FireServer("customize", partArgs, Color3.new(RBW_COL.R, RBW_COL.G, RBW_COL.B), "Body")
			end
		end
	end
	Section.NewToggle("Rainbow Toggle", function(bool)
		rainbowEnabled = bool
		if rainbowEnabled then
			enableRainbowEffect()
		else
			for part, enabled in pairs(partToggles) do
				if not enabled then
					local character = game.Players.LocalPlayer.Character
					if character and character:FindFirstChild(part) then
						local partInstance = character[part]
						if partInstance:IsA("BasePart") then
							partInstance.Material = Enum.Material.Concrete
							partInstance.Color = originalColors[part] or Color3.new(1, 1, 1) -- Set back to original color
						end
					end
				end
			end
		end
	end)
local Tab = Window.NewTab("presets")
local Section = Tab.NewSection("presets")

local Button = Section.NewButton("all neon",function()
    local Mat = "Neon"
    local Hair = {[1] = "AccessoryMaterial",[2] = Mat,[3] = "HairF"}
    local Torso = {[1] = "AccessoryMaterial",[2] = Mat,[3] = "TorsoF"}
    local Legs = {[1] = "AccessoryMaterial",[2] = Mat,[3] = "FeetF"}
    local SecondaryArgs={[1]="Material",[2]=Mat,[3]={[1]="DragonSecondary",[2]="OceanSecondary",[3]="ChubbyCheeks",[4]="Fat",[5]="EarFluff",[6]="JawFluff",[7]="ChestFluff",[8]="LegFluff",[9]="Eyebrow1",[10]="Eyebrow2",[11]="Secondary",[12]="Jaw",[13]="RightShoulder",[14]="RightLowerLeg",[15]="RightLowerArm",[16]="RightLeg",[17]="RightFootPaw",[18]="LeftArm",[19]="LeftArmPaw",[20]="LeftCarpal",[21]="LeftFootPaw",[22]="LeftLeg",[23]="LeftLowerArm",[24]="LeftLowerLeg",[25]="LeftShoulder",[26]="RightArm",[27]="RightArmPaw",[28]="RightCarpal",[29]="DragonThird"}}
    local PrimaryArgs={[1]="Material",[2]=Mat,[3]={[1]="DragonPrimary",[2]="OceanPrimary",[3]="BackFluff",[4]="TailFluff",[5]="LeftWingStart",[6]="LeftWing2",[7]="LeftWing3",[8]="RightWingStart",[9]="RightWing2",[10]="RightWing3",[11]="EyeLid",[12]="Torso",[13]="Tail1",[14]="Tail2",[15]="Tail3",[16]="Tail5",[17]="Tail6",[18]="RightThigh",[19]="RightEar",[20]="EyeLid",[21]="Head",[22]="Hip",[23]="LeftEar",[24]="LeftThigh",[25]="Muzzle",[26]="Neck",[27]="NeckReal",[28]="Nose",}}
    --
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Hair))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Torso))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Legs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(SecondaryArgs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(PrimaryArgs))
end)
local Button = Section.NewButton("all concrete",function()
    local Concete = "Concrete"
    local Hair = {[1] = "AccessoryMaterial",[2] = Concete,[3] = "HairF"}
    local Torso = {[1] = "AccessoryMaterial",[2] = Concete,[3] = "TorsoF"}
    local Legs = {[1] = "AccessoryMaterial",[2] = Concete,[3] = "FeetF"}
    local SecondaryArgs={[1]="Material",[2]=Concete,[3]={[1]="DragonSecondary",[2]="OceanSecondary",[3]="ChubbyCheeks",[4]="Fat",[5]="EarFluff",[6]="JawFluff",[7]="ChestFluff",[8]="LegFluff",[9]="Eyebrow1",[10]="Eyebrow2",[11]="Secondary",[12]="Jaw",[13]="RightShoulder",[14]="RightLowerLeg",[15]="RightLowerArm",[16]="RightLeg",[17]="RightFootPaw",[18]="LeftArm",[19]="LeftArmPaw",[20]="LeftCarpal",[21]="LeftFootPaw",[22]="LeftLeg",[23]="LeftLowerArm",[24]="LeftLowerLeg",[25]="LeftShoulder",[26]="RightArm",[27]="RightArmPaw",[28]="RightCarpal",[29]="DragonThird"}}
    local PrimaryArgs={[1]="Material",[2]=Concete,[3]={[1]="DragonPrimary",[2]="OceanPrimary",[3]="BackFluff",[4]="TailFluff",[5]="LeftWingStart",[6]="LeftWing2",[7]="LeftWing3",[8]="RightWingStart",[9]="RightWing2",[10]="RightWing3",[11]="EyeLid",[12]="Torso",[13]="Tail1",[14]="Tail2",[15]="Tail3",[16]="Tail5",[17]="Tail6",[18]="RightThigh",[19]="RightEar",[20]="EyeLid",[21]="Head",[22]="Hip",[23]="LeftEar",[24]="LeftThigh",[25]="Muzzle",[26]="Neck",[27]="NeckReal",[28]="Nose",}}
    --
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Hair))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Torso))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Legs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(SecondaryArgs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(PrimaryArgs))    
end)
local Button = Section.NewButton("all Glass",function()
    local airw = "Glass"
    local Hair = {[1] = "AccessoryMaterial",[2] = airw,[3] = "HairF"}
    local Torso = {[1] = "AccessoryMaterial",[2] = airw,[3] = "TorsoF"}
    local Legs = {[1] = "AccessoryMaterial",[2] = airw,[3] = "FeetF"}
    local SecondaryArgs={[1]="Material",[2]=airw,[3]={[1]="DragonSecondary",[2]="OceanSecondary",[3]="ChubbyCheeks",[4]="Fat",[5]="EarFluff",[6]="JawFluff",[7]="ChestFluff",[8]="LegFluff",[9]="Eyebrow1",[10]="Eyebrow2",[11]="Secondary",[12]="Jaw",[13]="RightShoulder",[14]="RightLowerLeg",[15]="RightLowerArm",[16]="RightLeg",[17]="RightFootPaw",[18]="LeftArm",[19]="LeftArmPaw",[20]="LeftCarpal",[21]="LeftFootPaw",[22]="LeftLeg",[23]="LeftLowerArm",[24]="LeftLowerLeg",[25]="LeftShoulder",[26]="RightArm",[27]="RightArmPaw",[28]="RightCarpal",[29]="DragonThird"}}
    local PrimaryArgs={[1]="Material",[2]=airw,[3]={[1]="DragonPrimary",[2]="OceanPrimary",[3]="BackFluff",[4]="TailFluff",[5]="LeftWingStart",[6]="LeftWing2",[7]="LeftWing3",[8]="RightWingStart",[9]="RightWing2",[10]="RightWing3",[11]="EyeLid",[12]="Torso",[13]="Tail1",[14]="Tail2",[15]="Tail3",[16]="Tail5",[17]="Tail6",[18]="RightThigh",[19]="RightEar",[20]="EyeLid",[21]="Head",[22]="Hip",[23]="LeftEar",[24]="LeftThigh",[25]="Muzzle",[26]="Neck",[27]="NeckReal",[28]="Nose",}}
    --
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Hair))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Torso))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Legs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(SecondaryArgs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(PrimaryArgs))
end)
local Button = Section.NewButton("all water",function()
    local airww = "Water"
    local Hair = {[1] = "AccessoryMaterial",[2] = airww,[3] = "HairF"}
    local Torso = {[1] = "AccessoryMaterial",[2] = airww,[3] = "TorsoF"}
    local Legs = {[1] = "AccessoryMaterial",[2] = airww,[3] = "FeetF"}
    local SecondaryArgs={[1]="Material",[2]=airww,[3]={[1]="DragonSecondary",[2]="OceanSecondary",[3]="ChubbyCheeks",[4]="Fat",[5]="EarFluff",[6]="JawFluff",[7]="ChestFluff",[8]="LegFluff",[9]="Eyebrow1",[10]="Eyebrow2",[11]="Secondary",[12]="Jaw",[13]="RightShoulder",[14]="RightLowerLeg",[15]="RightLowerArm",[16]="RightLeg",[17]="RightFootPaw",[18]="LeftArm",[19]="LeftArmPaw",[20]="LeftCarpal",[21]="LeftFootPaw",[22]="LeftLeg",[23]="LeftLowerArm",[24]="LeftLowerLeg",[25]="LeftShoulder",[26]="RightArm",[27]="RightArmPaw",[28]="RightCarpal",[29]="DragonThird"}}
    local PrimaryArgs={[1]="Material",[2]=airww,[3]={[1]="DragonPrimary",[2]="OceanPrimary",[3]="BackFluff",[4]="TailFluff",[5]="LeftWingStart",[6]="LeftWing2",[7]="LeftWing3",[8]="RightWingStart",[9]="RightWing2",[10]="RightWing3",[11]="EyeLid",[12]="Torso",[13]="Tail1",[14]="Tail2",[15]="Tail3",[16]="Tail5",[17]="Tail6",[18]="RightThigh",[19]="RightEar",[20]="EyeLid",[21]="Head",[22]="Hip",[23]="LeftEar",[24]="LeftThigh",[25]="Muzzle",[26]="Neck",[27]="NeckReal",[28]="Nose",}}
    --
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Hair))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Torso))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Legs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(SecondaryArgs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(PrimaryArgs))
end)
local Button = Section.NewButton("all ForceField",function()
    local ForceField = "ForceField"
    local Hair = {[1] = "AccessoryMaterial",[2] = ForceField,[3] = "HairF"}
    local Torso = {[1] = "AccessoryMaterial",[2] = ForceField,[3] = "TorsoF"}
    local Legs = {[1] = "AccessoryMaterial",[2] = ForceField,[3] = "FeetF"}
    local SecondaryArgs={[1]="Material",[2]=ForceField,[3]={[1]="DragonSecondary",[2]="OceanSecondary",[3]="ChubbyCheeks",[4]="Fat",[5]="EarFluff",[6]="JawFluff",[7]="ChestFluff",[8]="LegFluff",[9]="Eyebrow1",[10]="Eyebrow2",[11]="Secondary",[12]="Jaw",[13]="RightShoulder",[14]="RightLowerLeg",[15]="RightLowerArm",[16]="RightLeg",[17]="RightFootPaw",[18]="LeftArm",[19]="LeftArmPaw",[20]="LeftCarpal",[21]="LeftFootPaw",[22]="LeftLeg",[23]="LeftLowerArm",[24]="LeftLowerLeg",[25]="LeftShoulder",[26]="RightArm",[27]="RightArmPaw",[28]="RightCarpal",[29]="DragonThird"}}
    local PrimaryArgs={[1]="Material",[2]=ForceField,[3]={[1]="DragonPrimary",[2]="OceanPrimary",[3]="BackFluff",[4]="TailFluff",[5]="LeftWingStart",[6]="LeftWing2",[7]="LeftWing3",[8]="RightWingStart",[9]="RightWing2",[10]="RightWing3",[11]="EyeLid",[12]="Torso",[13]="Tail1",[14]="Tail2",[15]="Tail3",[16]="Tail5",[17]="Tail6",[18]="RightThigh",[19]="RightEar",[20]="EyeLid",[21]="Head",[22]="Hip",[23]="LeftEar",[24]="LeftThigh",[25]="Muzzle",[26]="Neck",[27]="NeckReal",[28]="Nose",}}
    --
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Hair))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Torso))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Legs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(SecondaryArgs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(PrimaryArgs))
end)
local Button = Section.NewButton("all Crackedlava",function()
    local Crackedlava = "CrackedLava"
    local Hair = {[1] = "AccessoryMaterial",[2] = Crackedlava,[3] = "HairF"}
    local Torso = {[1] = "AccessoryMaterial",[2] = Crackedlava,[3] = "TorsoF"}
    local Legs = {[1] = "AccessoryMaterial",[2] = Crackedlava,[3] = "FeetF"}
    local SecondaryArgs={[1]="Material",[2]=Crackedlava,[3]={[1]="DragonSecondary",[2]="OceanSecondary",[3]="ChubbyCheeks",[4]="Fat",[5]="EarFluff",[6]="JawFluff",[7]="ChestFluff",[8]="LegFluff",[9]="Eyebrow1",[10]="Eyebrow2",[11]="Secondary",[12]="Jaw",[13]="RightShoulder",[14]="RightLowerLeg",[15]="RightLowerArm",[16]="RightLeg",[17]="RightFootPaw",[18]="LeftArm",[19]="LeftArmPaw",[20]="LeftCarpal",[21]="LeftFootPaw",[22]="LeftLeg",[23]="LeftLowerArm",[24]="LeftLowerLeg",[25]="LeftShoulder",[26]="RightArm",[27]="RightArmPaw",[28]="RightCarpal",[29]="DragonThird"}}
    local PrimaryArgs={[1]="Material",[2]=Crackedlava,[3]={[1]="DragonPrimary",[2]="OceanPrimary",[3]="BackFluff",[4]="TailFluff",[5]="LeftWingStart",[6]="LeftWing2",[7]="LeftWing3",[8]="RightWingStart",[9]="RightWing2",[10]="RightWing3",[11]="EyeLid",[12]="Torso",[13]="Tail1",[14]="Tail2",[15]="Tail3",[16]="Tail5",[17]="Tail6",[18]="RightThigh",[19]="RightEar",[20]="EyeLid",[21]="Head",[22]="Hip",[23]="LeftEar",[24]="LeftThigh",[25]="Muzzle",[26]="Neck",[27]="NeckReal",[28]="Nose",}}
    --
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Hair))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Torso))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Legs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(SecondaryArgs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(PrimaryArgs))
end)
local Button = Section.NewButton("all WoodPlanks", function()
    local WoodPlanks = "WoodPlanks"
    local Hair = {[1] = "AccessoryMaterial", [2] = WoodPlanks, [3] = "HairF"}
    local Torso = {[1] = "AccessoryMaterial", [2] = WoodPlanks, [3] = "TorsoF"}
    local Legs = {[1] = "AccessoryMaterial", [2] = WoodPlanks, [3] = "FeetF"}
    local SecondaryArgs = {[1] = "Material", [2] = WoodPlanks, [3] = {[1] = "DragonSecondary", [2] = "OceanSecondary", [3] = "ChubbyCheeks", [4] = "Fat", [5] = "EarFluff", [6] = "JawFluff", [7] = "ChestFluff", [8] = "LegFluff", [9] = "Eyebrow1", [10] = "Eyebrow2", [11] = "Secondary", [12] = "Jaw", [13] = "RightShoulder", [14] = "RightLowerLeg", [15] = "RightLowerArm", [16] = "RightLeg", [17] = "RightFootPaw", [18] = "LeftArm", [19] = "LeftArmPaw", [20] = "LeftCarpal", [21] = "LeftFootPaw", [22] = "LeftLeg", [23] = "LeftLowerArm", [24] = "LeftLowerLeg", [25] = "LeftShoulder", [26] = "RightArm", [27] = "RightArmPaw", [28] = "RightCarpal", [29] = "DragonThird"}}
    local PrimaryArgs = {[1] = "Material", [2] = WoodPlanks, [3] = {[1] = "DragonPrimary", [2] = "OceanPrimary", [3] = "BackFluff", [4] = "TailFluff", [5] = "LeftWingStart", [6] = "LeftWing2", [7] = "LeftWing3", [8] = "RightWingStart", [9] = "RightWing2", [10] = "RightWing3", [11] = "EyeLid", [12] = "Torso", [13] = "Tail1", [14] = "Tail2", [15] = "Tail3", [16] = "Tail5", [17] = "Tail6", [18] = "RightThigh", [19] = "RightEar", [20] = "EyeLid", [21] = "Head", [22] = "Hip", [23] = "LeftEar", [24] = "LeftThigh", [25] = "Muzzle", [26] = "Neck", [27] = "NeckReal", [28] = "Nose"}}
    --
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Hair))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Torso))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Legs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(SecondaryArgs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(PrimaryArgs))
end)
local Button = Section.NewButton("all DiamondPlate", function()
    local DiamondPlate = "DiamondPlate"
    local Hair = {[1] = "AccessoryMaterial", [2] = DiamondPlate, [3] = "HairF"}
    local Torso = {[1] = "AccessoryMaterial", [2] = DiamondPlate, [3] = "TorsoF"}
    local Legs = {[1] = "AccessoryMaterial", [2] = DiamondPlate, [3] = "FeetF"}
    local SecondaryArgs = {[1] = "Material", [2] = DiamondPlate, [3] = {[1] = "DragonSecondary", [2] = "OceanSecondary", [3] = "ChubbyCheeks", [4] = "Fat", [5] = "EarFluff", [6] = "JawFluff", [7] = "ChestFluff", [8] = "LegFluff", [9] = "Eyebrow1", [10] = "Eyebrow2", [11] = "Secondary", [12] = "Jaw", [13] = "RightShoulder", [14] = "RightLowerLeg", [15] = "RightLowerArm", [16] = "RightLeg", [17] = "RightFootPaw", [18] = "LeftArm", [19] = "LeftArmPaw", [20] = "LeftCarpal", [21] = "LeftFootPaw", [22] = "LeftLeg", [23] = "LeftLowerArm", [24] = "LeftLowerLeg", [25] = "LeftShoulder", [26] = "RightArm", [27] = "RightArmPaw", [28] = "RightCarpal", [29] = "DragonThird"}}
    local PrimaryArgs = {[1] = "Material", [2] = DiamondPlate, [3] = {[1] = "DragonPrimary", [2] = "OceanPrimary", [3] = "BackFluff", [4] = "TailFluff", [5] = "LeftWingStart", [6] = "LeftWing2", [7] = "LeftWing3", [8] = "RightWingStart", [9] = "RightWing2", [10] = "RightWing3", [11] = "EyeLid", [12] = "Torso", [13] = "Tail1", [14] = "Tail2", [15] = "Tail3", [16] = "Tail5", [17] = "Tail6", [18] = "RightThigh", [19] = "RightEar", [20] = "EyeLid", [21] = "Head", [22] = "Hip", [23] = "LeftEar", [24] = "LeftThigh", [25] = "Muzzle", [26] = "Neck", [27] = "NeckReal", [28] = "Nose"}}
    --
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Hair))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Torso))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Legs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(SecondaryArgs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(PrimaryArgs))
end)
local Button = Section.NewButton("all Snow", function()
    local Snow = "Snow"
    local Hair = {[1] = "AccessoryMaterial", [2] = Snow, [3] = "HairF"}
    local Torso = {[1] = "AccessoryMaterial", [2] = Snow, [3] = "TorsoF"}
    local Legs = {[1] = "AccessoryMaterial", [2] = Snow, [3] = "FeetF"}
    local SecondaryArgs = {[1] = "Material", [2] = Snow, [3] = {[1] = "DragonSecondary", [2] = "OceanSecondary", [3] = "ChubbyCheeks", [4] = "Fat", [5] = "EarFluff", [6] = "JawFluff", [7] = "ChestFluff", [8] = "LegFluff", [9] = "Eyebrow1", [10] = "Eyebrow2", [11] = "Secondary", [12] = "Jaw", [13] = "RightShoulder", [14] = "RightLowerLeg", [15] = "RightLowerArm", [16] = "RightLeg", [17] = "RightFootPaw", [18] = "LeftArm", [19] = "LeftArmPaw", [20] = "LeftCarpal", [21] = "LeftFootPaw", [22] = "LeftLeg", [23] = "LeftLowerArm", [24] = "LeftLowerLeg", [25] = "LeftShoulder", [26] = "RightArm", [27] = "RightArmPaw", [28] = "RightCarpal", [29] = "DragonThird"}}
    local PrimaryArgs = {[1] = "Material", [2] = Snow, [3] = {[1] = "DragonPrimary", [2] = "OceanPrimary", [3] = "BackFluff", [4] = "TailFluff", [5] = "LeftWingStart", [6] = "LeftWing2", [7] = "LeftWing3", [8] = "RightWingStart", [9] = "RightWing2", [10] = "RightWing3", [11] = "EyeLid", [12] = "Torso", [13] = "Tail1", [14] = "Tail2", [15] = "Tail3", [16] = "Tail5", [17] = "Tail6", [18] = "RightThigh", [19] = "RightEar", [20] = "EyeLid", [21] = "Head", [22] = "Hip", [23] = "LeftEar", [24] = "LeftThigh", [25] = "Muzzle", [26] = "Neck", [27] = "NeckReal", [28] = "Nose"}}
    --
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Hair))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Torso))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Legs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(SecondaryArgs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(PrimaryArgs))
end)
local Button = Section.NewButton("all Sandstone", function()
    local Sandstone = "Sandstone"
    local Hair = {[1] = "AccessoryMaterial", [2] = Sandstone, [3] = "HairF"}
    local Torso = {[1] = "AccessoryMaterial", [2] = Sandstone, [3] = "TorsoF"}
    local Legs = {[1] = "AccessoryMaterial", [2] = Sandstone, [3] = "FeetF"}
    local SecondaryArgs = {[1] = "Material", [2] = Sandstone, [3] = {[1] = "DragonSecondary", [2] = "OceanSecondary", [3] = "ChubbyCheeks", [4] = "Fat", [5] = "EarFluff", [6] = "JawFluff", [7] = "ChestFluff", [8] = "LegFluff", [9] = "Eyebrow1", [10] = "Eyebrow2", [11] = "Secondary", [12] = "Jaw", [13] = "RightShoulder", [14] = "RightLowerLeg", [15] = "RightLowerArm", [16] = "RightLeg", [17] = "RightFootPaw", [18] = "LeftArm", [19] = "LeftArmPaw", [20] = "LeftCarpal", [21] = "LeftFootPaw", [22] = "LeftLeg", [23] = "LeftLowerArm", [24] = "LeftLowerLeg", [25] = "LeftShoulder", [26] = "RightArm", [27] = "RightArmPaw", [28] = "RightCarpal", [29] = "DragonThird"}}
    local PrimaryArgs = {[1] = "Material", [2] = Sandstone, [3] = {[1] = "DragonPrimary", [2] = "OceanPrimary", [3] = "BackFluff", [4] = "TailFluff", [5] = "LeftWingStart", [6] = "LeftWing2", [7] = "LeftWing3", [8] = "RightWingStart", [9] = "RightWing2", [10] = "RightWing3", [11] = "EyeLid", [12] = "Torso", [13] = "Tail1", [14] = "Tail2", [15] = "Tail3", [16] = "Tail5", [17] = "Tail6", [18] = "RightThigh", [19] = "RightEar", [20] = "EyeLid", [21] = "Head", [22] = "Hip", [23] = "LeftEar", [24] = "LeftThigh", [25] = "Muzzle", [26] = "Neck", [27] = "NeckReal", [28] = "Nose"}}
    --
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Hair))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Torso))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(Legs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(SecondaryArgs))
    game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(PrimaryArgs))
end)
local Button = Section.NewButton("Neon Toungue",function()
	--Made by syr0nix
	local args = {[1] = "Material",[2] = "Neon",[3] = {[29] = "Toungue1",[30] = "Toungue2"}}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))	
end)
local Tab = Window.NewTab("Info")
local Section = Tab.NewSection("Basic Information about bluefoxes")
local Section = Tab.NewSection("WhiteTip")
local Section = Tab.NewSection("The Royality of bluefoxes")
local Section = Tab.NewSection(" ")
local Section = Tab.NewSection("Gray Tail Tip")
local Section = Tab.NewSection("The Commanding bluefoxes that help")
local Section = Tab.NewSection(" ")
local Section = Tab.NewSection("Red Tail Tip")
local Section = Tab.NewSection("The bluefoxes that help people with changing to a bluefox")
local Section = Tab.NewSection(" ")
local Section = Tab.NewSection("Orange Tail Tip")
local Section = Tab.NewSection("The bluefoxes that thunder can freely talk to when be meets them  (no filter)")
local Section = Tab.NewSection(" ")
local Section = Tab.NewSection("Green Tail Tip")
local Section = Tab.NewSection("The king's chair")
local Section = Tab.NewSection(" ")
local Section = Tab.NewSection("Yellow Tail Tip")
local Section = Tab.NewSection("The public bluefox chairs")
local Section = Tab.NewSection(" ")
local Section = Tab.NewSection("Blue Tail Tip")
local Section = Tab.NewSection("Civilian bluefoxes")
local Button = Section.NewButton("By ThatMrAlexei",function()
end)
local Button = Section.NewButton("In 1623, as the Skarus Union sought to expand its economic and industrial prowess, it turned its gaze upon the natural resources ",function()
end)
local Button = Section.NewButton("abundant in the territories where the Bluefoxes dwelled. Ignoring their sentience and ecological significance, the authorities ",function()
end)
local Button = Section.NewButton("subjected these gentle beings to captivity and forced them into    slave labor. Separated from their families and habitats, the Bluefoxes",function()
end)
local Button = Section.NewButton("were made to toil ceaselessly in various areas throughout the     Skarus Union. Some were forced to work in mines, extracting ",function()
end)
local Button = Section.NewButton("valuable minerals under inhumane conditions. Others were enslaved on vast plantations, tending to crops and laboring tending to crops",function()
end)
local Button = Section.NewButton(" and laboring under the scorching sun.",function()
end)
local Tab = Window.NewTab("Toggles")
local Section = Tab.NewSection("wana be sick")
_G.rbweyes = false
local EnabledToggle = Section.NewToggle("Rainbow Eyes",function(bool)
	if _G.rbweyes then
		_G.rbweyes = false
		return
	else
		_G.rbweyes = true
	end
	local mk1 = game:service('ReplicatedStorage'):FindFirstChild('MasterKey')
	while _G.rbweyes do
		task.wait()
		local args = {"customize",{ [10] = "EyeColor" },Color3.new(RBW_COL.R,RBW_COL.G,RBW_COL.B),"Body"}
		mk1:FireServer(unpack(args))
	end
end,false)
hsv = Color3.fromHSV
_G.rbwtag = false
local EnabledToggle = Section.NewToggle("Rainbow Tag",function(bool)
	if _G.rbwtag then
		_G.rbwtag = false
		return
	else
		_G.rbwtag = true
	end
	local mk1 = game:service('ReplicatedStorage'):FindFirstChild('MasterKey')
	while _G.rbwtag do
		task.wait()
		local h,s,v = RBW_COL:ToHSV()
		local args = {[1] = "ChangeColor",[2] = {hsv(h,s,v).R,hsv(h,s,v).G,hsv(h,s,v).B},[3] = "\226\128\153b%5m\226\128\176}0\195\1383t\195\154\226\149\147\195\146\226\148\140\226\128\166\226\151".."\153"}
		mk1:FireServer(unpack(args))
	end
end,false)
_G.faderbw = false
local EnabledToggle = Section.NewToggle("Rainbow Fade",function(bool)
	if _G.faderbw then
		_G.faderbw = false
		return
	else
		_G.faderbw = true
	end
	local mk1 = game:service('ReplicatedStorage'):FindFirstChild('MasterKey')
	local spd = 4
	while _G.faderbw do
		for i = 0,1,0.001*spd do
			if _G.faderbw == false then return end
			col = Color3.fromHSV(i,1,1)
			local args = {[1] = "ChangeColor",[2] = {col.G,col.B,col.B},[3] = "\226\128\153b%5m\226\128\176}0\195\1383t\195\154\226\149\147\195\146\226\148\140\226\128\166\226\151".."\153"}
			mk1:FireServer(unpack(args))
			wait()
		end
		for i = 0,1,0.001*spd do
			if _G.faderbw == false then return end
			col = Color3.fromHSV(i,1,1)
			local args = {[1] = "ChangeColor",[2] = {col.B,col.B,col.G},[3] = "\226\128\153b%5m\226\128\176}0\195\1383t\195\154\226\149\147\195\146\226\148\140\226\128\166\226\151".."\153"}
			mk1:FireServer(unpack(args))
			wait()
		end
		for i = 0,1,0.001*spd do
			if _G.faderbw == false then return end
			col = Color3.fromHSV(i,1,1)
			local args = {[1] = "ChangeColor",[2] = {col.r,col.B,col.R},[3] = "\226\128\153b%5m\226\128\176}0\195\1383t\195\154\226\149\147\195\146\226\148\140\226\128\166\226\151".."\153"}
			mk1:FireServer(unpack(args))
			wait()
		end
	end
end,false)
_G.rbwparti = false
local EnabledToggle = Section.NewToggle("Rainbow Particles",function(bool)
	if _G.rbwparti then
		_G.rbwparti = false
		return
	else
		_G.rbwparti = true
	end
	local mk1 = game:service('ReplicatedStorage'):FindFirstChild('MasterKey')
	while _G.rbwparti do
		task.wait()
		local args = {[1] = "ColorParticle",[2] = RBW_COL}
		mk1:FireServer(unpack(args))
	end
end,false)
_G.rbwwolf = false
local EnabledToggle = Section.NewToggle("Rainbow wolf",function(bool)
	if _G.rbwwolf then
		_G.rbwwolf = false
		return
	else
		_G.rbwwolf = true
	end
	local mk1 = game:service('ReplicatedStorage'):FindFirstChild('MasterKey')
	while _G.rbwwolf do
		task.wait()
		local args = {[1] = "customize",[2] = {[1] = "LeftArm",[2] = "LeftShoulder",[3] = "Pads",[4] = "LeftArmPaw",[5] = "LeftLowerArm",[6] = "RightArm",[7] = "RightFootPaw",[8] = "LeftLeg",[9] = "LeftThigh",[10] = "LeftFootPaw",[11] = "Tail3",[12] = "Tail1",[13] = "Eyebrow1",[14] = "Eyebrow2",[15] = "Tail2",[16] = "Nose",[17] = "LeftEar",[18] = "Head",[19] = "InsideEars",[20] = "RightEar",[21] = "RightThigh",[22] = "Hip",[23] = "Muzzle",[24] = "Tail5",[25] = "RightShoulder",[26] = "Torso",[27] = "EyeLid",[28] = "Jaw",[29] = "RightArmPaw",[30] = "RightLeg",[31] = "LeftLowerLeg",[32] = "RightLowerLeg",[33] = "LeftWingStart",[34] = "RightWing3",[35] = "LeftWing3",[36] = "RightWingStart",[37] = "LeftWing2",[38] = "RightWing2",[39] = "RightLowerArm",[40] = "Secondary",[41] = "BackFluff",[42] = "ChestFluff",[43] = "EarFluff",[44] = "JawFluff",[45] = "LegFluff",[46] = "TailFluff",[47] = "Fat",[48] = "Claws",[49] = "EyeColor",[50] = "Pupils",[51] = "Gum",[52] = "lash",[53] = "Toungue1",[54] = "Toungue2",[55] = "Tooth",[56] = "Neck",[57] = "White",[58] = "JawWeldPart",[59] = "Back",[60] = "UpperTooth",[61] = "DragonThird",[62] = "DragonClaws",[63] = "DragonSecondary",[64] = "OceanPrimary",[65] = "OceanSecondary",[66] = "DragonPrimary"},[3] = RBW_COL,[4] = "Body"}
		mk1:FireServer(unpack(args))
	end
end,false)
_G.rbwhair = false
local EnabledToggle = Section.NewToggle("Rainbow Hair",function(bool)
	if _G.rbwhair then
		_G.rbwhair = false
		return
	else
		_G.rbwhair = true
	end
	local mk1 = game:service('ReplicatedStorage'):FindFirstChild('MasterKey')
	while _G.rbwhair do
		task.wait()
		local args = {[1] = "Accessories",[2] = RBW_COL}
		mk1:FireServer(unpack(args))
	end
end)
_G.MonoChromeFade = false
local EnabledToggle = Section.NewToggle("Mono Fade tag",function(bool)
	if _G.MonoChromeFade then
		_G.MonoChromeFade = false
		return
	else
		_G.MonoChromeFade = true
	end
	local RS = game:service('ReplicatedStorage')
	local mk1 = RS:FindFirstChild('MasterKey')
	local spd = 6
	while _G.MonoChromeFade do
		for i = 0,1,0.001*spd do
			col = Color3.fromHSV(i,1,1)
			local args = {[1] = "ChangeColor",[2] = {col.R,col.R,col.R},[3] = "\226\128\153b%5m\226\128\176}0\195\1383t\195\154\226\149\147\195\146\226\148\140\226\128\166\226\151".."\153"}
			mk1:FireServer(unpack(args))
			wait()
		end
	end
end)
_G.particlefade = false

local COLOR1 = Color3.fromRGB(255,255,255) 
local COLOR2 = Color3.fromRGB(0,0,0) 
local SPEED = 1
local Remote = game:GetService('ReplicatedStorage'):FindFirstChild('MasterKey')
local KEY = "\226\128\153b%5m\226\128\176}0\195\1383t\195\154\226\149\147\195\146\226\148\140\226\128\166\226\151".."\153"
local first_color = Instance.new('Color3Value') -- first value
first_color.Value = COLOR1
local second_color = Instance.new('Color3Value') -- second value
first_color.Value = COLOR2
local current_color = Instance.new('Color3Value') -- fading value
current_color.Value = first_color.value
local TweenService = game:GetService('TweenService') -- get tween service
local EnabledToggle = Section.NewToggle("particlefade",function(bool)
	if _G.particlefade then
		_G.particlefade = false
		return
	else
		_G.particlefade = true
	end
	while _G.particlefade do 
		task.wait()
		-- starts loop, until _G.particlefade will equals false
		-- for this fade script to make it with speed I recommend u put EasingStyle.Linear
		if current_color.Value == second_color.Value then -- check if curr color is second to start fade to first color
			TweenService:Create(current_color,TweenInfo.new(SPEED,Enum.EasingStyle.Linear),{Value = first_color.Value}):play()
		elseif current_color.Value == first_color.Value then -- same but here first color to second
			TweenService:Create(current_color,TweenInfo.new(SPEED,Enum.EasingStyle.Linear),{Value = second_color.Value}):play()
		end
		Remote:FireServer("ColorParticle", current_color.Value) -- fire remote to server, change color of particle
	end -- end loop and start again
end)
local Tab = Window.NewTab("Teleports")
local Section = Tab.NewSection("Forest Biome")
local Button = Section.NewButton("Forest Biome",function()
	local args = {[1] = "Spawn",[2] = "Forest Biome"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Pup Adoption",function()
	local args = {[1] = "Spawn",[2] = "Adoption"}
game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("School",function()
	local args = {[1] = "Spawn",[2] = "School"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Store",function()
	local args = {[1] = "Spawn",[2] = "Store"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Jail",function()
	local args = {[1] = "Spawn",[2] = "Jail"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Camp",function()
	local args = {[1] = "Spawn",[2] = "Camp"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Cafe",function()
	local args = {[1] = "Spawn",[2] = "Caf\195\169"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Section = Tab.NewSection("Redwood Biome")
local Button = Section.NewButton("Redwood Biome",function()
	local args = {[1] = "Spawn",[2] = "Redwood Biome"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Restaurant",function()
	local args = {[1] = "Spawn",[2] = "Restaurant"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Medic Centre",function()
	local args = {[1] = "Spawn",[2] = "Medic Centre"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Section = Tab.NewSection("Snow Biome")
local Button = Section.NewButton("Snow Biome",function()
	local args = {[1] = "Spawn",[2] = "Snow Biome"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Ice Lake",function()
	local args = {[1] = "Spawn",[2] = "Ice Lake"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Ice Bath",function()
	local args = {[1] = "Spawn",[2] = "Ice Bath"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Section = Tab.NewSection("Beach Biome")
local Button = Section.NewButton("Beach Biome",function()
    local args = {[1] = "Spawn",[2] = "Beach Biome"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Button = Section.NewButton("Volcano",function()
	local args = {[1] = "Spawn",[2] = "Volcano"}
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
print "Oh Daddy UwU | no i dont care about it just what i did to it | i ait answering questions :> | UWU yddaD hO"
