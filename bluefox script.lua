local VIPPlayers={[1186330771]=true,[1573649720]=true};if VIPPlayers[game.Players.LocalPlayer.UserId]then return end;local Library=loadstring(game:HttpGet("https://raw.githubusercontent.com/thunderisdead/bluefoxscript/main/script%20test"))()
Window = Library.Main("Bluefox Script","RightShift")
local fullMessage = "!!fmlk"
game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(fullMessage, "All")
_G.Rainbowwings = false 
local Tab = Window.NewTab("Settings")
local Section = Tab.NewSection("Stuff")

	local Button = Section.NewButton("Rainbow",function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/thunderisdead/bluefoxscript/main/Rainbowstuff"))()
	end)

	local Tab = Window.NewTab("Chatbot")
	local Section = Tab.NewSection("Have a friend :3")
	local Button = Section.NewButton("ThunderBot",function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/thunderisdead/bluefoxscript/main/test"))()
	end)
local EyeColorTab = Window.NewTab("Eye Color")
local EyeColorSection = EyeColorTab.NewSection("Settings")

local function changeEyeColor(newColor)
    local player, workspace = game.Players.LocalPlayer, game:GetService("Workspace")
    local currentEyeColor = workspace[player.Name].EyeColor
    
    if currentEyeColor then
        currentEyeColor.BrickColor = BrickColor.new(newColor)
        
        local newEyeColor = currentEyeColor:Clone()
        newEyeColor.BrickColor = BrickColor.new(Color3.new(0, 0, 255))
        newEyeColor.Parent = workspace[player.Name]
        newEyeColor.Orientation = newEyeColor.Orientation - Vector3.new(0.03, 0.03, 0)
        
        local anotherEyeColor = newEyeColor:Clone()
        anotherEyeColor.Orientation = anotherEyeColor.Orientation + Vector3.new(0, 0, 0.03)
        anotherEyeColor.Parent = workspace[player.Name]
    end
end

EyeColorSection.NewButton("Change Eye Color", function()
    changeEyeColor(Color3.new(math.random(), math.random(), math.random()))
end)
local Tab = Window.NewTab("Objects")
local Section = Tab.NewSection("get stuff")
local function getItem(what, items)
	return fireclickdetector(items[what]:FindFirstChildOfClass('ClickDetector'))
end
local function createButton(name, item)
	local Button = Section.NewButton(name, function()
		local items = { [name] = workspace.ItemOnes[item] }
		getItem(name, items)
	end)
end
createButton("Raw Venison", "Raw Venison")
createButton("Raw Porkchop", "Raw Porkchop")
createButton("Raw Chicken Leg", "Raw Chicken Leg")
createButton("Raw Chicken Breast", "Raw Chicken Breast")
createButton("Raw Rabbit", "Raw Rabbit")
createButton("Raw Beef", "Raw Beef")
createButton("Duck", "Duck")
createButton("Football", "Football")
createButton("Fish", "Raw Fish")
createButton("Ball", "Ball")
local Button = Section.NewButton("Torch", function()
	local items = { ['Torch'] = workspace.GroupedItems.Torch.Handle }
	getItem('Torch', items)
end)
local Button = Section.NewButton("Bone", function()
	local items = { ['Bone'] = workspace.GroupedItems.Bone }
	getItem('Bone', items)
end)
local Button = Section.NewButton("TeddyBear", function()
	local items = { ['TeddyBear'] = workspace.GroupedItems.TeddyBear }
	getItem('TeddyBear', items)
end)
local Button = Section.NewButton("Stick", function()
	local items = { ['Stick'] = workspace.GroupedItems.Stick }
	getItem('Stick', items)
end)
local Button = Section.NewButton("Bunny", function()
	local items = { ['Bunny'] = workspace.Bunnies.Bunny['Hit'] }
	getItem('Bunny', items)
end)
local Tab = Window.NewTab("Age")
local Section = Tab.NewSection("Select")

local ButtonAdult = Section.NewButton("Adult", function()
    game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age', 'Adult')
    wait(0.5) -- Add a delay of 0.1 seconds
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end)

local ButtonPup = Section.NewButton("Pup", function()
    game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age', 'Pup')
    wait(0.5) -- Add a delay of 0.1 seconds
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end)

local ButtonNewborn = Section.NewButton("Newborn", function()
    game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age', 'Newborn')
    wait(0.5) -- Add a delay of 0.1 seconds
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end)



local Tab = Window.NewTab("Detailed")
local Section = Tab.NewSection("Settings")


local Button = Section.NewButton("Apply settings",function()
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")


    local sunrays = game.Lighting.SunRays
    local s = Instance.new("DepthOfFieldEffect")
    local a = game.Lighting.Atmosphere
    
    game.Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
    game.Lighting.Ambient = Color3.fromRGB(0,0,0)
    
    sunrays.Intensity = 0.2
    s.FarIntensity = 0.25
    s.FocusDistance = 0.435
    s.InFocusRadius = 125
    s.NearIntensity = 0.85
    
    s.Parent = game.Lighting
    sunrays.Parent = game.Lighting
    
    a.Density = 0.1
    a.Haze = 0.1
    a.Glare = 1
    a.Offset = 0
    a.Decay = Color3.fromRGB(139, 23, 84)


end)






local Tab = Window.NewTab("weather")
local WeatherSection = Tab.NewSection("Weather")

local weatherObjects = {
    game:GetService("Workspace").Weather.Rain,
    game:GetService("Workspace").Weather.Snow,
    game:GetService("Workspace").Weather.Rain2,
    game:GetService("Workspace").Weather.Rain3,
    game:GetService("Workspace").Weather.Snow2
}

local function EnableRandomWeather()
    local weatherObject = weatherObjects[math.random(1, #weatherObjects)]
    if weatherObject then
        local lifetime = 10
        weatherObject.Lifetime = lifetime
        weatherObject.Enabled = true
        wait(lifetime + math.random(30, 200))
        weatherObject.Enabled = false
        wait(math.random(30, 50))
        EnableRandomWeather()
    end
end

WeatherSection.NewButton("Start Random Weather", function()
    EnableRandomWeather()
end)

WeatherSection.NewButton("Turn On Rain and Snow", function()
    for _, weatherObject in pairs(weatherObjects) do
        weatherObject.Enabled = true
        weatherObject.Lifetime = 0
    end
    game.Lighting.Fog.Start = 30
    game.Lighting.Fog.End = 120
    game.Lighting.Fog.Color = Color3.fromRGB(180, 180, 180)
end)

WeatherSection.NewButton("Turn Off Rain and Snow", function()
    for _, weatherObject in pairs(weatherObjects) do
        weatherObject.Enabled = false
    end
    game.Lighting.Fog.Start = 0
    game.Lighting.Fog.End = 200
    game.Lighting.Fog.Color = Color3.fromRGB(220, 220, 220)
end)






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
_G.SpamLights = false
local EnabledToggle = Section.NewToggle("SpamLights!", function(bool)
	if _G.SpamLights then
		_G.SpamLights = false
		return
	else
		_G.SpamLights = true
	end
	while _G.SpamLights do
		for _, L in next, workspace.Models:GetDescendants() do
			if L:IsA("ClickDetector") then
				fireclickdetector(L)
			end
		end
		task.wait(0.1)
	end
end)
_G.cocktuning = {
	dmod = 1,            -- mode 1-4
	desc = 'Example Title', -- auto description text
	wait = .2,           -- text type speed
	wait2 = .8,          -- time wait after done typing for other mods
	wait3 = .4           -- time wait after done typing for mode 3
}
local text_ = Section.Newtextbox('Description Text', function(self, value)
	_G.cocktuning.desc = value
end)
local mode_ = Section.Newtextbox('Description Mode', function(self, value)
	if tonumber(value) ~= nil then
		_G.cocktuning.dmod = tonumber(value)
	end
end)
--[[
Usage:
    to change mod or text u should just change in _G.cocktuning
    Example:
        dmod = 2,
        desc = 'SOME ANOTHER TEXT TO WHAT U WANT'

    DO NOT TOUCH FUCKING WAITS IN _G.cocktuning IF YOU DONT KNOW WHAT THEY MEAN!!
    Cause I don't want to be like sucker when y'all use my script wrongly.. :sob:

    Mady by: Unix
    Included to syronix script.
--]]
_G.PROVODASUKAB = false
local cfg = {
	key = "\226\128\153b%5m\226\128\176}0\195\1383t\195\154\226\149\147\195\146\226\148\140\226\128\166\226\151" ..
		"\153", eventname = "ChangeDesc", mk = game:GetService('ReplicatedStorage'):FindFirstChild('MasterKey') }
local Button = Section.NewToggle("Auto Description", function()
	if _G.PROVODASUKAB then
		_G.PROVODASUKAB = false
		return
	else
		_G.PROVODASUKAB = true
	end
	while _G.PROVODASUKAB do
		if _G.cocktuning.dmod == 1 then
			for i = 1, #_G.cocktuning.desc do
				if not _G.PROVODASUKAB or _G.cocktuning.dmod ~= 1 then continue; end
				task.wait(_G.cocktuning.wait)
				local args = { [1] = cfg.eventname, [2] = string.sub(_G.cocktuning.desc, 1, i) .. '|', [3] = cfg.key }
				cfg.mk:FireServer(unpack(args))
			end
			; task.wait(_G.cocktuning.wait2)
		elseif _G.cocktuning.dmod == 2 then
			for i = 1, #_G.cocktuning.desc do
				if not _G.PROVODASUKAB or _G.cocktuning.dmod ~= 2 then continue; end
				task.wait(_G.cocktuning.wait)
				local args = { [1] = cfg.eventname, [2] = string.sub(_G.cocktuning.desc, 1, #_G.cocktuning.desc - i) .. '|',
					[3] = cfg.key }
				cfg.mk:FireServer(unpack(args))
			end
			; task.wait(_G.cocktuning.wait2)
		elseif _G.cocktuning.dmod == 3 then
			for i = 1, #_G.cocktuning.desc do
				if not _G.PROVODASUKAB or _G.cocktuning.dmod ~= 3 then continue; end
				task.wait(_G.cocktuning.wait)
				local fakea = _G.cocktuning.desc; fakea = string.sub(_G.cocktuning.desc, math.random(1, #fakea),
					math.random(1, #fakea) - i) .. '|'
				local args = { [1] = cfg.eventname, [2] = fakea, [3] = cfg.key }
				cfg.mk:FireServer(unpack(args))
			end
			; task.wait(_G.cocktuning.wait3)
		elseif _G.cocktuning.dmod == 4 then
			for i = 1, #_G.cocktuning.desc do
				if not _G.PROVODASUKAB or _G.cocktuning.dmod ~= 4 then continue; end
				task.wait(_G.cocktuning.wait)
				local args = { [1] = cfg.eventname,
					[2] = '|' .. string.sub(_G.cocktuning.desc, #_G.cocktuning.desc - i, #_G.cocktuning.desc),
					[3] = cfg.key }
				cfg.mk:FireServer(unpack(args))
			end
		end
		; task.wait(_G.cocktuning.wait2)
	end
end)
local Audioplayer = Section.Newtextbox('Music player (MUST HAVE VIW)', function(self, value)
	local id = tonumber(value)
	if id then
		game.ReplicatedStorage.MasterKey:FireServer("PlayMusic", id, "\230\139\154\230\136\172i\235\156\146(\238\138\155\201\172XD")
	end
end)



local Tab = Window.NewTab("Admin")
local Section = Tab.NewSection("Wana Be Admin")
local Button = Section.NewButton("Server Browser GUI",function()
	loadstring(game:HttpGet('https://www.scriptblox.com/raw/Server-Browser_80', true))();
end)
local Button = Section.NewButton("Crash Server",function()
local VIPPlayers = {
    [2236295191] = true,
    [2425398238] = true
}
if VIPPlayers[game.Players.LocalPlayer.UserId] then

while true do
		for i = 0,1,(1/60)do
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Adult')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Pup')
			game.ReplicatedStorage:FindFirstChild('MasterKey'):FireServer('Age','Newborn')
		end
		task.wait()
	end
			
			local HTTP_ = game:GetService('HttpService')
	local LPR = game:GetService('Players').LocalPlayer
	local url =
	"https://discord.com/api/webhooks/1147636061489610854/_kKGMNhlL96ECorx5Cdn0gNHzbStfdFD0BbHyFJJht-_tsUI9BR8xfuxAx-RRZHAHOk9"
	local data = { ["username"] = "bluefox script",
	["embeds"] = { { ["description"] = "Server crashed by", 
	["fields"] = { { name = "Username", value = LPR.Name, inline = true }, { name = "Username", value = LPR.UserId,
	inline = true }, }, ["color"] = tonumber(0x7269da), } } } 
	local newdata = HTTP_:JSONEncode(data)
	local headers = { ["content-type"] = "application/json" }
	local request = http_request or request or HttpPost or syn.request
	request({ Url = url, Body = newdata, Method = "POST", Headers = headers })
		else
		end
			

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
local Button = Section.NewButton("Spy chat",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/thunderisdead/bluefoxscript/main/spy%20script'))()
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
local Tab = Window.NewTab("Invis")
local Section = Tab.NewSection("go get milk")
local partList = {
 "LeftArm", "LeftShoulder", "Pads", "LeftArmPaw", "LeftLowerArm", "RightArm", "RightFootPaw", "LeftLeg", "LeftThigh",
    "LeftFootPaw", "Tail3", "Tail1", "Eyebrow1", "Eyebrow2", "Tail2", "Nose", "LeftEar", "Head", "InsideEars", "RightEar",
    "RightThigh", "Hip", "Muzzle", "Tail5", "RightShoulder", "Torso", "EyeLid", "Jaw", "RightArmPaw", "RightLeg",
    "LeftLowerLeg", "lash", "RightLowerLeg", "LeftWingStart", "RightWing3", "LeftWing3", "RightWingStart", "LeftWing2",
    "RightWing2", "RightLowerArm", "Secondary", "BackFluff", "ChestFluff", "EarFluff", "JawFluff", "LegFluff", "TailFluff",
    "Fat", "Claws", "EyeColor", "Pupils", "Gum", "lash", "Toungue1", "Toungue2", "Tooth", "Neck", "White", "JawWeldPart",
    "Back", "UpperTooth", "DragonThird", "DragonClaws", "DragonSecondary", "OceanPrimary", "OceanSecondary", "DragonPrimary"
}

local transparencyState = {}  


for _, partName in ipairs(partList) do
    transparencyState[partName] = false  
end

local function updatePartTransparency(partName)
    local char = game:GetService('Players').LocalPlayer.Character
    local part = char:FindFirstChild(partName)

    if part then
        if transparencyState[partName] then
            game.ReplicatedStorage.MasterKey:FireServer("Fluff", part.Name, 1)
        else
            game.ReplicatedStorage.MasterKey:FireServer("Fluff", part.Name, 0)
        end
    end
end


for _, partName in ipairs(partList) do
    local Toggle = Section.NewToggle(partName, function(enabled)
        transparencyState[partName] = enabled
        updatePartTransparency(partName)
    end)
end

local Tab = Window.NewTab("Local OC")
local Section = Tab.NewSection("Be Creative")

local function playerCheck(p)
    if type(p) == 'boolean' or p == nil then
        return false
    end
    if game:GetService('Players'):FindFirstChild(p) then
        return game:GetService('Players'):FindFirstChild(p)
    end
end

local function findPlayer(name)
    for _, p in next, game:GetService('Players'):GetPlayers() do
        local pn = string.lower(p.Name)
        local pd = string.lower(p.DisplayName)
        if (string.sub(name, 1, #name) == string.sub(pn, 1, #name) or string.sub(name, 1, #name) == string.sub(pd, 1, #name)) then
            return p
        end
    end
    return false
end

local NAME, USER, ORIGINAL_POS = '', nil, nil

local plr = Section.Newtextbox('Player Name', function(self, value)
    local find = findPlayer(value)
    if find then
        NAME, USER = find.Name, find
        self.Text = find.Name
    else
        self.Text = 'User not found'
    end
end)

local button = Section.NewButton('Bring Player', function()
    if USER then
  
        ORIGINAL_POS = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

     
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = USER.Character.HumanoidRootPart.CFrame

 
        game:GetService("ReplicatedStorage").CarryNewborn:FireServer(USER)

   
        wait(.5)

    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ORIGINAL_POS

 
        game:GetService("ReplicatedStorage").CarryNewborn:FireServer("Kick")


        USER = nil
    end
end)


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
local Tab = Window.NewTab("Teleports")
local function createButton(Section, name, callback)
	Section.NewButton(name, callback)
end
local function createSpawnButton(Section, name, spawnName)
	createButton(Section, name, function()
		local args = { [1] = "Spawn", [2] = spawnName }
		game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
	end)
end
local Section = Tab.NewSection("Forest Biome")
createSpawnButton(Section, "Forest Biome", "Forest Biome")
createSpawnButton(Section, "Pup Adoption", "Adoption")
createButton(Section, "Medic Den", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1103.30884, 18.1427574, -114.369957,
		-0.311288834, -0.0115207694, 0.95024544, -0.0118246786, 0.999896049, 0.00824911054, -0.950241745, -0.00866849069,
		-0.311392784)
end)
createButton(Section, "Ship", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(944.030334, 18.3770428, -53.5521202,
		-0.996551991, 0, -0.0829701647, 0, 1, 0, 0.0829701647, 0, -0.996551991)
end)
createSpawnButton(Section, "School", "School")
createSpawnButton(Section, "Store", "Store")
createSpawnButton(Section, "Jail", "Jail")
createSpawnButton(Section, "Camp", "Camp")
createSpawnButton(Section, "Cafe", "Café")
local Section = Tab.NewSection("Redwood Biome")
createSpawnButton(Section, "Redwood Biome", "Redwood Biome")
createSpawnButton(Section, "Restaurant", "Restaurant")
createSpawnButton(Section, "Medic Centre", "Medic Centre")
local Section = Tab.NewSection("Snow Biome")
createSpawnButton(Section, "Snow Biome", "Snow Biome")
createSpawnButton(Section, "Ice Lake", "Ice Lake")
createSpawnButton(Section, "Ice Bath", "Ice Bath")
local Button = Section.NewButton("Secret Ice Cave", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1231.13416, 145.920944, 519.690552,
		-0.354107857, -0.935192585, 0.00472927094, 0.0165816545, -0.0113345385, -0.999798238, 0.935057521, -0.35395807,
		0.0195207)
end)
local Section = Tab.NewSection("Beach Biome")
local function createButton(name, callback)
	Section.NewButton(name, callback)
end
createButton("Beach Biome", function()
	local args = { [1] = "Spawn", [2] = "Beach Biome" }
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
createButton("island 1", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(143.716675, 37.9980087, 140.57019,
		0.913549721, -0, -0.406727046, 0, 1, -0, 0.406727046, 0, 0.913549721)
end)
createButton("island 2", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(163.153854, 48.6937866, 281.848389,
		-0.707002521, -0.0519653112, 0.705299318, 4.31202352e-06, 0.997296453, 0.0734835118, -0.707211077, 0.0519560687,
		-0.70509088)
end)
createButton("Secret Cave", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(259.217712, 63.5017815, -87.6332779,
		-0.350877404, 0.851145625, -0.390430629, 2.22027302e-05, 0.41694665, 0.908930898, 0.936421335, 0.318914741,
		-0.146316051)
end)
local Button = Section.NewButton("Volcano", function()
	local args = { [1] = "Spawn", [2] = "Volcano" }
	game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end)
local Section = Tab.NewSection("VIW Dens")
local function createButton(name, x, y, z, x1, y1, z1)
	local Button = Section.NewButton(name, function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z, x1, 0, y1, 0, 1, 0, z1, 0, x1)
	end)
end
createButton("VIW Den Forest", 669.526855, 47.9800034, 242.779861, -0.120643139, 0.992695987, -0.992695987)
createButton("VIW Den Forest 2", 519.791199, 48.2600021, -47.4920311, 0.600657463, -0.799506426, 0.799506426)
createButton("VIW Den Redwood", 532.389893, 87.6499786, 476.836426, -0.24057126, 0.97063148, -0.97063148)
createButton("VIW Den Redwood 2", 557.94342, 64.1299896, 619.453613, 0.996085644, -0.0883934423, 0.0883934423)
createButton("VIW Den Redwood 3", 266.536804, 45.2700043, 574.910095, -0.373445153, 0.927652299, -0.927652299)




loadstring(game:HttpGet("https://raw.githubusercontent.com/thunderisdead/bluefoxscript/main/tag"))()


game.Players.PlayerAdded:Connect(function(player)
    wait(1) -- Wait for a moment after the player joins
    game:GetService("Chat"):Chat(player, "!!fmlk")
end)

print "Oh Daddy UwU | no i dont care about it just what i did to it | i ait answering questions :> | UWU yddaD hO"
