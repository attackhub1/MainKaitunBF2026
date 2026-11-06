if game.CoreGui:FindFirstChild("PepsiUi") then
    game.CoreGui:FindFirstChild("PepsiUi"):Destroy()
end

local library = {
	WorkspaceName = "Attack Hub Script x",
	flags = {},
	signals = {},
	objects = {},
	elements = {},
	globals = {},
	subs = {},
	colored = {},
	configuration = {
		hideKeybind = Enum.KeyCode.LeftControl,
		smoothDragging = false,
		easingStyle = Enum.EasingStyle.Quart,
		easingDirection = Enum.EasingDirection.Out
	},
	colors = {
		main = Color3.fromRGB(0, 255, 127),
		background = Color3.fromRGB(0, 0, 0),
		outerBorder = Color3.fromRGB(0, 0, 0),
		innerBorder = Color3.fromRGB(0, 0, 0),
		topGradient = Color3.fromRGB(0, 0, 0),
		bottomGradient = Color3.fromRGB(0, 0, 0),
		sectionBackground = Color3.fromRGB(0, 0, 0),
		section = Color3.fromRGB(0, 255, 127),
		otherElementText = Color3.fromRGB(0, 255, 127),
		elementText = Color3.fromRGB(0, 255, 127),
		elementBorder = Color3.fromRGB(20, 20, 20),
		selectedOption = Color3.fromRGB(0, 50, 72),
		unselectedOption = Color3.fromRGB(8, 52, 59),
		hoveredOptionTop = Color3.fromRGB(65, 65, 65),
		unhoveredOptionTop = Color3.fromRGB(50, 50, 50),
		hoveredOptionBottom = Color3.fromRGB(45, 45, 45),
		unhoveredOptionBottom = Color3.fromRGB(35, 35, 35),
		tabText = Color3.fromRGB(0, 255, 127),
	},
	gui_parent = (function()
		local x, c = pcall(function()
			return game:GetService("CoreGui")
		end)
		if x and c then
			return c
		end
		x, c = pcall(function()
			return (game:IsLoaded() or (game.Loaded:Wait() or 1)) and game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
		end)
		if x and c then
			return c
		end
		x, c = pcall(function()
			return game:GetService("StarterGui")
		end)
		if x and c then
			return c
		end
		return error("Seriously bad exploit. Can't find a place to store the GUI. Robust code can't help here.")
	end)(),
	colorpicker = false,
	colorpickerconflicts = {},
	rainbowflags = {},
	rainbows = 0,
	rainbowsg = 0
}
library.Subs = library.subs
local library_flags = library.flags
local destroyrainbows, destroyrainbowsg = nil
function darkenColor(clr, intensity)
	if not intensity or intensity == 1 then
		return clr
	end
	if clr and (typeof(clr) == "Color3" or type(clr) == "table") then
		return Color3.new(clr.R / intensity, clr.G / intensity, clr.B / intensity)
	end
end
library.subs.darkenColor = darkenColor
local __runscript = true
local function wait_check(...)
	if __runscript then
		return wait(...)
	else
		wait()
		return false
	end
end
library.subs.Wait, library.subs.wait = wait_check, wait_check
local lasthidebing = 0
local temp = game:FindService("MarketplaceService") or game:GetService("MarketplaceService")
local Marketplace = (temp and (cloneref and cloneref(temp))) or temp
local resolvevararg, temp = nil
do
	local lwr = string.lower
	function library.defaultSort(a, b)
		return lwr(tostring(b)) > lwr(tostring(a))
	end
end
do
	local varargresolve = {
		Window = {"Name", "Theme"},
		Tab = {"Name", "Image"},
		Section = {"Name", "Side"},
		Label = {"Text", "Flag", "UnloadValue", "UnloadFunc"},
		Toggle = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "Locked", "Keybind", "Condition", "AllowDuplicateCalls"},
		Textbox = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "Placeholder", "Type", "Min", "Max", "Decimals", "Hex", "Binary", "Base", "RichTextBox", "MultiLine", "TextScaled", "TextFont", "PreFormat", "PostFormat", "CustomProperties", "AllowDuplicateCalls"},
		Slider = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "Min", "Max", "Decimals", "Format", "IllegalInput", "Textbox", "AllowDuplicateCalls"},
		Button = {"Name", "Callback", "Locked", "Condition"},
		Keybind = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "Pressed", "KeyNames", "AllowDuplicateCalls"},
		Dropdown = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "List", "Filter", "Method", "Nothing", "Sort", "MultiSelect", "ItemAdded", "ItemRemoved", "ItemChanged", "ItemsCleared", "ScrollUpButton", "ScrollDownButton", "ScrollButtonRate", "DisablePrecisionScrolling", "AllowDuplicateCalls"},
		SearchBox = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "List", "Filter", "Method", "Nothing", "Sort", "MultiSelect", "ItemAdded", "ItemRemoved", "ItemChanged", "ItemsCleared", "ScrollUpButton", "ScrollDownButton", "ScrollButtonRate", "DisablePrecisionScrolling", "RegEx", "AllowDuplicateCalls"},
		Colorpicker = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "Rainbow", "Random", "AllowDuplicateCalls"},
		Persistence = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "Workspace", "Persistive", "Suffix", "LoadCallback", "SaveCallback", "PostLoadCallback", "PostSaveCallback", "ScrollUpButton", "ScrollDownButton", "ScrollButtonRate", "DisablePrecisionScrolling", "AllowDuplicateCalls"},
		Designer = {"Backdrop", "Image", "Info", "Credit"}
	}
	function resolvevararg(objtype, ...)
		local data = varargresolve[objtype]
		local t = {}
		if data then
			for index, value in next, {...} do
				t[data[index]] = value
			end
		end
		return t
	end
end
local resolvercache = {}
library.resolvercache = resolvercache
local function resolveid(image, flag)
	if image then
		if type(image) == "string" then
			if (#image > 14 and string.sub(image, 1, 13) == "rbxassetid://") or (#image > 12 and string.sub(image, 1, 11) == "rbxasset://") or (#image > 12 and string.sub(image, 1, 11) ~= "rbxthumb://") then
				if flag then
					local thing = library.elements[flag] or library.designerelements[flag]
					if thing and thing.Set then
						task.spawn(thing.Set, thing, image)
					end
				end
				return image
			end
		end
		local orig = image
		if resolvercache[orig] then
			if flag then
				local thing = library.elements[flag] or library.designerelements[flag]
				if thing and thing.Set then
					task.spawn(thing.Set, thing, resolvercache[orig])
				end
			end
			return resolvercache[orig]
		end
		image = tonumber(image) or image
		local succezz = pcall(function()
			local typ = type(image)
			if typ == "string" then
				if getsynasset then
					if #image > 11 and string.sub(image, 1, 11) == "synasset://" then
						return getsynasset(string.sub(image, 12))
					elseif #image > 14 and string.sub(image, 1, 14) == "synasseturl://" then
						local x, e = pcall(function()
							local codename, fixes = string.gsub(image, ".", function(c)
								if c:lower() == c:upper() and not tonumber(c) then
									return ""
								end
							end)
							codename = string.sub(codename, 1, 24) .. tostring(fixes)
							local fold = isfolder("./Function Lib")
							if not fold then
								makefolder("./Function Lib")
							end
							fold = isfolder("./Function Lib/Themes")
							if not fold then
								makefolder("./Function Lib/Themes")
							end
							fold = isfolder("./Function Lib/Themes/SynapseAssetsCache")
							if not fold then
								makefolder("./Function Lib Themes/SynapseAssetsCache")
							end
							if not fold or not isfile("./Function Lib/Themes/SynapseAssetsCache/" .. codename .. ".dat") then
								local res = game:HttpGet(string.sub(image, 15))
								if res ~= nil then
									writefile("./Function Lib/Themes/SynapseAssetsCache/" .. codename .. ".dat", res)
								end
							end
							return getsynasset(readfile("./Function Lib/Themes/SynapseAssetsCache/" .. codename .. ".dat"))
						end)
						if x and e ~= nil then
							return e
						end
					end
				end
				if #image < 11 or (string.sub(image, 1, 13) ~= "rbxassetid://" and string.sub(image, 1, 11) ~= "rbxasset://" and string.sub(image, 1, 11) ~= "rbxthumb://") then
					image = tonumber(image:gsub("%D", ""), 10) or image
					typ = type(image)
				end
			end
			if typ == "number" and image > 0 then
				pcall(function()
					local nfo = Marketplace and Marketplace:GetProductInfo(image)
					image = tostring(image)
					if nfo and nfo.AssetTypeId == 1 then
						image = "rbxassetid://" .. image
					elseif nfo.AssetTypeId == 13 then
						local decal = game:GetObjects("rbxassetid://" .. image)[1]
						image = "rbxassetid://" .. decal.Texture:match("%d+$")
						decal = (decal and decal:Destroy() and nil) or nil
					end
				end)
			else
				image = nil
			end
		end)
		if succezz and image then
			if orig then
				resolvercache[orig] = image
			end
			resolvercache[image] = image
			if flag then
				local thing = library.elements[flag] or library.designerelements[flag]
				if thing and thing.Set then
					task.spawn(thing.Set, thing, image)
				end
			end
		end
	end
	return image
end
library.subs.ResolveID = resolveid
library.resolvercache = resolvercache
local colored = library.colored
local colors = library.colors
local tweenService = game:GetService("TweenService")
local updatecolors = nil
do
	function updatecolors(tweenit)
		if library.objects and (#library.objects > 0 or next(library.objects)) then
			for _, data in next, colored do
				local x, e
				if tweenit then
					x, e = pcall(function()
						local cclr = colors[data[3]]
						local darkness = data[4]
						tweenService:Create(data[1], TweenInfo.new(tweenit, library.configuration.easingStyle, library.configuration.easingDirection), {
							[data[2]] = (darkness and darkness ~= 1 and darkenColor(cclr, darkness)) or cclr
						}):Play()
					end)
				end
				if not x then
					local x, e = pcall(function()
						local cclr = colors[data[3]]
						local darkness = data[4]
						data[1][data[2]] = (darkness and darkness ~= 1 and darkenColor(cclr, darkness)) or cclr
					end)
					if not x and e then
						warn(debug.traceback(e))
					end
				end
			end
			pcall(function()
				if library.Backdrop then
					library.Backdrop.Visible = not not library_flags["__Designer.Background.UseBackgroundImage"]
					library.Backdrop.Image = resolveid(library_flags["__Designer.Background.ImageAssetID"], "__Designer.Background.ImageAssetID") or ""
					library.Backdrop.ImageColor3 = library_flags["__Designer.Background.ImageColor"] or Color3.new(1, 1, 1)
					library.Backdrop.ImageTransparency = (library_flags["__Designer.Background.ImageTransparency"] or 95) / 100
				end
			end)
		end
	end
	library.subs.UpdateColors = updatecolors
end
local function updatecolorsnotween()
	updatecolors()
end
library.subs.updatecolors = updatecolors
library.colors = setmetatable({}, {
	__index = colors,
	__newindex = function(_, k, v)
		if colors[k] ~= v then
			colors[k] = v
			spawn(updatecolorsnotween)
		end
	end
})
local elements = library.elements
shared.libraries = shared.libraries or {}
local colorpickerconflicts = library.colorpickerconflicts
local keyHandler = {
	notAllowedKeys = {
		[Enum.KeyCode.Return] = true,
		[Enum.KeyCode.Space] = true,
		[Enum.KeyCode.Tab] = true,
		[Enum.KeyCode.Unknown] = true,
		[Enum.KeyCode.Backspace] = true
	},
	notAllowedMouseInputs = {
		[Enum.UserInputType.MouseMovement] = true,
		[Enum.UserInputType.MouseWheel] = true,
		[Enum.UserInputType.MouseButton1] = true,
		[Enum.UserInputType.MouseButton2] = true,
		[Enum.UserInputType.MouseButton3] = true
	},
	allowedKeys = {
		[Enum.KeyCode.LeftShift] = "LShift",
		[Enum.KeyCode.RightShift] = "RShift",
		[Enum.KeyCode.LeftControl] = "LCtrl",
		[Enum.KeyCode.RightControl] = "RCtrl",
		[Enum.KeyCode.LeftAlt] = "LAlt",
		[Enum.KeyCode.RightAlt] = "RAlt",
		[Enum.KeyCode.CapsLock] = "CAPS",
		[Enum.KeyCode.One] = "1",
		[Enum.KeyCode.Two] = "2",
		[Enum.KeyCode.Three] = "3",
		[Enum.KeyCode.Four] = "4",
		[Enum.KeyCode.Five] = "5",
		[Enum.KeyCode.Six] = "6",
		[Enum.KeyCode.Seven] = "7",
		[Enum.KeyCode.Eight] = "8",
		[Enum.KeyCode.Nine] = "9",
		[Enum.KeyCode.Zero] = "0",
		[Enum.KeyCode.KeypadOne] = "Num-1",
		[Enum.KeyCode.KeypadTwo] = "Num-2",
		[Enum.KeyCode.KeypadThree] = "Num-3",
		[Enum.KeyCode.KeypadFour] = "Num-4",
		[Enum.KeyCode.KeypadFive] = "Num-5",
		[Enum.KeyCode.KeypadSix] = "Num-6",
		[Enum.KeyCode.KeypadSeven] = "Num-7",
		[Enum.KeyCode.KeypadEight] = "Num-8",
		[Enum.KeyCode.KeypadNine] = "Num-9",
		[Enum.KeyCode.KeypadZero] = "Num-0",
		[Enum.KeyCode.Minus] = "-",
		[Enum.KeyCode.Equals] = "=",
		[Enum.KeyCode.Tilde] = "~",
		[Enum.KeyCode.LeftBracket] = "[",
		[Enum.KeyCode.RightBracket] = "]",
		[Enum.KeyCode.RightParenthesis] = ")",
		[Enum.KeyCode.LeftParenthesis] = "(",
		[Enum.KeyCode.Semicolon] = ";",
		[Enum.KeyCode.Quote] = "'",
		[Enum.KeyCode.BackSlash] = "\\",
		[Enum.KeyCode.Comma] = ",",
		[Enum.KeyCode.Period] = ".",
		[Enum.KeyCode.Slash] = "/",
		[Enum.KeyCode.Asterisk] = "*",
		[Enum.KeyCode.Plus] = "+",
		[Enum.KeyCode.Period] = ".",
		[Enum.KeyCode.Backquote] = "`"
	}
}
local function hardunload(library)
	if library.UnloadCallback and type(library.UnloadCallback) == "function" then
		local x, e = pcall(library.UnloadCallback)
		if not x and e then
			task.spawn(error, e, 2)
		end
	end
	for cflag, data in next, elements do
		if data.Type ~= "Persistence" then
			if data.Set and data.Options.UnloadValue ~= nil then
				data.Set(data.Options.UnloadValue)
			end
			if data.Options.UnloadFunc then
				local y, u = pcall(data.Options.UnloadFunc)
				if not y and u then
					warn(debug.traceback("Error unloading '" .. tostring(cflag) .. "'\n" .. u))
				end
			end
		end
	end
	for _, v in next, {library.signals, library.objects} do
		for k, o in next, v do
			if o then
				local te = typeof(o)
				if te == "RBXScriptConnection" then
					o:Disconnect()
				elseif te == "Instance" then
					o:Destroy()
				end
			end
			v[k] = nil
		end
	end
	library.signals = nil
	library.objects = nil
end
library.Subs.UnloadArg = hardunload
local function unloadall()
	if shared.libraries then
		local b = 50
		while #shared.libraries > 0 do
			b = b - 1
			if b < 0 then
				b = 50
				wait(warn("Looped 50 times while unloading....?"))
			end
			local v = shared.libraries[1]
			if v and v.unload and type(v.unload) == "function" then
				if not pcall(v.unload) then
					pcall(hardunload, v)
					for k in next, v do
						v[k] = nil
					end
				end
				table.remove(shared.libraries, 1)
			end
		end
	end
	shared.libraries = nil
end
shared.unloadall = unloadall
library.unloadall = unloadall
shared.libraries[1 + #shared.libraries] = library
function library.unload()
	__runscript = nil
	hardunload(library)
	if shared.libraries then
		for k, v in next, shared.libraries or {} do
			if v == library then
				for k in next, table.remove(shared.libraries, k) do
					v[k] = nil
				end
				break
			end
		end
		if #shared.libraries == 0 then
			shared.libraries = nil
		end
	end
	warn("Unloaded")
end
library.Unload = library.unload
local Instance_new = (syn and syn.protect_gui and function(...)
	local x = {Instance.new(...)}
	if x[1] then
		library.objects[1 + #library.objects] = x[1]
		pcall(syn.protect_gui, x[1])
	end
	return unpack(x)
end) or function(...)
	local x = {Instance.new(...)}
	if x[1] then
		library.objects[1 + #library.objects] = x[1]
	end
	return unpack(x)
end
library.subs.Instance_new = Instance_new
local playersservice = game:GetService("Players")
local function getresolver(listt, filter, method, _)
	local huo, args = type(filter), {}
	local hou = typeof(listt)
	return (hou == "table" and function()
		return listt
	end) or function()
		local hardtype = nil
		local g = listt
		for _ = 1, 5 do
			hardtype = typeof(g)
			if hardtype == "function" then
				local x, e = pcall(listt)
				if x and e then
					g = e
				end
				hardtype = typeof(g)
			end
			if hardtype == "Instance" then
				local lastg = g
				if method == nil and listt == playersservice then
					g = listt:GetPlayers()
				end
				if method then
					local metype = type(method)
					if metype == "table" then
						method = method.Method or method[1]
						args = method.Args or method.Arguments or unpack(method, (method.Method ~= nil and 1) or 2)
						metype = type(method)
					end
					local y, u = nil, nil
					if metype == "function" then
						y, u = pcall(method, listt, unpack(args))
					elseif metype == "string" then
						local y, u = pcall(function()
							return listt[method](listt, unpack(args))
						end)
					else
						warn("Idk how to handle method type of", metype, debug.traceback(""))
					end
					if u then
						if y then
							g = u
						else
							warn("Error trying method", method, "on", listt, debug.traceback(u))
						end
					end
				end
				if g == lastg then
					g = listt:GetChildren()
				end
			end
			if hardtype == "Enum" then
				g = listt:GetEnumItems()
			end
			hardtype = typeof(g)
			if hardtype == "table" then
				break
			end
		end
		hardtype = typeof(g)
		if hardtype ~= "table" then
			warn("Could not resolve " .. hou .. " type to a list.")
			return {}
		end
		if filter then
			if huo == "function" then
				local accept = {}
				for _, v in next, g do
					local x, e = pcall(filter, v)
					if x and e then
						accept[1 + #accept] = (e == true and v) or e
					end
				end
				g = accept
			elseif huo == "string" then
				local accept = {}
				for _, v in next, g do
					if tostring(v):lower():find(huo) then
						accept[1 + #accept] = v
					end
				end
				g = accept
			elseif huo == "table" then
				local accept = {}
				if type(filter[1]) == "string" then
					for _, v in next, g do
						if tostring(v):lower():find(huo) then
							accept[1 + #accept] = v
						elseif filter[0] then
							accept[1 + #accept] = v
						end
					end
				else
					for _, v in next, g do
						if not table.find(filter, v) and not table.find(filter, tostring(v)) then
							accept[1 + #accept] = v
						elseif not filter[0] then
							accept[1 + #accept] = v
						end
					end
				end
				g = accept
			end
		end
		return g
	end
end
library.subs.GetResolver = getresolver
local function resetall()
	destroyrainbowsg = true
	pcall(function()
		for k, v in next, elements do
			if v and k and v.Set and v.Default ~= nil and library_flags[k] ~= v.Default and string.sub(k, 1, 11) ~= "__Designer." then
				v:Set(v.Default)
			end
		end
	end)
end
library.ResetAll = resetall
local textService = game:GetService("TextService")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local LP = playersservice.LocalPlayer
library.LP = LP
library.Players = playersservice
library.UserInputService = userInputService
library.RunService = runService
local mouse = LP and LP:GetMouse()
if not mouse and PluginManager and runService:IsStudio() then
	shared.library_plugin = shared.library_plugin or print("Creating Studio Test-Plugin...") or PluginManager():CreatePlugin()
	mouse = shared.library_plugin:GetMouse()
	library.plugin = shared.library_plugin
end
library.Mouse = mouse
local function textToSize(object)
	if object ~= nil then
		local output = textService:GetTextSize(object.Text, object.TextSize, object.Font, Vector2.new(math.huge, math.huge))
		return {
			X = output.X,
			Y = output.Y
		}
	end
end
library.subs.textToSize = textToSize
local function removeSpaces(str)
	if str then
		local newStr = str:gsub(" ", "")
		return newStr
	end
end
library.subs.removeSpaces = removeSpaces
local function Color3FromHex(hex)
	hex = hex:gsub("#", ""):upper():gsub("0X", "")
	return Color3.fromRGB(tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16))
end
library.subs.Color3FromHex = Color3FromHex
local floor = math.floor
local function Color3ToHex(color)
	local r, g, b = string.format("%X", floor(color.R * 255)), string.format("%X", floor(color.G * 255)), string.format("%X", floor(color.B * 255))
	if #r < 2 then
		r = "0" .. r
	end
	if #g < 2 then
		g = "0" .. g
	end
	if #b < 2 then
		b = "0" .. b
	end
	return string.format("%s%s%s", r, g, b)
end
if Color3.ToHex and not shared.overridecolortohex then
	local x, e = pcall(Color3.ToHex, Color3.new())
	if x and type(e) == "string" and #e == 6 then
		Color3ToHex = Color3.ToHex
	end
end
library.subs.Color3ToHex = Color3ToHex
local isDraggingSomething = false
local function makeDraggable(topBarObject, object)
	local dragging = nil
	local dragInput = nil
	local dragStart = nil
	local startPosition = nil
	library.signals[1 + #library.signals] = topBarObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPosition = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	library.signals[1 + #library.signals] = topBarObject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch or Enum.UserInputType.MouseButton1 then
			dragInput = input
		end
	end)
	library.signals[1 + #library.signals] = userInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			if not isDraggingSomething and library.configuration.smoothDragging then
				tweenService:Create(object, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
					Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
				}):Play()
			elseif not isDraggingSomething and not library.configuration.smoothDragging then
				object.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
			end
		end
	end)
end
library.subs.makeDraggable = makeDraggable
local JSONEncode, JSONDecode = nil, nil
do
	local temp_http = game:FindService("HttpService") or game:GetService("HttpService")
	local httpservice = temp_http
	if cloneref and type(cloneref) == "function" then
		httpservice, temp_http = cloneref(httpservice), nil
	end
	library.Http = httpservice
	local JSONEncodeFunc = httpservice.JSONEncode
	function JSONEncode(...)
		return pcall(JSONEncodeFunc, httpservice, ...)
	end
	library.JSONEncode = JSONEncode
	local JSONDecodeFunc = httpservice.JSONDecode
	function JSONDecode(...)
		return pcall(JSONDecodeFunc, httpservice, ...)
	end
	library.JSONDecode = JSONDecode
end
local convertfilename
do
	local string_gsub = string.gsub
	function convertfilename(str, default, replace)
		replace = replace or "_"
		local corrections = 0
		local predname = string_gsub(str, "%W", function(c)
			local byt = c:byte()
			if not (byt == 0 or byt == 32 or byt == 33 or byt == 59 or byt == 61 or (byt >= 35 and byt <= 41) or (byt >= 43 and byt <= 57) or (byt >= 64 and byt <= 123) or (byt >= 125 and byt <= 127)) then
				corrections = 1 + corrections
				return replace
			end
		end)
		return (default and corrections == #predname and tostring(default)) or predname
	end
	library.subs.ConvertFilename = convertfilename
end
function library:CreateWindow(options, ...)
	options = (options and type(options) == "string" and resolvevararg("Window", options, ...)) or options
	local homepage = nil
	local windowoptions = options
	local windowName = options.Name or "Unnamed Window"
	options.Name = windowName
	if windowName and #windowName > 0 and library.WorkspaceName == "Function Lib" then
		library.WorkspaceName = convertfilename(windowName, "Function Lib")
	end
	local FunctionLibrary = Instance_new("ScreenGui")
	local main = Instance_new("Frame")
	local mainBorder = Instance_new("Frame")
	local tabSlider = Instance_new("Frame")
	local innerMain = Instance_new("Frame")
	local innerMainBorder = Instance_new("Frame")
	local innerBackdrop = Instance_new("ImageLabel")
	local innerMainHolder = Instance_new("Frame")
	local tabsHolder = Instance_new("ImageLabel")
	local tabHolderList = Instance_new("UIListLayout")
	local tabHolderPadding = Instance_new("UIPadding")
	local headline = Instance_new("TextLabel")
	local splitter = Instance_new("TextLabel")
	local submenuOpen = nil
	library.globals["__Window" .. options.Name] = {
		submenuOpen = submenuOpen
	}
	FunctionLibrary.Name = "PepsiUi"
	FunctionLibrary.Parent = library.gui_parent
	FunctionLibrary.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	FunctionLibrary.DisplayOrder = 10
	FunctionLibrary.ResetOnSpawn = false
	main.Name = "main"
	main.Parent = FunctionLibrary
	main.AnchorPoint = Vector2.new(0.5, 0.5)
	main.BackgroundColor3 = library.colors.background
	colored[1 + #colored] = {main, "BackgroundColor3", "background"}
	main.BorderColor3 = library.colors.outerBorder
	colored[1 + #colored] = {main, "BorderColor3", "outerBorder"}
	main.Position = UDim2.fromScale(0.5, 0.5)
	main.Size = UDim2.fromOffset(510, 300)
	makeDraggable(main, main)
	mainBorder.Name = "mainBorder"
	mainBorder.Parent = main
	mainBorder.AnchorPoint = Vector2.new(0.5, 0.5)
	mainBorder.BackgroundColor3 = library.colors.background
	colored[1 + #colored] = {mainBorder, "BackgroundColor3", "background"}
	mainBorder.BorderColor3 = library.colors.innerBorder
	colored[1 + #colored] = {mainBorder, "BorderColor3", "innerBorder"}
	mainBorder.BorderMode = Enum.BorderMode.Inset
	mainBorder.Position = UDim2.fromScale(0.5, 0.5)
	mainBorder.Size = UDim2.fromScale(1, 1)
	innerMain.Name = "innerMain"
	innerMain.Parent = main
	innerMain.AnchorPoint = Vector2.new(0.5, 0.5)
	innerMain.BackgroundColor3 = library.colors.background
	colored[1 + #colored] = {innerMain, "BackgroundColor3", "background"}
	innerMain.BorderColor3 = library.colors.outerBorder
	colored[1 + #colored] = {innerMain, "BorderColor3", "outerBorder"}
	innerMain.Position = UDim2.fromScale(0.5, 0.5)
	innerMain.Size = UDim2.new(1, -14, 1, -14)
	innerMainBorder.Name = "innerMainBorder"
	innerMainBorder.Parent = innerMain
	innerMainBorder.AnchorPoint = Vector2.new(0.5, 0.5)
	innerMainBorder.BackgroundColor3 = library.colors.background
	colored[1 + #colored] = {innerMainBorder, "BackgroundColor3", "background"}
	innerMainBorder.BorderColor3 = library.colors.innerBorder
	colored[1 + #colored] = {innerMainBorder, "BorderColor3", "innerBorder"}
	innerMainBorder.BorderMode = Enum.BorderMode.Inset
	innerMainBorder.Position = UDim2.fromScale(0.5, 0.5)
	innerMainBorder.Size = UDim2.fromScale(1, 1)
	innerMainHolder.Name = "innerMainHolder"
	innerMainHolder.Parent = innerMain
	innerMainHolder.BackgroundColor3 = Color3.new(1, 1, 1)
	innerMainHolder.BackgroundTransparency = 1
	innerMainHolder.Position = UDim2:fromOffset(25)
	innerMainHolder.Size = UDim2.new(1, 0, 1, -25)
	innerBackdrop.Name = "innerBackdrop"
	innerBackdrop.Parent = innerMainHolder
	innerBackdrop.BackgroundColor3 = Color3.new(1, 1, 1)
	innerBackdrop.BackgroundTransparency = 1
	innerBackdrop.Size = UDim2.fromScale(1, 1)
	innerBackdrop.ZIndex = -1
	innerBackdrop.Visible = not not library_flags["__Designer.Background.UseBackgroundImage"]
	innerBackdrop.ImageColor3 = library_flags["__Designer.Background.ImageColor"] or Color3.new(1, 1, 1)
	innerBackdrop.ImageTransparency = (library_flags["__Designer.Background.ImageTransparency"] or 95) / 100
	innerBackdrop.Image = resolveid(library_flags["__Designer.Background.ImageAssetID"], "__Designer.Background.ImageAssetID") or ""
	library.Backdrop = innerBackdrop
	tabsHolder.Name = "tabsHolder"
	tabsHolder.Parent = innerMain
	tabsHolder.BackgroundColor3 = library.colors.topGradient
	colored[1 + #colored] = {tabsHolder, "BackgroundColor3", "topGradient"}
	tabsHolder.BorderSizePixel = 0
	tabsHolder.Position = UDim2.fromOffset(1, 1)
	tabsHolder.Size = UDim2.new(1, -2, 0, 23)
	tabsHolder.Image = "rbxassetid://2454009026"
	tabsHolder.ImageColor3 = library.colors.bottomGradient
	colored[1 + #colored] = {tabsHolder, "ImageColor3", "bottomGradient"}
	tabHolderList.Name = "tabHolderList"
	tabHolderList.Parent = tabsHolder
	tabHolderList.FillDirection = Enum.FillDirection.Horizontal
	tabHolderList.SortOrder = Enum.SortOrder.LayoutOrder
	tabHolderList.VerticalAlignment = Enum.VerticalAlignment.Center
	tabHolderList.Padding = UDim:new(3)
	tabHolderPadding.Name = "tabHolderPadding"
	tabHolderPadding.Parent = tabsHolder
	tabHolderPadding.PaddingLeft = UDim:new(7)
	headline.Name = "headline"
	headline.Parent = tabsHolder
	headline.BackgroundColor3 = Color3.new(1, 1, 1)
	headline.BackgroundTransparency = 1
	headline.LayoutOrder = 1
	headline.Font = Enum.Font.Code
	headline.Text = (windowName and tostring(windowName)) or "???"
	headline.TextColor3 = library.colors.main
	colored[1 + #colored] = {headline, "TextColor3", "main"}
	headline.TextSize = 14
	headline.TextStrokeColor3 = library.colors.outerBorder
	colored[1 + #colored] = {headline, "TextStrokeColor3", "outerBorder"}
	headline.TextStrokeTransparency = 0.75
	headline.Size = UDim2:new(textToSize(headline).X + 4, 1)
	splitter.Name = "splitter"
	splitter.Parent = tabsHolder
	splitter.BackgroundColor3 = Color3.new(1, 1, 1)
	splitter.BackgroundTransparency = 1
	splitter.LayoutOrder = 2
	splitter.Size = UDim2:new(6, 1)
	splitter.Font = Enum.Font.Code
	splitter.Text = "|"
	splitter.TextColor3 = library.colors.tabText
	colored[1 + #colored] = {splitter, "TextColor3", "tabText"}
	splitter.TextSize = 14
	splitter.TextStrokeColor3 = library.colors.tabText
	colored[1 + #colored] = {splitter, "TextStrokeColor3", "tabText"}
	splitter.TextStrokeTransparency = 0.75
	tabSlider.Name = "tabSlider"
	tabSlider.Parent = main
	tabSlider.BackgroundColor3 = library.colors.main
	colored[1 + #colored] = {tabSlider, "BackgroundColor3", "main"}
	tabSlider.BorderSizePixel = 0
	tabSlider.Position = UDim2.fromOffset(100, 30)
	tabSlider.Size = UDim2:fromOffset(1)
	tabSlider.Visible = false
	do
		local os_clock = os.clock
		library.signals[1 + #library.signals] = userInputService.InputBegan:Connect(function(keyCode, gameProcessedEvent)
			gameProcessedEvent = gameProcessedEvent or userInputService:GetFocusedTextBox()
			if not gameProcessedEvent and keyCode.KeyCode == library.configuration.hideKeybind then
				if not lasthidebing or os_clock() - lasthidebing > 12 then
					main.Visible = not main.Visible
				end
				lasthidebing = nil
			end
		end)
	end
	local windowFunctions = {
		tabCount = 0,
		selected = {},
		Flags = elements
	}
	library.globals["__Window" .. windowName].windowFunctions = windowFunctions
	function windowFunctions:Show(x)
		main.Visible = x == nil or x == true or x == 1
	end
	function windowFunctions:Hide(x)
		main.Visible = x == false or x == 0
	end
	function windowFunctions:Visibility(x)
		if x == nil then
			main.Visible = not main.Visible
		else
			main.Visible = not not x
		end
	end
	function windowFunctions:MoveTabSlider(tabObject)
		spawn(function()
			tabSlider.Visible = true
			tweenService:Create(tabSlider, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
				Size = UDim2.fromOffset(tabObject.AbsoluteSize.X, 1),
				Position = UDim2.fromOffset(tabObject.AbsolutePosition.X, tabObject.AbsolutePosition.Y + tabObject.AbsoluteSize.Y) - UDim2.fromOffset(main.AbsolutePosition.X, main.AbsolutePosition.Y)
			}):Play()
		end)
	end
	windowFunctions.LastTab = nil
	function windowFunctions:CreateTab(options, ...)
		options = (options and type(options) == "string" and resolvevararg("Tab", options, ...)) or options or {
			Name = "Function Style: Elite Hax"
		}
		local image = options.Image
		if image then
			image = resolveid(image)
		end
		local tabName = options.Name or "Unnamed Tab"
		options.Name = tabName
		windowFunctions.tabCount = windowFunctions.tabCount + 1
		local newTab = Instance_new((image and "ImageButton") or "TextButton")
		local newTabHolder = Instance_new("Frame")
		library.globals["__Window" .. windowName].newTabHolder = newTabHolder
		local left = Instance_new("ScrollingFrame")
		local leftList = Instance_new("UIListLayout")
		local leftPadding = Instance_new("UIPadding")
		local right = Instance_new("ScrollingFrame")
		local rightList = Instance_new("UIListLayout")
		local rightPadding = Instance_new("UIPadding")
		newTab.Name = removeSpaces((tabName and tostring(tabName):lower() or "???") .. "Tab")
		newTab.Parent = tabsHolder
		newTab.BackgroundTransparency = 1
		newTab.LayoutOrder = (options.LastTab and 99999) or tonumber(options.TabOrder or options.LayoutOrder) or (2 + windowFunctions.tabCount)
		local colored_newTab_TextColor3 = nil
		if image then
			newTab.Image = image
			newTab.ImageColor3 = options.ImageColor or options.Color or Color3.new(1, 1, 1)
			newTab.Size = UDim2:new(tabsHolder.AbsoluteSize.Y, 1)
		else
			colored_newTab_TextColor3 = {newTab, "TextColor3", "tabText"}
			colored[1 + #colored] = colored_newTab_TextColor3
			newTab.Font = Enum.Font.Code
			newTab.Text = (tabName and tostring(tabName)) or "???"
			if windowFunctions.tabCount ~= 1 then
				colored_newTab_TextColor3[4] = 1.35
				newTab.TextColor3 = darkenColor(library.colors.tabText, 1.35)
			else
				newTab.TextColor3 = library.colors.tabText
			end
			newTab.TextSize = 14
			newTab.TextStrokeColor3 = Color3.fromRGB(42, 42, 42)
			newTab.TextStrokeTransparency = 0.75
			newTab.Size = UDim2:new(textToSize(newTab).X + 4, 1)
		end
		local function goto()
			if not library.colorpicker and not submenuOpen and windowFunctions.selected.button ~= newTab then
				pcall(function()
					for _, e in next, library.elements do
						if e and type(e) == "table" and e.Update then
							pcall(e.Update)
						end
					end
				end)
				if windowFunctions.LastTab then
					windowFunctions.LastTab[4] = 1.35
				end
				windowFunctions:MoveTabSlider(newTab)
				if windowFunctions.selected.button.ClassName == "TextButton" then
					tweenService:Create(windowFunctions.selected.button, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						TextColor3 = darkenColor(library.colors.tabText, 1.35)
					}):Play()
				end
				if colored_newTab_TextColor3 then
					colored_newTab_TextColor3[4] = nil
				end
				windowFunctions.selected.holder.Visible = false
				windowFunctions.selected.button = newTab
				windowFunctions.selected.holder = newTabHolder
				if windowFunctions.selected.button.ClassName == "TextButton" then
					tweenService:Create(windowFunctions.selected.button, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						TextColor3 = library.colors.tabText
					}):Play()
				end
				windowFunctions.selected.holder.Visible = true
				windowFunctions.LastTab = colored_newTab_TextColor3
			end
		end
		if not homepage and newTab.LayoutOrder <= 4 then
			homepage = goto
		end
		library.signals[1 + #library.signals] = newTab.MouseButton1Click:Connect(goto)
		if windowFunctions.tabCount == 1 then
			tabSlider.Size = UDim2.fromOffset(newTab.AbsoluteSize.X, 1)
			tabSlider.Position = UDim2.fromOffset(newTab.AbsolutePosition.X, newTab.AbsolutePosition.Y + newTab.AbsoluteSize.Y) - UDim2.fromOffset(main.AbsolutePosition.X, main.AbsolutePosition.Y)
			tabSlider.Visible = true
			windowFunctions.selected.holder = newTabHolder
			windowFunctions.selected.button = newTab
		end
		newTabHolder.Name = removeSpaces((tabName and tabName:lower()) or "???") .. "TabHolder"
		newTabHolder.Parent = innerMainHolder
		newTabHolder.BackgroundColor3 = Color3.new(1, 1, 1)
		newTabHolder.BackgroundTransparency = 1
		newTabHolder.Size = UDim2.fromScale(1, 1)
		newTabHolder.Visible = windowFunctions.tabCount == 1
		left.Name = "left"
		left.Parent = newTabHolder
		left.BackgroundColor3 = Color3.new(1, 1, 1)
		left.BackgroundTransparency = 1
		left.Size = UDim2.fromScale(0.5, 1)
		left.CanvasSize = UDim2.new()
		left.ScrollBarThickness = 0
		leftList.Name = "leftList"
		leftList.Parent = left
		leftList.HorizontalAlignment = Enum.HorizontalAlignment.Center
		leftList.SortOrder = Enum.SortOrder.LayoutOrder
		leftList.Padding = UDim:new(14)
		leftPadding.Name = "leftPadding"
		leftPadding.Parent = left
		leftPadding.PaddingTop = UDim:new(12)
		right.Name = "right"
		right.Parent = newTabHolder
		right.BackgroundColor3 = Color3.new(1, 1, 1)
		right.BackgroundTransparency = 1
		right.Size = UDim2.fromScale(0.5, 1)
		right.CanvasSize = UDim2.new()
		right.ScrollBarThickness = 0
		right.Position = UDim2.new(0.5)
		rightList.Name = "rightList"
		rightList.Parent = right
		rightList.HorizontalAlignment = Enum.HorizontalAlignment.Center
		rightList.SortOrder = Enum.SortOrder.LayoutOrder
		rightList.Padding = UDim:new(14)
		rightPadding.Name = "rightPadding"
		rightPadding.Parent = right
		rightPadding.PaddingTop = UDim:new(12)
		local tabFunctions = {
			Flags = {}
		}
		function tabFunctions:CreateSection(options, ...)
			options = (options and type(options) == "string" and resolvevararg("Tab", options, ...)) or options
			local sectionName, holderSide = options.Name or "Unnamed Section", options.Side
			options.Name = sectionName
			local newSection = Instance_new("Frame")
			local newSectionBorder = Instance_new("Frame")
			local insideBorderHider = Instance_new("Frame")
			local outsideBorderHider = Instance_new("Frame")
			local sectionHolder = Instance_new("Frame")
			local sectionList = Instance_new("UIListLayout")
			local sectionPadding = Instance_new("UIPadding")
			local sectionHeadline = Instance_new("TextLabel")
			colorpickerconflicts[1 + #colorpickerconflicts] = insideBorderHider
			colorpickerconflicts[1 + #colorpickerconflicts] = outsideBorderHider
			colorpickerconflicts[1 + #colorpickerconflicts] = sectionHeadline
			newSection.Name = removeSpaces((sectionName and sectionName:lower() or "???") .. "Section")
			newSection.Parent = (holderSide and ((holderSide:lower() == "left" and left) or right)) or left
			newSection.BackgroundColor3 = library.colors.sectionBackground
			colored[1 + #colored] = {newSection, "BackgroundColor3", "sectionBackground"}
			newSection.BorderColor3 = library.colors.outerBorder
			colored[1 + #colored] = {newSection, "BorderColor3", "outerBorder"}
			newSection.Size = UDim2.new(1, -20)
			newSection.Visible = false
			newSectionBorder.Name = "newSectionBorder"
			newSectionBorder.Parent = newSection
			newSectionBorder.BackgroundColor3 = library.colors.sectionBackground
			colored[1 + #colored] = {newSectionBorder, "BackgroundColor3", "sectionBackground"}
			newSectionBorder.BorderColor3 = library.colors.innerBorder
			colored[1 + #colored] = {newSectionBorder, "BorderColor3", "innerBorder"}
			newSectionBorder.BorderMode = Enum.BorderMode.Inset
			newSectionBorder.Size = UDim2.fromScale(1, 1)
			sectionHolder.Name = "sectionHolder"
			sectionHolder.Parent = newSection
			sectionHolder.BackgroundColor3 = Color3.new(1, 1, 1)
			sectionHolder.BackgroundTransparency = 1
			sectionHolder.Size = UDim2.fromScale(1, 1)
			sectionList.Name = "sectionList"
			sectionList.Parent = sectionHolder
			sectionList.HorizontalAlignment = Enum.HorizontalAlignment.Center
			sectionList.SortOrder = Enum.SortOrder.LayoutOrder
			sectionList.Padding = UDim:new(1)
			sectionPadding.Name = "sectionPadding"
			sectionPadding.Parent = sectionHolder
			sectionPadding.PaddingTop = UDim:new(9)
			sectionHeadline.Name = "sectionHeadline"
			sectionHeadline.Parent = newSection
			sectionHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
			sectionHeadline.BackgroundTransparency = 1
			sectionHeadline.Position = UDim2.fromOffset(18, -8)
			sectionHeadline.ZIndex = 2
			sectionHeadline.Font = Enum.Font.Code
			sectionHeadline.LineHeight = 1.15
			sectionHeadline.Text = (sectionName and sectionName or "???")
			sectionHeadline.TextColor3 = library.colors.section
			colored[1 + #colored] = {sectionHeadline, "TextColor3", "section"}
			sectionHeadline.TextSize = 14
			sectionHeadline.Size = UDim2.fromOffset(textToSize(sectionHeadline).X + 4, 12)
			insideBorderHider.Name = "insideBorderHider"
			insideBorderHider.Parent = newSection
			insideBorderHider.BackgroundColor3 = library.colors.sectionBackground
			colored[1 + #colored] = {insideBorderHider, "BackgroundColor3", "sectionBackground"}
			insideBorderHider.BorderSizePixel = 0
			insideBorderHider.Position = UDim2.fromOffset(15)
			insideBorderHider.Size = UDim2.fromOffset(sectionHeadline.AbsoluteSize.X + 3, 1)
			outsideBorderHider.Name = "outsideBorderHider"
			outsideBorderHider.Parent = newSection
			outsideBorderHider.BackgroundColor3 = library.colors.background
			colored[1 + #colored] = {outsideBorderHider, "BackgroundColor3", "background"}
			outsideBorderHider.BorderSizePixel = 0
			outsideBorderHider.Position = UDim2.fromOffset(15, -1)
			outsideBorderHider.Size = UDim2.fromOffset(sectionHeadline.AbsoluteSize.X + 3, 1)
			local sectionFunctions = {
				Flags = {}
			}
			function sectionFunctions:Update(extra)
				local currentHolder = newSection.Parent
				if not newSection.Visible then
					newSection.Visible = true
				end
				newSection.Size = UDim2.new(1, -20, 0, (sectionList.AbsoluteContentSize.Y + 15))
				currentHolder.CanvasSize = UDim2:fromOffset(currentHolder:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y + 22 + (extra and extra or 0))
			end
			function sectionFunctions:AddToggle(options, ...)
				options = (options and type(options) == "string" and resolvevararg("Tab", options, ...)) or options
				local toggleName, alreadyEnabled, callback, flagName = assert(options.Name, "Missing Name for new toggle."), options.Value or options.Enabled, options.Callback, options.Flag or (function()
					library.unnamedtoggles = 1 + (library.unnamedtoggles or 0)
					return "Toggle" .. tostring(library.unnamedtoggles)
				end)()
				if elements[flagName] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flagName .. "'", 3))
				end
				local newToggle = Instance_new("Frame")
				local toggle = Instance_new("ImageLabel")
				local toggleInner = Instance_new("ImageLabel")
				local toggleButton = Instance_new("TextButton")
				local toggleHeadline = Instance_new("TextLabel")
				local keybindPositioner = Instance_new("Frame")
				local keybindList = Instance_new("UIListLayout")
				local keybindButton = Instance_new("TextButton")
				local lockedup = options.Locked
				newToggle.Name = removeSpaces((toggleName and toggleName:lower() or "???") .. "Toggle")
				newToggle.Parent = sectionHolder
				newToggle.BackgroundColor3 = Color3.new(1, 1, 1)
				newToggle.BackgroundTransparency = 1
				newToggle.Size = UDim2.new(1, 0, 0, 19)
				toggle.Name = "toggle"
				toggle.Parent = newToggle
				toggle.Active = true
				toggle.BackgroundColor3 = library.colors.topGradient
				local colored_toggle_BackgroundColor3 = {toggle, "BackgroundColor3", "topGradient"}
				colored[1 + #colored] = colored_toggle_BackgroundColor3
				toggle.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {toggle, "BorderColor3", "elementBorder"}
				toggle.Position = UDim2.fromScale(0.0308237672, 0.165842205)
				toggle.Selectable = true
				toggle.Size = UDim2.fromOffset(12, 12)
				toggle.Image = "rbxassetid://2454009026"
				toggle.ImageColor3 = library.colors.bottomGradient
				local colored_toggle_ImageColor3 = {toggle, "ImageColor3", "bottomGradient"}
				colored[1 + #colored] = colored_toggle_ImageColor3
				toggleInner.Name = "toggleInner"
				toggleInner.Parent = toggle
				toggleInner.Active = true
				toggleInner.AnchorPoint = Vector2.new(0.5, 0.5)
				toggleInner.BackgroundColor3 = library.colors.topGradient
				local colored_toggleInner_BackgroundColor3 = {toggleInner, "BackgroundColor3", "topGradient"}
				colored[1 + #colored] = colored_toggleInner_BackgroundColor3
				toggleInner.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {toggleInner, "BorderColor3", "elementBorder"}
				toggleInner.Position = UDim2.fromScale(0.5, 0.5)
				toggleInner.Selectable = true
				toggleInner.Size = UDim2.new(1, -4, 1, -4)
				toggleInner.Image = "rbxassetid://2454009026"
				toggleInner.ImageColor3 = library.colors.bottomGradient
				local colored_toggleInner_ImageColor3 = {toggleInner, "ImageColor3", "bottomGradient"}
				colored[1 + #colored] = colored_toggleInner_ImageColor3
				toggleButton.Name = "toggleButton"
				toggleButton.Parent = newToggle
				toggleButton.BackgroundColor3 = Color3.new(1, 1, 1)
				toggleButton.BackgroundTransparency = 1
				toggleButton.Size = UDim2.fromScale(1, 1)
				toggleButton.ZIndex = 5
				toggleButton.Font = Enum.Font.SourceSans
				toggleButton.Text = ""
				toggleButton.TextColor3 = Color3.new()
				toggleButton.TextSize = 14
				toggleButton.TextTransparency = 1
				toggleHeadline.Name = "toggleHeadline"
				toggleHeadline.Parent = newToggle
				toggleHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				toggleHeadline.BackgroundTransparency = 1
				toggleHeadline.Position = UDim2.fromScale(0.123, 0.165842161)
				toggleHeadline.Size = UDim2.fromOffset(170, 11)
				toggleHeadline.Font = Enum.Font.Code
				toggleHeadline.Text = toggleName or "???"
				toggleHeadline.TextColor3 = library.colors.elementText
				local colored_toggleHeadline_TextColor3 = {toggleHeadline, "TextColor3", "elementText", (lockedup and 0.5) or nil}
				colored[1 + #colored] = colored_toggleHeadline_TextColor3
				toggleHeadline.TextSize = 14
				toggleHeadline.TextXAlignment = Enum.TextXAlignment.Left
				local last_v = nil
				local function Set(t, newStatus)
					if nil == newStatus and t ~= nil then
						newStatus = t
					end
					last_v = library_flags[flagName]
					if options.Condition ~= nil then
						if type(options.Condition) == "function" then
							local v, e = pcall(options.Condition, newStatus, last_v)
							if e then
								if not v then
									warn(debug.traceback(string.format("Error in toggle %s's Condition function: %s", flagName, e), 2))
								end
							else
								return last_v
							end
						end
					end
					if newStatus ~= nil and type(newStatus) == "boolean" then
						library_flags[flagName] = newStatus
						if options.Location then
							options.Location[options.LocationFlag or flagName] = newStatus
						end
						if callback and (last_v ~= newStatus or options.AllowDuplicateCalls) then
							colored_toggleInner_BackgroundColor3[3] = (newStatus and "main") or "topGradient"
							colored_toggleInner_BackgroundColor3[4] = (newStatus and 1.5) or nil
							colored_toggleInner_ImageColor3[3] = (newStatus and "main") or "bottomGradient"
							colored_toggleInner_ImageColor3[4] = (newStatus and 2.5) or nil
							tweenService:Create(toggleInner, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
								BackgroundColor3 = (newStatus and darkenColor(library.colors.main, 1.5)) or library.colors.topGradient,
								ImageColor3 = (newStatus and darkenColor(library.colors.main, 2.5)) or library.colors.bottomGradient
							}):Play()
							task.spawn(callback, newStatus, last_v)
						end
					end
					return newStatus
				end
				options.Keybind = options.Keybind or options.Key or options.KeyBind
				local haskbflag, kbUpdate, kbData = nil, nil, nil
				if options.Keybind then
					local options = options.Keybind
					local htyp = typeof(options)
					if htyp == "EnumItem" then
						options = {
							Value = options
						}
					elseif htyp ~= "table" then
						options = {}
					end
					local presetKeybind, callback, kbpresscallback, kbflag = options.Value or options.Key, options.Callback, options.Pressed, options.Flag or (function()
						if flagName then
							return flagName .. "_ToggleKeybind"
						end
						library.unnamedkeybinds = 1 + (library.unnamedkeybinds or 0)
						return "Keybind" .. tostring(library.unnamedkeybinds)
					end)()
					if elements[kbflag] ~= nil or kbflag == flagName then
						warn(debug.traceback("Warning! Re-used flag '" .. kbflag .. "'", 3))
					end
					haskbflag = kbflag
					library.keyHandler = keyHandler
					local keyHandler = options.KeyNames or keyHandler
					local bindedKey = presetKeybind
					local justBinded = false
					local keyName = keyHandler.allowedKeys[bindedKey] or (bindedKey and (bindedKey.Name or tostring(bindedKey):gsub("Enum.KeyCode.", ""))) or "NONE"
					local newKeybind = newToggle
					keybindPositioner.Name = "keybindPositioner"
					keybindPositioner.Parent = newKeybind
					keybindPositioner.BackgroundColor3 = Color3.new(1, 1, 1)
					keybindPositioner.BackgroundTransparency = 1
					keybindPositioner.Position = UDim2.new(0.00448430516)
					keybindPositioner.Size = UDim2.fromOffset(214, 19)
					keybindPositioner.ZIndex = 1 + toggleButton.ZIndex
					keybindList.Name = "keybindList"
					keybindList.Parent = keybindPositioner
					keybindList.FillDirection = Enum.FillDirection.Horizontal
					keybindList.HorizontalAlignment = Enum.HorizontalAlignment.Right
					keybindList.SortOrder = Enum.SortOrder.LayoutOrder
					keybindList.VerticalAlignment = Enum.VerticalAlignment.Center
					keybindButton.Name = "keybindButton"
					keybindButton.Parent = keybindPositioner
					keybindButton.Active = false
					keybindButton.BackgroundColor3 = Color3.new(1, 1, 1)
					keybindButton.BackgroundTransparency = 1
					keybindButton.Position = UDim2.fromScale(0.598130822, 0.184210524)
					keybindButton.Selectable = false
					keybindButton.Size = UDim2.fromOffset(46, 12)
					keybindButton.Font = Enum.Font.Code
					keybindButton.Text = keyName or (presetKeybind and tostring(presetKeybind):gsub("Enum.KeyCode.", "")) or "[NONE]"
					keybindButton.TextColor3 = library.colors.otherElementText
					local colored_keybindButton_TextColor3 = {keybindButton, "TextColor3", "otherElementText"}
					colored[1 + #colored] = colored_keybindButton_TextColor3
					keybindButton.TextSize = 14
					keybindButton.TextXAlignment = Enum.TextXAlignment.Right
					keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
					local klast_v = bindedKey or presetKeybind
					local function newkey()
						if lockedup then
							return
						end
						local old_texts = keybindButton.Text
						colored_keybindButton_TextColor3[3] = "main"
						colored_keybindButton_TextColor3[4] = nil
						tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							TextColor3 = library.colors.main
						}):Play()
						if klast_v then
							keybindButton.Text = "(Was " .. (klast_v and tostring(klast_v):gsub("Enum.KeyCode.", "") or "[NONE]") .. ") [...]"
						else
							keybindButton.Text = "[...]"
						end
						local receivingKey = nil
						receivingKey = userInputService.InputBegan:Connect(function(key)
							if lockedup then
								return receivingKey:Disconnect()
							end
							klast_v = library_flags[kbflag]
							if not keyHandler.notAllowedKeys[key.KeyCode] then
								if key.KeyCode ~= Enum.KeyCode.Unknown then
									bindedKey = (key.KeyCode ~= Enum.KeyCode.Escape and key.KeyCode) or library_flags[kbflag]
									library_flags[kbflag] = bindedKey
									if options.Location then
										options.Location[options.LocationFlag or kbflag] = bindedKey
									end
									if bindedKey then
										keyName = keyHandler.allowedKeys[bindedKey] or (bindedKey and (bindedKey.Name or tostring(bindedKey):gsub("Enum.KeyCode.", ""))) or "NONE"
										keybindButton.Text = "[" .. (keyName or (bindedKey and bindedKey.Name) or "NONE") .. "]"
										keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
										justBinded = true
										colored_keybindButton_TextColor3[3] = "otherElementText"
										colored_keybindButton_TextColor3[4] = nil
										tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
											TextColor3 = library.colors.otherElementText
										}):Play()
										receivingKey:Disconnect()
									end
									if callback and klast_v ~= bindedKey then
										task.spawn(callback, bindedKey, klast_v)
									end
									return
								elseif key.KeyCode == Enum.KeyCode.Unknown and not keyHandler.notAllowedMouseInputs[key.UserInputType] then
									bindedKey = key.UserInputType
									library_flags[kbflag] = bindedKey
									if options.Location then
										options.Location[options.LocationFlag or kbflag] = bindedKey
									end
									keyName = keyHandler.allowedKeys[bindedKey]
									keybindButton.Text = "[" .. (keyName or (bindedKey and bindedKey.Name) or tostring(bindedKey.KeyCode):gsub("Enum.KeyCode.", "")) .. "]"
									keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
									justBinded = true
									colored_keybindButton_TextColor3[3] = "otherElementText"
									colored_keybindButton_TextColor3[4] = nil
									tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
										TextColor3 = library.colors.otherElementText
									}):Play()
									receivingKey:Disconnect()
									if callback and klast_v ~= bindedKey then
										task.spawn(callback, bindedKey, klast_v)
									end
									return
								end
							end
							if key.KeyCode == Enum.KeyCode.Backspace or Enum.KeyCode.Escape == key.KeyCode then
								old_texts, bindedKey = "[NONE]", nil
							end
							keybindButton.Text = old_texts
							colored_keybindButton_TextColor3[3] = "otherElementText"
							colored_keybindButton_TextColor3[4] = nil
							tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
								TextColor3 = library.colors.otherElementText
							}):Play()
							receivingKey:Disconnect()
							if callback and klast_v ~= bindedKey then
								task.spawn(callback, bindedKey, klast_v)
							end
						end)
						library.signals[1 + #library.signals] = receivingKey
					end
					library.signals[1 + #library.signals] = keybindButton.MouseButton1Click:Connect(newkey)
					if kbpresscallback and not justBinded then
						library.signals[1 + #library.signals] = userInputService.InputBegan:Connect(function(key, chatting)
							chatting = chatting or not not userInputService:GetFocusedTextBox()
							if not chatting and not justBinded then
								if not keyHandler.notAllowedKeys[key.KeyCode] and not keyHandler.notAllowedMouseInputs[key.UserInputType] then
									if bindedKey == key.UserInputType or not justBinded and bindedKey == key.KeyCode then
										if kbpresscallback then
											task.spawn(kbpresscallback, key, chatting)
										end
									end
									justBinded = false
								end
							end
						end)
					end
					options.Mode = (options.Mode and string.lower(tostring(options.Mode))) or "dynamic"
					local modes = {
						dynamic = 1,
						hold = 1,
						toggle = 1
					}
					library.signals[1 + #library.signals] = userInputService.InputBegan:Connect(function(input, chatting)
						if justBinded then
							wait(0.1)
							justBinded = false
							return
						elseif lockedup then
							return
						end
						chatting = chatting or userInputService:GetFocusedTextBox()
						if not chatting then
							local key = library_flags[kbflag]
							local mode = options.Mode
							if not modes[mode] then
								mode = "dynamic"
								options.Mode = mode
							end
							if key == input.KeyCode or key == input.UserInputType then
								if mode == "dynamic" or mode == "both" or mode == "hold" then
									if mode == "dynamic" and library_flags[flagName] then
										return Set(false)
									end
									Set(true)
									local now = os.clock()
									local waittil = nil
									if mode == "dynamic" then
										waittil = Instance.new("BindableEvent")
									end
									local xconnection = nil
									xconnection = userInputService.InputEnded:Connect(function(input, chatting)
										chatting = chatting or userInputService:GetFocusedTextBox()
										if not chatting and (key == input.KeyCode or key == input.UserInputType) then
											xconnection = (xconnection and xconnection:Disconnect() and nil) or nil
											if mode == "hold" or os.clock() - now > math.clamp(tonumber(options.DynamicTime) or 0.65, 0.05, 20) then
												Set(false)
											end
										end
									end)
									library.signals[1 + #library.signals] = xconnection
								else
									Set(not library_flags[flagName])
								end
							end
						end
					end)
					local function kbset(t, key)
						if nil == key and t ~= nil then
							key = t
						end
						if key == "nil" or key == "NONE" or key == "none" then
							key = nil
						end
						last_v = library_flags[kbflag]
						bindedKey = key
						library_flags[kbflag] = key
						if options.Location then
							options.Location[options.LocationFlag or kbflag] = key
						end
						keyName = (key == nil and "NONE") or keyHandler.allowedKeys[key]
						keybindButton.Text = "[" .. (keyName or key.Name or tostring(key):gsub("Enum.KeyCode.", "")) .. "]"
						keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
						justBinded = true
						colored_keybindButton_TextColor3[3] = "otherElementText"
						colored_keybindButton_TextColor3[4] = nil
						tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							TextColor3 = library.colors.otherElementText
						}):Play()
						if callback and (last_v ~= key or options.AllowDuplicateCalls) then
							task.spawn(callback, key, last_v)
						end
						return key
					end
					if presetKeybind ~= nil then
						kbset(presetKeybind)
					else
						library_flags[kbflag] = bindedKey
						if options.Location then
							options.Location[options.LocationFlag or kbflag] = bindedKey
						end
					end
					local default = library_flags[kbflag]
					local function UpdateKb()
						callback, kbpresscallback = options.Callback, options.Pressed
						local key = library_flags[kbflag]
						bindedKey = key
						keyName = keyHandler.allowedKeys[bindedKey] or (bindedKey and (bindedKey.Name or tostring(bindedKey):gsub("Enum.KeyCode.", ""))) or "NONE"
						keybindButton.Text = "[" .. (keyName or (key and key.Name) or tostring(key):gsub("Enum.KeyCode.", "")) .. "]"
						keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
						colored_keybindButton_TextColor3[3] = "otherElementText"
						colored_keybindButton_TextColor3[4] = (lockedup and 2.5) or nil
						tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							TextColor3 = (lockedup and darkenColor(library.colors.otherElementText, colored_keybindButton_TextColor3[4])) or library.colors.otherElementText
						}):Play()
						return key
					end
					kbUpdate = UpdateKb
					local objectdata = {
						Options = options,
						Name = kbflag,
						Flag = kbflag,
						Type = "Keybind",
						Default = default,
						Parent = sectionFunctions,
						Instance = keybindButton,
						Get = function()
							return library_flags[kbflag]
						end,
						Set = kbset,
						RawSet = function(t, key)
							if t ~= nil and key == nil then
								key = t
							end
							library_flags[kbflag] = key
							UpdateKb()
							return key
						end,
						Update = UpdateKb,
						Reset = function()
							return kbset(nil, default)
						end
					}
					kbData = objectdata
					tabFunctions.Flags[kbflag], sectionFunctions.Flags[kbflag], elements[kbflag] = objectdata, objectdata, objectdata
				end
				sectionFunctions:Update()
				library.signals[1 + #library.signals] = toggleButton.MouseButton1Click:Connect(function()
					if not library.colorpicker and not submenuOpen and not lockedup then
						local newval = not library_flags[flagName]
						if options.Condition ~= nil then
							if type(options.Condition) == "function" then
								local v, e = pcall(options.Condition, newval, not newval)
								if e then
									if not v then
										warn(debug.traceback(string.format("Error in toggle %s's Condition function: %s", flagName, e), 2))
									end
								else
									return last_v
								end
							end
						end
						library_flags[flagName] = newval
						if options.Location then
							options.Location[options.LocationFlag or flagName] = newval
						end
						colored_toggleInner_BackgroundColor3[3] = (newval and "main") or "topGradient"
						colored_toggleInner_BackgroundColor3[4] = (newval and 1.5) or nil
						colored_toggleInner_ImageColor3[3] = (newval and "main") or "bottomGradient"
						colored_toggleInner_ImageColor3[4] = (newval and 2.5) or nil
						tweenService:Create(toggleInner, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = (newval and darkenColor(library.colors.main, 1.5)) or library.colors.topGradient,
							ImageColor3 = (newval and darkenColor(library.colors.main, 2.5)) or library.colors.bottomGradient
						}):Play()
						if callback then
							task.spawn(callback, newval)
						end
					end
				end)
				library.signals[1 + #library.signals] = newToggle.MouseEnter:Connect(function()
					colored_toggle_BackgroundColor3[3] = "main"
					colored_toggle_BackgroundColor3[4] = 1.5
					colored_toggle_ImageColor3[3] = "main"
					colored_toggle_ImageColor3[4] = 2.5
					tweenService:Create(toggle, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = darkenColor(library.colors.main, 1.5),
						ImageColor3 = darkenColor(library.colors.main, 2.5)
					}):Play()
				end)
				library.signals[1 + #library.signals] = newToggle.MouseLeave:Connect(function()
					colored_toggle_BackgroundColor3[3] = "topGradient"
					colored_toggle_BackgroundColor3[4] = nil
					colored_toggle_ImageColor3[3] = "bottomGradient"
					colored_toggle_ImageColor3[4] = nil
					tweenService:Create(toggle, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = library.colors.topGradient,
						ImageColor3 = library.colors.bottomGradient
					}):Play()
				end)
				if library_flags[flagName] then
					colored_toggleInner_BackgroundColor3[3] = "main"
					colored_toggleInner_BackgroundColor3[4] = 1.5
					colored_toggleInner_ImageColor3[3] = "main"
					colored_toggleInner_ImageColor3[4] = 2.5
					tweenService:Create(toggleInner, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = darkenColor(library.colors.main, 1.5),
						ImageColor3 = darkenColor(library.colors.main, 2.5)
					}):Play()
				end
				local function Update()
					toggleName, callback = options.Name or toggleName, options.Callback
					local boolstatus = library_flags[flagName]
					colored_toggleInner_BackgroundColor3[3] = (boolstatus and "main") or "topGradient"
					colored_toggleInner_BackgroundColor3[4] = (boolstatus and 1.5) or nil
					colored_toggleInner_ImageColor3[3] = (boolstatus and "main") or "bottomGradient"
					colored_toggleInner_ImageColor3[4] = (boolstatus and 2.5) or nil
					if lockedup then
						colored_toggleInner_BackgroundColor3[4] = 1 + (colored_toggleInner_BackgroundColor3[4] or 1)
						colored_toggleInner_ImageColor3[4] = 1 + (colored_toggleInner_ImageColor3[4] or 1)
					end
					tweenService:Create(toggleInner, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = (boolstatus and darkenColor(library.colors.main, colored_toggleInner_BackgroundColor3[4])) or library.colors.topGradient,
						ImageColor3 = (boolstatus and darkenColor(library.colors.main, colored_toggleInner_ImageColor3[4])) or library.colors.bottomGradient
					}):Play()
					colored_toggleHeadline_TextColor3[4] = (lockedup and 2.5) or nil
					tweenService:Create(toggleHeadline, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						TextColor3 = (lockedup and darkenColor(library.colors.elementText, colored_toggleHeadline_TextColor3[4])) or library.colors.elementText
					}):Play()
					toggleHeadline.Text = toggleName or "???"
					return boolstatus
				end
				if alreadyEnabled ~= nil then
					Set(alreadyEnabled)
				else
					library_flags[flagName] = not not alreadyEnabled
					if options.Location then
						options.Location[options.LocationFlag or flagName] = not not alreadyEnabled
					end
				end
				local default = not not library_flags[flagName]
				Update()
				if kbUpdate then
					kbUpdate()
				end
				local objectdata = {
					Options = options,
					Type = "Toggle",
					Name = flagName,
					Flag = flagName,
					Default = default,
					Parent = sectionFunctions,
					Instance = toggleButton,
					Set = Set,
					RawSet = function(t, newStatus, condition)
						if t ~= nil and type(t) ~= "table" then
							newStatus, condition = t, newStatus
						end
						last_v = library_flags[flagName]
						if condition ~= false and condition ~= 0 then
							local overridecondition = condition and type(condition) == "function" and condition
							if overridecondition or options.Condition ~= nil then
								if type(overridecondition or options.Condition) == "function" then
									local v, e = pcall(overridecondition or options.Condition, newStatus, last_v)
									if e then
										if not v then
											warn(debug.traceback(string.format("Error in toggle (RawSet) %s's Condition function: %s", flagName, e), 2))
										end
									else
										return last_v
									end
								end
							end
						end
						library_flags[flagName] = newStatus
						if options.Location then
							options.Location[options.LocationFlag or flagName] = newStatus
						end
						Update()
						return newStatus
					end,
					KeybindData = kbData,
					Get = function()
						return library_flags[flagName]
					end,
					Update = Update,
					Reset = function()
						return Set(nil, default)
					end,
					SetLocked = function(t, state)
						if type(t) ~= "table" then
							state = t
						end
						local last_v = lockedup
						if state == nil then
							lockedup = not lockedup
						else
							lockedup = state
						end
						if lockedup ~= last_v then
							colored_toggleHeadline_TextColor3[4] = (lockedup and 2.5) or nil
							Update()
							if kbUpdate then
								kbUpdate()
							end
						end
						return lockedup
					end,
					Lock = function()
						if not lockedup then
							lockedup = true
							colored_toggleHeadline_TextColor3[4] = 2.5
							Update()
							if kbUpdate then
								kbUpdate()
							end
						end
						return lockedup
					end,
					Unlock = function()
						if lockedup then
							lockedup = false
							colored_toggleHeadline_TextColor3[4] = nil
							Update()
							if kbUpdate then
								kbUpdate()
							end
						end
						return lockedup
					end,
					SetCondition = function(t, condition)
						if type(t) ~= "table" and condition == nil then
							condition = t
						end
						options.Condition = condition
						return condition
					end
				}
				if kbData then
					kbData.ToggleData = objectdata
				end
				tabFunctions.Flags[flagName], sectionFunctions.Flags[flagName], elements[flagName] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.CreateToggle = sectionFunctions.AddToggle
			sectionFunctions.NewToggle = sectionFunctions.AddToggle
			sectionFunctions.Toggle = sectionFunctions.AddToggle
			sectionFunctions.Tog = sectionFunctions.AddToggle
			function sectionFunctions:AddButton(...)
				local args = nil
				if ... and not select(2, ...) and type(...) == "table" and #... > 0 and type((...)[1]) == "table" and (...)[1].Name then
					args = ...
				else
					args = {...}
				end
				local buttons, offset = {}, 0
				local fram = nil
				for _, options in next, args do
					options = (options and options[1] and type(options[1]) == "string" and resolvevararg("Button", unpack(options))) or options
					local buttonName, callback = assert(options.Name, "Missing Name for new button."), options.Callback or (warn("AddButton missing callback. Name:", options.Name or "No Name", debug.traceback("")) and nil) or function()
					end
					local lockedup = options.Locked
					local realButton = Instance_new("TextButton")
					realButton.Name = "realButton"
					realButton.BackgroundColor3 = Color3.new(1, 1, 1)
					realButton.BackgroundTransparency = 1
					realButton.Size = UDim2.fromScale(1, 1)
					realButton.ZIndex = 5
					realButton.Font = Enum.Font.Code
					realButton.Text = (buttonName and tostring(buttonName)) or "???"
					realButton.TextColor3 = library.colors.elementText
					local colored_realButton_TextColor3 = {realButton, "TextColor3", "elementText"}
					colored[1 + #colored] = colored_realButton_TextColor3
					realButton.TextSize = 14
					local textsize = textToSize(realButton).X + 14
					if newSection.Parent.AbsoluteSize.X < offset + textsize + 8 then
						offset, fram = 0, nil
					end
					local newButton = fram or Instance_new("Frame")
					fram = newButton
					local button = Instance_new("ImageLabel")
					newButton.Name = removeSpaces((buttonName and buttonName:lower() or "???") .. "Holder")
					newButton.Parent = sectionHolder
					newButton.BackgroundColor3 = Color3.new(1, 1, 1)
					newButton.BackgroundTransparency = 1
					newButton.Size = UDim2.new(1, 0, 0, 24)
					button.Name = "button"
					button.Parent = newButton
					button.Active = true
					button.BackgroundColor3 = library.colors.topGradient
					local colored_button_BackgroundColor3 = {button, "BackgroundColor3", "topGradient"}
					colored[1 + #colored] = colored_button_BackgroundColor3
					button.BorderColor3 = library.colors.elementBorder
					colored[1 + #colored] = {button, "BorderColor3", "elementBorder"}
					button.Position = UDim2.new(0.031, offset, 0.166)
					button.Selectable = true
					button.Size = UDim2.fromOffset(28, 18)
					button.Image = "rbxassetid://2454009026"
					button.ImageColor3 = library.colors.bottomGradient
					local colored_button_ImageColor3 = {button, "ImageColor3", "bottomGradient"}
					colored[1 + #colored] = colored_button_ImageColor3
					local buttonInner = Instance_new("ImageLabel")
					buttonInner.Name = "buttonInner"
					buttonInner.Parent = button
					buttonInner.Active = true
					buttonInner.AnchorPoint = Vector2.new(0.5, 0.5)
					buttonInner.BackgroundColor3 = library.colors.topGradient
					local colored_buttonInner_BackgroundColor3 = {buttonInner, "BackgroundColor3", "topGradient"}
					colored[1 + #colored] = colored_buttonInner_BackgroundColor3
					buttonInner.BorderColor3 = library.colors.elementBorder
					colored[1 + #colored] = {buttonInner, "BorderColor3", "elementBorder"}
					buttonInner.Position = UDim2.fromScale(0.5, 0.5)
					buttonInner.Selectable = true
					buttonInner.Size = UDim2.new(1, -4, 1, -4)
					buttonInner.Image = "rbxassetid://2454009026"
					buttonInner.ImageColor3 = library.colors.bottomGradient
					local colored_buttonInner_ImageColor3 = {buttonInner, "ImageColor3", "bottomGradient"}
					colored[1 + #colored] = colored_buttonInner_ImageColor3
					button.Size = UDim2.fromOffset(textsize, 18)
					realButton.Parent = button
					offset = offset + textsize + 6
					sectionFunctions:Update()
					local presses = 0
					library.signals[1 + #library.signals] = realButton.MouseButton1Click:Connect(function()
						if lockedup then
							return
						end
						if options.Condition ~= nil and type(options.Condition) == "function" then
							local v, e = pcall(options.Condition, presses)
							if e then
								if not v then
									warn(debug.traceback(string.format("Error in button %s's Condition function: %s", buttonName, e), 2))
								end
							else
								return
							end
						end
						if not library.colorpicker and not submenuOpen then
							presses = 1 + presses
							task.spawn(callback, presses)
						end
					end)
					local imin = nil
					library.signals[1 + #library.signals] = button.MouseEnter:Connect(function()
						imin = 1
						colored_button_BackgroundColor3[3] = "main"
						colored_button_BackgroundColor3[4] = 1.5
						colored_button_ImageColor3[3] = "main"
						colored_button_ImageColor3[4] = 2.5
						tweenService:Create(button, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = darkenColor(library.colors.main, 1.5),
							ImageColor3 = darkenColor(library.colors.main, 2.5)
						}):Play()
					end)
					library.signals[1 + #library.signals] = button.MouseLeave:Connect(function()
						imin = nil
						colored_button_BackgroundColor3[3] = "topGradient"
						colored_button_BackgroundColor3[4] = nil
						colored_button_ImageColor3[3] = "bottomGradient"
						colored_button_ImageColor3[4] = nil
						tweenService:Create(button, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = library.colors.topGradient,
							ImageColor3 = library.colors.bottomGradient
						}):Play()
					end)
					local function Update()
						buttonName, callback = options.Name or buttonName, options.Callback or (warn(debug.traceback("AddButton missing callback. Name:" .. (options.Name or buttonName or "No Name"), 2)) and nil) or function()
						end
						colored_button_BackgroundColor3[3] = (imin and "main") or "topGradient"
						colored_button_BackgroundColor3[4] = (imin and 1.5) or nil
						colored_button_ImageColor3[3] = (imin and "main") or "bottomGradient"
						colored_button_ImageColor3[4] = (imin and 2.5) or nil
						colored_buttonInner_BackgroundColor3[4] = nil
						colored_buttonInner_ImageColor3[4] = nil
						colored_realButton_TextColor3[4] = nil
						if lockedup then
							colored_button_BackgroundColor3[4] = 1.25
							colored_button_ImageColor3[4] = 1.25
							colored_buttonInner_BackgroundColor3[4] = 1.25
							colored_buttonInner_ImageColor3[4] = 1.25
							colored_realButton_TextColor3[4] = 1.75
						end
						tweenService:Create(button, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = (imin and darkenColor(library.colors.main, colored_button_BackgroundColor3[4])) or darkenColor(library.colors.topGradient, colored_button_BackgroundColor3[4]),
							ImageColor3 = (imin and darkenColor(library.colors.main, colored_button_ImageColor3[4])) or darkenColor(library.colors.bottomGradient, colored_button_ImageColor3[4])
						}):Play()
						tweenService:Create(buttonInner, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = darkenColor(library.colors.topGradient, colored_buttonInner_BackgroundColor3[4]),
							ImageColor3 = darkenColor(library.colors.bottomGradient, colored_buttonInner_ImageColor3[4])
						}):Play()
						tweenService:Create(realButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							TextColor3 = darkenColor(library.colors.elementText, colored_realButton_TextColor3[4])
						}):Play()
						realButton.Text = (buttonName and tostring(buttonName)) or "???"
						return presses
					end
					Update()
					local objectdata = {
						Options = options,
						Name = buttonName,
						Flag = buttonName,
						Type = "Button",
						Parent = sectionFunctions,
						Instance = realButton,
						Press = function(...)
							if lockedup then
								return presses
							end
							if options.Condition ~= nil and type(options.Condition) == "function" then
								local v, e = pcall(options.Condition, presses)
								if e then
									if not v then
										warn(debug.traceback(string.format("Error in button %s's Condition function: %s", buttonName, e), 2))
									end
								else
									return presses
								end
							end
							local args = {...}
							local a1 = args[1]
							if a1 and type(a1) == "table" then
								table.remove(args, 1)
							end
							presses = 1 + presses
							task.spawn(callback, presses, ...)
							return presses
						end,
						RawPress = function(...)
							local args = {...}
							local a1 = args[1]
							if a1 and type(a1) == "table" then
								table.remove(args, 1)
							end
							task.spawn(callback, presses, ...)
							return presses
						end,
						Get = function()
							return callback, presses
						end,
						SetLocked = function(t, state)
							if type(t) ~= "table" then
								state = t
							end
							local last_v = lockedup
							if state == nil then
								lockedup = not lockedup
							else
								lockedup = state
							end
							if lockedup ~= last_v then
								Update()
							end
							return lockedup
						end,
						Lock = function()
							if not lockedup then
								lockedup = true
								Update()
							end
							return lockedup
						end,
						Unlock = function()
							if lockedup then
								lockedup = false
								Update()
							end
							return lockedup
						end,
						SetCondition = function(t, condition)
							if type(t) ~= "table" and condition == nil then
								condition = t
							end
							options.Condition = condition
							return condition
						end,
						Update = Update,
						SetText = function(t, str)
							if type(t) ~= "table" and str == nil then
								str = t
							end
							buttonName = str
							options.Name = str
							realButton.Text = (buttonName and tostring(buttonName)) or "???"
							return str
						end,
						SetCallback = function(t, call)
							if type(t) ~= "table" and call == nil then
								call = t
							end
							options.Callback = call
							callback = call
							return call
						end
					}
					tabFunctions.Flags[buttonName], sectionFunctions.Flags[buttonName], elements[buttonName] = objectdata, objectdata, objectdata
					buttons[1 + #buttons] = objectdata
				end
				function buttons.PressAll()
					for _, v in next, buttons do
						v.Press()
					end
				end
				function buttons.UpdateAll()
					for _, v in next, buttons do
						v.Update()
					end
				end
				if #buttons == 1 then
					for k, v in next, buttons[1] do
						if buttons[k] == nil then
							buttons[k] = v
						end
					end
				end
				return buttons
			end
			sectionFunctions.CreateButton = sectionFunctions.AddButton
			sectionFunctions.NewButton = sectionFunctions.AddButton
			sectionFunctions.Button = sectionFunctions.AddButton
			function sectionFunctions:AddTextbox(options, ...)
				options = (options and type(options) == "string" and resolvevararg("Textbox", options, ...)) or options
				local textboxName, presetValue, placeholder, callback, flagName = assert(options.Name, "Missing Name for new textbox."), options.Value, options.Placeholder, options.Callback, options.Flag or (function()
					library.unnamedtextboxes = 1 + (library.unnamedtextboxes or 0)
					return "Textbox" .. tostring(library.unnamedtextboxes)
				end)()
				if elements[flagName] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flagName .. "'", 3))
				end
				local requiredtype = options.Type
				local newTextbox = Instance_new("Frame")
				local textbox = Instance_new("ImageLabel")
				local textboxInner = Instance_new("ImageLabel")
				local realTextbox = Instance_new("TextBox")
				local textboxHeadline = Instance_new("TextLabel")
				newTextbox.Name = removeSpaces((textboxName and textboxName:lower()) or "???") .. "Holder"
				newTextbox.Parent = sectionHolder
				newTextbox.BackgroundColor3 = Color3.new(1, 1, 1)
				newTextbox.BackgroundTransparency = 1
				newTextbox.Size = UDim2.new(1, 0, 0, 42)
				textbox.Name = "textbox"
				textbox.Parent = newTextbox
				textbox.Active = true
				textbox.BackgroundColor3 = library.colors.topGradient
				local colored_textbox_BackgroundColor3 = {textbox, "BackgroundColor3", "topGradient"}
				colored[1 + #colored] = colored_textbox_BackgroundColor3
				textbox.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {textbox, "BorderColor3", "elementBorder"}
				textbox.Position = UDim2.fromScale(0.031, 0.48)
				textbox.Selectable = true
				textbox.Size = UDim2.fromOffset(206, 18)
				textbox.Image = "rbxassetid://2454009026"
				textbox.ImageColor3 = library.colors.bottomGradient
				local colored_textbox_ImageColor3 = {textbox, "ImageColor3", "bottomGradient"}
				colored[1 + #colored] = colored_textbox_ImageColor3
				textboxInner.Name = "textboxInner"
				textboxInner.Parent = textbox
				textboxInner.Active = true
				textboxInner.AnchorPoint = Vector2.new(0.5, 0.5)
				textboxInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {textboxInner, "BackgroundColor3", "topGradient"}
				textboxInner.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {textboxInner, "BorderColor3", "elementBorder"}
				textboxInner.Position = UDim2.fromScale(0.5, 0.5)
				textboxInner.Selectable = true
				textboxInner.Size = UDim2.new(1, -4, 1, -4)
				textboxInner.Image = "rbxassetid://2454009026"
				textboxInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {textboxInner, "ImageColor3", "bottomGradient"}
				realTextbox.Name = "realTextbox"
				if options.Rich or options.RichText or options.RichTextBox then
					realTextbox.RichText = true
				end
				if options.MultiLine or options.Lines then
					realTextbox.MultiLine = true
				end
				if options.Font or options.TextFont then
					realTextbox.Font = options.Font
				end
				if options.TextScaled or options.Scaled then
					realTextbox.TextScaled = true
				end
				realTextbox.BackgroundColor3 = Color3.new(1, 1, 1)
				realTextbox.BackgroundTransparency = 1
				realTextbox.Position = UDim2.new(0.0295485705)
				realTextbox.Size = UDim2.fromScale(0.97, 1)
				realTextbox.ZIndex = 5
				realTextbox.Font = Enum.Font.Code
				realTextbox.LineHeight = 1.15
				realTextbox.Text = tostring(presetValue)
				realTextbox.TextColor3 = library.colors.otherElementText
				colored[1 + #colored] = {realTextbox, "TextColor3", "otherElementText"}
				realTextbox.TextSize = 14
				if options.ClearTextOnFocus or options.ClearText then
					realTextbox.ClearTextOnFocus = true
				else
					realTextbox.ClearTextOnFocus = false
				end
				realTextbox.PlaceholderText = (placeholder ~= nil and tostring(placeholder)) or (presetValue ~= nil and tostring(presetValue)) or ""
				realTextbox.TextXAlignment = Enum.TextXAlignment.Left
				if options.CustomProperties and type(options.CustomProperties) == "table" then
					for k, v in next, options.CustomProperties do
						local oof, e = pcall(function()
							realTextbox[k] = v
						end)
						if not oof and e then
							warn("Error setting Textbox", flagName, "|", e, debug.traceback(""))
						end
					end
				end
				realTextbox.Parent = textbox
				textboxHeadline.Name = "textboxHeadline"
				textboxHeadline.Parent = newTextbox
				textboxHeadline.Active = true
				textboxHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				textboxHeadline.BackgroundTransparency = 1
				textboxHeadline.Position = UDim2.new(0.031)
				textboxHeadline.Selectable = true
				textboxHeadline.Size = UDim2.fromOffset(206, 20)
				textboxHeadline.ZIndex = 5
				textboxHeadline.Font = Enum.Font.Code
				textboxHeadline.LineHeight = 1.15
				textboxHeadline.Text = (textboxName and tostring(textboxName)) or "???"
				textboxHeadline.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {textboxHeadline, "TextColor3", "elementText"}
				textboxHeadline.TextSize = 14
				textboxHeadline.TextXAlignment = Enum.TextXAlignment.Left
				sectionFunctions:Update()
				local last_v = presetValue
				local function resolvevalue(val)
					if options.PreFormat then
						local typ = type(options.PreFormat)
						if typ == "function" then
							local x, e = pcall(options.PreFormat, val)
							if not x and e then
								warn("Error in Pre-Format (Textbox " .. flagName .. "):", e)
							else
								val = e
							end
						end
					end
					if requiredtype == "number" then
						if not options.Hex and not options.Binary and not options.Base then
							val = tonumber(val) or tonumber(val:gsub("%D", ""), 10) or 0
						else
							val = tonumber(val, (options.Hex and 16) or (options.Binary and 2) or options.Base or 10) or 0
						end
						if options.Max or options.Min then
							val = math.clamp(val, options.Min or -math.huge, options.Max or math.huge)
						end
						local decimalprecision = tonumber(options.Decimals or options.Precision or options.Precise)
						if decimalprecision then
							val = tonumber(string.format("%0." .. tostring(decimalprecision) .. "f", val))
						end
					end
					if options.PostFormat then
						local typ = type(options.PostFormat)
						if typ == "function" then
							local x, e = pcall(options.PostFormat, val)
							if not x and e then
								warn("Error in Post-Format (Textbox " .. flagName .. "):", e)
							else
								val = e
							end
						end
					end
					return (val and tonumber(val)) or val
				end
				library.signals[1 + #library.signals] = realTextbox.FocusLost:Connect(function()
					last_v = library_flags[flagName]
					local val = resolvevalue(realTextbox.Text)
					library_flags[flagName] = val
					if options.Location then
						options.Location[options.LocationFlag or flagName] = val
					end
					if callback and last_v ~= val then
						task.spawn(callback, tostring(val), last_v, realTextbox)
					end
				end)
				library.signals[1 + #library.signals] = newTextbox.MouseEnter:Connect(function()
					colored_textbox_BackgroundColor3[3] = "main"
					colored_textbox_BackgroundColor3[4] = 1.5
					colored_textbox_ImageColor3[3] = "main"
					colored_textbox_ImageColor3[4] = 2.5
					tweenService:Create(textbox, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = darkenColor(library.colors.main, 1.5),
						ImageColor3 = darkenColor(library.colors.main, 2.5)
					}):Play()
				end)
				library.signals[1 + #library.signals] = newTextbox.MouseLeave:Connect(function()
					colored_textbox_BackgroundColor3[3] = "topGradient"
					colored_textbox_BackgroundColor3[4] = nil
					colored_textbox_ImageColor3[3] = "bottomGradient"
					colored_textbox_ImageColor3[4] = nil
					tweenService:Create(textbox, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = library.colors.topGradient,
						ImageColor3 = library.colors.bottomGradient
					}):Play()
				end)
				local function set(t, str)
					if nil == str and t ~= nil then
						str = t
					end
					last_v = library_flags[flagName]
					library_flags[flagName] = str
					if options.Location then
						options.Location[options.LocationFlag or flagName] = str
					end
					local sstr = (str ~= nil and tostring(str)) or "Empty Text"
					if realTextbox.Text ~= sstr then
						realTextbox.Text = sstr
					end
					if callback and (last_v ~= str or options.AllowDuplicateCalls) then
						task.spawn(callback, str, last_v, realTextbox)
					end
					return str
				end
				if presetValue ~= nil then
					set(presetValue)
				else
					library_flags[flagName] = presetValue
					if options.Location then
						options.Location[options.LocationFlag or flagName] = presetValue
					end
				end
				local default = library_flags[flagName]
				local function update()
					textboxName, placeholder, callback = options.Name or textboxName, options.Placeholder or placeholder, options.Callback
					local str = library_flags[flagName]
					str = (str ~= nil and tostring(str)) or "Empty Text"
					if realTextbox.Text ~= str then
						realTextbox.Text = str
					end
					textboxHeadline.Text = (textboxName and tostring(textboxName)) or "???"
					return str
				end
				local objectdata = {
					Options = options,
					Name = flagName,
					Flag = flagName,
					Type = "Textbox",
					Default = default,
					Parent = sectionFunctions,
					Instance = realTextbox,
					Get = function()
						return library_flags[flagName]
					end,
					Set = set,
					Update = update,
					RawSet = function(t, str)
						if t ~= nil and str == nil then
							str = t
						end
						last_v = library_flags[flagName]
						library_flags[flagName] = str
						if options.Location then
							options.Location[options.LocationFlag or flagName] = str
						end
						update()
						return str
					end,
					Reset = function()
						return set(nil, default)
					end
				}
				tabFunctions.Flags[flagName], sectionFunctions.Flags[flagName], elements[flagName] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.AddTextBox = sectionFunctions.AddTextbox
			sectionFunctions.NewTextBox = sectionFunctions.AddTextbox
			sectionFunctions.CreateTextBox = sectionFunctions.AddTextbox
			sectionFunctions.TextBox = sectionFunctions.AddTextbox
			sectionFunctions.NewTextbox = sectionFunctions.AddTextbox
			sectionFunctions.CreateTextbox = sectionFunctions.AddTextbox
			sectionFunctions.Textbox = sectionFunctions.AddTextbox
			sectionFunctions.Box = sectionFunctions.AddTextbox
			function sectionFunctions:AddKeybind(options, ...)
				options = (options and type(options) == "string" and resolvevararg("Keybind", options, ...)) or options
				local keybindName, presetKeybind, callback, presscallback, flag = assert(options.Name, "Missing Name for new keybind."), options.Value, options.Callback, options.Pressed, options.Flag or (function()
					library.unnamedkeybinds = 1 + (library.unnamedkeybinds or 0)
					return "Keybind" .. tostring(library.unnamedkeybinds)
				end)()
				if elements[flag] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flag .. "'", 3))
				end
				library.keyHandler = keyHandler
				local keyHandler = options.KeyNames or keyHandler
				local newKeybind = Instance_new("Frame")
				local keybindHeadline = Instance_new("TextLabel")
				local keybindPositioner = Instance_new("Frame")
				local keybindList = Instance_new("UIListLayout")
				local keybindButton = Instance_new("TextButton")
				local bindedKey = presetKeybind
				local justBinded = false
				local keyName = (presetKeybind and tostring(presetKeybind):gsub("Enum.KeyCode.", "") or "")
				newKeybind.Name = "newKeybind"
				newKeybind.Parent = sectionHolder
				newKeybind.BackgroundColor3 = Color3.new(1, 1, 1)
				newKeybind.BackgroundTransparency = 1
				newKeybind.Size = UDim2.new(1, 0, 0, 19)
				keybindHeadline.Name = "keybindHeadline"
				keybindHeadline.Parent = newKeybind
				keybindHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				keybindHeadline.BackgroundTransparency = 1
				keybindHeadline.Position = UDim2.fromScale(0.031, 0.165842161)
				keybindHeadline.Size = UDim2.fromOffset(215, 12)
				keybindHeadline.Font = Enum.Font.Code
				keybindHeadline.Text = (keybindName and tostring(keybindName)) or "???"
				keybindHeadline.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {keybindHeadline, "TextColor3", "elementText"}
				keybindHeadline.TextSize = 14
				keybindHeadline.TextXAlignment = Enum.TextXAlignment.Left
				keybindPositioner.Name = "keybindPositioner"
				keybindPositioner.Parent = newKeybind
				keybindPositioner.BackgroundColor3 = Color3.new(1, 1, 1)
				keybindPositioner.BackgroundTransparency = 1
				keybindPositioner.Position = UDim2.new(0.00448430516)
				keybindPositioner.Size = UDim2.fromOffset(214, 19)
				keybindList.Name = "keybindList"
				keybindList.Parent = keybindPositioner
				keybindList.FillDirection = Enum.FillDirection.Horizontal
				keybindList.HorizontalAlignment = Enum.HorizontalAlignment.Right
				keybindList.SortOrder = Enum.SortOrder.LayoutOrder
				keybindList.VerticalAlignment = Enum.VerticalAlignment.Center
				keybindButton.Name = "keybindButton"
				keybindButton.Parent = keybindPositioner
				keybindButton.Active = false
				keybindButton.BackgroundColor3 = Color3.new(1, 1, 1)
				keybindButton.BackgroundTransparency = 1
				keybindButton.Position = UDim2.fromScale(0.598130822, 0.184210524)
				keybindButton.Selectable = false
				keybindButton.Size = UDim2.fromOffset(46, 12)
				keybindButton.Font = Enum.Font.Code
				keybindButton.Text = (presetKeybind and tostring(presetKeybind):gsub("Enum.KeyCode.", "") or "[NONE]")
				keybindButton.TextColor3 = library.colors.otherElementText
				local colored_keybindButton_TextColor3 = {keybindButton, "TextColor3", "otherElementText"}
				colored[1 + #colored] = colored_keybindButton_TextColor3
				keybindButton.TextSize = 14
				keybindButton.TextXAlignment = Enum.TextXAlignment.Right
				keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
				sectionFunctions:Update()
				local last_v = bindedKey or presetKeybind
				local function newkey()
					local old_texts = keybindButton.Text
					colored_keybindButton_TextColor3[3] = "main"
					colored_keybindButton_TextColor3[4] = nil
					tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						TextColor3 = library.colors.main
					}):Play()
					if last_v then
						keybindButton.Text = "(Was " .. (last_v and tostring(last_v):gsub("Enum.KeyCode.", "") or "[NONE]") .. ") [...]"
					else
						keybindButton.Text = "[...]"
					end
					local receivingKey = nil
					receivingKey = userInputService.InputBegan:Connect(function(key)
						last_v = library_flags[flag]
						if not keyHandler.notAllowedKeys[key.KeyCode] then
							if key.KeyCode ~= Enum.KeyCode.Unknown then
								bindedKey = (key.KeyCode ~= Enum.KeyCode.Escape and key.KeyCode) or library_flags[flag]
								library_flags[flag] = bindedKey
								if options.Location then
									options.Location[options.LocationFlag or flag] = bindedKey
								end
								if bindedKey then
									keyName = keyHandler.allowedKeys[bindedKey]
									keybindButton.Text = "[" .. (keyName or bindedKey.Name or tostring(key.KeyCode):gsub("Enum.KeyCode.", "")) .. "]"
									keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
									justBinded = true
									colored_keybindButton_TextColor3[3] = "otherElementText"
									colored_keybindButton_TextColor3[4] = nil
									tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
										TextColor3 = library.colors.otherElementText
									}):Play()
									receivingKey:Disconnect()
								end
								if callback and last_v ~= bindedKey then
									task.spawn(callback, bindedKey, last_v)
								end
								return
							elseif key.KeyCode == Enum.KeyCode.Unknown and not keyHandler.notAllowedMouseInputs[key.UserInputType] then
								bindedKey = key.UserInputType
								library_flags[flag] = bindedKey
								if options.Location then
									options.Location[options.LocationFlag or flag] = bindedKey
								end
								keyName = keyHandler.allowedKeys[bindedKey]
								keybindButton.Text = "[" .. (keyName or bindedKey.Name or tostring(key.KeyCode):gsub("Enum.KeyCode.", "")) .. "]"
								keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
								justBinded = true
								colored_keybindButton_TextColor3[3] = "otherElementText"
								colored_keybindButton_TextColor3[4] = nil
								tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
									TextColor3 = library.colors.otherElementText
								}):Play()
								receivingKey:Disconnect()
								if callback and last_v ~= bindedKey then
									task.spawn(callback, bindedKey, last_v)
								end
								return
							end
						end
						if key.KeyCode == Enum.KeyCode.Backspace or Enum.KeyCode.Escape == key.KeyCode then
							old_texts, bindedKey = "[NONE]", nil
						end
						keybindButton.Text = old_texts
						colored_keybindButton_TextColor3[3] = "otherElementText"
						colored_keybindButton_TextColor3[4] = nil
						tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							TextColor3 = library.colors.otherElementText
						}):Play()
						receivingKey:Disconnect()
						if callback and last_v ~= bindedKey then
							task.spawn(callback, bindedKey, last_v)
						end
					end)
					library.signals[1 + #library.signals] = receivingKey
				end
				library.signals[1 + #library.signals] = keybindButton.MouseButton1Click:Connect(newkey)
				library.signals[1 + #library.signals] = newKeybind.InputEnded:Connect(function(input)
					if not library.colorpicker and not submenuOpen and input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						newkey()
					end
				end)
				if presscallback then
					library.signals[1 + #library.signals] = userInputService.InputBegan:Connect(function(key, chatting)
						if not keyHandler.notAllowedKeys[key.KeyCode] and not keyHandler.notAllowedMouseInputs[key.UserInputType] then
							if not justBinded and bindedKey == key.UserInputType or not justBinded and bindedKey == key.KeyCode and not chatting then
								if presscallback then
									task.spawn(presscallback, key, chatting)
								end
							end
							if justBinded then
								justBinded = false
							end
						end
					end)
				end
				local function set(t, key)
					if nil == key and t ~= nil then
						key = t
					end
					if key == "nil" or key == "NONE" or key == "none" then
						key = nil
					end
					last_v = library_flags[flag]
					bindedKey = key
					library_flags[flag] = key
					if options.Location then
						options.Location[options.LocationFlag or flag] = key
					end
					keyName = (key == nil and "NONE") or keyHandler.allowedKeys[key]
					keybindButton.Text = "[" .. (keyName or key.Name or tostring(key):gsub("Enum.KeyCode.", "")) .. "]"
					keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
					justBinded = true
					colored_keybindButton_TextColor3[3] = "otherElementText"
					colored_keybindButton_TextColor3[4] = nil
					tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						TextColor3 = library.colors.otherElementText
					}):Play()
					if callback and (last_v ~= key or options.AllowDuplicateCalls) then
						task.spawn(callback, key, last_v)
					end
					return key
				end
				if presetKeybind ~= nil then
					set(presetKeybind)
				else
					library_flags[flag] = bindedKey
					if options.Location then
						options.Location[options.LocationFlag or flag] = bindedKey
					end
				end
				local default = library_flags[flag]
				local function update()
					keybindName, callback, presscallback = options.Name or keybindName, options.Callback, options.Pressed
					local key = library_flags[flag]
					keyName = (key == nil and "NONE") or keyHandler.allowedKeys[key]
					keybindButton.Text = "[" .. (keyName or key.Name or tostring(key):gsub("Enum.KeyCode.", "")) .. "]"
					keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
					colored_keybindButton_TextColor3[3] = "otherElementText"
					colored_keybindButton_TextColor3[4] = nil
					tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						TextColor3 = library.colors.otherElementText
					}):Play()
					keybindHeadline.Text = (keybindName and tostring(keybindName)) or "???"
					return key
				end
				local objectdata = {
					Options = options,
					Name = flag,
					Flag = flag,
					Type = "Keybind",
					Default = default,
					Parent = sectionFunctions,
					Instance = keybindButton,
					Get = function()
						return library_flags[flag]
					end,
					Set = set,
					RawSet = function(t, key)
						if nil == key and t ~= nil then
							key = t
						end
						if key == "nil" or key == "NONE" or key == "none" then
							key = nil
						end
						last_v = library_flags[flag]
						bindedKey = key
						library_flags[flag] = key
						if options.Location then
							options.Location[options.LocationFlag or flag] = key
						end
						justBinded = true
						return key
					end,
					Update = update,
					Reset = function()
						return set(nil, default)
					end
				}
				tabFunctions.Flags[flag], sectionFunctions.Flags[flag], elements[flag] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.NewKeybind = sectionFunctions.AddKeybind
			sectionFunctions.CreateKeybind = sectionFunctions.AddKeybind
			sectionFunctions.Keybind = sectionFunctions.AddKeybind
			sectionFunctions.Bind = sectionFunctions.AddKeybind
			function sectionFunctions:AddLabel(options, ...)
				options = (options and type(options) == "string" and resolvevararg("Label", options, ...)) or options
				local labelName, flag = options.Text or options.Value or options.Name, options.Flag or (function()
					library.unnamedlabels = 1 + (library.unnamedlabels or 0)
					return "Label" .. tostring(library.unnamedlabels)
				end)()
				if elements[flag] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flag .. "'", 3))
				end
				local newLabel = Instance_new("Frame")
				local labelHeadline = Instance_new("TextLabel")
				local labelPositioner = Instance_new("Frame")
				local labelButton = Instance_new("TextButton")
				newLabel.Name = "newLabel"
				newLabel.Parent = sectionHolder
				newLabel.BackgroundColor3 = Color3.new(1, 1, 1)
				newLabel.BackgroundTransparency = 1
				newLabel.Size = UDim2.new(1, 0, 0, 19)
				labelHeadline.Name = "labelHeadline"
				labelHeadline.Parent = newLabel
				labelHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				labelHeadline.BackgroundTransparency = 1
				labelHeadline.Position = UDim2.fromScale(0.031, 0.165842161)
				labelHeadline.Size = UDim2.fromOffset(215, 12)
				labelHeadline.Font = Enum.Font.Code
				labelHeadline.Text = (labelName and tostring(labelName)) or "Empty Text"
				labelHeadline.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {labelHeadline, "TextColor3", "elementText"}
				labelHeadline.TextSize = 14
				labelHeadline.TextXAlignment = Enum.TextXAlignment.Left
				labelPositioner.Name = "labelPositioner"
				labelPositioner.Parent = newLabel
				labelPositioner.BackgroundColor3 = Color3.new(1, 1, 1)
				labelPositioner.BackgroundTransparency = 1
				labelPositioner.Position = UDim2.new(0.00448430516)
				labelPositioner.Size = UDim2.fromOffset(214, 19)
				sectionFunctions:Update()
				local function set(t, str)
					if nil == str and t ~= nil then
						str = t
					end
					labelHeadline.Text = (nil ~= str and tostring(str)) or "Empty Text"
					return str
				end
				local default = labelHeadline.Text
				local objectdata = {
					Options = options,
					Name = flag,
					Flag = flag,
					Type = "Label",
					Default = default,
					Parent = sectionFunctions,
					Instance = labelHeadline,
					Get = function()
						return labelHeadline.Text, labelHeadline
					end,
					Set = set,
					RawSet = set,
					Update = function()
						return labelHeadline.Text
					end,
					Reset = function()
						return set(nil, default)
					end
				}
				tabFunctions.Flags[flag], sectionFunctions.Flags[flag], elements[flag] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.NewLabel = sectionFunctions.AddLabel
			sectionFunctions.CreateLabel = sectionFunctions.AddLabel
			sectionFunctions.Label = sectionFunctions.AddLabel
			sectionFunctions.Text = sectionFunctions.AddLabel
			function sectionFunctions:AddSlider(options, ...)
				options = (options and type(options) == "string" and resolvevararg("Slider", options, ...)) or options
				local sliderName, maxValue, minValue, presetValue, callback, flagName = assert(options.Name, "Missing Name for new slider."), assert(options.Max, "Missing Max for new slider."), assert(options.Min, "Missing Min for new slider."), options.Value, options.Callback, options.Flag or (function()
					library.unnamedsliders = 1 + (library.unnamedsliders or 0)
					return "Slider" .. tostring(library.unnamedsliders)
				end)()
				if elements[flagName] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flagName .. "'", 3))
				end
				local decimalprecision = tonumber(options.Decimals or options.Precision or options.Precise)
				if not decimalprecision and options.Max - options.Min <= 1 then
					decimalprecision = 1
				end
				if decimalprecision then
					decimalprecision = math.clamp(decimalprecision, 0, 99)
					if decimalprecision <= 0 then
						decimalprecision = nil
					end
					decimalprecision = tostring(decimalprecision)
				end
				local formattyp = options.Format and type(options.Format)
				local function resolvedisplay(val, was)
					local str = nil
					if decimalprecision then
						str = string.format("%0." .. decimalprecision .. "f", val)
					end
					str = str or tostring(val)
					if formattyp == "string" then
						return string.format(options.Format, val)
					elseif formattyp == "function" then
						local oof, g = pcall(options.Format, val, was)
						if not oof or not g then
							warn("Your format function for", sliderName, "Slider:", flagName, "has returned nothing. It should return a string to display.", debug.traceback(""))
							return "Format Function Errored"
						end
						return tostring(g)
					end
					return (sliderName or "???") .. ": " .. str
				end
				local usetextbox = options.Textbox or options.InputBox or options.CustomInput
				local newSlider = Instance_new("Frame")
				local slider = Instance_new("ImageLabel")
				local sliderInner = Instance_new("ImageLabel")
				local sliderColored = Instance_new("ImageLabel")
				local sliderHeadline = Instance_new("TextLabel")
				local startingValue = presetValue or minValue
				local sliderDragging = false
				newSlider.Name = "newSlider"
				newSlider.Parent = sectionHolder
				newSlider.BackgroundColor3 = Color3.new(1, 1, 1)
				newSlider.BackgroundTransparency = 1
				newSlider.Size = UDim2.new(1, 0, 0, 42)
				slider.Name = "slider"
				slider.Parent = newSlider
				slider.Active = true
				slider.BackgroundColor3 = library.colors.topGradient
				local colored_slider_BackgroundColor3 = {slider, "BackgroundColor3", "topGradient"}
				colored[1 + #colored] = colored_slider_BackgroundColor3
				slider.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {slider, "BorderColor3", "elementBorder"}
				slider.Position = UDim2.fromScale(0.031, 0.48)
				slider.Selectable = true
				slider.Size = (usetextbox and UDim2.fromOffset(156, 18)) or UDim2.fromOffset(206, 18)
				slider.Image = "rbxassetid://2454009026"
				slider.ImageColor3 = library.colors.bottomGradient
				local colored_slider_ImageColor3 = {slider, "ImageColor3", "bottomGradient"}
				colored[1 + #colored] = colored_slider_ImageColor3
				sliderInner.Name = "sliderInner"
				sliderInner.Parent = slider
				sliderInner.Active = true
				sliderInner.AnchorPoint = Vector2.new(0.5, 0.5)
				sliderInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {sliderInner, "BackgroundColor3", "topGradient"}
				sliderInner.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {sliderInner, "BorderColor3", "elementBorder"}
				sliderInner.Position = UDim2.fromScale(0.5, 0.5)
				sliderInner.Selectable = true
				sliderInner.Size = UDim2.new(1, -4, 1, -4)
				sliderInner.Image = "rbxassetid://2454009026"
				sliderInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {sliderInner, "ImageColor3", "bottomGradient"}
				sliderColored.Name = "sliderColored"
				sliderColored.Parent = sliderInner
				sliderColored.Active = true
				sliderColored.BackgroundColor3 = darkenColor(library.colors.main, 1.5)
				colored[1 + #colored] = {sliderColored, "BackgroundColor3", "main", 1.5}
				sliderColored.BorderSizePixel = 0
				sliderColored.Selectable = true
				sliderColored.Size = UDim2.fromScale(((startingValue or minValue) - minValue) / (maxValue - minValue), 1)
				sliderColored.Image = "rbxassetid://2454009026"
				sliderColored.ImageColor3 = darkenColor(library.colors.main, 2.5)
				colored[1 + #colored] = {sliderColored, "ImageColor3", "main", 2.5}
				sliderHeadline.Name = "sliderHeadline"
				sliderHeadline.Parent = newSlider
				sliderHeadline.Active = true
				sliderHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				sliderHeadline.BackgroundTransparency = 1
				sliderHeadline.Position = UDim2.new(0.031)
				sliderHeadline.Selectable = true
				sliderHeadline.Size = UDim2.fromOffset(206, 20)
				sliderHeadline.ZIndex = 5
				sliderHeadline.Font = Enum.Font.Code
				sliderHeadline.LineHeight = 1.15
				sliderHeadline.Text = resolvedisplay(startingValue)
				sliderHeadline.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {sliderHeadline, "TextColor3", "elementText"}
				sliderHeadline.TextSize = 14
				sliderHeadline.TextXAlignment = Enum.TextXAlignment.Left
				local realTextbox = nil
				local function Set(t, newValue)
					if nil == newValue and t ~= nil then
						newValue = t
					end
					minValue, maxValue = options.Min, options.Max
					if newValue and (options.IllegalInput or ((not minValue or newValue >= minValue) and (not maxValue or newValue <= maxValue))) then
						local last_val = library_flags[flagName]
						library_flags[flagName] = newValue
						if options.Location then
							options.Location[options.LocationFlag or flagName] = newValue
						end
						do
							local newValue = (options.IllegalInput and math.clamp(newValue, minValue or -math.huge, maxValue or math.huge)) or newValue
							tweenService:Create(sliderColored, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
								Size = UDim2.fromScale(((newValue or minValue) - minValue) / (maxValue - minValue), 1)
							}):Play()
						end
						sliderHeadline.Text = resolvedisplay(newValue, last_val)
						if usetextbox and realTextbox then
							realTextbox.Text = tostring(newValue)
						end
						if callback and (last_val ~= newValue or options.AllowDuplicateCalls) then
							task.spawn(callback, newValue, last_val)
						end
					end
					return newValue
				end
				if presetValue ~= nil then
					Set(presetValue)
				else
					library_flags[flagName] = startingValue
					if options.Location then
						options.Location[options.LocationFlag or flagName] = startingValue
					end
				end
				if usetextbox then
					if type(usetextbox) ~= "table" then
						usetextbox = options
					end
					local textbox = Instance_new("ImageLabel")
					local textboxInner = Instance_new("ImageLabel")
					realTextbox = Instance_new("TextBox")
					textbox.Name = "textbox"
					textbox.Parent = newSlider
					textbox.Active = true
					textbox.BackgroundColor3 = library.colors.topGradient
					local colored_textbox_BackgroundColor3 = {textbox, "BackgroundColor3", "topGradient"}
					colored[1 + #colored] = colored_textbox_BackgroundColor3
					textbox.BorderColor3 = library.colors.elementBorder
					colored[1 + #colored] = {textbox, "BorderColor3", "elementBorder"}
					textbox.Position = UDim2.new(1, -54, 0.48)
					textbox.Selectable = true
					textbox.Size = UDim2.fromOffset(43, 18)
					textbox.Image = "rbxassetid://2454009026"
					textbox.ImageColor3 = library.colors.bottomGradient
					local colored_textbox_ImageColor3 = {textbox, "ImageColor3", "bottomGradient"}
					colored[1 + #colored] = colored_textbox_ImageColor3
					textboxInner.Name = "textboxInner"
					textboxInner.Parent = textbox
					textboxInner.Active = true
					textboxInner.AnchorPoint = Vector2.new(0.5, 0.5)
					textboxInner.BackgroundColor3 = library.colors.topGradient
					colored[1 + #colored] = {textboxInner, "BackgroundColor3", "topGradient"}
					textboxInner.BorderColor3 = library.colors.elementBorder
					colored[1 + #colored] = {textboxInner, "BorderColor3", "elementBorder"}
					textboxInner.Position = UDim2.fromScale(0.5, 0.5)
					textboxInner.Selectable = true
					textboxInner.Size = UDim2.new(1, -4, 1, -4)
					textboxInner.Image = "rbxassetid://2454009026"
					textboxInner.ImageColor3 = library.colors.bottomGradient
					colored[1 + #colored] = {textboxInner, "ImageColor3", "bottomGradient"}
					realTextbox.Name = "realTextbox"
					realTextbox.Parent = textbox
					realTextbox.BackgroundColor3 = Color3.new(1, 1, 1)
					realTextbox.BackgroundTransparency = 1
					realTextbox.Position = UDim2.new(0.0295485705)
					realTextbox.Size = UDim2.fromScale(0.97, 1)
					realTextbox.ZIndex = 5
					realTextbox.ClearTextOnFocus = false
					realTextbox.Font = Enum.Font.Code
					realTextbox.LineHeight = 1.15
					realTextbox.Text = tostring(presetValue)
					realTextbox.TextColor3 = library.colors.otherElementText
					colored[1 + #colored] = {realTextbox, "TextColor3", "otherElementText"}
					realTextbox.TextSize = 14
					realTextbox.PlaceholderText = (presetValue ~= nil and tostring(presetValue)) or ""
					library.signals[1 + #library.signals] = realTextbox.FocusLost:Connect(function()
						local val = realTextbox.Text
						if usetextbox.PreFormat then
							local typ = type(usetextbox.PreFormat)
							if typ == "function" then
								local x, e = pcall(usetextbox.PreFormat, val)
								if not x and e then
									warn("Error in Pre-Format (Textbox " .. flagName .. "):", e)
								else
									val = e
								end
							end
						end
						val = (not usetextbox.Hex and not usetextbox.Binary and not usetextbox.Base and (tonumber(val) or tonumber(val:gsub("%D", ""), 10) or 0)) or tonumber(val, (usetextbox.Hex and 16) or (usetextbox.Binary and 2) or usetextbox.Base or 10) or 0
						if not options.IllegalInput and (options.Max or options.Min) then
							val = math.clamp(val, options.Min or -math.huge, options.Max or math.huge)
						end
						local decimalprecision = tonumber(options.Decimals or options.Precision or options.Precise)
						if decimalprecision then
							val = tonumber(string.format("%0." .. tostring(decimalprecision) .. "f", val))
						end
						if usetextbox.PostFormat then
							local typ = type(usetextbox.PostFormat)
							if typ == "function" then
								local x, e = pcall(usetextbox.PostFormat, val)
								if not x and e then
									warn("Error in Post-Format (Textbox " .. flagName .. "):", e)
								else
									val = e
								end
							end
						end
						Set((val and tonumber(val)) or presetValue or 0)
					end)
					library.signals[1 + #library.signals] = textbox.MouseEnter:Connect(function()
						colored_textbox_BackgroundColor3[3] = "main"
						colored_textbox_BackgroundColor3[4] = 1.5
						colored_textbox_ImageColor3[3] = "main"
						colored_textbox_ImageColor3[4] = 2.5
						tweenService:Create(textbox, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = darkenColor(library.colors.main, 1.5),
							ImageColor3 = darkenColor(library.colors.main, 2.5)
						}):Play()
					end)
					library.signals[1 + #library.signals] = textbox.MouseLeave:Connect(function()
						colored_textbox_BackgroundColor3[3] = "topGradient"
						colored_textbox_BackgroundColor3[4] = nil
						colored_textbox_ImageColor3[3] = "bottomGradient"
						colored_textbox_ImageColor3[4] = nil
						tweenService:Create(textbox, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = library.colors.topGradient,
							ImageColor3 = library.colors.bottomGradient
						}):Play()
					end)
				end
				sectionFunctions:Update()
				library.signals[1 + #library.signals] = slider.MouseEnter:Connect(function()
					colored_slider_BackgroundColor3[3] = "main"
					colored_slider_BackgroundColor3[4] = 1.5
					colored_slider_ImageColor3[3] = "main"
					colored_slider_ImageColor3[4] = 2.5
					tweenService:Create(slider, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = darkenColor(library.colors.main, 1.5),
						ImageColor3 = darkenColor(library.colors.main, 2.5)
					}):Play()
				end)
				library.signals[1 + #library.signals] = slider.MouseLeave:Connect(function()
					colored_slider_BackgroundColor3[3] = "topGradient"
					colored_slider_BackgroundColor3[4] = nil
					colored_slider_ImageColor3[3] = "bottomGradient"
					colored_slider_ImageColor3[4] = nil
					tweenService:Create(slider, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = library.colors.topGradient,
						ImageColor3 = library.colors.bottomGradient
					}):Play()
				end)
				local function sliding(input, sb, sc)
					local last_val = library_flags[flagName]
					local pos = UDim2.fromScale(math.clamp((input.Position.X - sb.AbsolutePosition.X) / sb.AbsoluteSize.X, 0, 1), 1)
					tweenService:Create(sc, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
						Size = pos
					}):Play()
					local sliderValue = nil
					if decimalprecision then
						sliderValue = tonumber(string.format("%0." .. decimalprecision .. "f", ((pos.X.Scale * maxValue) / maxValue) * (maxValue - minValue) + minValue))
					end
					sliderValue = sliderValue or tonumber(string.format("%0.2f", (floor(((pos.X.Scale * maxValue) / maxValue) * (maxValue - minValue) + minValue))))
					library_flags[flagName] = sliderValue
					if options.Location then
						options.Location[options.LocationFlag or flagName] = sliderValue
					end
					sliderHeadline.Text = resolvedisplay(sliderValue, last_val)
					if usetextbox and realTextbox then
						realTextbox.Text = tostring(sliderValue)
					end
					if callback and last_val ~= sliderValue then
						task.spawn(callback, sliderValue, last_val)
					end
					last_val = sliderValue
				end
				library.signals[1 + #library.signals] = newSlider.InputBegan:Connect(function(input)
					if not library.colorpicker and input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						sliderDragging = true
						isDraggingSomething = true
					end
				end)
				library.signals[1 + #library.signals] = newSlider.InputEnded:Connect(function(input)
					if not library.colorpicker and input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						sliderDragging = false
						isDraggingSomething = false
					end
				end)
				library.signals[1 + #library.signals] = newSlider.InputBegan:Connect(function(input)
					if not library.colorpicker and not isDraggingSomething and input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						isDraggingSomething = true
						sliding(input, sliderInner, sliderColored)
					end
				end)
				library.signals[1 + #library.signals] = userInputService.InputChanged:Connect(function(input)
					if not library.colorpicker and sliderDragging and Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not Enum.UserInputType.MouseMovement then
						sliding(input, sliderInner, sliderColored)
					end
				end)
				local default = library_flags[flagName]
				local function Update(t, last_val)
					if last_val == nil and t ~= nil and type(t) ~= "table" then
						last_val = t
					end
					sliderName, maxValue, minValue, callback = options.Name or sliderName, options.Max or maxValue, options.Min or minValue, options.Callback
					local newValue = library_flags[flagName]
					do
						local newValue = math.clamp(newValue, options.Min or -math.huge, options.Max or math.huge)
						tweenService:Create(sliderColored, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
							Size = UDim2.fromScale(((newValue or minValue) - minValue) / (maxValue - minValue), 1)
						}):Play()
					end
					sliderHeadline.Text = resolvedisplay(newValue, last_val)
					if usetextbox and realTextbox then
						realTextbox.Text = tostring(newValue)
					end
					return newValue
				end
				local objectdata = {
					Options = options,
					Name = flagName,
					Flag = flagName,
					Type = "Slider",
					Default = default,
					Parent = sectionFunctions,
					Instance = sliderHeadline,
					Set = Set,
					Get = function()
						return library_flags[flagName]
					end,
					SetConstraints = function(t, min, max)
						if t and type(t) ~= "table" then
							min, max = t, min
						end
						if min then
							options.Min = min
						end
						if max then
							options.Max = max
						end
						Update()
					end,
					SetMin = function(t, min)
						if min == nil and t ~= nil then
							min = t
						end
						if min and min ~= options.Min then
							options.Min = min
							Update()
						end
					end,
					SetMax = function(t, max)
						if max == nil and t ~= nil then
							max = t
						end
						if max and max ~= options.Max then
							options.Max = max
							Update()
						end
					end,
					Update = Update,
					RawSet = function(t, newValue)
						if nil == newValue and t ~= nil then
							newValue = t
						end
						local last_val = library_flags[flagName]
						library_flags[flagName] = newValue
						if options.Location then
							options.Location[options.LocationFlag or flagName] = newValue
						end
						Update(nil, last_val)
					end,
					Reset = function()
						return Set(nil, default)
					end
				}
				tabFunctions.Flags[flagName], sectionFunctions.Flags[flagName], elements[flagName] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.NewSlider = sectionFunctions.AddSlider
			sectionFunctions.CreateSlider = sectionFunctions.AddSlider
			sectionFunctions.NumberConstraint = sectionFunctions.AddSlider
			sectionFunctions.Slider = sectionFunctions.AddSlider
			sectionFunctions.Slide = sectionFunctions.AddSlider
			function sectionFunctions:AddSearchBox(options, ...)
				options = (options and type(options) == "string" and resolvevararg("SearchBox", options, ...)) or options
				local dropdownName, listt, val, callback, flagName = assert(options.Name, "Missing Name for new searchbox."), assert(options.List, "Missing List for new searchbox."), options.Value, options.Callback, options.Flag or (function()
					library.unnamedsearchbox = 1 + (library.unnamedsearchbox or 0)
					return "SearchBox" .. tostring(library.unnamedsearchbox)
				end)()
				if elements[flagName] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flagName .. "'", 3))
				end
				local newDropdown = Instance_new("Frame")
				local dropdown = Instance_new("ImageLabel")
				local dropdownInner = Instance_new("ImageLabel")
				local dropdownToggle = Instance_new("ImageButton")
				local dropdownSelection = Instance_new("TextBox")
				local dropdownHeadline = Instance_new("TextLabel")
				local dropdownHolderFrame = Instance_new("ImageLabel")
				local dropdownHolderInner = Instance_new("ImageLabel")
				local realDropdownHolder = Instance_new("ScrollingFrame")
				local realDropdownHolderList = Instance_new("UIListLayout")
				local dropdownEnabled = false
				local resolvelist = getresolver(listt, options.Filter)
				local list = resolvelist()
				local multiselect = options.MultiSelect or options.Multi or options.Multiple
				local passed_multiselect = multiselect and type(multiselect)
				local blankstring = not multiselect and (options.BlankValue or options.NoValueString or options.Nothing)
				local selectedOption = val or list[1] or blankstring
				local addcallback = options.ItemAdded or options.AddedCallback
				local delcallback = options.ItemRemoved or options.RemovedCallback
				local clrcallback = options.ItemsCleared or options.ClearedCallback
				local modcallback = options.ItemChanged or options.ChangedCallback
				if blankstring and val == nil then
					val = blankstring
				end
				if val ~= nil then
					selectedOption = val
				end
				if multiselect and (not selectedOption or type(selectedOption) ~= "table") then
					selectedOption = {}
				end
				local selectedObjects = {}
				local optionCount = 0
				newDropdown.Name = "newDropdown"
				newDropdown.Parent = sectionHolder
				newDropdown.BackgroundColor3 = Color3.new(1, 1, 1)
				newDropdown.BackgroundTransparency = 1
				newDropdown.Size = UDim2.new(1, 0, 0, 42)
				dropdown.Name = "dropdown"
				dropdown.Parent = newDropdown
				dropdown.Active = true
				dropdown.BackgroundColor3 = library.colors.topGradient
				local colored_dropdown_BackgroundColor3 = {dropdown, "BackgroundColor3", "topGradient"}
				colored[1 + #colored] = colored_dropdown_BackgroundColor3
				dropdown.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {dropdown, "BorderColor3", "elementBorder"}
				dropdown.Position = UDim2.fromScale(0.027, 0.45)
				dropdown.Selectable = true
				dropdown.Size = UDim2.fromOffset(206, 18)
				dropdown.Image = "rbxassetid://2454009026"
				dropdown.ImageColor3 = library.colors.bottomGradient
				local colored_dropdown_ImageColor3 = {dropdown, "ImageColor3", "bottomGradient"}
				colored[1 + #colored] = colored_dropdown_ImageColor3
				dropdownInner.Name = "dropdownInner"
				dropdownInner.Parent = dropdown
				dropdownInner.Active = true
				dropdownInner.AnchorPoint = Vector2.new(0.5, 0.5)
				dropdownInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {dropdownInner, "BackgroundColor3", "topGradient"}
				dropdownInner.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {dropdownInner, "BorderColor3", "elementBorder"}
				dropdownInner.Position = UDim2.fromScale(0.5, 0.5)
				dropdownInner.Selectable = true
				dropdownInner.Size = UDim2.new(1, -4, 1, -4)
				dropdownInner.Image = "rbxassetid://2454009026"
				dropdownInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {dropdownInner, "ImageColor3", "bottomGradient"}
				dropdownToggle.Name = "dropdownToggle"
				dropdownToggle.Parent = dropdown
				dropdownToggle.BackgroundColor3 = Color3.new(1, 1, 1)
				dropdownToggle.BackgroundTransparency = 1
				dropdownToggle.Position = UDim2.fromScale(0.9, 0.17)
				dropdownToggle.Rotation = 90
				dropdownToggle.Size = UDim2.fromOffset(12, 12)
				dropdownToggle.ZIndex = 6
				dropdownToggle.Image = "rbxassetid://71659683"
				dropdownToggle.ImageColor3 = Color3.fromRGB(171, 171, 171)
				dropdownSelection.Name = "dropdownSelection"
				dropdownSelection.Parent = dropdown
				dropdownSelection.BackgroundColor3 = Color3.new(1, 1, 1)
				dropdownSelection.BackgroundTransparency = 1
				dropdownSelection.Position = UDim2.new(0.0295485705)
				dropdownSelection.Size = UDim2.fromScale(0.85, 1)
				dropdownSelection.ZIndex = 5
				dropdownSelection.Font = Enum.Font.Code
				dropdownSelection.LineHeight = 1.15
				dropdownSelection.Text = (passed_multiselect == "string" and multiselect) or (multiselect and (blankstring or "Select Item(s)")) or (selectedOption and tostring(selectedOption)) or blankstring or "No Blank String"
				dropdownSelection.TextColor3 = library.colors.otherElementText
				colored[1 + #colored] = {dropdownSelection, "TextColor3", "otherElementText"}
				dropdownSelection.TextSize = 14
				dropdownSelection.TextXAlignment = Enum.TextXAlignment.Left
				dropdownSelection.ClearTextOnFocus = true
				dropdownHeadline.Name = "dropdownHeadline"
				dropdownHeadline.Parent = newDropdown
				dropdownHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				dropdownHeadline.BackgroundTransparency = 1
				dropdownHeadline.Position = UDim2.fromScale(0.034, 0.03)
				dropdownHeadline.Size = UDim2.fromOffset(167, 11)
				dropdownHeadline.Font = Enum.Font.Code
				dropdownHeadline.Text = (dropdownName and tostring(dropdownName)) or "???"
				dropdownHeadline.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {dropdownHeadline, "TextColor3", "elementText"}
				dropdownHeadline.TextSize = 14
				dropdownHeadline.TextXAlignment = Enum.TextXAlignment.Left
				dropdownHolderFrame.Name = "dropdownHolderFrame"
				dropdownHolderFrame.Parent = newDropdown
				dropdownHolderFrame.Active = true
				dropdownHolderFrame.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {dropdownHolderFrame, "BackgroundColor3", "topGradient"}
				dropdownHolderFrame.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {dropdownHolderFrame, "BorderColor3", "elementBorder"}
				dropdownHolderFrame.Position = UDim2.fromScale(0.025, 1.012)
				dropdownHolderFrame.Selectable = true
				dropdownHolderFrame.Size = UDim2.fromOffset(206, 22)
				dropdownHolderFrame.Visible = false
				dropdownHolderFrame.Image = "rbxassetid://2454009026"
				dropdownHolderFrame.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {dropdownHolderFrame, "ImageColor3", "bottomGradient"}
				dropdownHolderInner.Name = "dropdownHolderInner"
				dropdownHolderInner.Parent = dropdownHolderFrame
				dropdownHolderInner.Active = true
				dropdownHolderInner.AnchorPoint = Vector2.new(0.5, 0.5)
				dropdownHolderInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {dropdownHolderInner, "BackgroundColor3", "topGradient"}
				dropdownHolderInner.BorderColor3 = library.colors.elementBorder
				dropdownHolderInner.Position = UDim2.fromScale(0.5, 0.5)
				dropdownHolderInner.Selectable = true
				dropdownHolderInner.Size = UDim2.new(1, -4, 1, -4)
				dropdownHolderInner.Image = "rbxassetid://2454009026"
				dropdownHolderInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {dropdownHolderInner, "ImageColor3", "bottomGradient"}
				realDropdownHolder.Name = "realDropdownHolder"
				realDropdownHolder.Parent = dropdownHolderInner
				realDropdownHolder.BackgroundColor3 = Color3.new(1, 1, 1)
				realDropdownHolder.BackgroundTransparency = 1
				realDropdownHolder.Selectable = false
				realDropdownHolder.Size = UDim2.fromScale(1, 1)
				realDropdownHolder.CanvasSize = UDim2.new()
				realDropdownHolder.ScrollBarThickness = 5
				realDropdownHolder.ScrollingDirection = Enum.ScrollingDirection.Y
				realDropdownHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
				realDropdownHolder.ScrollBarImageTransparency = 0.5
				realDropdownHolder.ScrollBarImageColor3 = library.colors.section
				colored[1 + #colored] = {realDropdownHolder, "ScrollBarImageColor3", "section"}
				realDropdownHolderList.Name = "realDropdownHolderList"
				realDropdownHolderList.Parent = realDropdownHolder
				realDropdownHolderList.HorizontalAlignment = Enum.HorizontalAlignment.Center
				realDropdownHolderList.SortOrder = Enum.SortOrder.LayoutOrder
				sectionFunctions:Update()
				local restorezindex = {}
				library.signals[1 + #library.signals] = newDropdown.MouseEnter:Connect(function()
					colored_dropdown_BackgroundColor3[3] = "main"
					colored_dropdown_BackgroundColor3[4] = 1.5
					colored_dropdown_ImageColor3[3] = "main"
					colored_dropdown_ImageColor3[4] = 2.5
					tweenService:Create(dropdown, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = darkenColor(library.colors.main, 1.5),
						ImageColor3 = darkenColor(library.colors.main, 2.5)
					}):Play()
				end)
				library.signals[1 + #library.signals] = newDropdown.MouseLeave:Connect(function()
					if not dropdownEnabled then
						colored_dropdown_BackgroundColor3[3] = "topGradient"
						colored_dropdown_BackgroundColor3[4] = nil
						colored_dropdown_ImageColor3[3] = "bottomGradient"
						colored_dropdown_ImageColor3[4] = nil
						tweenService:Create(dropdown, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = library.colors.topGradient,
							ImageColor3 = library.colors.bottomGradient
						}):Play()
					end
				end)
				local function UpdateDropdownHolder()
					if optionCount >= 6 then
						realDropdownHolder.CanvasSize = UDim2:fromOffset(realDropdownHolderList.AbsoluteContentSize.Y + 2)
					elseif optionCount <= 5 then
						dropdownHolderFrame.Size = UDim2.fromOffset(206, realDropdownHolderList.AbsoluteContentSize.Y + 4)
					end
				end
				local function AddOptions(optionsTable, filter)
					if options.Sort then
						local didstuff, dosort = nil, options.Sort
						if type(dosort) == "function" then
							local g, h = pcall(table.sort, optionsTable, dosort)
							if g then
								didstuff = true
							elseif h then
								warn("Error sorting list:", h, debug.traceback(""))
							end
						end
						if not didstuff then
							table.sort(optionsTable, library.defaultSort)
						end
					end
					if blankstring and (optionsTable[1] ~= blankstring or table.find(optionsTable, blankstring, 2)) then
						local exists = table.find(optionsTable, blankstring)
						if exists then
							for _ = 1, 35 do
								table.remove(optionsTable, exists)
								exists = table.find(optionsTable, blankstring)
								if not exists then
									break
								end
							end
						end
						table.insert(optionsTable, 1, blankstring)
					end
					optionCount = 0
					realDropdownHolderList.Parent = nil
					realDropdownHolder:ClearAllChildren()
					realDropdownHolderList.Parent = realDropdownHolder
					for _, v in next, optionsTable do
						if not filter or tostring(v):lower():find(dropdownSelection.Text:lower(), 1, not options.RegEx) then
							optionCount = optionCount + 1
							UpdateDropdownHolder()
							local newOption = Instance_new("ImageLabel")
							local optionButton = Instance_new("TextButton")
							if selectedOption == v then
								selectedObjects[1] = newOption
								selectedObjects[2] = optionButton
							end
							newOption.Name = "Frame"
							newOption.Parent = realDropdownHolder
							local togged = (not multiselect and selectedOption == v) or (multiselect and table.find(selectedOption, v))
							newOption.BackgroundColor3 = (togged and library.colors.selectedOption) or library.colors.topGradient
							newOption.BorderSizePixel = 0
							newOption.Size = UDim2.fromOffset(202, 18)
							newOption.Image = "rbxassetid://2454009026"
							newOption.ImageColor3 = (togged and library.colors.unselectedOption) or library.colors.bottomGradient
							local stringed = tostring(v)
							optionButton.Name = stringed
							optionButton.Parent = newOption
							optionButton.Active = true
							optionButton.AnchorPoint = Vector2.new(0.5, 0.5)
							optionButton.BackgroundColor3 = Color3.new(1, 1, 1)
							optionButton.BackgroundTransparency = 1
							optionButton.Position = UDim2.fromScale(0.5, 0.5)
							optionButton.Selectable = true
							optionButton.Size = UDim2.new(1, -10, 1)
							optionButton.ZIndex = 5
							optionButton.Font = Enum.Font.Code
							optionButton.Text = (togged and (" " .. stringed)) or stringed
							optionButton.TextColor3 = (togged and library.colors.main) or library.colors.otherElementText
							optionButton.TextSize = 14
							optionButton.TextXAlignment = Enum.TextXAlignment.Left
							library.signals[1 + #library.signals] = optionButton[(multiselect and "MouseButton1Click") or "MouseButton1Down"]:Connect(function()
								if not library.colorpicker then
									dropdownSelection.Text = (passed_multiselect == "string" and multiselect) or blankstring or "Select Item(s)"
									restorezindex[newSection] = restorezindex[newSection] or newSection.ZIndex
									restorezindex[newDropdown] = restorezindex[newDropdown] or newDropdown.ZIndex
									restorezindex[sectionHolder] = restorezindex[sectionHolder] or sectionHolder.ZIndex
									if multiselect then
										local cloned = {unpack(selectedOption)}
										local togged = table.find(selectedOption, v)
										if togged then
											table.remove(selectedOption, togged)
										else
											selectedOption[1 + #selectedOption] = v
										end
										togged = table.find(selectedOption, v)
										optionButton.Text = (togged and (" " .. stringed)) or stringed
										newOption.BackgroundColor3 = (togged and library.colors.selectedOption) or library.colors.topGradient
										newOption.ImageColor3 = (togged and library.colors.unselectedOption) or library.colors.bottomGradient
										optionButton.TextColor3 = (togged and library.colors.main) or library.colors.otherElementText
										if callback then
											task.spawn(callback, selectedOption, cloned)
										end
										if togged then
											if addcallback then
												task.spawn(addcallback, v, selectedOption)
											end
										elseif delcallback then
											task.spawn(delcallback, v, selectedOption)
										end
										if modcallback then
											task.spawn(modcallback, v, togged, selectedOption)
										end
										if #selectedOption == 0 and clrcallback then
											task.spawn(clrcallback, selectedOption, cloned)
										end
										return
									else
										dropdownSelection.Text = stringed
										if selectedOption ~= v then
											local last_v = library_flags[flagName]
											selectedObjects[1].BackgroundColor3 = library.colors.topGradient
											selectedObjects[1].ImageColor3 = library.colors.bottomGradient
											selectedObjects[2].Text = selectedObjects[2].Name
											selectedObjects[2].TextColor3 = library.colors.otherElementText
											selectedOption = v
											selectedObjects[1] = newOption
											selectedObjects[2] = optionButton
											newOption.BackgroundColor3 = library.colors.selectedOption
											newOption.ImageColor3 = library.colors.unselectedOption
											optionButton.TextColor3 = library.colors.main
											dropdownHolderFrame.Visible = false
											dropdownToggle.Rotation = 90
											dropdownEnabled = false
											newDropdown.ZIndex = 1
											colored_dropdown_BackgroundColor3[3] = "topGradient"
											colored_dropdown_BackgroundColor3[4] = nil
											colored_dropdown_ImageColor3[3] = "bottomGradient"
											colored_dropdown_ImageColor3[4] = nil
											tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
												BackgroundColor3 = library.colors.topGradient,
												ImageColor3 = library.colors.bottomGradient
											}):Play()
											library_flags[flagName] = selectedOption
											if options.Location then
												options.Location[options.LocationFlag or flagName] = selectedOption
											end
											dropdownSelection.Text = tostring(selectedOption)
											if submenuOpen then
												submenuOpen = nil
											end
											if callback then
												task.spawn(callback, selectedOption, last_v)
											end
										else
											submenuOpen = nil
											dropdownToggle.Rotation = 90
											colored_dropdown_BackgroundColor3[3] = "topGradient"
											colored_dropdown_BackgroundColor3[4] = nil
											colored_dropdown_ImageColor3[3] = "bottomGradient"
											colored_dropdown_ImageColor3[4] = nil
											tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
												BackgroundColor3 = library.colors.topGradient,
												ImageColor3 = library.colors.bottomGradient
											}):Play()
											dropdownHolderFrame.Visible = false
										end
									end
									for ins, z in next, restorezindex do
										ins.ZIndex = z
									end
								end
							end)
							library.signals[1 + #library.signals] = optionButton.MouseEnter:Connect(function()
								tweenService:Create(newOption, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
									BackgroundColor3 = library.colors.hoveredOptionTop,
									ImageColor3 = library.colors.hoveredOptionBottom
								}):Play()
							end)
							library.signals[1 + #library.signals] = optionButton.MouseLeave:Connect(function()
								local togged = (not multiselect and selectedOption == v) or (multiselect and table.find(selectedOption, v))
								tweenService:Create(newOption, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
									BackgroundColor3 = (togged and library.colors.selectedOption) or library.colors.topGradient,
									ImageColor3 = (togged and library.colors.unselectedOption) or library.colors.bottomGradient
								}):Play()
							end)
							UpdateDropdownHolder()
						end
					end
				end
				local precisionscrolling = nil
				local showing = false
				local function display(dropdownEnabled, f)
					if submenuOpen == dropdown or submenuOpen == nil then
						if dropdownEnabled then
							list = resolvelist()
							AddOptions(list, f)
							submenuOpen = dropdown
							dropdownToggle.Rotation = 270
							restorezindex[newSection] = restorezindex[newSection] or newSection.ZIndex
							restorezindex[newDropdown] = restorezindex[newDropdown] or newDropdown.ZIndex
							restorezindex[sectionHolder] = restorezindex[sectionHolder] or sectionHolder.ZIndex
							newSection.ZIndex = 50 + newSection.ZIndex
							newDropdown.ZIndex = 2
							sectionHolder.ZIndex = 2
							colored_dropdown_BackgroundColor3[3] = "main"
							colored_dropdown_BackgroundColor3[4] = 1.5
							colored_dropdown_ImageColor3[3] = "main"
							colored_dropdown_ImageColor3[4] = 2.5
							tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
								BackgroundColor3 = darkenColor(library.colors.main, 1.5),
								ImageColor3 = darkenColor(library.colors.main, 2.5)
							}):Play()
							dropdownHolderFrame.Visible = true
							if not options.DisablePrecisionScrolling then
								local scrollrate = tonumber(options.ScrollButtonRate or options.ScrollRate) or 5
								local upkey = options.ScrollUpButton or library.scrollupbutton or shared.scrollupbutton or Enum.KeyCode.Up
								local downkey = options.ScrollDownButton or library.scrolldownbutton or shared.scrolldownbutton or Enum.KeyCode.Down
								precisionscrolling = (precisionscrolling and precisionscrolling:Disconnect() and nil) or userInputService.InputBegan:Connect(function(input)
									if input.UserInputType == Enum.UserInputType.Keyboard then
										local code = input.KeyCode
										local isup = code == upkey
										local isdown = code == downkey
										if isup or isdown then
											local txt = userInputService:GetFocusedTextBox()
											if not txt or txt == dropdownSelection then
												while wait_check() and userInputService:IsKeyDown(code) do
													realDropdownHolder.CanvasPosition = Vector2:new(math.clamp(realDropdownHolder.CanvasPosition.Y + ((isup and -scrollrate) or scrollrate), 0, realDropdownHolder.AbsoluteCanvasSize.Y))
												end
											end
										end
									end
								end)
								library.signals[1 + #library.signals] = precisionscrolling
							end
						else
							submenuOpen = nil
							dropdownToggle.Rotation = 90
							colored_dropdown_BackgroundColor3[3] = "topGradient"
							colored_dropdown_BackgroundColor3[4] = nil
							colored_dropdown_ImageColor3[3] = "bottomGradient"
							colored_dropdown_ImageColor3[4] = nil
							tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
								BackgroundColor3 = library.colors.topGradient,
								ImageColor3 = library.colors.bottomGradient
							}):Play()
							dropdownHolderFrame.Visible = false
							for ins, z in next, restorezindex do
								ins.ZIndex = z
							end
							precisionscrolling = (precisionscrolling and precisionscrolling:Disconnect() and nil) or nil
						end
					end
					showing = dropdownEnabled
				end
				local Set = (multiselect and function(t, dat)
					if nil == dat and t ~= nil then
						dat = t
					end
					local lastv = library_flags[flagName]
					if not lastv or selectedOption ~= lastv then
						if lastv and type(lastv) == "table" then
							selectedOption = library_flags[flagName]
						else
							library_flags[flagName] = selectedOption
						end
						warn("Attempting to use new table for", flagName, " Please use :Set(), because setting it through flags table may cause errors", debug.traceback(""))
						lastv = library_flags[flagName]
					end
					local cloned = {unpack(selectedOption)}
					if not dat then
						if #selectedOption ~= 0 then
							table.clear(selectedOption)
							if callback then
								task.spawn(callback, selectedOption, cloned)
							end
						end
						return selectedOption
					elseif type(dat) ~= "table" then
						warn("Expected table for argument #1 on Set for MultiSelect searchbox. Got", dat, debug.traceback(""))
						return selectedOption
					end
					for k = table.pack(unpack(dat)).n, 1, -1 do
						if dat[k] == nil then
							table.remove(dat, k)
						end
					end
					local proceed = #cloned ~= #dat
					table.clear(selectedOption)
					for k, v in next, dat do
						selectedOption[k] = v
						if not proceed and cloned[k] ~= v then
							proceed = 1
						end
					end
					dropdownSelection.Text = (passed_multiselect == "string" and multiselect) or blankstring or "Select Item(s)"
					if proceed and callback then
						task.spawn(callback, selectedOption, cloned)
					end
					return selectedOption
				end) or function(t, str)
					if nil == str and t then
						str = t
					end
					local last_v = library_flags[flagName]
					selectedOption = str
					library_flags[flagName] = str
					if options.Location then
						options.Location[options.LocationFlag or flagName] = str
					end
					local sstr = (selectedOption and tostring(selectedOption)) or blankstring or "No Blank String"
					if dropdownSelection.Text ~= sstr then
						dropdownSelection.Text = sstr
					end
					if callback and (last_v ~= str or options.AllowDuplicateCalls) then
						task.spawn(callback, str, last_v)
					end
					return str
				end
				if val ~= nil then
					Set(val)
				else
					library_flags[flagName] = selectedOption
					if options.Location then
						options.Location[options.LocationFlag or flagName] = selectedOption
					end
				end
				library.signals[1 + #library.signals] = dropdownToggle.MouseButton1Click:Connect(function()
					showing = not showing
					display(showing)
				end)
				library.signals[1 + #library.signals] = dropdownSelection.Focused:Connect(function()
					showing = true
					display(true)
				end)
				library.signals[1 + #library.signals] = dropdownSelection:GetPropertyChangedSignal("Text"):Connect(function()
					if showing then
						display(true, #dropdownSelection.Text > 0)
					end
				end)
				if not multiselect then
					library.signals[1 + #library.signals] = dropdownSelection.FocusLost:Connect(function(b)
						if showing then
							wait()
						end
						showing = false
						display(false)
						if b then
							Set(dropdownSelection.Text)
						end
					end)
				end
				AddOptions(list)
				local default = library_flags[flagName]
				local function update()
					dropdownName, callback = options.Name or dropdownName, options.Callback
					local sstr = (passed_multiselect == "string" and multiselect) or (not multiselect and library_flags[flagName] and tostring(library_flags[flagName])) or (not multiselect and selectedOption and tostring(selectedOption)) or blankstring or "Nothing"
					if dropdownSelection.Text ~= sstr then
						dropdownSelection.Text = sstr
					end
					dropdownHeadline.Text = (dropdownName and tostring(dropdownName)) or "???"
					return sstr
				end
				local function validate(fallbackValue)
					if list and table.find(list, library_flags[flagName]) then
						update()
						return true
					end
					if fallbackValue ~= nil then
						if fallbackValue == "__DEFAULT" then
							fallbackValue = default
						end
					else
						fallbackValue = list[1]
					end
					if multiselect and type(fallbackValue) ~= "table" then
						fallbackValue = {fallbackValue}
					end
					return Set(fallbackValue)
				end
				local objectdata = {
					Options = options,
					Name = flagName,
					Flag = flagName,
					Type = "SearchBox",
					Default = default,
					Parent = sectionFunctions,
					Instance = dropdownSelection,
					Validate = validate,
					Set = Set,
					RawSet = ((multiselect and function(t, dat)
						if nil == dat and t ~= nil then
							dat = t
						end
						local lastv = library_flags[flagName]
						if not lastv or selectedOption ~= lastv then
							if lastv and type(lastv) == "table" then
								selectedOption = library_flags[flagName]
							else
								library_flags[flagName] = selectedOption
							end
							warn("Attempting to use new table for", flagName, " Please use :Set(), as setting through flags table may cause errors", debug.traceback(""))
							lastv = library_flags[flagName]
						end
						local cloned = {unpack(selectedOption)}
						if not dat then
							if #selectedOption ~= 0 then
								table.clear(selectedOption)
								if callback then
									task.spawn(callback, selectedOption, cloned)
								end
							end
							return selectedOption
						elseif type(dat) ~= "table" then
							warn("Expected table for argument #1 on Set for MultiSelect searchbox. Got", dat, debug.traceback(""))
							return selectedOption
						end
						for k = table.pack(unpack(dat)).n, 1, -1 do
							if dat[k] == nil then
								table.remove(dat, k)
							end
						end
						local proceed = #cloned ~= #dat
						table.clear(selectedOption)
						for k, v in next, dat do
							selectedOption[k] = v
							if not proceed and cloned[k] ~= v then
								proceed = 1
							end
						end
						update()
						return selectedOption
					end) or function(t, str)
						if nil == str and t then
							str = t
						end
						selectedOption = str
						library_flags[flagName] = str
						if options.Location then
							options.Location[options.LocationFlag or flagName] = str
						end
						update()
						return str
					end),
					Get = function()
						return library_flags[flagName]
					end,
					Update = update,
					Reset = function()
						return Set(nil, default)
					end
				}
				function objectdata.UpdateList(t, listt, updateValues)
					if (nil == listt and t ~= nil) or (type(t) == "table" and type(listt) ~= "table") then
						listt, updateValues = t, listt
					end
					if listt == objectdata then
						listt = nil
					end
					resolvelist = getresolver(listt or options.List, options.Filter, options.Method)
					list = resolvelist()
					if updateValues then
						validate()
					end
					if showing then
						display(false)
						display(true)
					end
					return list
				end
				tabFunctions.Flags[flagName], sectionFunctions.Flags[flagName], elements[flagName] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.NewSearchBox = sectionFunctions.AddSearchBox
			sectionFunctions.CreateSearchBox = sectionFunctions.AddSearchBox
			sectionFunctions.SearchBox = sectionFunctions.AddSearchBox
			sectionFunctions.CreateSearchbox = sectionFunctions.AddSearchBox
			sectionFunctions.NewSearchbox = sectionFunctions.AddSearchBox
			sectionFunctions.Searchbox = sectionFunctions.AddSearchBox
			sectionFunctions.Sbox = sectionFunctions.AddSearchBox
			sectionFunctions.SBox = sectionFunctions.AddSearchBox
			if isfolder and makefolder and listfiles and readfile and writefile then
				function sectionFunctions:AddPersistence(options, ...)
					options = (options and type(options) == "string" and resolvevararg("Tab", options, ...)) or options
					local dropdownName, custom_workspace, val, persistiveflags, suffix, callback, loadcallback, savecallback, postload, postsave, flagName = assert(options.Name, "Missing Name for new persistence."), options.Workspace or library.WorkspaceName, options.Value, options.Persistive or options.Flags or "all", options.Suffix, options.Callback, options.LoadCallback, options.SaveCallback, options.PostLoadCallback, options.PostSaveCallback, options.Flag or (function()
						library.unnamedpersistence = 1 + (library.unnamedpersistence or 0)
						return "Persistence" .. tostring(library.unnamedpersistence)
					end)()
					if elements[flagName] ~= nil then
						warn(debug.traceback("Warning! Re-used flag '" .. flagName .. "'", 3))
					end
					local designerpersists = options.Desginer
					local newDropdown = Instance_new("Frame")
					local dropdown = Instance_new("ImageLabel")
					local dropdownInner = Instance_new("ImageLabel")
					local dropdownToggle = Instance_new("ImageButton")
					local dropdownSelection = Instance_new("TextBox")
					local dropdownHeadline = Instance_new("TextLabel")
					local dropdownHolderFrame = Instance_new("ImageLabel")
					local dropdownHolderInner = Instance_new("ImageLabel")
					local realDropdownHolder = Instance_new("ScrollingFrame")
					local realDropdownHolderList = Instance_new("UIListLayout")
					local dropdownEnabled = false
					if not isfolder("./Function Lib") then
						makefolder("./Function Lib")
					end
					local common_string = "./Function Lib/" .. tostring(custom_workspace or library.WorkspaceName)
					local function resolvelist(nofold)
						if custom_workspace ~= options.Workspace then
							custom_workspace = options.Workspace
							common_string = "./Function Lib/" .. tostring(custom_workspace or library.WorkspaceName)
						end
						if not isfolder or not makefolder or not listfiles then
							return {}
						end
						if not isfolder(common_string) then
							if nofold then
								return {}
							end
							makefolder(common_string)
						end
						assert(isfolder(common_string), "Couldn't create folder: " .. tostring(library.WorkspaceName or "No workspace name?"))
						local names, files = {}, listfiles(common_string)
						if #files > 0 then
							local len = #common_string + 2
							for _, f in next, files do
								names[1 + #names] = string.sub(f, len, -5)
							end
							table.sort(names)
						end
						return names
					end
					local list = resolvelist(true)
					local blankstring = options.BlankValue or options.NoValueString or options.Nothing
					local selectedObjects = {}
					local optionCount = 0
					if blankstring and val == nil then
						val = blankstring
					end
					local selectedOption = val or blankstring or list[1]
					newDropdown.Name = "newDropdown"
					newDropdown.Parent = sectionHolder
					newDropdown.BackgroundColor3 = Color3.new(1, 1, 1)
					newDropdown.BackgroundTransparency = 1
					newDropdown.Size = UDim2.new(1, 0, 0, 42)
					dropdown.Name = "dropdown"
					dropdown.Parent = newDropdown
					dropdown.Active = true
					dropdown.BackgroundColor3 = library.colors.topGradient
					local colored_dropdown_BackgroundColor3 = {dropdown, "BackgroundColor3", "topGradient"}
					colored[1 + #colored] = colored_dropdown_BackgroundColor3
					dropdown.BorderColor3 = library.colors.elementBorder
					colored[1 + #colored] = {dropdown, "BorderColor3", "elementBorder"}
					dropdown.Position = UDim2.fromScale(0.027, 0.45)
					dropdown.Selectable = true
					dropdown.Size = UDim2.fromOffset(206, 18)
					dropdown.Image = "rbxassetid://2454009026"
					dropdown.ImageColor3 = library.colors.bottomGradient
					local colored_dropdown_ImageColor3 = {dropdown, "ImageColor3", "bottomGradient"}
					colored[1 + #colored] = colored_dropdown_ImageColor3
					dropdownInner.Name = "dropdownInner"
					dropdownInner.Parent = dropdown
					dropdownInner.Active = true
					dropdownInner.AnchorPoint = Vector2.new(0.5, 0.5)
					dropdownInner.BackgroundColor3 = library.colors.topGradient
					colored[1 + #colored] = {dropdownInner, "BackgroundColor3", "topGradient"}
					dropdownInner.BorderColor3 = library.colors.elementBorder
					colored[1 + #colored] = {dropdownInner, "BorderColor3", "elementBorder"}
					dropdownInner.Position = UDim2.fromScale(0.5, 0.5)
					dropdownInner.Selectable = true
					dropdownInner.Size = UDim2.new(1, -4, 1, -4)
					dropdownInner.Image = "rbxassetid://2454009026"
					dropdownInner.ImageColor3 = library.colors.bottomGradient
					colored[1 + #colored] = {dropdownInner, "ImageColor3", "bottomGradient"}
					dropdownToggle.Name = "dropdownToggle"
					dropdownToggle.Parent = dropdown
					dropdownToggle.BackgroundColor3 = Color3.new(1, 1, 1)
					dropdownToggle.BackgroundTransparency = 1
					dropdownToggle.Position = UDim2.fromScale(0.9, 0.17)
					dropdownToggle.Rotation = 90
					dropdownToggle.Size = UDim2.fromOffset(12, 12)
					dropdownToggle.ZIndex = 2
					dropdownToggle.Image = "rbxassetid://71659683"
					dropdownToggle.ImageColor3 = Color3.fromRGB(171, 171, 171)
					dropdownSelection.Name = "dropdownSelection"
					dropdownSelection.Parent = dropdown
					dropdownSelection.BackgroundColor3 = Color3.new(1, 1, 1)
					dropdownSelection.BackgroundTransparency = 1
					dropdownSelection.Position = UDim2.new(0.0295485705)
					dropdownSelection.Size = UDim2.fromScale(0.97, 1)
					dropdownSelection.ZIndex = 5
					dropdownSelection.Font = Enum.Font.Code
					dropdownSelection.LineHeight = 1.15
					dropdownSelection.Text = (selectedOption and tostring(selectedOption)) or "nil"
					dropdownSelection.TextColor3 = library.colors.otherElementText
					colored[1 + #colored] = {dropdownSelection, "TextColor3", "otherElementText"}
					dropdownSelection.TextSize = 14
					dropdownSelection.TextXAlignment = Enum.TextXAlignment.Left
					dropdownHeadline.Name = "dropdownHeadline"
					dropdownHeadline.Parent = newDropdown
					dropdownHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
					dropdownHeadline.BackgroundTransparency = 1
					dropdownHeadline.Position = UDim2.fromScale(0.034, 0.03)
					dropdownHeadline.Size = UDim2.fromOffset(167, 11)
					dropdownHeadline.Font = Enum.Font.Code
					dropdownHeadline.Text = (dropdownName and tostring(dropdownName)) or "???"
					dropdownHeadline.TextColor3 = library.colors.elementText
					colored[1 + #colored] = {dropdownHeadline, "TextColor3", "elementText"}
					dropdownHeadline.TextSize = 14
					dropdownHeadline.TextXAlignment = Enum.TextXAlignment.Left
					dropdownHolderFrame.Name = "dropdownHolderFrame"
					dropdownHolderFrame.Parent = newDropdown
					dropdownHolderFrame.Active = true
					dropdownHolderFrame.BackgroundColor3 = library.colors.topGradient
					colored[1 + #colored] = {dropdownHolderFrame, "BackgroundColor3", "topGradient"}
					dropdownHolderFrame.BorderColor3 = library.colors.elementBorder
					colored[1 + #colored] = {dropdownHolderFrame, "BorderColor3", "elementBorder"}
					dropdownHolderFrame.Position = UDim2.fromScale(0.025, 1.012)
					dropdownHolderFrame.Selectable = true
					dropdownHolderFrame.Size = UDim2.fromOffset(206, 22)
					dropdownHolderFrame.Visible = false
					dropdownHolderFrame.Image = "rbxassetid://2454009026"
					dropdownHolderFrame.ImageColor3 = library.colors.bottomGradient
					colored[1 + #colored] = {dropdownHolderFrame, "ImageColor3", "bottomGradient"}
					dropdownHolderInner.Name = "dropdownHolderInner"
					dropdownHolderInner.Parent = dropdownHolderFrame
					dropdownHolderInner.Active = true
					dropdownHolderInner.AnchorPoint = Vector2.new(0.5, 0.5)
					dropdownHolderInner.BackgroundColor3 = library.colors.topGradient
					colored[1 + #colored] = {dropdownHolderInner, "BackgroundColor3", "topGradient"}
					dropdownHolderInner.BorderColor3 = library.colors.elementBorder
					colored[1 + #colored] = {dropdownHolderInner, "BorderColor3", "elementBorder"}
					dropdownHolderInner.Position = UDim2.fromScale(0.5, 0.5)
					dropdownHolderInner.Selectable = true
					dropdownHolderInner.Size = UDim2.new(1, -4, 1, -4)
					dropdownHolderInner.Image = "rbxassetid://2454009026"
					dropdownHolderInner.ImageColor3 = library.colors.bottomGradient
					colored[1 + #colored] = {dropdownHolderInner, "ImageColor3", "bottomGradient"}
					realDropdownHolder.Name = "realDropdownHolder"
					realDropdownHolder.Parent = dropdownHolderInner
					realDropdownHolder.BackgroundColor3 = Color3.new(1, 1, 1)
					realDropdownHolder.BackgroundTransparency = 1
					realDropdownHolder.Selectable = false
					realDropdownHolder.Size = UDim2.fromScale(1, 1)
					realDropdownHolder.CanvasSize = UDim2.new()
					realDropdownHolder.ScrollBarThickness = 5
					realDropdownHolder.ScrollingDirection = Enum.ScrollingDirection.Y
					realDropdownHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
					realDropdownHolder.ScrollBarImageTransparency = 0.5
					realDropdownHolder.ScrollBarImageColor3 = library.colors.section
					colored[1 + #colored] = {realDropdownHolder, "ScrollBarImageColor3", "section"}
					realDropdownHolderList.Name = "realDropdownHolderList"
					realDropdownHolderList.Parent = realDropdownHolder
					realDropdownHolderList.HorizontalAlignment = Enum.HorizontalAlignment.Center
					realDropdownHolderList.SortOrder = Enum.SortOrder.LayoutOrder
					sectionFunctions:Update()
					library.signals[1 + #library.signals] = newDropdown.MouseEnter:Connect(function()
						colored_dropdown_BackgroundColor3[3] = "main"
						colored_dropdown_BackgroundColor3[4] = 1.5
						colored_dropdown_ImageColor3[3] = "main"
						colored_dropdown_ImageColor3[4] = 2.5
						tweenService:Create(dropdown, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = darkenColor(library.colors.main, 1.5),
							ImageColor3 = darkenColor(library.colors.main, 2.5)
						}):Play()
					end)
					library.signals[1 + #library.signals] = newDropdown.MouseLeave:Connect(function()
						if not dropdownEnabled then
							colored_dropdown_BackgroundColor3[3] = "topGradient"
							colored_dropdown_BackgroundColor3[4] = nil
							colored_dropdown_ImageColor3[3] = "bottomGradient"
							colored_dropdown_ImageColor3[4] = nil
							tweenService:Create(dropdown, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
								BackgroundColor3 = library.colors.topGradient,
								ImageColor3 = library.colors.bottomGradient
							}):Play()
						end
					end)
					local restorezindex = {}
					local function UpdateDropdownHolder()
						if optionCount >= 6 then
							realDropdownHolder.CanvasSize = UDim2:fromOffset(realDropdownHolderList.AbsoluteContentSize.Y + 2)
						elseif optionCount <= 5 then
							dropdownHolderFrame.Size = UDim2.fromOffset(206, (realDropdownHolderList.AbsoluteContentSize.Y + 4))
						end
					end
					local function AddOptions(optionsTable, filter)
						if options.Sort then
							local didstuff, dosort = nil, options.Sort
							if type(dosort) == "function" then
								local g, h = pcall(table.sort, optionsTable, dosort)
								if g then
									didstuff = true
								elseif h then
									warn("Error sorting list:", h, debug.traceback(""))
								end
							end
							if not didstuff then
								table.sort(optionsTable, library.defaultSort)
							end
						end
						if blankstring and (optionsTable[1] ~= blankstring or table.find(optionsTable, blankstring, 2)) then
							local exists = table.find(optionsTable, blankstring)
							if exists then
								for _ = 1, 35 do
									table.remove(optionsTable, exists)
									exists = table.find(optionsTable, blankstring)
									if not exists then
										break
									end
								end
							end
							table.insert(optionsTable, 1, blankstring)
						end
						optionCount = 0
						realDropdownHolderList.Parent = nil
						realDropdownHolder:ClearAllChildren()
						realDropdownHolderList.Parent = realDropdownHolder
						for _, v in next, optionsTable do
							if not filter or tostring(v):lower():find(dropdownSelection.Text:lower(), 1, true) then
								optionCount = optionCount + 1
								UpdateDropdownHolder()
								local newOption = Instance_new("ImageLabel")
								local optionButton = Instance_new("TextButton")
								if selectedOption == v or not selectedObjects[1] or not selectedObjects[2] then
									selectedObjects[1] = newOption
									selectedObjects[2] = optionButton
								end
								newOption.Name = "Frame"
								newOption.Parent = realDropdownHolder
								newOption.BackgroundColor3 = (selectedOption == v and library.colors.selectedOption or library.colors.topGradient)
								newOption.BorderSizePixel = 0
								newOption.Size = UDim2.fromOffset(202, 18)
								newOption.Image = "rbxassetid://2454009026"
								newOption.ImageColor3 = (selectedOption == v and library.colors.unselectedOption or library.colors.bottomGradient)
								optionButton.Name = tostring(v)
								optionButton.Parent = newOption
								optionButton.AnchorPoint = Vector2.new(0.5, 0.5)
								optionButton.BackgroundColor3 = Color3.new(1, 1, 1)
								optionButton.BackgroundTransparency = 1
								optionButton.Position = UDim2.fromScale(0.5, 0.5)
								optionButton.Size = UDim2.new(1, -10, 1)
								optionButton.ZIndex = 5
								optionButton.Font = Enum.Font.Code
								optionButton.Text = (selectedOption == v and " " .. tostring(v)) or tostring(v)
								optionButton.TextColor3 = (selectedOption == v and library.colors.main or library.colors.otherElementText)
								optionButton.TextSize = 14
								optionButton.TextXAlignment = Enum.TextXAlignment.Left
								library.signals[1 + #library.signals] = optionButton.MouseButton1Down:Connect(function()
									dropdownSelection.Text = tostring(v)
									restorezindex[newSection] = restorezindex[newSection] or newSection.ZIndex
									restorezindex[newDropdown] = restorezindex[newDropdown] or newDropdown.ZIndex
									restorezindex[sectionHolder] = restorezindex[sectionHolder] or sectionHolder.ZIndex
									if selectedOption ~= v then
										local last_v = library_flags[flagName]
										selectedObjects[1].BackgroundColor3 = library.colors.topGradient
										selectedObjects[1].ImageColor3 = library.colors.bottomGradient
										selectedObjects[2].Text = selectedObjects[2].Name
										selectedObjects[2].TextColor3 = library.colors.otherElementText
										selectedOption = v
										selectedObjects[1] = newOption
										selectedObjects[2] = optionButton
										newOption.BackgroundColor3 = library.colors.selectedOption
										newOption.ImageColor3 = library.colors.unselectedOption
										optionButton.TextColor3 = library.colors.main
										dropdownHolderFrame.Visible = false
										dropdownToggle.Rotation = 90
										dropdownEnabled = false
										colored_dropdown_BackgroundColor3[3] = "topGradient"
										colored_dropdown_BackgroundColor3[4] = nil
										colored_dropdown_ImageColor3[3] = "bottomGradient"
										colored_dropdown_ImageColor3[4] = nil
										tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
											BackgroundColor3 = library.colors.topGradient,
											ImageColor3 = library.colors.bottomGradient
										}):Play()
										library_flags[flagName] = selectedOption
										if options.Location then
											options.Location[options.LocationFlag or flagName] = selectedOption
										end
										dropdownSelection.Text = tostring(selectedOption)
										if submenuOpen then
											submenuOpen = nil
										end
										if callback then
											task.spawn(callback, selectedOption, last_v)
										end
									else
										submenuOpen = nil
										dropdownToggle.Rotation = 90
										newDropdown.ZIndex = 1
										sectionHolder.ZIndex = 1
										colored_dropdown_BackgroundColor3[3] = "topGradient"
										colored_dropdown_BackgroundColor3[4] = nil
										colored_dropdown_ImageColor3[3] = "bottomGradient"
										colored_dropdown_ImageColor3[4] = nil
										tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
											BackgroundColor3 = library.colors.topGradient,
											ImageColor3 = library.colors.bottomGradient
										}):Play()
										dropdownHolderFrame.Visible = false
									end
									for ins, z in next, restorezindex do
										ins.ZIndex = z
									end
								end)
								library.signals[1 + #library.signals] = optionButton.MouseEnter:Connect(function()
									tweenService:Create(newOption, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
										BackgroundColor3 = library.colors.hoveredOptionTop,
										ImageColor3 = library.colors.hoveredOptionBottom
									}):Play()
								end)
								library.signals[1 + #library.signals] = optionButton.MouseLeave:Connect(function()
									tweenService:Create(newOption, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
										BackgroundColor3 = library.colors.unhoveredOptionTop,
										ImageColor3 = library.colors.unhoveredOptionBottom
									}):Play()
								end)
								UpdateDropdownHolder()
							end
						end
					end
					local precisionscrolling = nil
					local showing = false
					local function display(dropdownEnabled, f)
						if submenuOpen == dropdown or submenuOpen == nil then
							if dropdownEnabled then
								list = resolvelist(true)
								AddOptions(list, f)
								submenuOpen = dropdown
								restorezindex[newSection] = restorezindex[newSection] or newSection.ZIndex
								restorezindex[newDropdown] = restorezindex[newDropdown] or newDropdown.ZIndex
								restorezindex[sectionHolder] = restorezindex[sectionHolder] or sectionHolder.ZIndex
								newSection.ZIndex = 50 + newSection.ZIndex
								dropdownToggle.Rotation = 270
								newDropdown.ZIndex = 2
								sectionHolder.ZIndex = 2
								colored_dropdown_BackgroundColor3[3] = "main"
								colored_dropdown_BackgroundColor3[4] = 1.5
								colored_dropdown_ImageColor3[3] = "main"
								colored_dropdown_ImageColor3[4] = 2.5
								tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
									BackgroundColor3 = darkenColor(library.colors.main, 1.5),
									ImageColor3 = darkenColor(library.colors.main, 2.5)
								}):Play()
								dropdownHolderFrame.Visible = true
								if not options.DisablePrecisionScrolling then
									local upkey = options.ScrollUpButton or library.scrollupbutton or shared.scrollupbutton or Enum.KeyCode.Up
									local downkey = options.ScrollDownButton or library.scrolldownbutton or shared.scrolldownbutton or Enum.KeyCode.Down
									precisionscrolling = (precisionscrolling and precisionscrolling:Disconnect() and nil) or userInputService.InputBegan:Connect(function(input)
										if input.UserInputType == Enum.UserInputType.Keyboard then
											local code = input.KeyCode
											local isup = code == upkey
											local isdown = code == downkey
											if isup or isdown then
												local txt = userInputService:GetFocusedTextBox()
												if not txt then
													while wait_check() and userInputService:IsKeyDown(code) do
														realDropdownHolder.CanvasPosition = Vector2:new(math.clamp(realDropdownHolder.CanvasPosition.Y + ((isup and -5) or 5), 0, realDropdownHolder.AbsoluteCanvasSize.Y))
													end
												end
											end
										end
									end)
									library.signals[1 + #library.signals] = precisionscrolling
								end
							else
								submenuOpen = nil
								dropdownToggle.Rotation = 90
								colored_dropdown_BackgroundColor3[3] = "topGradient"
								colored_dropdown_BackgroundColor3[4] = nil
								colored_dropdown_ImageColor3[3] = "bottomGradient"
								colored_dropdown_ImageColor3[4] = nil
								tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
									BackgroundColor3 = library.colors.topGradient,
									ImageColor3 = library.colors.bottomGradient
								}):Play()
								dropdownHolderFrame.Visible = false
								for ins, z in next, restorezindex do
									ins.ZIndex = z
								end
								precisionscrolling = (precisionscrolling and precisionscrolling:Disconnect() and nil) or nil
							end
							showing = dropdownEnabled
						end
					end
					local last_v = nil
					local function Set(t, str)
						if nil == str and t then
							str = t
						end
						selectedOption = str
						last_v = library_flags[flagName]
						library_flags[flagName] = str
						if options.Location then
							options.Location[options.LocationFlag or flagName] = str
						end
						local sstr = (selectedOption and tostring(selectedOption)) or blankstring or "No Blank String"
						if dropdownSelection.Text ~= sstr then
							dropdownSelection.Text = sstr
						end
						if callback and (last_v ~= str or options.AllowDuplicateCalls) then
							task.spawn(callback, str, last_v)
						end
						return str
					end
					if val ~= nil then
						Set(val)
					else
						Set("Filename")
					end
					library.signals[1 + #library.signals] = dropdownSelection.Focused:Connect(function()
						showing = true
						display(true)
					end)
					library.signals[1 + #library.signals] = dropdownSelection:GetPropertyChangedSignal("Text"):Connect(function()
						if showing then
							display(true, #dropdownSelection.Text > 0)
						end
					end)
					library.signals[1 + #library.signals] = dropdownSelection.FocusLost:Connect(function(b)
						if showing then
							wait()
						end
						showing = false
						display(false)
						if b then
							Set(dropdownSelection.Text)
						end
					end)
					AddOptions(list)
					local function savestuff(s, get)
						if not s or type(s) ~= "string" then
							s = nil
						end
						local rawfile = "json__save"
						if not get then
							local filenameddst = string.gsub(s or dropdownSelection.Text or "", "%W", "")
							if #filenameddst == 0 then
								return
							end
							rawfile = string.format("%s/%s.txt", common_string, filenameddst)
						end
						if savecallback then
							local x, e = pcall(savecallback, rawfile, library_flags[flagName])
							if not x and e then
								warn("Error while calling the Pre-Save callback:", e, debug.traceback(""))
							end
						end
						local working_with = {}
						if persistiveflags == 1 or persistiveflags == true or persistiveflags == "*" then
							persistiveflags = "all"
						elseif persistiveflags == 2 then
							persistiveflags = "tab"
						elseif persistiveflags == 3 then
							persistiveflags = "section"
						end
						if persistiveflags == "all" or persistiveflags == "tab" or persistiveflags == "section" then
							for cflag, data in next, (persistiveflags == "all" and elements) or (persistiveflags == "tab" and tabFunctions.Flags) or (persistiveflags == "section" and sectionFunctions.Flags) do
								if data.Type ~= "Persistence" and (designerpersists or string.sub(cflag, 1, 11) ~= "__Designer.") then
									working_with[cflag] = data
								end
							end
						elseif type(persistiveflags) == "table" then
							if #persistiveflags > 0 then
								local inverted = persistiveflags[0] == false or persistiveflags.Inverted
								for k, cflag in next, persistiveflags do
									if k > 0 then
										local data = elements[cflag]
										if data and data.Type ~= "Persistence" and (designerpersists or string.sub(cflag, 1, 11) ~= "__Designer.") then
											working_with[cflag] = (not inverted and data) or nil
										end
									end
								end
							else
								for cflag, persists in next, elements do
									if persists and (designerpersists or string.sub(cflag, 1, 11) ~= "__Designer.") then
										local data = elements[cflag]
										if data then
											working_with[cflag] = data
										end
									end
								end
							end
						end
						local saving = {}
						for cflag in next, working_with do
							local value = library_flags[cflag]
							local good, jval = nil, nil
							if value ~= nil then
								good, jval = JSONEncode(value)
							else
								good, jval = true, "null"
							end
							if not good or (jval == "null" and value ~= nil) then
								local typ = typeof(value)
								if typ == "Color3" then
									value = (library.rainbowflags[cflag] and "rainbow") or Color3ToHex(value)
								end
								value = tostring(value)
								good, jval = JSONEncode(value)
								if not good or (jval == "null" and value ~= nil) then
									warn("Could not save value:", value, debug.traceback(""))
								end
							end
							if good and jval then
								saving[cflag] = value
							end
						end
						local ret = nil
						local good, content = JSONEncode(saving)
						if good and content then
							if not get then
								if not isfolder(common_string) then
									makefolder(common_string)
								end
								writefile(rawfile, content)
							else
								ret = content
							end
						end
						if postsave then
							local x, e = pcall(postsave, rawfile, library_flags[flagName])
							if not x and e then
								warn("Error while calling the Post-Save callback:", e, debug.traceback(""))
							end
						end
						return ret
					end
					local function loadstuff(s, jsonmode, silent)
						if not s or type(s) ~= "string" then
							s = nil
						end
						local filename = "json__load"
						if not jsonmode then
							local filenameddst = convertfilename(s or dropdownSelection.Text, nil, "")
							if #filenameddst == 0 then
								return
							end
							filename = string.format("%s/%s.txt", common_string, filenameddst)
						end
						if loadcallback then
							local x, e = pcall(loadcallback, (jsonmode and s) or filename, library_flags[flagName])
							if not x and e then
								warn("Error while calling the Pre-Load callback:", e, debug.traceback(""))
							end
						end
						if jsonmode or not isfile or isfile(filename) then
							local content = (jsonmode and s) or (not jsonmode and readfile(filename))
							if content and #content > 1 then
								local good, jcontent = JSONDecode(content)
								if good and jcontent then
									for cflag, val in next, jcontent do
										if val and type(val) == "string" and #val > 7 and #val < 64 and string.sub(val, 1, 5) == "Enum." then
											local e = string.find(val, ".", 6, true)
											if e then
												local en = Enum[string.sub(val, 6, e - 1)]
												en = en and en[string.sub(val, e + 1)]
												if en then
													val = en
												else
													warn("Tried & failed to convert '" .. val .. "' to EnumItem")
												end
											end
										end
										local data = elements[cflag]
										if data and data.Type ~= "Persistence" then
											if silent and data.RawSet then
												data:RawSet(val)
											elseif data.Set then
												data:Set(val)
											else
												library_flags[cflag] = val
											end
										end
									end
								end
							end
						end
						if postload then
							local x, e = pcall(postload, filename, library_flags[flagName])
							if not x and e then
								warn("Error while calling the Post-Load callback:", e, debug.traceback(""))
							end
						end
					end
					do
						local buttons, offset = {}, 0
						local fram = nil
						for _, options in next, {{
							Name = "Save" .. ((suffix and (" " .. tostring(suffix))) or ""),
							Callback = savestuff
							}, {
								Name = "Load" .. ((suffix and (" " .. tostring(suffix))) or ""),
								Callback = loadstuff
							}} do
							local buttonName, callback = options.Name, options.Callback
							local realButton = Instance_new("TextButton")
							realButton.Name = "realButton"
							realButton.BackgroundColor3 = Color3.new(1, 1, 1)
							realButton.BackgroundTransparency = 1
							realButton.Size = UDim2.fromScale(1, 1)
							realButton.ZIndex = 5
							realButton.Font = Enum.Font.Code
							realButton.Text = (buttonName and tostring(buttonName)) or "???"
							realButton.TextColor3 = library.colors.elementText
							colored[1 + #colored] = {realButton, "TextColor3", "elementText"}
							realButton.TextSize = 14
							local textsize = textToSize(realButton).X + 14
							if newSection.Parent.AbsoluteSize.X < offset + textsize + 8 then
								offset, fram = 0, nil
							end
							local newButton = fram or Instance_new("Frame")
							fram = newButton
							local button = Instance_new("ImageLabel")
							newButton.Name = removeSpaces((buttonName and buttonName:lower() or "???") .. "Holder")
							newButton.Parent = sectionHolder
							newButton.BackgroundColor3 = Color3.new(1, 1, 1)
							newButton.BackgroundTransparency = 1
							newButton.Size = UDim2.new(1, 0, 0, 24)
							button.Name = "button"
							button.Parent = newButton
							button.Active = true
							button.BackgroundColor3 = library.colors.topGradient
							local colored_button_BackgroundColor3 = {button, "BackgroundColor3", "topGradient"}
							colored[1 + #colored] = colored_button_BackgroundColor3
							button.BorderColor3 = library.colors.elementBorder
							colored[1 + #colored] = {button, "BorderColor3", "elementBorder"}
							button.Position = UDim2.new(0.031, offset, 0.166)
							button.Selectable = true
							button.Size = UDim2.fromOffset(28, 18)
							button.Image = "rbxassetid://2454009026"
							button.ImageColor3 = library.colors.bottomGradient
							local colored_button_ImageColor3 = {button, "ImageColor3", "bottomGradient"}
							colored[1 + #colored] = colored_button_ImageColor3
							local buttonInner = Instance_new("ImageLabel")
							buttonInner.Name = "buttonInner"
							buttonInner.Parent = button
							buttonInner.Active = true
							buttonInner.AnchorPoint = Vector2.new(0.5, 0.5)
							buttonInner.BackgroundColor3 = library.colors.topGradient
							colored[1 + #colored] = {buttonInner, "BackgroundColor3", "topGradient"}
							buttonInner.BorderColor3 = library.colors.elementBorder
							colored[1 + #colored] = {buttonInner, "BorderColor3", "elementBorder"}
							buttonInner.Position = UDim2.fromScale(0.5, 0.5)
							buttonInner.Selectable = true
							buttonInner.Size = UDim2.new(1, -4, 1, -4)
							buttonInner.Image = "rbxassetid://2454009026"
							buttonInner.ImageColor3 = library.colors.bottomGradient
							colored[1 + #colored] = {buttonInner, "ImageColor3", "bottomGradient"}
							button.Size = UDim2.fromOffset(textsize, 18)
							realButton.Parent = button
							offset = offset + textsize + 6
							sectionFunctions:Update()
							local presses = 0
							library.signals[1 + #library.signals] = realButton.MouseButton1Click:Connect(function()
								if not library.colorpicker and not submenuOpen then
									presses = 1 + presses
									task.spawn(callback, presses)
								end
							end)
							library.signals[1 + #library.signals] = button.MouseEnter:Connect(function()
								colored_button_BackgroundColor3[3] = "main"
								colored_button_BackgroundColor3[4] = 1.5
								colored_button_ImageColor3[3] = "main"
								colored_button_ImageColor3[4] = 2.5
								tweenService:Create(button, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
									BackgroundColor3 = darkenColor(library.colors.main, 1.5),
									ImageColor3 = darkenColor(library.colors.main, 2.5)
								}):Play()
							end)
							library.signals[1 + #library.signals] = button.MouseLeave:Connect(function()
								colored_button_BackgroundColor3[3] = "topGradient"
								colored_button_BackgroundColor3[4] = nil
								colored_button_ImageColor3[3] = "bottomGradient"
								colored_button_ImageColor3[4] = nil
								tweenService:Create(button, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
									BackgroundColor3 = library.colors.topGradient,
									ImageColor3 = library.colors.bottomGradient
								}):Play()
							end)
						end
					end
					local default = library_flags[flagName]
					local function update()
						dropdownName, custom_workspace, persistiveflags, suffix, callback, loadcallback, savecallback, postload, postsave = options.Name or dropdownName, options.Workspace or library.WorkspaceName, options.Persistive or options.Flags or "all", options.Suffix, options.Callback, options.LoadCallback, options.SaveCallback, options.PostLoadCallback, options.PostSaveCallback
						local sstr = tostring(library_flags[flagName])
						if dropdownSelection.Text ~= sstr then
							dropdownSelection.Text = sstr
						end
						dropdownHeadline.Text = (dropdownName and tostring(dropdownName)) or "???"
						return sstr
					end
					local objectdata = {
						Options = options,
						Name = flagName,
						Flag = flagName,
						Type = "Persistence",
						Default = default,
						Parent = sectionFunctions,
						Instance = dropdownSelection,
						Set = Set,
						SaveFile = function(t, str, ret)
							if t ~= nil and type(t) ~= "table" then
								str, ret = t, str
							end
							if type(str) == "string" then
								str = str:match("(.+)%..+$") or str
							end
							return savestuff(str, ret)
						end,
						LoadFile = function(t, str, jsonmode)
							if t ~= nil and type(t) ~= "table" then
								str, jsonmode = t, str
							end
							if isfile and isfile(str) then
								return loadstuff(readfile(str), true)
							elseif not jsonmode and type(str) == "string" then
								str = str:match("(.+)%..+$") or str
							end
							return loadstuff(str, jsonmode)
						end,
						LoadJSON = function(_, json)
							return loadstuff(json, true)
						end,
						LoadFileRaw = function(t, str, jsonmode)
							if t ~= nil and type(t) ~= "table" then
								str, jsonmode = t, str
							end
							if isfile and isfile(str) then
								return loadstuff(readfile(str), true, true)
							elseif not jsonmode and type(str) == "string" then
								str = str:match("(.+)%..+$") or str
							end
							return loadstuff(str, jsonmode, true)
						end,
						LoadJSONRaw = function(_, json)
							return loadstuff(json, true, true)
						end,
						GetJSON = function(t, clipboard)
							if nil == clipboard and t ~= nil then
								clipboard = t
							end
							local json = savestuff(nil, true)
							local clipfunc = (clipboard and type(clipboard) == "function" and clipboard) or setclipboard
							if clipboard and clipfunc then
								clipfunc(json)
							end
							return json
						end,
						RawSet = function(t, str)
							if nil == str and t ~= nil then
								str = t
							end
							selectedOption = str
							last_v = library_flags[flagName]
							library_flags[flagName] = str
							if options.Location then
								options.Location[options.LocationFlag or flagName] = str
							end
							update()
							return str
						end,
						Get = function()
							return library_flags[flagName]
						end,
						Update = update,
						Reset = function()
							return Set(nil, default)
						end
					}
					tabFunctions.Flags[flagName], sectionFunctions.Flags[flagName], elements[flagName] = objectdata, objectdata, objectdata
					return objectdata
				end
			else
				function sectionFunctions.AddPersistence()
					if not library.warnedpersistance then
						library.warnedpersistance = 1
						warn(debug.traceback("Persistance not supported"))
					end
					function sectionFunctions.AddPersistence()
					end
				end
			end
			sectionFunctions.NewPersistence = sectionFunctions.AddPersistence
			sectionFunctions.CreatePersistence = sectionFunctions.AddPersistence
			sectionFunctions.Persistence = sectionFunctions.AddPersistence
			sectionFunctions.CreateSaveLoad = sectionFunctions.AddPersistence
			sectionFunctions.SaveLoad = sectionFunctions.AddPersistence
			sectionFunctions.SL = sectionFunctions.AddPersistence
			function sectionFunctions:AddDropdown(options, ...)
				options = (options and type(options) == "string" and resolvevararg("Dropdown", options, ...)) or options
				local dropdownName, listt, val, callback, flagName = assert(options.Name, "Missing Name for new searchbox."), assert(options.List, "Missing List for new searchbox."), options.Value, options.Callback, options.Flag or (function()
					library.unnameddropdown = 1 + (library.unnameddropdown or 0)
					return "Dropdown" .. tostring(library.unnameddropdown)
				end)()
				if elements[flagName] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flagName .. "'", 3))
				end
				local newDropdown = Instance_new("Frame")
				local dropdown = Instance_new("ImageLabel")
				local dropdownInner = Instance_new("ImageLabel")
				local dropdownToggle = Instance_new("ImageButton")
				local dropdownSelection = Instance_new("TextLabel")
				local dropdownHeadline = Instance_new("TextLabel")
				local dropdownHolderFrame = Instance_new("ImageLabel")
				local dropdownHolderInner = Instance_new("ImageLabel")
				local realDropdownHolder = Instance_new("ScrollingFrame")
				local realDropdownHolderList = Instance_new("UIListLayout")
				local dropdownEnabled = false
				local multiselect = options.MultiSelect or options.Multi or options.Multiple
				local addcallback = options.ItemAdded or options.AddedCallback
				local delcallback = options.ItemRemoved or options.RemovedCallback
				local clrcallback = options.ItemsCleared or options.ClearedCallback
				local modcallback = options.ItemChanged or options.ChangedCallback
				local blankstring = not multiselect and (options.BlankValue or options.NoValueString or options.Nothing)
				local resolvelist = getresolver(listt, options.Filter, options.Method)
				local list = resolvelist()
				local selectedOption = list[1]
				local passed_multiselect = multiselect and type(multiselect)
				if blankstring and val == nil then
					val = blankstring
				end
				if val ~= nil then
					selectedOption = val
				end
				if multiselect and (not selectedOption or type(selectedOption) ~= "table") then
					selectedOption = {}
				end
				local selectedObjects = {}
				local optionCount = 0
				newDropdown.Name = "newDropdown"
				newDropdown.Parent = sectionHolder
				newDropdown.BackgroundColor3 = Color3.new(1, 1, 1)
				newDropdown.BackgroundTransparency = 1
				newDropdown.Size = UDim2.new(1, 0, 0, 42)
				dropdown.Name = "dropdown"
				dropdown.Parent = newDropdown
				dropdown.Active = true
				dropdown.BackgroundColor3 = library.colors.topGradient
				local colored_dropdown_BackgroundColor3 = {dropdown, "BackgroundColor3", "topGradient"}
				colored[1 + #colored] = colored_dropdown_BackgroundColor3
				dropdown.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {dropdown, "BorderColor3", "elementBorder"}
				dropdown.Position = UDim2.fromScale(0.027, 0.45)
				dropdown.Selectable = true
				dropdown.Size = UDim2.fromOffset(206, 18)
				dropdown.Image = "rbxassetid://2454009026"
				dropdown.ImageColor3 = library.colors.bottomGradient
				local colored_dropdown_ImageColor3 = {dropdown, "ImageColor3", "bottomGradient"}
				colored[1 + #colored] = colored_dropdown_ImageColor3
				dropdownInner.Name = "dropdownInner"
				dropdownInner.Parent = dropdown
				dropdownInner.Active = true
				dropdownInner.AnchorPoint = Vector2.new(0.5, 0.5)
				dropdownInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {dropdownInner, "BackgroundColor3", "topGradient"}
				dropdownInner.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {dropdownInner, "BorderColor3", "elementBorder"}
				dropdownInner.Position = UDim2.fromScale(0.5, 0.5)
				dropdownInner.Selectable = true
				dropdownInner.Size = UDim2.new(1, -4, 1, -4)
				dropdownInner.Image = "rbxassetid://2454009026"
				dropdownInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {dropdownInner, "ImageColor3", "bottomGradient"}
				dropdownToggle.Name = "dropdownToggle"
				dropdownToggle.Parent = dropdown
				dropdownToggle.BackgroundColor3 = Color3.new(1, 1, 1)
				dropdownToggle.BackgroundTransparency = 1
				dropdownToggle.Position = UDim2.fromScale(0.9, 0.17)
				dropdownToggle.Rotation = 90
				dropdownToggle.Size = UDim2.fromOffset(12, 12)
				dropdownToggle.ZIndex = 2
				dropdownToggle.Image = "rbxassetid://71659683"
				dropdownToggle.ImageColor3 = Color3.fromRGB(171, 171, 171)
				dropdownSelection.Name = "dropdownSelection"
				dropdownSelection.Parent = dropdown
				dropdownSelection.Active = true
				dropdownSelection.BackgroundColor3 = Color3.new(1, 1, 1)
				dropdownSelection.BackgroundTransparency = 1
				dropdownSelection.Position = UDim2.new(0.0295)
				dropdownSelection.Selectable = true
				dropdownSelection.Size = UDim2.fromScale(0.97, 1)
				dropdownSelection.ZIndex = 5
				dropdownSelection.Font = Enum.Font.Code
				dropdownSelection.Text = (passed_multiselect == "string" and multiselect) or (multiselect and (blankstring or "Select Item(s)")) or (selectedOption and tostring(selectedOption)) or blankstring or "No Blank String"
				dropdownSelection.TextColor3 = library.colors.otherElementText
				colored[1 + #colored] = {dropdownSelection, "TextColor3", "otherElementText"}
				dropdownSelection.TextSize = 14
				dropdownSelection.TextXAlignment = Enum.TextXAlignment.Left
				dropdownHeadline.Name = "dropdownHeadline"
				dropdownHeadline.Parent = newDropdown
				dropdownHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				dropdownHeadline.BackgroundTransparency = 1
				dropdownHeadline.Position = UDim2.fromScale(0.034, 0.03)
				dropdownHeadline.Size = UDim2.fromOffset(167, 11)
				dropdownHeadline.Font = Enum.Font.Code
				dropdownHeadline.Text = (dropdownName and tostring(dropdownName)) or "???"
				dropdownHeadline.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {dropdownHeadline, "TextColor3", "elementText"}
				dropdownHeadline.TextSize = 14
				dropdownHeadline.TextXAlignment = Enum.TextXAlignment.Left
				dropdownHolderFrame.Name = "dropdownHolderFrame"
				dropdownHolderFrame.Parent = newDropdown
				dropdownHolderFrame.Active = true
				dropdownHolderFrame.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {dropdownHolderFrame, "BackgroundColor3", "topGradient"}
				dropdownHolderFrame.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {dropdownHolderFrame, "BorderColor3", "elementBorder"}
				dropdownHolderFrame.Position = UDim2.fromScale(0.025, 1.012)
				dropdownHolderFrame.Selectable = true
				dropdownHolderFrame.Size = UDim2.fromOffset(206, 22)
				dropdownHolderFrame.Visible = false
				dropdownHolderFrame.Image = "rbxassetid://2454009026"
				dropdownHolderFrame.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {dropdownHolderFrame, "ImageColor3", "bottomGradient"}
				dropdownHolderInner.Name = "dropdownHolderInner"
				dropdownHolderInner.Parent = dropdownHolderFrame
				dropdownHolderInner.Active = true
				dropdownHolderInner.AnchorPoint = Vector2.new(0.5, 0.5)
				dropdownHolderInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {dropdownHolderInner, "BackgroundColor3", "topGradient"}
				dropdownHolderInner.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {dropdownHolderInner, "BorderColor3", "elementBorder"}
				dropdownHolderInner.Position = UDim2.fromScale(0.5, 0.5)
				dropdownHolderInner.Selectable = true
				dropdownHolderInner.Size = UDim2.new(1, -4, 1, -4)
				dropdownHolderInner.Image = "rbxassetid://2454009026"
				dropdownHolderInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {dropdownHolderInner, "ImageColor3", "bottomGradient"}
				realDropdownHolder.Name = "realDropdownHolder"
				realDropdownHolder.Parent = dropdownHolderInner
				realDropdownHolder.BackgroundColor3 = Color3.new(1, 1, 1)
				realDropdownHolder.BackgroundTransparency = 1
				realDropdownHolder.Selectable = false
				realDropdownHolder.Size = UDim2.fromScale(1, 1)
				realDropdownHolder.CanvasSize = UDim2.new()
				realDropdownHolder.ScrollBarThickness = 5
				realDropdownHolder.ScrollingDirection = Enum.ScrollingDirection.Y
				realDropdownHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
				realDropdownHolder.ScrollBarImageTransparency = 0.5
				realDropdownHolder.ScrollBarImageColor3 = library.colors.section
				colored[1 + #colored] = {realDropdownHolder, "ScrollBarImageColor3", "section"}
				realDropdownHolderList.Name = "realDropdownHolderList"
				realDropdownHolderList.Parent = realDropdownHolder
				realDropdownHolderList.HorizontalAlignment = Enum.HorizontalAlignment.Center
				realDropdownHolderList.SortOrder = Enum.SortOrder.LayoutOrder
				sectionFunctions:Update()
				local showing = false
				local function UpdateDropdownHolder()
					if optionCount >= 6 then
						realDropdownHolder.CanvasSize = UDim2:fromOffset(realDropdownHolderList.AbsoluteContentSize.Y + 2)
					elseif optionCount <= 5 then
						dropdownHolderFrame.Size = UDim2.fromOffset(206, realDropdownHolderList.AbsoluteContentSize.Y + 4)
					end
				end
				local restorezindex = {}
				local Set = (multiselect and function(t, dat)
					if nil == dat and t ~= nil then
						dat = t
					end
					local lastv = library_flags[flagName]
					if not lastv or selectedOption ~= lastv then
						if lastv and type(lastv) == "table" then
							selectedOption = library_flags[flagName]
						else
							library_flags[flagName] = selectedOption
						end
						warn("Attempting to use new table for", flagName, " Please use :Set(), as setting through flags table may cause errors", debug.traceback(""))
						lastv = library_flags[flagName]
					end
					local cloned = {unpack(selectedOption)}
					if not dat then
						if #selectedOption ~= 0 then
							table.clear(selectedOption)
							if callback then
								task.spawn(callback, selectedOption, cloned)
							end
						end
						return selectedOption
					elseif type(dat) ~= "table" then
						warn("Expected table for argument #1 on Set for MultiSelect dropdown. Got", dat, debug.traceback(""))
						return selectedOption
					end
					for k = table.pack(unpack(dat)).n, 1, -1 do
						if dat[k] == nil then
							table.remove(dat, k)
						end
					end
					local proceed = #cloned ~= #dat
					table.clear(selectedOption)
					for k, v in next, dat do
						selectedOption[k] = v
						if not proceed and cloned[k] ~= v then
							proceed = 1
						end
					end
					dropdownSelection.Text = (passed_multiselect == "string" and multiselect) or blankstring or "Select Item(s)"
					if proceed and callback then
						task.spawn(callback, selectedOption, cloned)
					end
					return selectedOption
				end) or function(t, str)
					if nil == str and t ~= nil then
						str = t
					end
					local last_v = library_flags[flagName]
					selectedOption = str
					library_flags[flagName] = str
					if options.Location then
						options.Location[options.LocationFlag or flagName] = str
					end
					local sstr = (selectedOption and tostring(selectedOption)) or blankstring or "No Blank String"
					if dropdownSelection.Text ~= sstr then
						dropdownSelection.Text = sstr
					end
					if callback and (last_v ~= str or options.AllowDuplicateCalls) then
						task.spawn(callback, str, last_v)
					end
					return str
				end
				if val ~= nil then
					Set(val)
				else
					library_flags[flagName] = selectedOption
					if options.Location then
						options.Location[options.LocationFlag or flagName] = selectedOption
					end
				end
				local function AddOptions(optionsTable)
					if options.Sort then
						local didstuff, dosort = nil, options.Sort
						if type(dosort) == "function" then
							local g, h = pcall(table.sort, optionsTable, dosort)
							if g then
								didstuff = true
							elseif h then
								warn("Error sorting list:", h, debug.traceback(""))
							end
						elseif dosort ~= 1 and dosort ~= true then
							warn("Potential mistake for passed Sort argument:", dosort, debug.traceback(""))
						end
						if not didstuff then
							table.sort(optionsTable, library.defaultSort)
						end
					end
					if blankstring and (optionsTable[1] ~= blankstring or table.find(optionsTable, blankstring, 2)) then
						local exists = table.find(optionsTable, blankstring)
						if exists then
							for _ = 1, 35 do
								table.remove(optionsTable, exists)
								exists = table.find(optionsTable, blankstring)
								if not exists then
									break
								end
							end
						end
						table.insert(optionsTable, 1, blankstring)
					end
					optionCount = 0
					realDropdownHolderList.Parent = nil
					realDropdownHolder:ClearAllChildren()
					realDropdownHolderList.Parent = realDropdownHolder
					for _, v in next, optionsTable do
						optionCount = optionCount + 1
						local newOption = Instance_new("ImageLabel")
						local optionButton = Instance_new("TextButton")
						if selectedOption == v then
							selectedObjects[1] = newOption
							selectedObjects[2] = optionButton
						end
						newOption.Name = "Frame"
						newOption.Parent = realDropdownHolder
						local togged = (not multiselect and selectedOption == v) or (multiselect and table.find(selectedOption, v))
						newOption.BackgroundColor3 = (togged and library.colors.selectedOption) or library.colors.topGradient
						newOption.BorderSizePixel = 0
						newOption.Size = UDim2.fromOffset(202, 18)
						newOption.Image = "rbxassetid://2454009026"
						newOption.ImageColor3 = (togged and library.colors.unselectedOption) or library.colors.bottomGradient
						local stringed = tostring(v)
						optionButton.Name = stringed
						optionButton.Parent = newOption
						optionButton.AnchorPoint = Vector2.new(0.5, 0.5)
						optionButton.BackgroundColor3 = Color3.new(1, 1, 1)
						optionButton.BackgroundTransparency = 1
						optionButton.Position = UDim2.fromScale(0.5, 0.5)
						optionButton.Size = UDim2.new(1, -10, 1)
						optionButton.ZIndex = 5
						optionButton.Font = Enum.Font.Code
						optionButton.Text = (togged and (" " .. stringed)) or stringed
						optionButton.TextColor3 = (togged and library.colors.main) or library.colors.otherElementText
						optionButton.TextSize = 14
						optionButton.TextXAlignment = Enum.TextXAlignment.Left
						library.signals[1 + #library.signals] = optionButton.MouseButton1Click:Connect(function()
							if not library.colorpicker then
								restorezindex[newSection] = restorezindex[newSection] or newSection.ZIndex
								restorezindex[newDropdown] = restorezindex[newDropdown] or newDropdown.ZIndex
								restorezindex[sectionHolder] = restorezindex[sectionHolder] or sectionHolder.ZIndex
								if multiselect then
									local cloned = {unpack(selectedOption)}
									local togged = table.find(selectedOption, v)
									if togged then
										table.remove(selectedOption, togged)
									else
										selectedOption[1 + #selectedOption] = v
									end
									togged = table.find(selectedOption, v)
									optionButton.Text = (togged and (" " .. stringed)) or stringed
									newOption.BackgroundColor3 = (togged and library.colors.selectedOption) or library.colors.topGradient
									newOption.ImageColor3 = (togged and library.colors.unselectedOption) or library.colors.bottomGradient
									optionButton.TextColor3 = (togged and library.colors.main) or library.colors.otherElementText
									dropdownSelection.Text = (passed_multiselect == "string" and multiselect) or blankstring or "Select Item(s)"
									if callback then
										task.spawn(callback, selectedOption, cloned)
									end
									if togged then
										if addcallback then
											task.spawn(addcallback, v, selectedOption)
										end
									elseif delcallback then
										task.spawn(delcallback, v, selectedOption)
									end
									if modcallback then
										task.spawn(modcallback, v, togged, selectedOption)
									end
									if #selectedOption == 0 and clrcallback then
										task.spawn(clrcallback, selectedOption, cloned)
									end
									return
								else
									if selectedOption ~= v then
										local last_v = library_flags[flagName]
										selectedObjects[1].BackgroundColor3 = library.colors.topGradient
										selectedObjects[1].ImageColor3 = library.colors.bottomGradient
										selectedObjects[2].Text = selectedObjects[2].Name
										selectedObjects[2].TextColor3 = library.colors.otherElementText
										selectedOption = v
										dropdownSelection.Text = stringed
										selectedObjects[1] = newOption
										selectedObjects[2] = optionButton
										newOption.BackgroundColor3 = library.colors.selectedOption
										newOption.ImageColor3 = library.colors.unselectedOption
										optionButton.Text = " " .. stringed
										optionButton.TextColor3 = library.colors.main
										dropdownHolderFrame.Visible = false
										dropdownToggle.Rotation = 90
										dropdownEnabled = false
										newDropdown.ZIndex = 1
										colored_dropdown_BackgroundColor3[3] = "topGradient"
										colored_dropdown_BackgroundColor3[4] = nil
										colored_dropdown_ImageColor3[3] = "bottomGradient"
										colored_dropdown_ImageColor3[4] = nil
										tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
											BackgroundColor3 = library.colors.topGradient,
											ImageColor3 = library.colors.bottomGradient
										}):Play()
										library_flags[flagName] = selectedOption
										if options.Location then
											options.Location[options.LocationFlag or flagName] = selectedOption
										end
										submenuOpen = nil
										showing = false
										if callback then
											task.spawn(callback, selectedOption, last_v)
										end
									else
										showing = false
										submenuOpen = nil
										dropdownToggle.Rotation = 90
										newDropdown.ZIndex = 1
										sectionHolder.ZIndex = 1
										colored_dropdown_BackgroundColor3[3] = "topGradient"
										colored_dropdown_BackgroundColor3[4] = nil
										colored_dropdown_ImageColor3[3] = "bottomGradient"
										colored_dropdown_ImageColor3[4] = nil
										tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
											BackgroundColor3 = library.colors.topGradient,
											ImageColor3 = library.colors.bottomGradient
										}):Play()
										dropdownHolderFrame.Visible = false
									end
								end
								for ins, z in next, restorezindex do
									ins.ZIndex = z
								end
							end
						end)
						library.signals[1 + #library.signals] = optionButton.MouseEnter:Connect(function()
							tweenService:Create(newOption, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
								BackgroundColor3 = library.colors.hoveredOptionTop,
								ImageColor3 = library.colors.hoveredOptionBottom
							}):Play()
						end)
						library.signals[1 + #library.signals] = optionButton.MouseLeave:Connect(function()
							local togged = (not multiselect and selectedOption == v) or (multiselect and table.find(selectedOption, v))
							tweenService:Create(newOption, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
								BackgroundColor3 = (togged and library.colors.selectedOption) or library.colors.topGradient,
								ImageColor3 = (togged and library.colors.unselectedOption) or library.colors.bottomGradient
							}):Play()
						end)
						UpdateDropdownHolder()
					end
				end
				local precisionscrolling = nil
				local function display(dropdownEnabled)
					list = resolvelist()
					if dropdownEnabled then
						AddOptions(list)
						submenuOpen = dropdown
						dropdownToggle.Rotation = 270
						restorezindex[newSection] = restorezindex[newSection] or newSection.ZIndex
						restorezindex[newDropdown] = restorezindex[newDropdown] or newDropdown.ZIndex
						restorezindex[sectionHolder] = restorezindex[sectionHolder] or sectionHolder.ZIndex
						newSection.ZIndex = 50 + newSection.ZIndex
						newDropdown.ZIndex = 2
						sectionHolder.ZIndex = 2
						colored_dropdown_BackgroundColor3[3] = "main"
						colored_dropdown_BackgroundColor3[4] = 1.5
						colored_dropdown_ImageColor3[3] = "main"
						colored_dropdown_ImageColor3[4] = 2.5
						tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = darkenColor(library.colors.main, 1.5),
							ImageColor3 = darkenColor(library.colors.main, 2.5)
						}):Play()
						dropdownHolderFrame.Visible = true
						if not options.DisablePrecisionScrolling then
							local upkey = options.ScrollUpButton or library.scrollupbutton or shared.scrollupbutton or Enum.KeyCode.Up
							local downkey = options.ScrollDownButton or library.scrolldownbutton or shared.scrolldownbutton or Enum.KeyCode.Down
							precisionscrolling = (precisionscrolling and precisionscrolling:Disconnect() and nil) or userInputService.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.Keyboard then
									local code = input.KeyCode
									local isup = code == upkey
									local isdown = code == downkey
									if isup or isdown then
										local txt = userInputService:GetFocusedTextBox()
										if not txt or txt == dropdownSelection then
											while wait_check() and userInputService:IsKeyDown(code) do
												realDropdownHolder.CanvasPosition = Vector2:new(math.clamp(realDropdownHolder.CanvasPosition.Y + ((isup and -5) or 5), 0, realDropdownHolder.AbsoluteCanvasSize.Y))
											end
										end
									end
								end
							end)
							library.signals[1 + #library.signals] = precisionscrolling
						end
					else
						submenuOpen = nil
						dropdownToggle.Rotation = 90
						colored_dropdown_BackgroundColor3[3] = "topGradient"
						colored_dropdown_BackgroundColor3[4] = nil
						colored_dropdown_ImageColor3[3] = "bottomGradient"
						colored_dropdown_ImageColor3[4] = nil
						tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = library.colors.topGradient,
							ImageColor3 = library.colors.bottomGradient
						}):Play()
						dropdownHolderFrame.Visible = false
						for ins, z in next, restorezindex do
							ins.ZIndex = z
						end
						precisionscrolling = (precisionscrolling and precisionscrolling:Disconnect() and nil) or nil
					end
					if not multiselect and (not next(list) or not table.find(list, library_flags[flagName])) then
						Set(list[1])
					end
					showing = dropdownEnabled
				end
				library.signals[1 + #library.signals] = newDropdown.InputEnded:Connect(function(input)
					if not library.colorpicker and input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						showing = not showing
						display(showing)
					end
				end)
				library.signals[1 + #library.signals] = newDropdown.MouseEnter:Connect(function()
					colored_dropdown_BackgroundColor3[3] = "main"
					colored_dropdown_BackgroundColor3[4] = 1.5
					colored_dropdown_ImageColor3[3] = "main"
					colored_dropdown_ImageColor3[4] = 2.5
					tweenService:Create(dropdown, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = darkenColor(library.colors.main, 1.5),
						ImageColor3 = darkenColor(library.colors.main, 2.5)
					}):Play()
				end)
				library.signals[1 + #library.signals] = newDropdown.MouseLeave:Connect(function()
					if not dropdownEnabled then
						colored_dropdown_BackgroundColor3[3] = "topGradient"
						colored_dropdown_BackgroundColor3[4] = nil
						colored_dropdown_ImageColor3[3] = "bottomGradient"
						colored_dropdown_ImageColor3[4] = nil
						tweenService:Create(dropdown, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = library.colors.topGradient,
							ImageColor3 = library.colors.bottomGradient
						}):Play()
					end
				end)
				library.signals[1 + #library.signals] = dropdownToggle.MouseButton1Click:Connect(function()
					if not library.colorpicker then
						showing = not showing
						display(showing)
					end
				end)
				AddOptions(list)
				local default = library_flags[flagName]
				local function update()
					dropdownName, callback = options.Name or dropdownName, options.Callback
					local sstr = (passed_multiselect == "string" and multiselect) or (library_flags[flagName] and tostring(library_flags[flagName])) or (selectedOption and tostring(selectedOption)) or blankstring or "nil"
					if dropdownSelection.Text ~= sstr then
						dropdownSelection.Text = sstr
					end
					dropdownHeadline.Text = (dropdownName and tostring(dropdownName)) or "???"
					return sstr
				end
				local function validate(fallbackValue)
					if list and table.find(list, library_flags[flagName]) then
						update()
						return true
					end
					if fallbackValue ~= nil then
						if fallbackValue == "__DEFAULT" then
							fallbackValue = fallbackValue
						end
					else
						fallbackValue = list[1]
					end
					return Set((multiselect and {fallbackValue}) or fallbackValue)
				end
				local objectdata = {
					Options = options,
					Name = flagName,
					Flag = flagName,
					Type = "Dropdown",
					Default = default,
					Parent = sectionFunctions,
					Instance = dropdownSelection,
					Get = function()
						return library_flags[flagName]
					end,
					Set = Set,
					RawSet = ((multiselect and function(t, dat)
						if nil == dat and t ~= nil then
							dat = t
						end
						local lastv = library_flags[flagName]
						if not lastv or selectedOption ~= lastv then
							if lastv and type(lastv) == "table" then
								selectedOption = library_flags[flagName]
							else
								library_flags[flagName] = selectedOption
							end
							warn("Attempting to use new table for", flagName, " Please use :Set(), as setting through flags table may cause errors", debug.traceback(""))
							lastv = library_flags[flagName]
						end
						local cloned = {unpack(selectedOption)}
						if not dat then
							if #selectedOption ~= 0 then
								table.clear(selectedOption)
							end
							return selectedOption
						elseif type(dat) ~= "table" then
							warn("Expected table for argument #1 on Set for MultiSelect dropdown. Got", dat, debug.traceback(""))
							return selectedOption
						end
						for k = table.pack(unpack(dat)).n, 1, -1 do
							if dat[k] == nil then
								table.remove(dat, k)
							end
						end
						table.clear(selectedOption)
						for k, v in next, dat do
							selectedOption[k] = v
						end
						return selectedOption
					end) or function(t, str)
						if nil == str and t ~= nil then
							str = t
						end
						selectedOption = str
						library_flags[flagName] = str
						if options.Location then
							options.Location[options.LocationFlag or flagName] = str
						end
						update()
						return str
					end),
					Update = update,
					Reset = function()
						return Set(nil, default)
					end
				}
				function objectdata.UpdateList(t, listt, updateValues)
					if (nil == listt and t ~= nil) or (type(t) == "table" and type(listt) ~= "table") then
						listt, updateValues = t, listt
					end
					if listt == objectdata then
						listt = nil
					end
					resolvelist = getresolver(listt or options.List, options.Filter, options.Method)
					list = resolvelist()
					if updateValues then
						validate()
					end
					if showing then
						display(false)
						display(true)
					end
					return list
				end
				tabFunctions.Flags[flagName], sectionFunctions.Flags[flagName], elements[flagName] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.AddDropDown = sectionFunctions.AddDropdown
			sectionFunctions.NewDropDown = sectionFunctions.AddDropdown
			sectionFunctions.NewDropdown = sectionFunctions.AddDropdown
			sectionFunctions.CreateDropdown = sectionFunctions.AddDropdown
			sectionFunctions.CreateDropdown = sectionFunctions.AddDropdown
			sectionFunctions.DropDown = sectionFunctions.AddDropdown
			sectionFunctions.Dropdown = sectionFunctions.AddDropdown
			sectionFunctions.DD = sectionFunctions.AddDropdown
			sectionFunctions.Dd = sectionFunctions.AddDropdown
			function sectionFunctions:AddColorpicker(options, ...)
				options = (options and type(options) == "string" and resolvevararg("Colorpicker", options, ...)) or options
				if options.Random == true then
					options.Value = "random"
				elseif options.Rainbow == true then
					options.Value = "rainbow"
				end
				local colorPickerName, presetColor, callback, flagName = assert(options.Name, "Missing Name for new colorpicker."), options.Value, options.Callback, options.Flag or (function()
					library.unnamedcolorpicker = 1 + (library.unnamedcolorpicker or 0)
					return "Colorpicker" .. tostring(library.unnamedcolorpicker)
				end)()
				if elements[flagName] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flagName .. "'", 3))
				end
				local designers = options.__designer
				options.__designer = nil
				local rainbowColorMode = false
				if presetColor == "random" then
					presetColor = Color3.new(math.random(), math.random(), math.random())
				elseif presetColor == "rainbow" then
					presetColor = Color3.new(1, 1, 1)
					rainbowColorMode = true
				end
				local newColorPicker = Instance_new("Frame")
				local colorPicker = Instance_new("ImageLabel")
				local colorPickerInner = Instance_new("ImageLabel")
				local colorPickerHeadline = Instance_new("TextLabel")
				local colorPickerButton = Instance_new("TextButton")
				local colorPickerHolderFrame = Instance_new("ImageLabel")
				local colorPickerHolderInner = Instance_new("ImageLabel")
				local color = Instance_new("ImageLabel")
				local selectorColor = Instance_new("Frame")
				local hue = Instance_new("ImageLabel")
				local hueGradient = Instance_new("UIGradient")
				local selectorHue = Instance_new("Frame")
				local randomColor = Instance_new("ImageLabel")
				local randomColorInner = Instance_new("ImageLabel")
				local randomColorButton = Instance_new("ImageButton")
				local hexInputBox = Instance_new("TextBox")
				local hexInput = Instance_new("ImageLabel")
				local hexInputInner = Instance_new("ImageLabel")
				local rainbow = Instance_new("ImageLabel")
				local rainbowInner = Instance_new("ImageLabel")
				local rainbowButton = Instance_new("ImageButton")
				local startingColor = presetColor or Color3.new(1, 1, 1)
				local colorPickerEnabled = false
				local colorH, colorS, colorV = 1, 1, 1
				local colorInput, hueInput = nil, nil
				local oldBackgroundColor = Color3.new()
				local oldImageColor = oldBackgroundColor
				local oldColor = oldBackgroundColor
				local rainbowColorValue = 0
				newColorPicker.Name = "newColorPicker"
				newColorPicker.Parent = sectionHolder
				newColorPicker.BackgroundColor3 = Color3.new(1, 1, 1)
				newColorPicker.BackgroundTransparency = 1
				newColorPicker.Size = UDim2.new(1, 0, 0, 19)
				colorPicker.Name = "colorPicker"
				colorPicker.Parent = newColorPicker
				colorPicker.Active = true
				colorPicker.BackgroundColor3 = library.colors.topGradient
				local colored_colorPicker_BackgroundColor3 = {colorPicker, "BackgroundColor3", "topGradient"}
				colored[1 + #colored] = colored_colorPicker_BackgroundColor3
				colorPicker.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {colorPicker, "BorderColor3", "elementBorder"}
				colorPicker.Position = UDim2.fromScale(0.842, 0.113)
				colorPicker.Selectable = true
				colorPicker.Size = UDim2.fromOffset(24, 12)
				colorPicker.Image = "rbxassetid://2454009026"
				colorPicker.ImageColor3 = library.colors.bottomGradient
				local colored_colorPicker_ImageColor3 = {colorPicker, "ImageColor3", "bottomGradient"}
				colored[1 + #colored] = colored_colorPicker_ImageColor3
				colorPickerInner.Name = "colorPickerInner"
				colorPickerInner.Parent = colorPicker
				colorPickerInner.Active = true
				colorPickerInner.AnchorPoint = Vector2.new(0.5, 0.5)
				colorPickerInner.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {colorPickerInner, "BorderColor3", "elementBorder"}
				colorPickerInner.Position = UDim2.fromScale(0.5, 0.5)
				colorPickerInner.Selectable = true
				colorPickerInner.Size = UDim2.new(1, -4, 1, -4)
				colorPickerInner.Image = "rbxassetid://2454009026"
				colorPickerInner.BackgroundColor3 = darkenColor(startingColor, 1.5)
				colorPickerInner.ImageColor3 = darkenColor(startingColor, 2.5)
				colorPickerHeadline.Name = "colorPickerHeadline"
				colorPickerHeadline.Parent = newColorPicker
				colorPickerHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				colorPickerHeadline.BackgroundTransparency = 1
				colorPickerHeadline.Position = UDim2.fromScale(0.034, 0.113)
				colorPickerHeadline.Size = UDim2.fromOffset(173, 11)
				colorPickerHeadline.Font = Enum.Font.Code
				colorPickerHeadline.Text = colorPickerName or "???"
				colorPickerHeadline.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {colorPickerHeadline, "TextColor3", "elementText"}
				colorPickerHeadline.TextSize = 14
				colorPickerHeadline.TextXAlignment = Enum.TextXAlignment.Left
				colorPickerButton.Name = "colorPickerButton"
				colorPickerButton.Parent = newColorPicker
				colorPickerButton.BackgroundColor3 = Color3.new(1, 1, 1)
				colorPickerButton.BackgroundTransparency = 1
				colorPickerButton.Size = UDim2.fromScale(1, 1)
				colorPickerButton.ZIndex = 5
				colorPickerButton.Font = Enum.Font.SourceSans
				colorPickerButton.Text = ""
				colorPickerButton.TextColor3 = Color3.new()
				colorPickerButton.TextSize = 14
				colorPickerButton.TextTransparency = 1
				colorPickerButton.BorderColor3 = library.colors.elementBorder
				local colored_colorPickerButton_BorderColor3 = {colorPickerButton, "BorderColor3", "elementBorder"}
				colored[1 + #colored] = colored_colorPickerButton_BorderColor3
				local function UpdateColorPicker(force, rainbsow)
					local last_vv = library_flags[flagName]
					local newColor = force or Color3.fromHSV(colorH, colorS, colorV)
					if not force then
						colorH, colorS, colorV = newColor:ToHSV()
					end
					colorPickerInner.BackgroundColor3 = darkenColor(newColor, 1.5)
					colorPickerInner.ImageColor3 = darkenColor(newColor, 2.5)
					color.BackgroundColor3 = Color3.fromHSV(colorH, 1, 1)
					library_flags[flagName] = newColor
					if options.Location then
						options.Location[options.LocationFlag or flagName] = newColor
					end
					hexInputBox.Text = Color3ToHex(newColor)
					if force then
						color.BackgroundColor3 = force
						selectorColor.Position = UDim2.new(force and select(3, Color3.toHSV(force)))
					end
					local pos = 1 - (Color3.toHSV(newColor))
					local scalex = selectorHue.Position.X.Scale
					if scalex ~= pos and not ((pos == 0 or pos == 1) and (scalex == 1 or scalex == 0)) then
						selectorHue.Position = UDim2.new(pos)
					end
					if callback and last_vv ~= newColor then
						task.spawn(callback, newColor, last_vv, rainbsow)
					end
				end
				library.signals[1 + #library.signals] = colorPickerButton.MouseButton1Click:Connect(function()
					if submenuOpen == colorPicker or submenuOpen == nil then
						colorPickerEnabled = not colorPickerEnabled
						library.colorpicker = colorPickerEnabled
						colorPickerHolderFrame.Visible = colorPickerEnabled
						if colorPickerEnabled then
							for _, v in next, colorpickerconflicts do
								v.Visible = false
							end
							submenuOpen = colorPicker
							newColorPicker.ZIndex = 2
							newSection.ZIndex = 100 + newSection.ZIndex
							colorPickerButton.BorderColor3 = library.colors.main
							colored_colorPickerButton_BorderColor3[3] = "main"
							UpdateColorPicker()
						else
							for _, v in next, colorpickerconflicts do
								v.Visible = true
							end
							submenuOpen = nil
							newColorPicker.ZIndex = 0
							newSection.ZIndex = newSection.ZIndex - 100
							colorPickerButton.BorderColor3 = library.colors.elementBorder
							colored_colorPickerButton_BorderColor3[3] = "elementBorder"
						end
					end
				end)
				colorPickerHolderFrame.Name = "colorPickerHolderFrame"
				colorPickerHolderFrame.Parent = newColorPicker
				colorPickerHolderFrame.Active = true
				colorPickerHolderFrame.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {colorPickerHolderFrame, "BackgroundColor3", "topGradient"}
				colorPickerHolderFrame.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {colorPickerHolderFrame, "BorderColor3", "elementBorder"}
				colorPickerHolderFrame.Selectable = true
				colorPickerHolderFrame.Position = UDim2.fromScale(0.025, 1.012)
				colorPickerHolderFrame.Size = UDim2.fromOffset(206, 250)
				if math.ceil(colorPickerHolderFrame.AbsolutePosition.Y + colorPickerHolderFrame.AbsoluteSize.Y) > floor(newTabHolder.AbsoluteSize.Y + newTabHolder.AbsolutePosition.Y) then
					colorPickerHolderFrame.Position = UDim2.new(0.025, 0, 1.012, -colorPickerHolderFrame.AbsoluteSize.Y - colorPickerButton.AbsoluteSize.Y - 2)
				end
				colorPickerHolderFrame.Visible = false
				colorPickerHolderFrame.Image = "rbxassetid://2454009026"
				colorPickerHolderFrame.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {colorPickerHolderFrame, "ImageColor3", "bottomGradient"}
				colorPickerHolderInner.Name = "colorPickerHolderInner"
				colorPickerHolderInner.Parent = colorPickerHolderFrame
				colorPickerHolderInner.Active = true
				colorPickerHolderInner.AnchorPoint = Vector2.new(0.5, 0.5)
				colorPickerHolderInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {colorPickerHolderInner, "BackgroundColor3", "topGradient"}
				colorPickerHolderInner.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {colorPickerHolderInner, "BorderColor3", "elementBorder"}
				colorPickerHolderInner.Position = UDim2.fromScale(0.5, 0.5)
				colorPickerHolderInner.Selectable = true
				colorPickerHolderInner.Size = UDim2.new(1, -4, 1, -4)
				colorPickerHolderInner.Image = "rbxassetid://2454009026"
				colorPickerHolderInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {colorPickerHolderInner, "ImageColor3", "bottomGradient"}
				color.Name = "color"
				color.Parent = colorPickerHolderInner
				color.BackgroundColor3 = startingColor
				color.BorderSizePixel = 0
				color.Position = UDim2.fromOffset(5, 5)
				color.Size = UDim2.new(1, -10, 0, 192)
				color.Image = "rbxassetid://4155801252"
				selectorColor.Name = "selectorColor"
				selectorColor.Parent = color
				selectorColor.AnchorPoint = Vector2.new(0.5, 0.5)
				selectorColor.BackgroundColor3 = Color3.fromRGB(144, 144, 144)
				selectorColor.BorderColor3 = Color3.fromRGB(69, 65, 70)
				selectorColor.Position = UDim2.new(startingColor and select(3, Color3.toHSV(startingColor)))
				selectorColor.Size = UDim2.fromOffset(4, 4)
				hue.Name = "hue"
				hue.Parent = colorPickerHolderInner
				hue.BackgroundColor3 = Color3.new(1, 1, 1)
				hue.BorderSizePixel = 0
				hue.Position = UDim2.fromOffset(5, 202)
				hue.Size = UDim2.new(1, -10, 0, 14)
				hue.Image = "rbxassetid://3570695787"
				hue.ScaleType = Enum.ScaleType.Slice
				hue.SliceScale = 0.01
				hueGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.17, Color3.fromRGB(235, 7, 255)), ColorSequenceKeypoint.new(0.33, Color3:fromRGB(9, 189)), ColorSequenceKeypoint.new(0.5, Color3:fromRGB(193, 196)), ColorSequenceKeypoint.new(0.66, Color3:new(1)), ColorSequenceKeypoint.new(0.84, Color3.fromRGB(255, 247)), ColorSequenceKeypoint.new(1, Color3.new(1))})
				hueGradient.Name = "hueGradient"
				hueGradient.Parent = hue
				selectorHue.Name = "selectorHue"
				selectorHue.Parent = hue
				selectorHue.BackgroundColor3 = Color3:fromRGB(125, 255)
				selectorHue.BackgroundTransparency = 0.2
				selectorHue.BorderColor3 = Color3:fromRGB(84, 91)
				selectorHue.Position = UDim2.new(1 - (Color3.toHSV(startingColor)))
				selectorHue.Size = UDim2:new(2, 1)
				hexInput.Name = "hexInput"
				hexInput.Parent = colorPickerHolderInner
				hexInput.Active = true
				hexInput.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {hexInput, "BackgroundColor3", "topGradient"}
				hexInput.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {hexInput, "BorderColor3", "elementBorder"}
				hexInput.Position = UDim2.fromOffset(5, 223)
				hexInput.Selectable = true
				hexInput.Size = UDim2.fromOffset(150, 18)
				hexInput.Image = "rbxassetid://2454009026"
				hexInput.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {hexInput, "ImageColor3", "bottomGradient"}
				hexInputInner.Name = "hexInputInner"
				hexInputInner.Parent = hexInput
				hexInputInner.Active = true
				hexInputInner.AnchorPoint = Vector2.new(0.5, 0.5)
				hexInputInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {hexInputInner, "BackgroundColor3", "topGradient"}
				hexInputInner.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {hexInputInner, "BorderColor3", "elementBorder"}
				hexInputInner.Position = UDim2.fromScale(0.5, 0.5)
				hexInputInner.Selectable = true
				hexInputInner.Size = UDim2.new(1, -4, 1, -4)
				hexInputInner.Image = "rbxassetid://2454009026"
				hexInputInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {hexInputInner, "ImageColor3", "bottomGradient"}
				hexInputBox.Name = "hexInputBox"
				hexInputBox.Parent = hexInput
				hexInputBox.BackgroundColor3 = Color3.new(1, 1, 1)
				hexInputBox.BackgroundTransparency = 1
				hexInputBox.Size = UDim2.fromScale(1, 1)
				hexInputBox.ZIndex = 5
				hexInputBox.Font = Enum.Font.Code
				hexInputBox.PlaceholderText = "Hex Input"
				hexInputBox.Text = Color3ToHex(startingColor)
				hexInputBox.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {hexInputBox, "TextColor3", "elementText"}
				hexInputBox.TextSize = 14
				hexInputBox.ClearTextOnFocus = false
				randomColor.Name = "randomColor"
				randomColor.Parent = colorPickerHolderInner
				randomColor.Active = true
				randomColor.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {randomColor, "BackgroundColor3", "topGradient"}
				randomColor.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {randomColor, "BorderColor3", "elementBorder"}
				randomColor.Position = UDim2.fromOffset(158, 223)
				randomColor.Selectable = true
				randomColor.Size = UDim2.fromOffset(18, 18)
				randomColor.Image = "rbxassetid://2454009026"
				randomColor.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {randomColor, "ImageColor3", "bottomGradient"}
				randomColorInner.Name = "randomColorInner"
				randomColorInner.Parent = randomColor
				randomColorInner.Active = true
				randomColorInner.AnchorPoint = Vector2.new(0.5, 0.5)
				randomColorInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {randomColorInner, "BackgroundColor3", "topGradient"}
				randomColorInner.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {randomColorInner, "BorderColor3", "elementBorder"}
				randomColorInner.Position = UDim2.fromScale(0.5, 0.5)
				randomColorInner.Selectable = true
				randomColorInner.Size = UDim2.new(1, -4, 1, -4)
				randomColorInner.Image = "rbxassetid://2454009026"
				randomColorInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {randomColorInner, "ImageColor3", "bottomGradient"}
				randomColorButton.Name = "randomColorButton"
				randomColorButton.Parent = randomColor
				randomColorButton.BackgroundColor3 = Color3.new(1, 1, 1)
				randomColorButton.BackgroundTransparency = 1
				randomColorButton.Size = UDim2.fromScale(1, 1)
				randomColorButton.ZIndex = 5
				randomColorButton.Image = "rbxassetid://7484765651"
				rainbow.Name = "rainbow"
				rainbow.Parent = colorPickerHolderInner
				rainbow.Active = true
				rainbow.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {rainbow, "BackgroundColor3", "topGradient"}
				rainbow.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {rainbow, "BorderColor3", "elementBorder"}
				rainbow.Position = UDim2.fromOffset(158 + 18 + 4, 223)
				rainbow.Selectable = true
				rainbow.Size = UDim2.fromOffset(18, 18)
				rainbow.Image = "rbxassetid://2454009026"
				rainbow.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {rainbow, "ImageColor3", "bottomGradient"}
				rainbowInner.Name = "rainbowInner"
				rainbowInner.Parent = randomColor
				rainbowInner.Active = true
				rainbowInner.AnchorPoint = Vector2.new(0.5, 0.5)
				rainbowInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {rainbowInner, "BackgroundColor3", "topGradient"}
				rainbowInner.BorderColor3 = library.colors.elementBorder
				colored[1 + #colored] = {rainbowInner, "BorderColor3", "elementBorder"}
				rainbowInner.Position = UDim2.fromScale(0.5, 0.5)
				rainbowInner.Selectable = true
				rainbowInner.Size = UDim2.new(1, -4, 1, -4)
				rainbowInner.Image = "rbxassetid://2454009026"
				rainbowInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {rainbowInner, "ImageColor3", "bottomGradient"}
				rainbowButton.Name = "rainbowButton"
				rainbowButton.Parent = rainbow
				rainbowButton.BackgroundColor3 = Color3.new(1, 1, 1)
				rainbowButton.BackgroundTransparency = 1
				rainbowButton.Size = UDim2.fromScale(1, 1)
				rainbowButton.ZIndex = 5
				rainbowButton.Image = "rbxassetid://7484772919"
				local indexwith = (designers and "rainbows") or "rainbowsg"
				local function setrainbow(t, rainbowColorMod)
					if nil == rainbowColorMod and t ~= nil then
						rainbowColorMod = t
					end
					if rainbowColorMod == nil or type(rainbowColorMod) ~= "boolean" then
						rainbowColorMode = not rainbowColorMode
					else
						rainbowColorMode = rainbowColorMod
					end
					if colorInput then
						colorInput = (colorInput:Disconnect() and nil) or nil
					end
					if hueInput then
						hueInput = (hueInput:Disconnect() and nil) or nil
					end
					pcall(function()
						if destroyrainbows and library.rainbows <= 0 then
							destroyrainbows = nil
						end
						if destroyrainbowsg and library.rainbowsg <= 0 then
							destroyrainbowsg = nil
						end
					end)
					if rainbowColorMode then
						pcall(function()
							if not library.rainbowflags[flagName] then
								library[indexwith] = 1 + library[indexwith]
							end
							library.rainbowflags[flagName] = true
							oldImageColor = colorPickerInner.ImageColor3
							oldBackgroundColor = colorPickerInner.BackgroundColor3
							oldColor = color.BackgroundColor3
							pcall(function()
								local common_float = 1 / 255
								while wait_check() and rainbowColorMode and (options.Value == "rainbow" or ((not designers and not destroyrainbowsg) or (designers and not destroyrainbows))) do
									rainbowColorValue = common_float + rainbowColorValue
									if rainbowColorValue > 1 then
										rainbowColorValue = 0
									end
									colorH = rainbowColorValue
									UpdateColorPicker(Color3.fromHSV(rainbowColorValue, 1, 1), true)
								end
							end)
						end)
						pcall(function()
							rainbowColorMode = nil
							if library.rainbowflags[flagName] then
								library[indexwith] = library[indexwith] - 1
							end
							library.rainbowflags[flagName] = nil
						end)
					end
					UpdateColorPicker(library_flags[flagName])
				end
				library.signals[1 + #library.signals] = randomColorButton.MouseButton1Click:Connect(function()
					if rainbowColorMode then
						setrainbow(false)
					end
					UpdateColorPicker(Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)))
				end)
				library.signals[1 + #library.signals] = rainbowButton.MouseButton1Click:Connect(setrainbow)
				sectionFunctions:Update()
				library.signals[1 + #library.signals] = newColorPicker.MouseEnter:Connect(function()
					tweenService:Create(colorPicker, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = darkenColor(library.colors.main, 1.5),
						ImageColor3 = darkenColor(library.colors.main, 2.5)
					}):Play()
					colored_colorPicker_BackgroundColor3[3] = "main"
					colored_colorPicker_BackgroundColor3[4] = 1.5
					colored_colorPicker_ImageColor3[3] = "main"
					colored_colorPicker_ImageColor3[4] = 2.5
				end)
				library.signals[1 + #library.signals] = newColorPicker.MouseLeave:Connect(function()
					if not colorPickerEnabled then
						tweenService:Create(colorPicker, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = library.colors.topGradient,
							ImageColor3 = library.colors.bottomGradient
						}):Play()
						colored_colorPicker_BackgroundColor3[3] = "topGradient"
						colored_colorPicker_BackgroundColor3[4] = nil
						colored_colorPicker_ImageColor3[3] = "bottomGradient"
						colored_colorPicker_ImageColor3[4] = nil
					end
				end)
				hexInputBox.FocusLost:Connect(function()
					if #hexInputBox.Text > 5 then
						local last_vv = library_flags[flagName]
						local not_fucked, clr = pcall(Color3FromHex, hexInputBox.Text)
						UpdateColorPicker((not_fucked and clr) or last_vv)
					end
				end)
				colorH = 1 - (math.clamp(selectorHue.AbsolutePosition.X - hue.AbsolutePosition.X, 0, hue.AbsoluteSize.X) / hue.AbsoluteSize.X)
				colorS = (math.clamp(selectorColor.AbsolutePosition.X - color.AbsolutePosition.X, 0, color.AbsoluteSize.X) / color.AbsoluteSize.X)
				colorV = 1 - (math.clamp(selectorColor.AbsolutePosition.Y - color.AbsolutePosition.Y, 0, color.AbsoluteSize.Y) / color.AbsoluteSize.Y)
				library.signals[1 + #library.signals] = color.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						isDraggingSomething = true
						colorInput = (colorInput and colorInput:Disconnect() and nil) or runService.RenderStepped:Connect(function()
							local colorX = (math.clamp(mouse.X - color.AbsolutePosition.X, 0, color.AbsoluteSize.X) / color.AbsoluteSize.X)
							local colorY = (math.clamp(mouse.Y - color.AbsolutePosition.Y, 0, color.AbsoluteSize.Y) / color.AbsoluteSize.Y)
							selectorColor.Position = UDim2.fromScale(colorX, colorY)
							colorS = colorX
							colorV = 1 - colorY
							UpdateColorPicker()
						end)
						library.signals[1 + #library.signals] = colorInput
					end
				end)
				library.signals[1 + #library.signals] = color.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						if colorInput then
							isDraggingSomething = false
							colorInput:Disconnect()
						end
					end
				end)
				library.signals[1 + #library.signals] = hue.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						if hueInput then
							hueInput:Disconnect()
						end
						isDraggingSomething = true
						hueInput = runService.RenderStepped:Connect(function()
							local hueX = math.clamp(mouse.X - hue.AbsolutePosition.X, 0, hue.AbsoluteSize.X) / hue.AbsoluteSize.X
							selectorHue.Position = UDim2.new(hueX)
							colorH = 1 - hueX
							UpdateColorPicker()
						end)
						library.signals[1 + #library.signals] = hueInput
					end
				end)
				library.signals[1 + #library.signals] = hue.InputEnded:Connect(function(input)
					if Input.UserInputType == input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						isDraggingSomething = false
						hueInput:Disconnect()
					end
				end)
				if rainbowColorMode then
					spawn(function()
						rainbowColorMode = nil
						setrainbow(true)
					end)
				end
				local function Set(t, clr)
					if clr == nil and t ~= nil then
						clr = t
					end
					if clr == "rainbow" then
						if not rainbowColorMode then
							task.spawn(setrainbow, true)
						end
						return
					elseif clr == "random" then
						clr = Color3.new(math.random(), math.random(), math.random())
					elseif type(clr) == "string" and tonumber(clr, 16) then
						clr = Color3FromHex(clr)
					end
					task.spawn(setrainbow, false)
					local last_v = library_flags[flagName]
					library_flags[flagName] = clr
					if options.Location then
						options.Location[options.LocationFlag or flagName] = clr
					end
					color.BackgroundColor3 = clr
					selectorColor.Position = UDim2.new(clr and select(3, Color3.toHSV(clr)))
					selectorHue.Position = UDim2.new(1 - (Color3.toHSV(clr)))
					colorPickerInner.BackgroundColor3 = darkenColor(clr, 1.5)
					colorPickerInner.ImageColor3 = darkenColor(clr, 2.5)
					hexInputBox.Text = Color3ToHex(clr)
					colorH, colorS, colorV = Color3.toHSV(clr)
					if callback and (last_v ~= clr or options.AllowDuplicateCalls) then
						task.spawn(callback, clr, last_v)
					end
					return clr
				end
				if presetColor ~= nil then
					Set(presetColor)
				else
					library_flags[flagName] = startingColor
					if options.Location then
						options.Location[options.LocationFlag or flagName] = startingColor
					end
				end
				local default = options.Value or startingColor or library_flags[flagName]
				local function update()
					colorPickerName, callback = options.Name or colorPickerName, options.Callback
					local clr = library_flags[flagName]
					color.BackgroundColor3 = clr
					selectorColor.Position = UDim2.new(clr and select(3, Color3.toHSV(clr)))
					selectorHue.Position = UDim2.new(1 - (Color3.toHSV(clr)))
					colorPickerInner.BackgroundColor3 = darkenColor(clr, 1.5)
					colorPickerInner.ImageColor3 = darkenColor(clr, 2.5)
					hexInputBox.Text = Color3ToHex(clr)
					colorPickerHeadline.Text = colorPickerName or "???"
					return clr
				end
				local objectdata = {
					Options = options,
					Name = flagName,
					Flag = flagName,
					Type = "Colorpicker",
					Default = default,
					Parent = sectionFunctions,
					Instance = newColorPicker,
					SetRainbow = setrainbow,
					Get = function()
						return library_flags[flagName]
					end,
					GetRainbow = function()
						return rainbowColorMode
					end,
					Set = Set,
					RawSet = function(t, clr)
						if clr == nil and t ~= nil then
							clr = t
						end
						if clr == "rainbow" then
							if not rainbowColorMode then
								task.spawn(setrainbow, true)
							end
							return clr
						elseif clr == "random" then
							clr = Color3.new(math.random(), math.random(), math.random())
						elseif clr and type(clr) == "string" and tonumber(clr, 16) then
							clr = Color3FromHex(clr)
						end
						task.spawn(setrainbow, false)
						library_flags[flagName] = clr
						if options.Location then
							options.Location[options.LocationFlag or flagName] = clr
						end
						return clr
					end,
					Update = update,
					Reset = function()
						return Set(nil, default)
					end
				}
				tabFunctions.Flags[flagName], sectionFunctions.Flags[flagName], elements[flagName] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.AddColorPicker = sectionFunctions.AddColorpicker
			sectionFunctions.NewColorpicker = sectionFunctions.AddColorpicker
			sectionFunctions.NewColorPicker = sectionFunctions.AddColorpicker
			sectionFunctions.CreateColorPicker = sectionFunctions.AddColorpicker
			sectionFunctions.CreateColorpicker = sectionFunctions.AddColorpicker
			sectionFunctions.ColorPicker = sectionFunctions.AddColorpicker
			sectionFunctions.Colorpicker = sectionFunctions.AddColorpicker
			sectionFunctions.Cp = sectionFunctions.AddColorpicker
			sectionFunctions.CP = sectionFunctions.AddColorpicker
			function sectionFunctions:UpdateAll()
				local target = self or sectionFunctions
				if target and type(target) == "table" and target.Flags then
					for _, e in next, target.Flags do
						if e and type(e) == "table" and e.Update then
							pcall(e.Update)
						end
					end
				end
			end
			return sectionFunctions
		end
		tabFunctions.AddSection = tabFunctions.CreateSection
		tabFunctions.NewSection = tabFunctions.CreateSection
		tabFunctions.Section = tabFunctions.CreateSection
		tabFunctions.Sec = tabFunctions.CreateSection
		tabFunctions.S = tabFunctions.CreateSection
		function tabFunctions:UpdateAll()
			local target = self or tabFunctions
			if target and type(target) == "table" and target.Flags then
				for _, e in next, target.Flags do
					if e and type(e) == "table" and e.Update then
						pcall(e.Update)
					end
				end
			end
		end
		return tabFunctions
	end
	windowFunctions.AddTab = windowFunctions.CreateTab
	windowFunctions.NewTab = windowFunctions.CreateTab
	windowFunctions.Tab = windowFunctions.CreateTab
	windowFunctions.T = windowFunctions.CreateTab
	function windowFunctions:CreateDesigner(options, ...)
		options = (options and type(options) == "string" and resolvevararg("Tab", options, ...)) or options
		assert(shared.bypasstablimit or library.Designer == nil, "Designer already exists")
		options = options or {}
		options.Image = options.Image or 7483871523
		options.LastTab = true
		local designer = windowFunctions:CreateTab(options)
		local colorsection = designer:CreateSection({
			Name = "Colors"
		})
		local backgroundsection = designer:CreateSection({
			Name = "Background",
			Side = "right"
		})
		local detailssection = designer:CreateSection({
			Name = "Info"
		})
		local filessection = designer:CreateSection({
			Name = "Profiles",
			Side = "right"
		})
		local settingssection = designer:CreateSection({
			Name = "Settings",
			Side = "right"
		})
		local designerelements = {}
		library.designerelements = designerelements
		for _, v in next, {{"Main", "main"}, {"Background", "background"}, {"Outer Border", "outerBorder"}, {"Inner Border", "innerBorder"}, {"Top Gradient", "topGradient"}, {"Bottom Gradient", "bottomGradient"}, {"Section Background", "sectionBackground"}, {"Section", "section"}, {"Element Text", "elementText"}, {"Other Element Text", "otherElementText"}, {"Tab Text", "tabText"}, {"Element Border", "elementBorder"}, {"Selected Option", "selectedOption"}, {"Unselected Option", "unselectedOption"}, {"Hovered Option Top", "hoveredOptionTop"}, {"Unhovered Option Top", "unhoveredOptionTop"}, {"Hovered Option Bottom", "hoveredOptionBottom"}, {"Unhovered Option Bottom", "unhoveredOptionBottom"}} do
			local nam, codename = v[1], v[2]
			local cflag = "__Designer.Colors." .. codename
			designerelements[codename] = {
				Return = colorsection:AddColorpicker({
					Name = nam,
					Flag = cflag,
					Value = library.colors[codename],
					Callback = function(v, y)
						library.colors[codename] = v or y
					end,
					__designer = 1
				}),
				Flag = cflag
			}
		end
		local flags = {}
		local persistoptions = {
			Name = "Workspace Profile",
			Flag = "__Designer.Background.WorkspaceProfile",
			Flags = true,
			Suffix = "Config",
			Workspace = library.WorkspaceName or "Unnamed Workspace",
			Desginer = true
		}
		local daaata = {{"AddTextbox", "__Designer.Textbox.ImageAssetID", backgroundsection, {
			Name = "Image Asset ID",
			Placeholder = "rbxassetid://4427304036",
			Flag = "__Designer.Background.ImageAssetID",
			Value = "rbxassetid://4427304036",
			Callback = updatecolorsnotween
		}}, {"AddColorpicker", "__Designer.Colorpicker.ImageColor", backgroundsection, {
			Name = "Image Color",
			Flag = "__Designer.Background.ImageColor",
			Value = Color3.new(1, 1, 1),
			Callback = updatecolorsnotween,
			__designer = 1
		}}, {"AddSlider", "__Designer.Slider.ImageTransparency", backgroundsection, {
			Name = "Image Transparency",
			Flag = "__Designer.Background.ImageTransparency",
			Value = 95,
			Min = 0,
			Max = 100,
			Format = "Image Transparency: %s%%",
			Textbox = true,
			Callback = updatecolorsnotween
		}}, {"AddToggle", "__Designer.Toggle.UseBackgroundImage", backgroundsection, {
			Name = "Use Background Image",
			Flag = "__Designer.Background.UseBackgroundImage",
			Value = true,
			Callback = updatecolorsnotween
		}}, {"AddPersistence", "__Designer.Persistence.ThemeFile", filessection, {
			Name = "Theme Profile",
			Flag = "__Designer.Files.ThemeFile",
			Workspace = "Function Lib Themes",
			Flags = flags,
			Suffix = "Theme",
			Desginer = true
		}}, {"AddTextbox", "__Designer.Textbox.WorkspaceName", filessection, {
			Name = "Workspace Name",
			Value = library.WorkspaceName or "Unnamed Workspace",
			Flag = "__Designer.Files.WorkspaceFile",
			Callback = function(n, o)
				persistoptions.Workspace = n or o
			end
		}}, {"AddPersistence", "__Designer.Persistence.WorkspaceProfile", filessection, persistoptions}, {"AddButton", "__Designer.Button.TerminateGUI", settingssection, {{
			Name = "Terminate GUI",
			Callback = library.unload
		}, {
			Name = "Reset GUI",
			Callback = resetall
		}}}, {"AddKeybind", "__Designer.Keybind.ShowHideKey", settingssection, {
			Name = "Show/Hide Key",
			Location = library.configuration,
			Flag = "__Designer.Settings.ShowHideKey",
			LocationFlag = "hideKeybind",
			Value = library.configuration.hideKeybind,
			Callback = function()
				lasthidebing = os.clock()
			end
		}}}
		if setclipboard and daaata[8] then
			local common_table = daaata[8][4]
			if common_table then
				common_table[1 + #common_table] = {
					Name = "Join Discord",
					Callback = function()
						local http = game:GetService('HttpService') 
						local req =  http_request or request or HttpPost or syn.request 
						if req then
							req({
								Url = 'http://127.0.0.1:6463/rpc?v=1',
								Method = 'POST',
								Headers = {
									['Content-Type'] = 'application/json',
									Origin = 'https://discord.com'
								},
								Body = http:JSONEncode({
									cmd = 'INVITE_BROWSER',
									nonce = http:GenerateGUID(false),
									args = {code = 'uNQRZs6gzm'}
								})
							})
						end
					end
				}
				common_table = nil
			end
		end
		if options.Info then
			local typ = type(options.Info)
			if typ == "string" then
				daaata[1 + #daaata] = {"AddLabel", "__Designer.Label.Creator", detailssection, {
					Text = options.Info
				}}
			elseif typ == "table" and #options.Info > 0 then
				for _, v in next, options.Info do
					daaata[1 + #daaata] = {"AddLabel", "__Designer.Label.Creator", detailssection, {
						Text = tostring(v)
					}}
				end
			end
		end
		for _, v in next, daaata do
			designerelements[v[2]] = v[3][v[1]](v[3], v[4])
		end
		designerelements["__Designer.Textbox.WorkspaceName"]:Set(library.WorkspaceName or "Unnamed Workspace")
		for k, v in next, elements do
			if v and k and string.sub(k, 1, 11) == "__Designer." and v.Type and v.Type ~= "Persistence" then
				flags[1 + #flags] = k
			end
		end
		if library.Backdrop then
			library.Backdrop.Image = resolveid(library_flags["__Designer.Background.ImageAssetID"], "__Designer.Background.ImageAssetID") or ""
			library.Backdrop.Visible = not not library_flags["__Designer.Background.UseBackgroundImage"]
			library.Backdrop.ImageTransparency = (library_flags["__Designer.Background.ImageTransparency"] or 95) / 100
			library.Backdrop.ImageColor3 = library_flags["__Designer.Background.ImageColor"] or Color3.new(1, 1, 1)
		end
		local function setbackground(t, Asset, Transparency, Visible)
			if Visible == nil and t ~= nil and type(t) ~= "table" then
				Asset, Transparency, Visible = t, Transparency, Visible
			end
			if Visible == 0 or ((Asset == 0 or Asset == false) and Visible == nil and Transparency == nil) then
				Visible = false
			elseif Visible == 1 or ((Asset == 1 or Asset == true) and Visible == nil and Transparency == nil) then
				Visible = true
			elseif Asset == nil and Transparency == nil and Visible == nil then
				Visible = not library_flags["__Designer.Background.UseBackgroundImage"]
			end
			local temp = Asset and type(Asset)
			if Transparency == nil and Visible == nil and temp == "number" and ((Asset ~= 1 and Asset ~= 0) or (Asset > 0 and Asset <= 100)) then
				Transparency, Asset, temp = Asset, nil
			end
			if temp and ((temp == "number" and Asset > 1) or temp == "string") then
				designerelements["__Designer.Textbox.ImageAssetID"]:Set(Asset)
			end
			temp = tonumber(Transparency)
			if temp then
				designerelements["__Designer.Slider.ImageTransparency"]:Set(temp)
			end
			if Visible ~= nil then
				designerelements["__Designer.Toggle.UseBackgroundImage"]:Set(not not Visible)
			end
			return Asset, Transparency, Visible
		end
		local bk = options.Background or options.Backdrop or options.Grahpic
		if bk then
			if type(bk) == "table" then
				setbackground(bk.Asset or bk[1], bk.Transparency or bk[2], bk.Visible or bk[3])
			else
				setbackground(bk, 0, 1)
			end
		end
		library.Designer = {
			Options = options,
			Parent = windowFunctions,
			Name = "Designer",
			Flag = "Designer",
			Type = "Designer",
			Instance = designer,
			SetBackground = setbackground
		}
		local savestuff = library.elements["__Designer.Background.WorkspaceProfile"]
		if savestuff then
			library.LoadFile = savestuff.LoadFile
			library.LoadFileRaw = savestuff.LoadFileRaw
			library.LoadJSON = savestuff.LoadJSON
			library.LoadJSONRaw = savestuff.LoadJSONRaw
			library.SaveFile = savestuff.SaveFile
			library.GetJSON = savestuff.GetJSON
		end
		spawn(updatecolorsnotween)
		return library.Designer
	end
	windowFunctions.AddDesigner = windowFunctions.CreateDesigner
	windowFunctions.NewDesigner = windowFunctions.CreateDesigner
	windowFunctions.Designer = windowFunctions.CreateDesigner
	windowFunctions.D = windowFunctions.CreateDesigner
	function windowFunctions:UpdateAll()
		local target = self or windowFunctions
		if target and type(target) == "table" and target.Flags then
			for _, e in next, target.Flags do
				if e and type(e) == "table" and e.Update then
					pcall(e.Update)
				end
			end
			pcall(function()
				if library.Backdrop then
					library.Backdrop.Visible = not not library_flags["__Designer.Background.UseBackgroundImage"]
					library.Backdrop.Image = resolveid(library_flags["__Designer.Background.ImageAssetID"], "__Designer.Background.ImageAssetID") or ""
					library.Backdrop.ImageColor3 = library_flags["__Designer.Background.ImageColor"] or Color3.new(1, 1, 1)
					library.Backdrop.ImageTransparency = (library_flags["__Designer.Background.ImageTransparency"] or 95) / 100
				end
			end)
		end
	end
	library.UpdateAll = windowFunctions.UpdateAll
	if options.Themeable or options.DefaultTheme or options.Theme then
		spawn(function()
			local os_clock = os.clock
			local starttime = os_clock()
			while os_clock() - starttime < 12 do
				if homepage then
					windowFunctions.GoHome = homepage
					local x, e = pcall(homepage)
					if not x and e then
						warn("Error going to Homepage:", e)
					end
					x, e = nil
					break
				end
				task.wait()
			end
			local whatDoILookLike = options.Themeable or options.DefaultTheme or options.Theme
			windowFunctions:CreateDesigner((type(whatDoILookLike) == "table" and whatDoILookLike) or nil)
			if options.DefaultTheme or options.Theme then
				spawn(function()
					local content = options.DefaultTheme or options.Theme or options.JSON or options.ThemeJSON
					if content and type(content) == "string" and #content > 1 then
						local good, jcontent = JSONDecode(content)
						if good and jcontent then
							for cflag, val in next, jcontent do
								local data = elements[cflag]
								if data and data.Type ~= "Persistence" then
									if data.Set then
										data:Set(val)
									elseif data.RawSet then
										data:RawSet(val)
									else
										library.flags[cflag] = val
									end
								end
							end
						end
					end
				end)
			end
			os_clock, starttime = nil
		end)
	end
	return windowFunctions
end
library.NewWindow = library.CreateWindow
library.AddWindow = library.CreateWindow
library.Window = library.CreateWindow
library.W = library.CreateWindow

local Wait = library.subs.Wait

local Wait = library.subs.Wait
Date = os.date("%A"..", ".."%B".." ".."%d"..", ".."%Y")
local PepsiUi = library:CreateWindow({
	Name = "Attack Hub Kaitun | " ..Date,
	Theme = {
		Image = "rbxassetid://7483871523",
		Info = "",
		Background = {
			Asset = "rbxassetid://16663324629"
		}
	}
})
local Page = PepsiUi:CreateTab({
    Name = "General"
})

local User = Page:CreateSection({
    Name = "info",
    Side = "Left"
})

local PlayersName = User:AddLabel({
    Name = "Name : "..game.Players.LocalPlayer.Name
})


local HealthUser = User:AddLabel({
    Name = ""
})

function Health()
    HealthUser:Set("Health : " ..game.Players.LocalPlayer.Character.Humanoid.Health)
end

spawn(function()
    pcall(function()
        while true do wait()
            Health()
        end
    end)
end)

local Race = User:AddLabel({
    Name = ""
})

function Races()
Race:Set("Race : " ..game.Players.LocalPlayer.Data.Race.Value)
end

spawn(function()
    pcall(function()
        while true do wait()
            Races()
        end
    end)
end)

local Level = User:AddLabel({
    Name = ""
})

function Levels()
    Level:Set("Level : " ..game.Players.LocalPlayer.Data.Level.Value)
end

spawn(function()
    pcall(function()
        while true do wait()
            Levels()
        end
    end)
end)

local Time = User:AddLabel({
    Name = ""
})

function UpdateTime()
    local GameTime = math.floor(workspace.DistributedGameTime + 0.5)
    local Hour = math.floor(GameTime / (60^2)) % 24
    local Minute = math.floor(GameTime / (60^1)) % 60
    local Second = math.floor(GameTime / (60^0)) % 60
    Time:Set(Hour .. " Hr(s) " .. Minute .. " Min(s) " .. Second .. " Sec(s) ")
end

spawn(function()
	pcall(function()
		while true do
			wait()
			UpdateTime()
		end
	end)
end)


local Melee = Page:CreateSection({
    Name = "Melee",
    Side = "Left"
})

local Superhuman = Melee:AddLabel({
    Name = "❌ | Superhuman"
})

local DeathStep = Melee:AddLabel({
    Name = "❌ | Death Step"
})

local SharkmanKarate = Melee:AddLabel({
    Name = "❌ | Sharkman Karate"
})

local ElectricClaw = Melee:AddLabel({
    Name = "❌ | Electric Claw"
})

local DragonTalon = Melee:AddLabel({
    Name = "❌ | Dragon Talon"
})

local GodHuman = Melee:AddLabel({
    Name = "❌ | God Human"
})

task.spawn(
    function()
        while task.wait() do
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman", true) == 1 then
                Superhuman:Set("✅ | Superhuman")
            end
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep", true) == 1 then
                DeathStep:Set("✅ | Death Step")
            end
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate", true) == 1 then
                SharkmanKarate:Set("✅ | Sharkman Karate")
            end
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", true) == 1 then
                ElectricClaw:Set("✅ | Electric Claw")
            end
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 1 then
                DragonTalon:Set("✅ | Dragon Talon")
            end
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman", true) == 1 then
                GodHuman:Set("✅ | God Human")
            end
        end
    end
)

local SwordReal = Page:CreateSection({
    Name = "Sword",
    Side = "Right"
})

local Saber = SwordReal:AddLabel({
    Name = "❌ | Saber"
})

local Yama = SwordReal:AddLabel({
    Name = "❌ | Yama"
})

local Tushita = SwordReal:AddLabel({
    Name = "❌ | Tushita"
})

local CursedDualKatana = SwordReal:AddLabel({
    Name = "❌ | Cursed Dual Katana"
})

task.spawn(
    function()
        while task.wait() do
            pcall(function()
                if Check_Sword("Saber") then
                    Saber:Set("✅ | Saber")
                end
                if Check_Sword("Yama") then
                    Yama:Set("✅ | Yama")
                end
                if Check_Sword("Tushita") then
                    Tushita:Set("✅ | Tushita")
                end
                if Check_Sword("Cursed Dual Katana") then
                    CursedDualKatana:Set("✅ | Cursed Dual Katana")
                end
            end)
        end
    end
)


local Gun = Page:CreateSection({
    Name = "Gun",
    Side = "Right"
})

local SoulGuitar = Gun:AddLabel({
    Name = "❌ | Soul Guitar"
})

task.spawn(
    function()
        while task.wait() do
            pcall(
                function()
                    for i, v in pairs(
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventoryWeapons")
                    ) do
                        if v.Name == "Soul Guitar" then
                            SoulGuitar:Set("✅ | Soul Guitar")
                        end                                               
                    end
                end
            )
        end
    end
)

--- hee

getgenv().Configs = {
    Team = "Pirates",
    FixLag = true,
    FPS = 240,
    WhiteScreen = false,
    Godhuman = true,
    Saber = true,
    CursedDualKatana = true,
    SkullGuitar = true,
    RaceV3 = true
}

local Config = getgenv().Configs

local LogCache = {}
local function LogChange(key, message)
	if LogCache[key] ~= message then
		LogCache[key] = message
		-- print(message)
	end
end

function Check_Sword(Sword_Name)
    for i, v in pairs(game:GetService("ReplicatedStorage").Remotes['CommF_']:InvokeServer("getInventory")) do
        if (v.Type == "Sword") then
            if v.Name == Sword_Name then
                return true
            end
        end
    end
end

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer
local TweenService = cloneref(game:GetService("TweenService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local TeleportService = cloneref(game:GetService("TeleportService"))
local Players = cloneref(game:GetService("Players"))
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local CoreGui = cloneref(game:GetService("CoreGui"))
local VirtualInputManager = game:GetService("VirtualInputManager")
local CommF_ = ReplicatedStorage.Remotes.CommF_
local CommE = ReplicatedStorage.Remotes.CommE
local MaxLevel = (workspace:GetAttribute("LEVEL_CAP") or 2800)
CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(v)
	if v.Name == "ErrorPrompt" and v:FindFirstChild("MessageArea") and v.MessageArea:FindFirstChild("ErrorFrame") then
		ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", game.JobId)
	end
end)
game.NetworkClient.ChildRemoved:Connect(function()
	ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", game.JobId)
	task.wait(5)
	TeleportService:Teleport(game.PlaceId)
end)

TeleportService.TeleportInitFailed:Connect(function(player, result, err)
	if result ~= Enum.TeleportResult.GameFull then
		ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", game.JobId)
	end
end)

if Config.WhiteScreen then
	RunService:Set3dRenderingEnabled(false)
	-- print("white screen applied")
end
if Config.FixLag then
	pcall(function()
		for _,v in pairs(Lighting:GetChildren()) do
			if v:IsA("PostEffect") then
				v.Enabled = false
			end
		end
		local function optimize(obj)
			if obj:IsA("BasePart") then
				obj.Material = Enum.Material.Plastic
				obj.Reflectance = 0
			elseif obj:IsA("Decal") or obj:IsA("Texture") then
				obj:Destroy()
			elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
				obj.Enabled = false
			elseif obj:IsA("Explosion") then
				obj.BlastPressure = 0
				obj.BlastRadius = 0
			end
		end
		for _,v in pairs(game:GetDescendants()) do
			optimize(v)
		end
		game.DescendantAdded:Connect(optimize)
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 9e9
		Lighting.Brightness = 0
		Lighting.EnvironmentDiffuseScale = 0
		Lighting.EnvironmentSpecularScale = 0
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		for _, v in workspace.Map:GetDescendants() do
			if v:IsA('BasePart') and v.Transparency ~= 1 then
				v.Transparency = 1
			end
		end
	end)
	-- print("lag fix applied")
end

if Config.FPS then
	setfpscap(Config.FPS)
	set_fps_cap(Config.FPS)
end

-- print("waiting for team...")

if not LocalPlayer.Team then
	repeat task.wait()
		CommF_:InvokeServer("SetTeam", Configs.Team)
	until LocalPlayer.Team
end
-- print("waiting for character...")
repeat task.wait(0.1) until LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
-- print("character ready")

-- print("team selected")

task.wait(2.5)

pcall(function() require(ReplicatedStorage.Util.CameraShaker):Stop() end)

-- print("camera shaker disabled")

-- print("initializing...")

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
LocalPlayer.CharacterAdded:Connect(function(v)
	Character = v
	-- print("character respawned")
end)

pcall(function()
	LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
		if child.Name == "SpinnerWindow" then
			child:Destroy()
		end
	end)
	workspace.ChildAdded:Connect(function(df)
		if df:IsA('Tool') then
			df:Destroy()
		end
	end)
end)

task.spawn(function()
	while true do
		local hrp = Character:FindFirstChild("HumanoidRootPart")
		if hrp and not hrp:FindFirstChild("fixvelo") then
			local bv = Instance.new("BodyVelocity")
			bv.Name = "fixvelo"
			bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			bv.Velocity = Vector3.new(0, 0, 0)
			bv.P = 1000
			bv.Parent = hrp
		end
		task.wait(0.5)
	end
end)

RunService.Stepped:Connect(function()
	if Character ~= nil then
		for _, child in Character:GetDescendants() do
			if child:IsA("BasePart") and child.CanCollide == true then
				child.CanCollide = false
			end
		end
	end
end)


task.spawn(function()
    while task.wait(1) do
        local t = os.date("*t")
        timeLabel.Text = string.format("%02d:%02d:%02d  |  %s, %s %d, %d", t.hour, t.min, t.sec, os.date("%A"), os.date("%B"), t.day, t.year)
    end
end)

pcall(function()
    assert(getrawmetatable)
    local grm = getrawmetatable(game)
    setreadonly(grm, false)
    local old = grm.__namecall
    grm.__namecall = newcclosure(function(self, ...)
        local args = {...}
        local name = tostring(args[1])
        for _, remote in ipairs({"TeleportDetect", "CHECKER_1", "CHECKER", "GUI_CHECK", "OneMoreTime", "checkingSPEED", "BANREMOTE", "PERMAIDBAN", "KICKREMOTE", "BR_KICKPC", "BR_KICKMOBILE"}) do
            if name == remote then
                return
            end
        end
        return old(self, ...)
    end)
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KaitunUIKrita"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer.PlayerGui
local frame = Instance.new("Frame", ScreenGui)
frame.Size = UDim2.new(0, 560, 0, 130)
frame.Position = UDim2.new(0.5, -280, 0, -9999999)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BackgroundTransparency = 0.05
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)
local gradient = Instance.new("UIGradient", frame)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(172, 224, 112)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 199, 164)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 133, 245))
})
gradient.Rotation = 0
local edge = Instance.new("UIStroke", frame)
edge.Color = Color3.fromRGB(196, 196, 196)
edge.Thickness = 3
edge.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local layout = Instance.new("UIListLayout", frame)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 6)
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -20, 0, 35)
title.BackgroundTransparency = 1
title.Text = "Attack Hub 1.0"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.LayoutOrder = 1
local timeLabel = Instance.new("TextLabel", frame)
timeLabel.Size = UDim2.new(1, -20, 0, 30)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "00:00:00"
timeLabel.Font = Enum.Font.GothamSemibold
timeLabel.TextSize = 18
timeLabel.TextColor3 = Color3.fromRGB(226, 246, 255)
timeLabel.LayoutOrder = 3
function SetStatus(text)
    local status = string.lower(tostring(text))
    if title.Text ~= status then
        -- print("ui: " .. status)
    end
    title.Text = status
end

local function EquipTool(v)
	Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild(v))
end

local function EquipWeapon(type)
	if not type then
		type = "Melee"
	end
	for _, v in LocalPlayer.Backpack:GetChildren() do
		if v.ToolTip == type then
			if not Character:FindFirstChild("HasBuso") then
				CommF_:InvokeServer("Buso")
			end
			Character.Humanoid:EquipTool(v)
			return
		end
	end
end

local function HasItem(name)
	if not Character then
		return
	end
	return Character:FindFirstChild(name) or LocalPlayer.Backpack:FindFirstChild(name)
end

local function CheckItem(Name)
	local data = IRS:GetItems(KEYS.QUANTITY)
	for _, v in data do
		local item = MATCH(v.ItemId)._ok
		local c = item.Display.Category
		if (c == "Sword" or c == "Gun" or c == "Accessory") and item.Index.StorageKey == Name then
			return true
		end
	end
	return false
end

local tw, conn
local function StopTween()
	if tw then
        LogChange("tween_stop", "tween: stopped")
		tw:Cancel()
		tw = nil
	end
	if conn then
		conn:Disconnect()
		conn = nil
	end
	local r = Character and Character:FindFirstChild("Root")
	if r then
		r:Destroy()
	end
end

local World = {}
World.Sea1 = function()
	return require(ReplicatedStorage.Util.Realm).getCurrentSeaAsync() == "Sea1"
end
World.Sea2 = function()
	return require(ReplicatedStorage.Util.Realm).getCurrentSeaAsync() == "Sea2"
end
World.Sea3 = function()
	return require(ReplicatedStorage.Util.Realm).getCurrentSeaAsync() == "Sea3"
end

local LastTravel = 0

local function RunTween(v, high)
    while not Character or not Character.PrimaryPart or not Character:FindFirstChild("Humanoid") do
        LogChange("tween_wait", "tween: waiting for character")
        task.wait()
    end
    local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        LogChange("tween_root", "tween: root missing")
        return
    end
    if typeof(v) == "CFrame" then
        v = v.Position
    end
    Character.Humanoid.Sit = false
    local targetCFrame = typeof(v) == "Vector3" and CFrame.new(v) or v
    local pos = targetCFrame.Position + Vector3.new(0, high or 0, 0)
    local rot = rootPart.CFrame - rootPart.Position
    local finalCFrame = CFrame.new(pos) * rot
    local distance = (rootPart.Position - finalCFrame.Position).Magnitude
    local speed
    if distance < 250 then
        speed = 285
    elseif distance < 500 then
        speed = 260
    elseif distance < 1000 then
        speed = 240
    else
        speed = 200
    end
    local travelTime = distance / speed
    if distance >= 1000 then
        LogChange("long_tween", "tween: long travel")
    end
    tw = TweenService:Create(rootPart, TweenInfo.new(travelTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { CFrame = finalCFrame })
    tw:Play()
    return tw
end
local function BreakClouds()
	if workspace.Map:FindFirstChild("Sky") then
		for _, v in workspace.Map.Sky:GetChildren() do
			if v:IsA("MeshPart") and v.Name == "cloud" and (Vector3.new(-4208.15869140625, 1089.8868408203125, -373.052490234375) - v.Position).Magnitude < 50 and not v:GetAttribute("Broken") then
				EquipWeapon()
                Character.HumanoidRootPart:PivotTo(v.CFrame)
				task.wait(0.25)
				ReplicatedStorage.Modules.Net["RE/RegisterAttack"]:FireServer(0.4)
				ReplicatedStorage.Modules.Net["RE/RegisterHit"]:FireServer(v)
                task.wait(0.5)
			end
		end
	end
end
local function SmartTween(t)
    if World.Sea3() then
        if not CheckItem("Valkyrie Helm") then
            LogChange("entrance_block", "travel: missing valkyrie helm")
            return
        end
    end
    if typeof(t) == "CFrame" then
        t = t.Position
    end
    while not Character or not Character.PrimaryPart or not Character:FindFirstChild("Humanoid") do
        task.wait()
    end
    local _is
    if World.Sea3() then
        _is = {
			{ Vector3.new(-5027.0302734375, 316.5475769042969, -3206.70361328125), Vector3.new(5650.94775390625, 1017.2747802734375, -350.37918090820312) },
            { Vector3.new(5650.94775390625, 1017.2747802734375, -350.37918090820312), Vector3.new(-5027.0302734375, 316.5475769042969, -3206.70361328125) },
            { Vector3.new(-12463.6025390625, 378.32705688476562, -7566.0830078125), Vector3.new(-5060.41162109375, 316.5475769042969, -3193.224853515625) },
            { Vector3.new(-5060.41162109375, 318.50201416015625, -3193.224853515625), Vector3.new(-12463.6025390625, 376.3725280761719, -7566.0830078125) },
        }
    elseif World.Sea2() then
        _is = {
            { Vector3.new(-390, 332, 673), Vector3.new(-390, 332, 673) },
            { Vector3.new(2285, 15, 905), Vector3.new(2285, 15, 905) },
            { Vector3.new(923, 126, 32852), Vector3.new(923, 126, 32852) },
            { Vector3.new(-6509, 83, -133), Vector3.new(-6509, 83, -133) },
        }
    elseif World.Sea1() then
        _is = {
			{ Vector3.new(61163.8515625, 11.6796875, 1819.7841796875), Vector3.new(4050.31103515625, -1.6880035400390625, -1814.1240234375) },
            { Vector3.new(3864.8515625, 6.6796875, -1926.7841796875), Vector3.new(61170.046875, -2, 1952.833984375) },
            { Vector3.new(-4166.60986328125, 1093.697998046875, -347.16226196289062), Vector3.new(-6020.27734375, 5469.15625, 2209.776123046875) },
        }
    else
        return
    end

    local min = nil
    local pos = 1
    for i, v in ipairs(_is) do
        local distanceToTarget = (t - v[1]).Magnitude
        if min == nil then
            min = distanceToTarget
        else
            if distanceToTarget < min then
                min = distanceToTarget
                pos = i
            end
        end
    end
    local dist = LocalPlayer:DistanceFromCharacter(t)
	local disttotp = LocalPlayer:DistanceFromCharacter(_is[pos][2])
    if (min + disttotp) < dist and (tick() - LastTravel) >= 1 then
        LastTravel = tick()
        -- print("travel: using entrance")
        tw = RunTween(_is[pos][2])
        if tw then
            tw.Completed:Wait()
        end
		task.wait(0.25)
		-- print("travel: requesting entrance")
		task.wait(0.25)
		if not CollectionService:HasTag(LocalPlayer, "Teleporting") then
			CommF_:InvokeServer("requestEntrance", _is[pos][1])
		end
		repeat task.wait() until (LocalPlayer:DistanceFromCharacter(_is[pos][1]) < LocalPlayer:DistanceFromCharacter(_is[pos][2]))
        -- print("travel: entrance reached")
        task.wait(0.25)
    end
end
local function Tween(v, speed, high)
    while not Character or not Character.PrimaryPart or not Character:FindFirstChild("Humanoid") do
        task.wait()
    end
    SmartTween(v)
    return RunTween(v, high)
end

local function WaitForAliveCharacter()
    while true do
        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if character and humanoid and humanoid.Health > 0 and root then
            return character, humanoid, root
        end
        task.wait(0.1)
    end
end

local function TweenWithRespawnRetry(target, speed, high)
    while true do
        local currentCharacter = LocalPlayer.Character
        local currentHumanoid = currentCharacter and currentCharacter:FindFirstChildOfClass("Humanoid")
        local currentRoot = currentCharacter and currentCharacter:FindFirstChild("HumanoidRootPart")
        if not currentCharacter or not currentHumanoid or currentHumanoid.Health <= 0 or not currentRoot then
            LogChange("respawn_wait", "tween: waiting for respawn")
        end
        local startCharacter, humanoid, root = WaitForAliveCharacter()
        LogChange("respawn_wait", "tween: character ready")
        local died = false
        local activeTween = nil

        local diedConnection = humanoid.Died:Connect(function()
            died = true
            if activeTween then
                pcall(function()
                    activeTween:Cancel()
                end)
            end
        end)

        local ok, tweenOrError = pcall(function()
            return Tween(target, speed, high)
        end)

        if ok and tweenOrError then
            activeTween = tweenOrError

            local finished = false
            local playbackState = nil
            local completedConnection = activeTween.Completed:Connect(function(state)
                playbackState = state
                finished = true
            end)

            local currentState = activeTween.PlaybackState
            if currentState == Enum.PlaybackState.Completed or currentState == Enum.PlaybackState.Cancelled then
                playbackState = currentState
                finished = true
            end

            if died then
                pcall(function()
                    activeTween:Cancel()
                end)
            end

            while not finished do
                task.wait(0.05)
            end

            completedConnection:Disconnect()
            diedConnection:Disconnect()

            local currentCharacter = LocalPlayer.Character
            local stillSameCharacter = currentCharacter == startCharacter
                and humanoid.Parent ~= nil
                and humanoid.Health > 0
                and root.Parent ~= nil
                and not died

            if not stillSameCharacter then
                -- print("tween: retry after respawn")
                task.wait(0.1)
            elseif playbackState == Enum.PlaybackState.Completed then
                LogChange("tween_result", "tween: complete")
                return true
            else
                LogChange("tween_result", "tween: cancelled")
                return false
            end
        else
            diedConnection:Disconnect()
            local characterChanged = LocalPlayer.Character ~= startCharacter
            if died or characterChanged or humanoid.Health <= 0 or not root.Parent then
                task.wait(0.1)
            else
                if not ok then
                    warn("tween retry failed: " .. tostring(tweenOrError))
                end
                return false
            end
        end
    end
end

task.spawn(function()
	while true do
		pcall(function()
			local char = LocalPlayer.Character
			if char and char.PrimaryPart and char:FindFirstChildOfClass("Humanoid") and char.Humanoid.Health > 0 then
				CommE:FireServer("Dodge", nil, 30, true, workspace:GetServerTimeNow())
			end
		end)
		task.wait(2.5)
	end
end)

task.spawn(function()
	while task.wait(0.5) do
		for _, v in LocalPlayer.PlayerGui:GetDescendants() do
			if v:IsA("TextLabel") and v.Text:find("Confront the prisoner") then
				local BonusMomentsRemoteFunction = ReplicatedStorage.Remotes.BonusMomentsRemoteFunction
				BonusMomentsRemoteFunction:InvokeServer("Escape from Alcatraz", "Provoke", "Puncher")
				BonusMomentsRemoteFunction:InvokeServer("Escape from Alcatraz", "Provoke", "Digger")
				BonusMomentsRemoteFunction:InvokeServer("Escape from Alcatraz", "Provoke", "Raft")
				local success, controllerModule = pcall(require,  ReplicatedStorage.Controllers.BonusMomentsController)
				if success and type(controllerModule) == "table" and rawget(controllerModule, "GetLoadedMoments") then
					local loadedMoments = controllerModule:GetLoadedMoments()
					for momentName, momentInstance in pairs(loadedMoments) do
						if type(momentInstance) == "table" then
							if type(momentInstance.Trove and momentInstance.Trove.Clean) == "function" then
								pcall(function() momentInstance.Trove:Clean() end)
							end
							if type(momentInstance._MainMaid and momentInstance._MainMaid.DoCleaning) == "function" then
								pcall(function() momentInstance._MainMaid:DoCleaning() end)
							end
							if type(momentInstance._Maid and momentInstance._Maid.DoCleaning) == "function" then
								pcall(function() momentInstance._Maid:DoCleaning() end)
							end
						end
						loadedMoments[momentName] = nil
					end
				end
			end
		end
	end
end)

local function TeleportSeabeast(c5)
	local a = Vector3.new(0, c5:FindFirstChild("HumanoidRootPart").Position.Y, 0)
	local ab = Vector3.new(0, workspace.Map["WaterBase-Plane"].Position.Y, 0)
	if (a - ab).Magnitude <= 175 then
		Tween(c5.HumanoidRootPart.CFrame * CFrame.new(0, 300, 50), 280).Completed:Wait()
	else
		Tween(CFrame.new(c5.HumanoidRootPart.Position.X,workspace.Map["WaterBase-Plane"].Position.Y + 200,c5.HumanoidRootPart.Position.Z),280).Completed:Wait()
	end
end

local function CheckPirateBoat()
	for _, v in workspace.Enemies:GetChildren() do
		if table.find({"PirateBasic","PirateBrigade"}, v.Name) and v:FindFirstChild("Health") and v.Health.Value > 0 then
			return v
		end
	end
end

local function CheckSeabeast()
	if not workspace:FindFirstChild("SeaBeasts") then
		return
	end
	for _, v in workspace.SeaBeasts:GetChildren() do
		if v.Name == "SeaBeast1" then
			if v.Health.Value >= 34500 then
				return v
			end
		end
	end
	return false
end

local function CheckBoat()
	for _, v in workspace.Boats:GetChildren() do
		if v:IsA("Model") then
			if v:FindFirstChild("Owner") and tostring(v.Owner.Value) == LocalPlayer.Name and v.Humanoid.Value > 0 and v:FindFirstChild("Engine") then
				if LocalPlayer:DistanceFromCharacter(v.Engine.CFrame.Position) <= 1750 then
					return v
				end
			end
		end
	end
	return false
end

local function GetElite()
	for _, v in {"Diablo", "Deandre", "Urban", "Tyrant of the Skies"} do
		local e = ReplicatedStorage:FindFirstChild(v) or workspace.Enemies:FindFirstChild(v)
		if e and e:FindFirstChild("Humanoid") then
			if e.Humanoid.Health > 0 then
				return e
			end
		end
	end
	return false
end

local r, id
for _, v in {ReplicatedStorage.Util, ReplicatedStorage.Common, ReplicatedStorage.Remotes, ReplicatedStorage.Assets, ReplicatedStorage.FX} do
	for _, n in v:GetChildren() do
		if n:IsA("RemoteEvent") and n:GetAttribute("Id") then
			r, id = n, n:GetAttribute("Id")
		end
	end
	v.ChildAdded:Connect(function(n)
		if n:IsA("RemoteEvent") and n:GetAttribute("Id") then
			r, id = n, n:GetAttribute("Id")
		end
	end)
end

local function Attack()
	local char = Character
	local parts = {}
	for _, v in workspace.Enemies:GetChildren() do
		local hrp = v:FindFirstChild("HumanoidRootPart")
		local hum = v:FindFirstChild("Humanoid")
		if v ~= char and hrp and hum and hum.Health > 0 and LocalPlayer:DistanceFromCharacter(hrp.Position) <= 35 then
			for _, _v in v:GetChildren() do
				if _v:IsA("BasePart") and LocalPlayer:DistanceFromCharacter(hrp.Position) <= 35 then
					parts[#parts + 1] = { v, _v }
				end
			end
		end
	end
	if #parts == 0 then
		return
	end
	local tool = char:FindFirstChildOfClass("Tool")
	if #parts > 0 and tool and (tool.ToolTip == "Melee" or tool.ToolTip == "Sword") then
		if (tool.Name == "Black Leg" and tool.Level.Value >= 150) or (tool.Name == "Death Step" and tool.Level.Value >= 400) then
			if LocalPlayer.PlayerGui.Main.Skills:FindFirstChild(tool.Name) and LocalPlayer.PlayerGui.Main.Skills[tool.Name].V.Cooldown.AbsoluteSize.X <= 0 then
				VirtualInputManager:SendKeyEvent(true, "V", false, game)
				VirtualInputManager:SendKeyEvent(false, "V", false, game)
				task.wait(1.5)
			end
		end
		ReplicatedStorage.Modules.Net["RE/RegisterAttack"]:FireServer()
		local head = parts[1][1]:FindFirstChild("Head")
		ReplicatedStorage.Modules.Net["RE/RegisterHit"]:FireServer( head, parts, {}, tostring(LocalPlayer.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15) )
		cloneref(r):FireServer(
			string.gsub("RE/RegisterHit", ".", function(c)
				return string.char(bit32.bxor(string.byte(c), math.floor(workspace:GetServerTimeNow() / 10 % 10) + 1))
			end),
			bit32.bxor(id + 909090, ReplicatedStorage.Modules.Net.seed:InvokeServer() * 2),
			head,
			parts
		)
	end
end

local function GetNearestChests()
	local nearest, minDist = nil, 99999
	for _, v in workspace:GetDescendants() do
		if v.Name == "Chest1" or v.Name == "Chest2" or v.Name == "Chest3" then
			if v:IsA("Part") and v.CanTouch then
				local dist = LocalPlayer:DistanceFromCharacter(v:GetPivot().Position)
				if dist < minDist then
					minDist = dist
					nearest = v
				end
			end
		end
	end
	return nearest
end

local function IfTableHaveIndex(k)
	for _ in k do
		return true
	end
end
LastServersDataPulled = 0
CachedServers = {}
local function GetServers()
	if LastServersDataPulled then
		if os.time() - LastServersDataPulled < 60 then
			return CachedServers
		end
	end
	for i = 1, 100, 1 do
		local W = ReplicatedStorage:WaitForChild("__ServerBrowser"):InvokeServer(i)
		if IfTableHaveIndex(W) then
			LastServersDataPulled = os.time()
			CachedServers = W
			return W
		end
	end
end

local function HopLowServer()
	for i, v in GetServers() do
		if v.Count <= 5 then
			return ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", i)
		end
	end
end

local function CheckSafezone(p)
	if not Character then
		return
	end
	if not Character:FindFirstChild("Humanoid") then
		return
	end
	if Character.Humanoid.Health > 0 then
		for _, v in workspace["_WorldOrigin"].SafeZones:GetChildren() do
			if v:IsA("Part") then
				if p and p:FindFirstChild("PrimaryPart") and (v.Position - p.PrimaryPart.Position).magnitude <= 200 and p.Humanoid.Health / p.Humanoid.MaxHealth >= 90 / 100 then
					return true
				end
			end
		end
	end
	return false
end

BlacklistedPlayers = {
	LocalPlayer.Name,
}
local Hop

local function GetSkyRacePlayer()
	for _, Player in Players:GetPlayers() do
		if Player and Player.Character then
			local Humanoid = Player.Character:FindFirstChild("Humanoid")
			if not table.find(BlacklistedPlayers, Player.Name) and Humanoid and Humanoid.Health > 0 then
				Hop()
				if Player.Data.Race.Value == "Skypiea" and not Player:GetAttribute("IslandRaiding") then
					if not CheckSafezone(Player) and LocalPlayer:DistanceFromCharacter(Player.Character.PrimaryPart.Position) < 12000 and Player.Character.PrimaryPart.CFrame.Y > 0 then
						table.insert(BlacklistedPlayers, Player.Name)
						return Player
					end
				end
			end
		end
	end
end

local function GetPlayerBoat()
	for _, boat in workspace.Boats:GetChildren() do
		if boat:IsA("Model") then
			local Owner = boat:FindFirstChild("Owner")
			local HD = boat:FindFirstChild("Humanoid")
			if Owner and HD and tostring(Owner.Value) == LocalPlayer.Name and HD.Value > 0 then
				return boat
			end
		end
	end
end

local function SendKey(key, hold)
	VirtualInputManager:SendKeyEvent(true, key, false, game)
	task.wait(hold)
	VirtualInputManager:SendKeyEvent(false, key, false, game)
end

local function GetSeabeast()
	for _, sb in workspace.SeaBeasts:GetChildren() do
		if sb.Health.Value > 30000 then
			return sb
		end
	end
end

task.spawn(function()
	while true do
		GetServers()
		task.wait(180)
	end
end)

Hop = function(k, W)
	local check_isvalid = false
	local h = GetServers()
	local X = {}
	for w, D in h do
		table.insert(X, { JobId = w, Players = D.Count, LastUpdate = D.__LastUpdate, Region = D.Region, })
	end
	for _ = 1, #X do
		while task.wait() do
			local h = math.random(1, #X)
			ServerData = X[h]
			if ServerData then
				if not k or ServerData.Players < k then
					if not W or ServerData.Region == W then
						break
					else
						check_isvalid = true
					end
				end
			end
		end
	end
	if not check_isvalid then
		ReplicatedStorage:WaitForChild("__ServerBrowser"):InvokeServer("teleport", ServerData.JobId)
	else
		local servers = {}
		local ok, req = pcall(function()
			return game:HttpGet( "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true" )
		end)
		if not ok or not req then
			return
		end
		local ok2, body = pcall(function()
			return HttpService:JSONDecode(req)
		end)
		if not ok2 or not body or not body.data then
			return
		end
		for _, v in body.data do
			if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < 2 and v.id ~= game.JobId then
				table.insert(servers, 1, v.id)
			end
		end
		if #servers > 0 then
			ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", servers[math.random(1, #servers)])
		end
	end
end

local BringMob = function(v, s)
	if not Character or not Character.PrimaryPart then
		return
	end
	local targets = {}
	for _, x in workspace.Enemies:GetChildren() do
		local h = x:FindFirstChildOfClass("Humanoid")
		if x.PrimaryPart and h and h.Health > 0 and (not v or x.Name == v) and LocalPlayer:DistanceFromCharacter(x.PrimaryPart.Position) <= 180 then
			targets[#targets + 1] = x
			if #targets == 3 then
				break
			end
		end
	end
	if #targets == 0 then
		return
	end
	local t = targets[1].PrimaryPart.CFrame
	for _, x in targets do
		if isnetworkowner(x.PrimaryPart) then
			x.PrimaryPart.CFrame = t
		end
	end
end

local function WaitUntilNoBusy()
	pcall(function()
		task.wait(0.1)
		if Character.Busy.Value then
			repeat
				task.wait(0.1)
			until not Character.Busy.Value
		end
	end)
end

local function AutoSkill()
	for _, v in LocalPlayer.Backpack:GetChildren() do
		if v.ToolTip == "Melee" or v.ToolTip == "Sword" or v.ToolTip == "Blox Fruit" or v.ToolTip == "Gun" then
			Character.Humanoid:EquipTool(v)
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
			WaitUntilNoBusy()
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.X, false, game)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.X, false, game)
			WaitUntilNoBusy()
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.C, false, game)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.C, false, game)
			break
		end
	end
end

local function Seabeast()
	if not CheckSeabeast() and not CheckPirateBoat() then
		if not CheckBoat() then
			if (Vector3.new(-12.7291985, 10.3120461, 2955.1543) - Character.HumanoidRootPart.Position).Magnitude > 8 then
				Tween(CFrame.new(-12.7291985, 10.3120461, 2955.1543), 280).Completed:Wait()
				CommF_:InvokeServer("BuyBoat", "PirateBrigade")
			else
				CommF_:InvokeServer("BuyBoat", "PirateBrigade")
			end
		else
			if (CheckBoat().VehicleSeat.Position - Vector3.new(28.4108, 1.2327, 3679.99)).Magnitude > 50 then
				CheckBoat().VehicleSeat.CFrame = CFrame.new(28.4108 + 20, 1.2327 + 10, 3679.99 + 20)
			else
				if not Character.Humanoid.Sit then
					if (CheckBoat().VehicleSeat.Position - Character.HumanoidRootPart.Position).Magnitude > 50 then
						Tween(CheckBoat().VehicleSeat.CFrame, 280).Completed:Wait()
					else
						Character.HumanoidRootPart.CFrame = CheckBoat().VehicleSeat.CFrame
					end
				end
			end
		end
	elseif CheckPirateBoat() then
		local v = CheckPirateBoat()
		repeat
			task.wait()
			Tween(v.Engine.CFrame * CFrame.new(0, -20, 0), 250).Completed:Wait()
			AutoSkill()
		until not v or not v.Parent or v.Health.Value <= 0 or not CheckPirateBoat()
	elseif CheckSeabeast() then
		local v = CheckSeabeast()
		repeat
			task.wait()
			TeleportSeabeast(v)
			AutoSkill()
		until not v or not v.Parent or v.Health.Value <= 0 or not CheckSeabeast()
	end
end

local function KillMonster(_v)
    LogChange("combat_target", "combat: target " .. string.lower(tostring(_v)))
    SetStatus("combat | target " .. string.lower(tostring(_v)))
	while not (Character and Character:FindFirstChildOfClass("Humanoid")) do
		task.wait()
	end
	if Character.Humanoid.Health > 0 then
		for _, v2 in {workspace.Enemies, ReplicatedStorage} do
			for _, v in v2:GetChildren() do
				if v.Name:find(_v) and v.PrimaryPart and v:FindFirstChildOfClass("Humanoid") then
					repeat
						task.wait()
						if not v or not v.PrimaryPart or not v:FindFirstChildOfClass("Humanoid") or v.Humanoid.Health <= 0 then
							break
						end
						Tween(v.PrimaryPart.Position + Vector3.new(0, 25, 7), 350)
						if LocalPlayer:DistanceFromCharacter(v.PrimaryPart.CFrame.Position) <= 200 then
							Tween(v.PrimaryPart.Position + Vector3.new(0, 25, 7), math.huge)
							if LocalPlayer:DistanceFromCharacter(v.PrimaryPart.CFrame.Position) <= 50 then
								EquipWeapon()
								Attack()
							end
						end
					until not v
						or not v.PrimaryPart
						or not v:FindFirstChildOfClass("Humanoid")
						or v.Humanoid.Health <= 0
						or Character.Humanoid.Health <= 0
						or not Character:FindFirstChild("Humanoid")
					break
				end
			end
		end
	end
end

local lastTakeQuest = 0
local QuestController, GetQuest, GetQuestData, GetQuestPosition

GetQuestPosition = function()
    local nearestPos = nil
    local shortestdist = math.huge
    for _, v in require(ReplicatedStorage.GuideModule).Data.NPCList do
        if typeof(v) == "table" and v.Position then
            for _, x in v do
                if x == GetQuest()["NameQuest"] then
                    local distance = LocalPlayer:DistanceFromCharacter(v.Position)
                    if distance < shortestdist then
                        shortestdist = distance
                        nearestPos = v.Position
                    end
                end
            end
        end
    end
    return nearestPos
end

local function TakeQuest()
	if (tick() - lastTakeQuest) < 0.75 then
		return
	end
	local q = GetQuest()
    if q and q.NameQuest then
        LogChange("quest_target", "quest: " .. string.lower(tostring(q.NameQuest)) .. " / " .. string.lower(tostring(q.NameMonster or "unknown")))
    else
        LogChange("quest_target", "quest: no target")
    end
	if q and q.NameQuest and q.ID and (not GetQuestData() or QuestController.CurrentQuestName ~= q.NameQuest) then
		local questPos = GetQuestPosition()
        LogChange("quest_travel", questPos and "quest: traveling to npc" or "quest: npc position missing")
		if not questPos then
			LogChange("quest_travel", "quest: npc position missing, hopping server")
			Hop()
		end
		if questPos and TweenWithRespawnRetry(questPos, 350) then
			task.wait(0.25)
			if LocalPlayer:DistanceFromCharacter(questPos) <= 15 then
                LogChange("quest_start", "quest: starting " .. string.lower(tostring(q.NameQuest)))
                SetStatus("quest | starting " .. string.lower(tostring(q.NameQuest)))
				CommF_:InvokeServer("StartQuest", q.NameQuest, q.ID)
			end
		end
	end
	lastTakeQuest = tick()
end

local MobsCakePrince = {
	"Cookie Crafter",
	"Cake Guard",
	"Baking Staff",
	"Head Baker",
}
local CakePrinceBosses = {
	"Dough King",
	"Cake Prince",
}
local function GetCakePrince()
	for _, v in {workspace.Enemies, ReplicatedStorage} do
		for _, v2 in v:GetChildren() do
			if table.find(CakePrinceBosses, v2.Name) and v2:FindFirstChild("Humanoid") and v2:FindFirstChild("HumanoidRootPart") and v2.Humanoid.Health > 0 then
				return v2
			end
		end
	end
end

QuestController = {
	CurrentQuest = "",
	CurrentQuestName = "",
	CachedQuestData = require(ReplicatedStorage.Quests),
	QuestConnection = nil,
}
QuestController.Set = function(self, data)
	self.CurrentQuest = (function()
		for i, _ in data.Progress do
			return i
		end
	end)()
	self.CurrentQuestName = data.InternalQuestName
end
QuestController.Reset = function(self)
	self.CurrentQuest = ""
	self.CurrentQuestName = ""
end

QuestController.QuestConnection = ReplicatedStorage.Remotes.QuestUpdate.OnClientEvent:Connect(function(a2, a3)
	if a2 and typeof(a2) == "table" then
		QuestController:Set(a2)
		return
	end
	QuestController:Reset()
end)

GetQuestData = function()
	return QuestController.CurrentQuest ~= ""
end

local function GetLastQuest()
	local data = require(ReplicatedStorage.GuideModule).Data
	if data and data.QuestData and data.QuestData.Task then
		for i, _ in data.QuestData.Task do
			return i
		end
	end
end

local function GetBestQuest()
	local bestLevelReq = -1
	local bestRnq, bestTaskName, bestRidq = nil, nil, nil
	for rnq, v in QuestController.CachedQuestData do
		if table.find({ "BartiloQuest", "Trainees", "MarineQuest", "CitizenQuest", }, tostring(rnq)) then
			continue
		end
		for ridq, ct in v do
			if ct.LevelReq < 0 or LocalPlayer.Data.Level.Value < ct.LevelReq then
				continue
			end
			for O, taskValue in ct.Task do
				if taskValue > 1 and ct.LevelReq > bestLevelReq then
					bestLevelReq = ct.LevelReq
					bestRnq = rnq
					bestTaskName = tostring(O)
					bestRidq = ridq
				end
			end
		end
	end
	if not bestRnq then
		return
	end
	return bestLevelReq, bestRnq, bestTaskName, bestRidq
end

GetQuest = function()
	local Level = LocalPlayer.Data.Level.Value
	local msn, nq, idq
	local min = 0
	if Level >= 275 and Level < 300 then
		nq, msn, idq = "ColosseumQuest", "Togga Warrior", 1
	elseif Level >= 1450 and World.Sea2() then
		nq, msn, idq = "ForgottenQuest", "Water Fighter", 2
	elseif Level >= 700 and World.Sea1() then
		nq, msn, idq = "FountainQuest", "Galley Captain", 2
	else
		min, nq, msn, idq = GetBestQuest()
	end
	local q = {}
	if Level >= 10 and not GetQuestData() and GetLastQuest() == msn then
		for rnq, v in QuestController.CachedQuestData do
			for _, N in v do
				for x, _ in N.Task do
					if tostring(x) == msn then
						for iq, v2 in v do
							for n, ct in v2.Task do
								if n ~= msn and ct > 1 then
									q.NameMonster = v2.LevelReq <= Level and tostring(n) or msn
									q.NameQuest = v2.LevelReq <= Level and rnq or nq
									q.ID = v2.LevelReq <= Level and iq or idq
									return q
								end
							end
						end
					end
				end
			end
		end
	end
	q.NameMonster = msn
	q.NameQuest = nq
	q.ID = idq
	return q
end

local function TakeQuestCake(b)
	if not GetQuestData() then
        LogChange("cake_quest", "quest: cake " .. string.lower(tostring(b)))
		local r = require(ReplicatedStorage.Quests)
		local t = {
			r.CakeQuest1,
			r.CakeQuest2,
		}
		local qn, id, lvrq
		for c, v in t do
			if typeof(v) == "table" then
				for i, v2 in v do
					if v2.Name == b then
						id = i
						qn = "CakeQuest" .. c
						lvrq = v2.LevelReq
					end
				end
			end
		end
		local p
		for _, v in require(ReplicatedStorage.GuideModule).Data.NPCList do
			if typeof(v) == "table" then
				for _, x in v do
					if x == qn then
						if LocalPlayer.Data.Level.Value >= lvrq then
							p = v.Position
						else
							return
						end
					end
				end
			end
		end

		if p and TweenWithRespawnRetry(p, 350) and LocalPlayer:DistanceFromCharacter(p) < 5 then
			task.wait(1)
			CommF_:InvokeServer("StartQuest", tostring(qn), id)
			task.wait(0.5)
		end
	end
end

local function TakeQuestBone(b)
	if not GetQuestData() then
        LogChange("bone_quest", "quest: bones " .. string.lower(tostring(b)))
		local r = require(ReplicatedStorage.Quests)
		local t = { r.HauntedQuest1, r.HauntedQuest2 }
		local qn, id, lvrq
		for c, v in t do
			if typeof(v) == "table" then
				for i, v2 in v do
					if v2.Name == b then
						id = i
						qn = "HauntedQuest" .. c
						lvrq = v2.LevelReq
					end
				end
			end
		end
		local p
		for _, v in require(ReplicatedStorage.GuideModule).Data.NPCList do
			if typeof(v) == "table" then
				for _, x in v do
					if x == qn then
						if LocalPlayer.Data.Level.Value >= lvrq then
							p = v.Position
						else
							return
						end
					end
				end
			end
		end

		if p and TweenWithRespawnRetry(p, 350) and LocalPlayer:DistanceFromCharacter(p) < 5 then
			task.wait(1)
			CommF_:InvokeServer("StartQuest", tostring(qn), id)
			task.wait(0.5)
		end
	end
end

local function GetMonsterName()
	local _v = {}
	for _, v in workspace.Enemies:GetChildren() do
		if not table.find(_v, v.Name) and v:IsA("Model") and v.Name ~= "PirateBasic" and not v.Name:find("Brigade") and not v.Name:find("FishBoat") and v:FindFirstChildOfClass("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
			table.insert(_v, v.Name)
		end
	end
	for _, v in _v do
		local name = v:gsub(" %pLv%. ?%d+%p", "")
		if QuestController.CurrentQuest == name then
			return name
		end
	end
	return false
end

local function LoadItem(v, t)
	CommF_:InvokeServer("LoadItem", v, { t, })
end

local function GetMaterial(name)
	local data = IRS:GetItems(KEYS.QUANTITY)
	for _, v in data do
		local item = MATCH(v.ItemId)._ok
		if item.Display.Category == "Material" and item.Index.StorageKey == name then
			return v.Value
		end
	end
	return 0
end

local function BringSG(v)
	while not (Character and Character.PrimaryPart) do
		task.wait()
	end
	local targets = {}
	for _, x in workspace.Enemies:GetChildren() do
		if x:FindFirstChild("HumanoidRootPart") and x:FindFirstChild("Humanoid") and x.Humanoid.Health > 0 and (not v or x.Name == v) and (p.Position - x.HumanoidRootPart.Position).Magnitude <= math.huge then
			targets[#targets + 1] = x
			if #targets == 6 then
				break
			end
		end
	end
	if #targets == 0 then
		return
	end
	local t = targets[1].HumanoidRootPart.CFrame
	for _, x in targets do
		sethiddenproperty(x.HumanoidRootPart, "NetworkOwnershipRule", Enum.NetworkOwnership.Manual)
		x.HumanoidRootPart.CFrame = t
	end
end

local function GetSG()
    LogChange("soul_guitar", "soul guitar: checking puzzle")
	local check = CommF_:InvokeServer("GuitarPuzzleProgress", "Check")
	if not check then
		if Lighting.Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" and (Lighting.ClockTime > 16 or Lighting.ClockTime < 5) then
            LogChange("soul_guitar_stage", "soul guitar: doing gravestone ritual")
            SetStatus("soul guitar | doing gravestone ritual")
			if LocalPlayer:DistanceFromCharacter(Vector3.new(-8654, 140, 6167)) > 50 then
				Tween(CFrame.new(-8654, 140, 6167), 350).Completed:Wait()
			end
			CommF_:InvokeServer("gravestoneEvent", 2)
			CommF_:InvokeServer("gravestoneEvent", 2, true)
        else
            LogChange("soul_guitar_stage", "soul guitar: waiting for full moon")
            SetStatus("soul guitar | waiting for full moon")
		end
	elseif check.Swamp == false then
        LogChange("soul_guitar_stage", "soul guitar: clearing swamp")
        SetStatus("soul guitar | clearing swamp")
		if (function() local b = 0 for _, v in workspace.Enemies:GetChildren() do if v.Name == "Living Zombie" and v.Humanoid and v.Humanoid.Health > 0 then
						b = b + 1
					end
				end
				return b
			end)() == 6
		then
			repeat
				for _, v in workspace.Enemies:GetChildren() do
					if v.Name == "Living Zombie" and v.Humanoid and v.Humanoid.Health > 0 then
						repeat
							task.wait()
							if not v or not v.PrimaryPart or not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0 then
								break
							end
							Tween(v.PrimaryPart.CFrame * CFrame.new(0, 15, 10), 350)
							if LocalPlayer:DistanceFromCharacter(v.PrimaryPart.CFrame.Position) <= 220 then
								Tween(v.PrimaryPart.CFrame * CFrame.new(0, 15, 10), math.huge)
								if LocalPlayer:DistanceFromCharacter(v.PrimaryPart.CFrame.Position) <= 40 then
									BringSG(v.Name)
									EquipWeapon()
									Attack()
								end
							end
						until not v or not v.PrimaryPart or not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0
					end
				end
			until CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Swamp
				or (function()
						local b = 0
						for _, v in workspace.Enemies:GetChildren() do
							if v.Name == "Living Zombie" and v.PrimaryPart and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								b = b + 1
							end
						end
						return b
					end)()
					== 0
		end
	elseif check.Gravestones == false then
        LogChange("soul_guitar_stage", "soul guitar: solving gravestones")
        SetStatus("soul guitar | solving gravestones")
		CommF_:InvokeServer("GuitarPuzzleProgress", "Gravestones")
	elseif check.Ghost == false then
        LogChange("soul_guitar_stage", "soul guitar: completing ghost challenge")
        SetStatus("soul guitar | completing ghost challenge")
		CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost")
	elseif check.Trophies == false then
        LogChange("soul_guitar_stage", "soul guitar: completing trophy challenge")
        SetStatus("soul guitar | completing trophy challenge")
		CommF_:InvokeServer("GuitarPuzzleProgress", "Trophies")
	elseif check.Pipes == false then
        LogChange("soul_guitar_stage", "soul guitar: solving pipes")
        SetStatus("soul guitar | solving pipes")
		CommF_:InvokeServer("GuitarPuzzleProgress", "Pipes")
	elseif check.CraftedOnce == false then
		if LocalPlayer.Data.Fragments.Value >= 5000 and GetMaterial("Bones") >= 500 and GetMaterial("Ectoplasm") >= 250 then
            LogChange("soul_guitar_stage", "soul guitar: crafting")
            SetStatus("soul guitar | crafting")
			CommF_:InvokeServer("soulGuitarBuy")
        else
            LogChange("soul_guitar_stage", "soul guitar: collecting materials")
            SetStatus("soul guitar | collecting materials")
            LogChange("soul_guitar_materials", "soul guitar: fragments " .. tostring(LocalPlayer.Data.Fragments.Value) .. "/5000, bones " .. tostring(GetMaterial("Bones")) .. "/500, ectoplasm " .. tostring(GetMaterial("Ectoplasm")) .. "/250")
		end
	end
end

local CheckMonster

local function UnlockSecondSea()
    LogChange("sea_unlock", "sea: unlocking second sea")
	local travel = CommF_:InvokeServer("TravelDressrosa")
	if travel:find("Cannot") then
		local data = CommF_:InvokeServer("DressrosaQuestProgress")
		if not data.UsedKey then
			if not data.TalkedDetective then
                LogChange("sea2_stage", "sea 2: talking to detective")
                SetStatus("sea 2 | talking to detective")
				CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
			elseif LocalPlayer.Backpack:FindFirstChild("Key") then
				Character.Humanoid:EquipTool(LocalPlayer.Backpack["Key"])
			end
			CommF_:InvokeServer("DressrosaQuestProgress", "UseKey")
		elseif not data.KilledIceBoss then
            LogChange("sea2_stage", "sea 2: defeating ice admiral")
            SetStatus("sea 2 | defeating ice admiral")
			if CheckMonster("Ice Admiral") then
				KillMonster("Ice Admiral")
			else
				Tween(CFrame.new(1328, 43, -1346), 300)
			end
		else
			CommF_:InvokeServer("TravelDressrosa")
		end
	end
end

local function GetFruitValue(_v)
	local data = IRS:GetItems(KEYS.QUANTITY)
	for _, v in data do
		local item = MATCH(v.ItemId)._ok
		if item.Display.Category == "Blox Fruit" and item.Quality.MoneyPrice >= _v then
			return item.Index.StorageKey
		end
	end
	return nil
end

local function GetFruitId(g)
	local ok = string.match(g, "((%u)[^%-]+)$")
	return ok .. "Fruit"
end

local zQuestProRemote = ReplicatedStorage.Remotes:FindFirstChild("RefreshZQuestPro")
if World.Sea2() and zQuestProRemote then
	local zQuestProConnection = zQuestProRemote.OnClientEvent:Connect(function(a)
		if a == "promptDialogue" then
			-- print("cutscene finished")
			HopLowServer()
		end
	end)
end

local GetFruits

local function UnlockThirdSea()
    LogChange("sea_unlock", "sea: unlocking third sea")
	local check = CommF_:InvokeServer("ZQuestProgress", "Check")
	if CommF_:InvokeServer("GetUnlockables").FlamingoAccess then
		-- print("check: " .. tostring(check))
		if check == 0 then
            LogChange("sea3_stage", "sea 3: starting rip indra quest")
            SetStatus("sea 3 | starting rip indra quest")
			CommF_:InvokeServer("TravelZou")
			if LocalPlayer:DistanceFromCharacter(Vector3.new(0, 0, 0)) < 20000 then
				CommF_:InvokeServer("ZQuestProgress", "Begin")
			end
			if CheckMonster("rip_indra") then
				KillMonster("rip_indra")
			else
				LocalPlayer:Kick("Rejoin to fix blox kid")
			end
		elseif check == 1 then
            LogChange("sea3_stage", "sea 3: continuing quest")
            SetStatus("sea 3 | continuing quest")
			CommF_:InvokeServer("TravelZou")
		else
			if CheckMonster("Don Swan") then
                LogChange("sea3_stage", "sea 3: defeating don swan")
                SetStatus("sea 3 | defeating don swan")
				KillMonster("Don Swan")
				SWAN_KILLED = true
				CommF_:InvokeServer("ZQuestProgress", "Begin")
			else
				if LocalPlayer:DistanceFromCharacter(Vector3.new(2288, 15, 863)) > 15 then
					Tween(CFrame.new(2288, 15, 863), 350).Completed:Wait()
					return true
				end
			end
		end
	else
        LogChange("sea3_stage", "sea 3: unlocking flamingo access")
        SetStatus("sea 3 | unlocking flamingo access")
		local talk = CommF_:InvokeServer("TalkTrevor", "1")
		if talk then
			if talk == 1 or talk ~= 2 then
				local df = GetFruitValue(1000000)
				if df then
					if talk == 1 then
						CommF_:InvokeServer("TalkTrevor", "2")
						task.wait(0.75)
					end
					PAUSE_AUTO_STORE = true
					CommF_:InvokeServer("LoadFruit", df)
					EquipTool(GetFruitId(df))
					CommF_:InvokeServer("TalkTrevor", "1")
					CommF_:InvokeServer("TalkTrevor", "2")
					CommF_:InvokeServer("TalkTrevor", "3")
					PAUSE_AUTO_STORE = false
				else
					local df = GetFruits()
					if df then
						pcall(function()
							Tween(df:GetPivot(), 350).Completed:Wait()
						end)
					end
					hop()
					task.wait(5)
				end
			end
		end
	end
end

GetFruits = function()
	for _, v in workspace:GetChildren() do
		if string.find(v.Name, "Fruit") and (v:IsA("Tool") or v:IsA("Model")) and (v.Name ~= "Fruit ") then
			return v
		end
	end
	return nil
end

local function GetCastleRaid()
	for _, v in {workspace.Enemies, ReplicatedStorage} do
		for _, v2 in v:GetChildren() do
			if v2:GetAttribute("Level") and v2:GetAttribute("Level") <= 1500 and v2:IsA("Model") and (v2:GetPivot().Position - Vector3.new(-5000, 350, -3035)).Magnitude <= 1000 then
				return true
			end
		end
	end
	return nil
end

task.spawn(function()
	while true do
		if not PAUSE_AUTO_STORE then
			pcall(function()
				local gg = {}
				for _, _v in {LocalPlayer.Backpack, LocalPlayer.Character} do
					if _v then
						for _, v in _v:GetChildren() do
							if v.Name:find("Fruit") and v:IsA("Tool") then
								local ori = v:GetAttribute("OriginalName") or v.Name
								if not CheckItem(v.Name) and not CheckItem(ori) then
									table.insert(gg, { tool = v, ori = ori, })
								end
							end
						end
					end
				end
				if #gg > 0 then
					local sf = {}
					local inv = CommF_:InvokeServer("getInventoryFruits")
					if type(inv) == "table" then
						for _, _v in inv do
							if type(_v) == "table" and _v.Name then
								sf[_v.Name] = true
							end
						end
					end
					for _, v in gg do
						if not sf[v.ori] then
							CommF_:InvokeServer("StoreFruit", v.ori, v.tool)
							sf[v.ori] = true
						end
					end
				end
			end)
		end
		CommF_:InvokeServer("Cousin", "DLCBoxData")
		task.wait(1)
	end
end)

local materialMon, materialPos
local function GetMaterialMon(material)
	if not Character or not Character.PrimaryPart then
		return
	end
	if World.Sea1() then
		if material == "Angel Wings" then
			materialMon = {
				"Shanda",
				"Royal Squad",
				"Royal Soldier",
				"Wysper",
				"Thunder God",
			}
			materialPos = CFrame.new(-4698, 845, -1912)
		elseif material == "Leather + Scrap Metal" then
			materialMon = {
				"Brute",
				"Pirate",
			}
			materialPos = CFrame.new(-1145, 15, 4350)
		elseif material == "Magma Ore" then
			materialMon = {
				"Military Soldier",
				"Military Spy",
				"Magma Admiral",
			}
			materialPos = CFrame.new(-5815, 84, 8820)
		elseif material == "Fish Tail" then
			materialMon = {
				"Fishman Warrior",
				"Fishman Commando",
				"Fishman Lord",
			}
			materialPos = CFrame.new(61123, 19, 1569)
		end
	elseif World.Sea2() then
		if material == "Leather + Scrap Metal" then
			materialMon = {
				"Marine Captain",
			}
			materialPos = CFrame.new(-2010.5059814453125, 73.00115966796875, -3326.620849609375)
		elseif material == "Magma Ore" then
			materialMon = {
				"Magma Ninja",
				"Lava Pirate",
			}
			materialPos = CFrame.new(-5428, 78, -5959)
		elseif material == "Ectoplasm" then
			materialMon = {
				"Ship Deckhand",
				"Ship Engineer",
				"Ship Steward",
				"Ship Officer",
			}
			materialPos = CFrame.new(911.35827636719, 125.95812988281, 33159.5390625)
		elseif material == "Mystic Droplet" then
			materialMon = {
				"Water Fighter",
			}
			materialPos = CFrame.new(-3385, 239, -10542)
		elseif material == "Radioactive Material" then
			materialMon = {
				"Factory Staff",
			}
			materialPos = CFrame.new(295, 73, -56)
		elseif material == "Vampire Fang" then
			materialMon = {
				"Vampire",
			}
			materialPos = CFrame.new(-6033, 7, -1317)
		end
	elseif World.Sea3() then
		if material == "Leather + Scrap Metal" then
			materialMon = {
				"Jungle Pirate",
				"Forest Pirate",
			}
			materialPos = CFrame.new(-11975.78515625, 331.7734069824219, -10620.0302734375)
		elseif material == "Fish Tail" then
			materialMon = {
				"Fishman Raider",
				"Fishman Captain",
			}
			materialPos = CFrame.new(-10993, 332, -8940)
		elseif material == "Conjured Cocoa" then
			materialMon = {
				"Chocolate Bar Battler",
				"Cocoa Warrior",
			}
			materialPos = CFrame.new(620, 78, -12581.369140625)
		elseif material == "Dragon Scale" then
			materialMon = {
				"Dragon Crew Warrior",
				"Dragon Crew Archer"
			}
			materialPos = CFrame.new(6594, 383, 139)
		elseif material == "Gunpowder" then
			materialMon = {
				"Pistol Billionaire",
			}
			materialPos = CFrame.new(-469, 74, 5904)
		elseif material == "Mini Tusk" then
			materialMon = {
				"Mythological Pirate",
			}
			materialPos = CFrame.new(-13545, 470, -6917)
		end
	end
end

local function FarmMaterial(material)
    LogChange("material", "material: farming " .. string.lower(tostring(material)))
	GetMaterialMon(material)
	local mob = nil
	local min = math.huge
	for _, v in workspace.Enemies:GetChildren() do
		if v.PrimaryPart and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and table.find(materialMon, v.Name) then
			local dist = LocalPlayer:DistanceFromCharacter(v.PrimaryPart.Position)
			if dist < min then
				min = dist
				mob = v
			end
		end
	end
	if mob and mob.PrimaryPart and mob.Humanoid and mob.Humanoid.Health > 0 then
        LogChange("material_target", "material: target found for " .. string.lower(tostring(material)))
        SetStatus("material | fighting for " .. string.lower(tostring(material)))
		repeat
			task.wait()
			EquipWeapon()
			Tween(mob.PrimaryPart.CFrame * CFrame.new(0, 20, 10), 350)
			if LocalPlayer:DistanceFromCharacter(mob.PrimaryPart.CFrame.Position) <= 200 then
				Tween(mob.PrimaryPart.CFrame * CFrame.new(0, 20, 10), math.huge)
				if LocalPlayer:DistanceFromCharacter(mob.PrimaryPart.CFrame.Position) <= 45 then
					BringMob(mob.Name)
					Attack()
				end
			end
		until not mob or not mob.PrimaryPart or not mob:FindFirstChild("Humanoid") or mob.Humanoid.Health <= 0
	else
        LogChange("material_target", "material: waiting for " .. string.lower(tostring(material)) .. " spawn")
        SetStatus("material | waiting for " .. string.lower(tostring(material)) .. " spawn")
		Tween(materialPos, 350).Completed:Wait()
	end
end

local function GetRaceGrade()
	local race = LocalPlayer.Data.Race
	if LocalPlayer.Backpack:FindFirstChild("Awakening") or Character:FindFirstChild("Awakening") then
		return "V4"
	elseif LocalPlayer.Backpack:FindFirstChild("Last Resort") or Character:FindFirstChild("Last Resort") or LocalPlayer.Backpack:FindFirstChild("Agility") or LocalPlayer.Character:FindFirstChild("Agility") or LocalPlayer.Backpack:FindFirstChild("Water Body") or Character:FindFirstChild("Water Body") or LocalPlayer.Backpack:FindFirstChild("Heavenly Blood") or Character:FindFirstChild("Heavenly Blood") or LocalPlayer.Backpack:FindFirstChild("Heightened Senses") or Character:FindFirstChild("Heightened Senses") or LocalPlayer.Backpack:FindFirstChild("Energy Core") or Character:FindFirstChild("Energy Core") or LocalPlayer.Backpack:FindFirstChild("Primordial Reign") or Character:FindFirstChild("Primordial Reign") then
		return "V3"
	elseif race:FindFirstChild("Evolved") then
		return "V2"
	else
		return "V1"
	end
end

BindedMeleeNPCNames = {}
local function MeleeNPCPosition(a, b, c)
	for i, v in {a, b, c} do
		if v and World["Sea" .. i]() then
			return v
		end
	end
	return nil
end

BindedMeleeNPCNames.BlackLeg =
	MeleeNPCPosition(Vector3.new(-985, 14, 3988), Vector3.new(-4754, 35, -4849), Vector3.new(-5045, 372, -3178))
BindedMeleeNPCNames.Electro =
	MeleeNPCPosition(Vector3.new(-5384, 14, -2149), Vector3.new(-4864, 35, -4765), Vector3.new(-4994, 315, -3201))
BindedMeleeNPCNames.FishmanKarate =
	MeleeNPCPosition(Vector3.new(61585, 19, 987), Vector3.new(-4957, 35, -4668), Vector3.new(-5022, 372, -3187))

BindedMeleeNPCNames.SharkmanKarate =
	MeleeNPCPosition(nil, Vector3.new(-2602, 239, -10317), Vector3.new(-4974, 315, -3221))
BindedMeleeNPCNames.DeathStep = MeleeNPCPosition(nil, Vector3.new(6356, 296, -6763), Vector3.new(-4997, 315, -3220))
BindedMeleeNPCNames.Superhuman = MeleeNPCPosition(nil, Vector3.new(1379, 247, -5190), Vector3.new(-5004, 372, -3194))
BindedMeleeNPCNames.DragonClaw = MeleeNPCPosition(nil, Vector3.new(702, 187, 653), Vector3.new(-4980, 372, -3205))

BindedMeleeNPCNames.ElectricClaw = MeleeNPCPosition(nil, nil, Vector3.new(-10371, 331, -10131))
BindedMeleeNPCNames.DragonTalon = MeleeNPCPosition(nil, nil, Vector3.new(5661, 1210, 863))
BindedMeleeNPCNames.Godhuman = MeleeNPCPosition(nil, nil, Vector3.new(-13774, 333, -9879))

local function TweenToMeleeBuyer(name)
	local p = BindedMeleeNPCNames[name]
	if p then
		return TweenWithRespawnRetry(p, 300)
	end
	return false
end
local function GetMastery(name)
	local melee = {
		"DeathStep",
		"Superhuman",
		"ElectricClaw",
		"DragonTalon",
		"SharkmanKarate",
		"BlackLeg",
		"Electro",
		"FishmanKarate",
		"SanguineArt",
		"DragonClaw",
	}
	if table.find(melee, name) then
		return MeleeData[name] or 0
	elseif CheckItem(name) then
		LoadItem(name)
		task.wait(1)
		local tool = LocalPlayer.Backpack:FindFirstChild(name)
		if tool then
			return tool.Level.Value
		end
	end
	return 0
end

local function DoRaceV2()
    LogChange("race_mode", "race v2: checking progress")
	if not World.Sea2() then
        LogChange("race_v2_travel", "race v2: traveling to sea 2")
        SetStatus("race v2 | traveling to sea 2")
		while true do
			CommF_:InvokeServer("TravelDressrosa")
			task.wait(5)
		end
	end
	if not LocalPlayer.Data.Race:FindFirstChild("Evolved") then
		local check = CommF_:InvokeServer("Alchemist", "1")
		if check == 0 then
            LogChange("race_v2_stage", "race v2: talking to alchemist")
            SetStatus("race v2 | talking to alchemist")
			CommF_:InvokeServer("Alchemist", "2")
		elseif check == 1 then
            if LocalPlayer.Backpack:FindFirstChild("Flower 1") or Character:FindFirstChild("Flower 1") then
                LogChange("race_v2_flower1", "race v2: flower 1 collected")
            end
            if LocalPlayer.Backpack:FindFirstChild("Flower 2") or Character:FindFirstChild("Flower 2") then
                LogChange("race_v2_flower2", "race v2: flower 2 collected")
            end
            if LocalPlayer.Backpack:FindFirstChild("Flower 3") or Character:FindFirstChild("Flower 3") then
                LogChange("race_v2_flower3", "race v2: flower 3 collected")
            end
			if not LocalPlayer.Backpack:FindFirstChild("Flower 1") and not Character:FindFirstChild("Flower 1") then
                LogChange("race_v2_stage", "race v2: collecting flower 1")
                SetStatus("race v2 | collecting flower 1")
				Tween(workspace.Flower1.CFrame, 350)
				firetouchinterest(workspace.Flower1, Character.HumanoidRootPart, 1)
				firetouchinterest(workspace.Flower1, Character.HumanoidRootPart, 0)
                LogChange("race_v2_flower1", "race v2: flower 1 collected")
			elseif not LocalPlayer.Backpack:FindFirstChild("Flower 2") and not Character:FindFirstChild("Flower 2") then
                LogChange("race_v2_stage", "race v2: collecting flower 2")
                SetStatus("race v2 | collecting flower 2")
				Tween(workspace.Flower2.CFrame, 350)
				firetouchinterest(workspace.Flower2, Character.HumanoidRootPart, 1)
				firetouchinterest(workspace.Flower2, Character.HumanoidRootPart, 0)
                LogChange("race_v2_flower2", "race v2: flower 2 collected")
			elseif not LocalPlayer.Backpack:FindFirstChild("Flower 3") and not Character:FindFirstChild("Flower 3") then
				if workspace.Enemies:FindFirstChild("Zombie") then
                    LogChange("race_v2_stage", "race v2: farming zombie for flower 3")
                    SetStatus("race v2 | farming zombie for flower 3")
					for _, v in workspace.Enemies:GetChildren() do
						if v.Name == "Zombie" then
							repeat
								task.wait()
								if not v or not v.PrimaryPart or not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0 then
									break
								end
								Tween(v.PrimaryPart.CFrame * CFrame.new(0, 15, 10), 350)
								if LocalPlayer:DistanceFromCharacter(v.PrimaryPart.Position) <= 200 then
									Tween(v.PrimaryPart.CFrame * CFrame.new(0, 15, 10), math.huge)
									EquipWeapon()
									BringMob(v.Name)
									Attack()
								end
							until LocalPlayer.Backpack:FindFirstChild("Flower 3")
								or not v
								or not v.PrimaryPart
								or not v:FindFirstChild("Humanoid")
								or v.Humanoid.Health <= 0
						end
					end
				else
                    LogChange("race_v2_stage", "race v2: waiting for zombie spawn")
                    SetStatus("race v2 | waiting for zombie spawn")
					Tween(CFrame.new(-5685, 48, -853), 350).Completed:Wait()
				end
			end
		elseif check == 2 then
            LogChange("race_v2_stage", "race v2: submitting flowers")
            SetStatus("race v2 | submitting flowers")
			CommF_:InvokeServer("Alchemist", "3")
		end
    else
        LogChange("race_v2_stage", "race v2: already evolved")
        SetStatus("race v2 | already evolved")
	end
end

CheckMonster = function(name)
	return workspace.Enemies:FindFirstChild(name) or ReplicatedStorage:FindFirstChild(name)
end

MinkQuestStage = 0
HumanQuestStage = 0
local function DoRaceV3()
    LogChange("race_mode", "race v3: checking progress")
	if not World.Sea2() then
        LogChange("race_v3_travel", "race v3: traveling to sea 2")
        SetStatus("race v3 | traveling to sea 2")
		while true do
			CommF_:InvokeServer("TravelDressrosa")
			task.wait(5)
		end
	end
	local race = LocalPlayer.Data.Race.Value
	local check = CommF_:InvokeServer("Wenlocktoad", "1")
	if check == 0 then
        LogChange("race_v3_stage", "race v3: starting quest")
        SetStatus("race v3 | starting quest")
		CommF_:InvokeServer("Wenlocktoad", "2")
	elseif check == 1 then
		if race == "Human" then
			if HumanQuestStage == 0 then
                LogChange("race_v3_stage", "race v3: fighting jeremy")
                SetStatus("race v3 | fighting jeremy")
				if CheckMonster("Jeremy") then
					KillMonster("Jeremy")
					HumanQuestStage = 1
				else
					Tween(CFrame.new(2333.209228515625, 449.2427062988281, 699.5128784179688), 300).Completed:Wait()
				end
			elseif HumanQuestStage == 1 then
                LogChange("race_v3_stage", "race v3: fighting diamond")
                SetStatus("race v3 | fighting diamond")
				if CheckMonster("Diamond") then
					KillMonster("Diamond")
					HumanQuestStage = 2
				else
					Tween(CFrame.new(-1713.5589599609375, 198.99554443359375, -104.31584167480469), 300).Completed:Wait()
				end
			elseif HumanQuestStage == 2 then
                LogChange("race_v3_stage", "race v3: fighting orbitus")
                SetStatus("race v3 | fighting orbitus")
				if CheckMonster("Orbitus") then
					KillMonster("Orbitus")
					HumanQuestStage = 3
				else
					Tween(CFrame.new(-2148.7568359375, 73.27831268310547, -4304.4130859375), 300).Completed:Wait()
				end
			elseif HumanQuestStage == 3 then
                LogChange("race_v3_stage", "race v3: completing human trial")
                SetStatus("race v3 | completing human trial")
				CommF_:InvokeServer("Wenlocktoad", "3")
			end
		elseif race == "Rabbit" then
			for _, v in workspace.ChestModels:GetChildren() do
				if MinkQuestStage < 30 then
                    LogChange("race_v3_chests", "race v3: collecting chest " .. tostring(MinkQuestStage + 1) .. "/30")
                    SetStatus("race v3 | collecting chest " .. tostring(MinkQuestStage + 1) .. "/30")
					Tween(v.WorldPivot.Position, 350).Completed:Wait()
					MinkQuestStage = MinkQuestStage + 1
				elseif MinkQuestStage >= 30 then
                    LogChange("race_v3_stage", "race v3: completing rabbit trial")
                    SetStatus("race v3 | completing rabbit trial")
					CommF_:InvokeServer("Wenlocktoad", "3")
				end
			end
		elseif race == "Fishman" then
            LogChange("race_v3_stage", "race v3: farming sea beasts")
            SetStatus("race v3 | farming sea beasts")
			repeat
				Seabeast()
				task.wait(1)
				CommF_:InvokeServer("Wenlocktoad", "3")
			until GetRaceGrade() == "V3" or not string.find(race, "Fish")
		end
	elseif check == 2 then
        LogChange("race_v3_stage", "race v3: completing trial")
        SetStatus("race v3 | completing trial")
		CommF_:InvokeServer("Wenlocktoad", "3")
    else
        LogChange("race_v3_stage", "race v3: waiting for trial")
        SetStatus("race v3 | waiting for trial")
	end
end

local Travel = {
	Sea1 = function()
		if not World.Sea1() then
			while true do
				CommF_:InvokeServer("TravelMain")
				task.wait(10)
			end
		end
	end,
	Sea2 = function()
		if not World.Sea2() then
			while true do
				CommF_:InvokeServer("TravelDressrosa")
				task.wait(10)
			end
		end
	end,
	Sea3 = function()
		if not World.Sea3() then
			while true do
				CommF_:InvokeServer("TravelZou")
				task.wait(10)
			end
		end
	end
}

local function GetGodHuman()
    LogChange("godhuman", "godhuman: checking requirements")
	local check = CommF_:InvokeServer("BuyGodhuman", true)
	if check ~= 0 and check ~= 1 then
		for i, v in {"Dragon Scale", "Fish Tail", "Mystic Droplet", "Magma Ore"} do
			local max = 0
			if (i % 2) > 0 then
				max = 10
			else
				max = 20
			end
			if GetMaterial(v) < max then
                LogChange("godhuman_material", "godhuman: " .. string.lower(v) .. " " .. tostring(GetMaterial(v)) .. "/" .. tostring(max))
				if (i == 1 or i == 2) and not World.Sea3() then
					Travel.Sea3()
				elseif (i == 3 or i == 4) and not World.Sea2() then
					Travel.Sea2()
				end
				repeat
					FarmMaterial(v)
					task.wait(0.2)
				until GetMaterial(v) >= max
			end
		end
        LogChange("godhuman_stage", "godhuman: traveling to buyer")
        SetStatus("godhuman | traveling to buyer")
		Travel.Sea3()
		TweenToMeleeBuyer("Godhuman")
        LogChange("godhuman_stage", "godhuman: purchasing style")
        SetStatus("godhuman | purchasing style")
		CommF_:InvokeServer("BuyGodhuman", true)
		CommF_:InvokeServer("BuyGodhuman")
	else
        LogChange("godhuman_stage", "godhuman: purchasing style")
        SetStatus("godhuman | purchasing style")
		Travel.Sea3()
		TweenToMeleeBuyer("Godhuman")
		CommF_:InvokeServer("BuyGodhuman")
	end
end

local function GetSaber()
    LogChange("saber", "saber: checking progress")
	Travel.Sea1()
	CommF_:InvokeServer("AbandonQuest")
	local data = CommF_:InvokeServer("ProQuestProgress")
	if data.UsedRelic == false then
        LogChange("saber_stage", "saber: solving jungle puzzle")
        SetStatus("saber | solving jungle puzzle")
		while not (workspace.Map:FindFirstChild("Jungle") and workspace.Map.Jungle:FindFirstChild("QuestPlates") and workspace.Map.Jungle.QuestPlates:FindFirstChild("Door")) do
			task.wait()
			Tween(CFrame.new(-1254.25439453125, 18.39460563659668, 342.31976318359375), 350)
		end
		if workspace.Map.Jungle.QuestPlates.Door.Transparency == 0 then
            LogChange("saber_stage", "saber: activating jungle plates")
            SetStatus("saber | activating jungle plates")
			for _, v in workspace.Map.Jungle.QuestPlates:GetChildren() do
				if v:IsA("Model") and string.find(v.Name, "Plate") then
					firetouchinterest(v.Button, Character.HumanoidRootPart, 1)
					firetouchinterest(v.Button, Character.HumanoidRootPart, 0)
				end
			end
		else
			if data.UsedTorch == false then
                LogChange("saber_stage", "saber: collecting torch")
                SetStatus("saber | collecting torch")
				if LocalPlayer.Backpack:FindFirstChild("Torch") or Character:FindFirstChild("Torch") then
					CommF_:InvokeServer("ProQuestProgress", "DestroyTorch")
				else
					CommF_:InvokeServer("ProQuestProgress", "GetTorch")
				end
			else
				if data.UsedCup then
					if data.TalkedSon and data.KilledMob then
                        LogChange("saber_stage", "saber: placing relic")
                        SetStatus("saber | placing relic")
						if not data.UsedRelic then
							CommF_:InvokeServer("ProQuestProgress", "RichSon")
							if not Character:FindFirstChild("Relic") then
								Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild("Relic"))
							end
							CommF_:InvokeServer("ProQuestProgress", "PlaceRelic")
						end
					elseif data.TalkedSon == false then
                        LogChange("saber_stage", "saber: talking to rich son")
                        SetStatus("saber | talking to rich son")
						CommF_:InvokeServer("ProQuestProgress", "RichSon")
					elseif data.KilledMob == false then
                        LogChange("saber_stage", "saber: defeating mob leader")
                        SetStatus("saber | defeating mob leader")
						if CheckMonster("Mob Leader") then
							KillMonster("Mob Leader")
						end
					end
				else
                    LogChange("saber_stage", "saber: filling cup")
                    SetStatus("saber | filling cup")
					CommF_:InvokeServer("ProQuestProgress", "GetCup")
					if not Character:FindFirstChild("Cup") then
						Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild("Cup"))
					end
					CommF_:InvokeServer("ProQuestProgress", "FillCup", Character.Cup)
					CommF_:InvokeServer("ProQuestProgress", "SickMan")
				end
			end
		end
	else
        LogChange("saber_stage", "saber: fighting saber expert")
        SetStatus("saber | fighting saber expert")
		if CheckMonster("Saber Expert") then
			KillMonster("Saber Expert")
		else
			Tween( ReplicatedStorage.FortBuilderReplicatedSpawnPositionsFolder["Saber Expert"].CFrame * CFrame.new(0, 25, 0), 350 )
		end
	end
end

local function DoBartiloQuest()
    LogChange("bartilo", "bartilo: checking progress")
	if not World.Sea2() then
        LogChange("bartilo_travel", "bartilo: traveling to sea 2")
        SetStatus("bartilo | traveling to sea 2")
		while true do
			CommF_:InvokeServer("TravelDressrosa")
			task.wait(7.5)
		end
	end
	local function CheckKilledBanit()
		return CommF_:InvokeServer("BartiloQuestProgress").KilledBandits
	end
	local data = CommF_:InvokeServer("BartiloQuestProgress", "Bartilo")
	if CheckKilledBanit() == false then
        LogChange("bartilo_stage", "bartilo: farming swan pirates")
        SetStatus("bartilo | farming swan pirates")
		repeat
			if QuestController.CurrentQuestName ~= "BartiloQuest" then
				CommF_:InvokeServer("StartQuest", "BartiloQuest", 1)
			end
			if workspace.Enemies:FindFirstChild("Swan Pirate") then
				for _, v in workspace.Enemies:GetChildren() do
					if v.Name == "Swan Pirate" and v:FindFirstChildOfClass("Humanoid") and v.Humanoid.Health > 0 and v.PrimaryPart then
						repeat
							task.wait()
							if not v or not v.PrimaryPart or not v:FindFirstChildOfClass("Humanoid") or v.Humanoid.Health <= 0 then
								break
							end
							Tween(v.PrimaryPart.Position + Vector3.new(0, 20, 10), 350)
							if LocalPlayer:DistanceFromCharacter(v.PrimaryPart.Position) <= 200 then
								Tween(v.PrimaryPart.Position + Vector3.new(0, 20, 10), math.huge)
								EquipWeapon()
								BringMob(v.Name)
								Attack()
							end
						until not v or not v.PrimaryPart or v.Humanoid.Health <= 0
					end
				end
			else
				Tween(CFrame.new(932.624451, 156.106079, 1180.27466), 350).Completed:Wait()
			end
		until CheckKilledBanit()
	elseif data == 1 then
        LogChange("bartilo_stage", "bartilo: defeating jeremy")
        SetStatus("bartilo | defeating jeremy")
		if CheckMonster("Jeremy") then
			KillMonster("Jeremy")
		else
			Tween(Vector3.new(2129, 469, 779), 300).Completed:Wait()
		end
	elseif data == 2 then
		for i = 1, 8 do
            LogChange("bartilo_plate", "bartilo: activating plate " .. tostring(i) .. "/8")
            SetStatus("bartilo | activating plate " .. tostring(i) .. "/8")
			firetouchinterest(workspace.Map.Dressrosa.BartiloPlates["Plate" .. i], Character.PrimaryPart, 0)
			task.wait(0.1)
			firetouchinterest(workspace.Map.Dressrosa.BartiloPlates["Plate" .. i], Character.PrimaryPart, 1)
		end
	end
end
local function CheckDataLevel()
	local lv = LocalPlayer.Data.Level.Value
	if lv < 10 then
		return 1
	elseif lv < 70 then
		return 2
	elseif lv < 120 then
		return 3
	else
		return 4
	end
end
local function FarmLevelLogic()
	local levelData = CheckDataLevel()
    LogChange("farm_band", "farm: level band " .. tostring(levelData))
	if levelData == 2 then
        LogChange("farm_target", "farm: targeting shanda")
        SetStatus("farm | targeting shanda | lv " .. tostring(LocalPlayer.Data.Level.Value))
		local foundMob = false
		for _, v in {workspace.Enemies, ReplicatedStorage} do
			for _, v2 in v:GetChildren() do
				if v2:IsA("Model") then
					local hrp = v2:FindFirstChild("HumanoidRootPart") or v2.PrimaryPart
					if v2.Name == "Shanda" and hrp and v2:FindFirstChildOfClass("Humanoid") and v2:FindFirstChildOfClass("Humanoid").Health > 0 then
						foundMob = true
						repeat
							task.wait()
							local t = Tween(hrp.Position + Vector3.new(0, 20, 5), 350)
							if LocalPlayer:DistanceFromCharacter(hrp.Position) <= 160 then
								if t then
									t:Cancel()
								end
								Tween(hrp.Position + Vector3.new(0, 20, 5), math.huge)
								if LocalPlayer:DistanceFromCharacter(hrp.Position) <= 40 then
									BringMob(v2.Name)
									EquipWeapon()
									Attack()
								end
							end
						until not v2 or not v2:FindFirstChildOfClass("Humanoid") or v2.Humanoid.Health == 0
						pcall(function()
							v2:Destroy()
						end)
						if not CheckMonster("Shanda") then
							break
						end
					end
				end
			end
			if foundMob then
				break
			end
		end
		if not foundMob then
			local n = ReplicatedStorage.FortBuilderReplicatedSpawnPositionsFolder:FindFirstChild("Shanda")
			if n then
				Tween(n:GetPivot().Position + Vector3.new(0, 25, 0), 350).Completed:Wait()
			end
		end
	elseif levelData == 3 then
        LogChange("farm_target", "farm: targeting god's guard")
        SetStatus("farm | targeting god's guard | lv " .. tostring(LocalPlayer.Data.Level.Value))
		local foundMob = false
		for _, v in {workspace.Enemies, ReplicatedStorage} do
			for _, v2 in v:GetChildren() do
				if v2:IsA("Model") then
					local hrp = v2:FindFirstChild("HumanoidRootPart") or v2.PrimaryPart
					if v2.Name == "God's Guard" and hrp and v2:FindFirstChildOfClass("Humanoid") and v2:FindFirstChildOfClass("Humanoid").Health > 0 then
						foundMob = true
						repeat
							task.wait()
							local t = Tween(hrp.Position + Vector3.new(0, 25, 5), 350)
							if LocalPlayer:DistanceFromCharacter(hrp.Position) <= 160 then
								if t then
									t:Cancel()
								end
								Tween(hrp.Position + Vector3.new(0, 25, 5), math.huge)
								if LocalPlayer:DistanceFromCharacter(hrp.Position) <= 40 then
									BringMob(v2.Name)
									EquipWeapon()
									Attack()
								end
							end
						until not v2
							or not v2.Parent
							or not v2:FindFirstChildOfClass("Humanoid")
							or v2:FindFirstChildOfClass("Humanoid").Health <= 0
							or not v2.Name:find("God's Guard")
						pcall(function()
							v2:Destroy()
						end)
						if not CheckMonster("God's Guard") then
							break
						end
					end
				end
			end
			if foundMob then
				break
			end
		end
		if not foundMob then
			local n = ReplicatedStorage.FortBuilderReplicatedSpawnPositionsFolder:FindFirstChild("God's Guard")
			if n then
				Tween(n:GetPivot().Position + Vector3.new(0, 25, 0), 350).Completed:Wait()
			end
		end
	elseif levelData == 4 or levelData == 1 then
		if GetMonsterName() then
            LogChange("farm_target", "farm: targeting quest mob")
            SetStatus("farm | targeting quest mob | lv " .. tostring(LocalPlayer.Data.Level.Value))
			for _, v2 in {workspace.Enemies, ReplicatedStorage} do
				for _, v in v2:GetChildren() do
					if v.Name == GetMonsterName() and v.PrimaryPart and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health > 0 then
						local startKillThisNPC = tick()
						repeat
							task.wait()
							TakeQuest()
							local t = Tween(v:GetPivot().Position + Vector3.new(0, 20, 5), 350)
							if LocalPlayer:DistanceFromCharacter(v:GetPivot().Position) <= 160 then
								if t then
									t:Cancel()
								end
								Tween(v:GetPivot().Position + Vector3.new(0, 20, 5), math.huge)
								if LocalPlayer:DistanceFromCharacter(v:GetPivot().Position) <= 40 then
									BringMob(v.Name)
									EquipWeapon()
									Attack()
								end
							end
						until not v
							or not v.PrimaryPart
							or not v:FindFirstChildOfClass("Humanoid")
							or v:FindFirstChildOfClass("Humanoid").Health <= 0
							or v.Name ~= GetMonsterName()
							or (tick() - startKillThisNPC) >= 90
						pcall(function()
							v:Destroy()
						end)
						if not CheckMonster(GetMonsterName()) then
							break
						end
					end
				end
			end
		else
            LogChange("farm_target", "farm: waiting for quest mob")
            SetStatus("farm | waiting for quest mob | lv " .. tostring(LocalPlayer.Data.Level.Value))
			TakeQuest()
			for _, v in {ReplicatedStorage.FortBuilderReplicatedSpawnPositionsFolder, workspace._WorldOrigin.EnemySpawns} do
				for _, v2 in v:GetChildren() do
					if not v2.Name:find("Boss") and QuestController.CurrentQuest == v2.Name then
						repeat task.wait()
							Tween(v2:GetPivot().Position + Vector3.new(0, 25, 0), 350)
						until GetMonsterName()
						break
					end
				end
			end
			task.wait(0.25)
		end
	end
end

boneNPCs = {
	"Reborn Skeleton",
	"Living Zombie",
	"Demonic Soul",
	"Posessed Mummy",
}
local function FarmBoneLogic()
    LogChange("bone_farm", "bone: searching for mobs")
	local mob = nil
	local min = math.huge
	for _, v in workspace.Enemies:GetChildren() do
		if v.PrimaryPart and v:FindFirstChildOfClass("Humanoid") and v.Humanoid.Health > 0 and table.find(boneNPCs, v.Name) then
			local dist = LocalPlayer:DistanceFromCharacter(v.PrimaryPart.Position)
			if dist < min then
				min = dist
				mob = v
			end
		end
	end
	if mob and mob.PrimaryPart and mob:FindFirstChildOfClass("Humanoid") and mob:FindFirstChildOfClass("Humanoid").Health > 0 then
        LogChange("bone_target", "bone: farming " .. string.lower(mob.Name))
        SetStatus("bone farm | " .. string.lower(mob.Name))
		TakeQuestBone(mob.Name)
		startKillThisNPC = tick()
		repeat
			task.wait()
			Tween(mob.PrimaryPart.CFrame * CFrame.new(0, 15, 5), 350)
			if LocalPlayer:DistanceFromCharacter(mob.PrimaryPart.Position) <= 210 then
				Tween(mob.PrimaryPart.CFrame * CFrame.new(0, 15, 5), math.huge)
				if LocalPlayer:DistanceFromCharacter(mob.PrimaryPart.Position) <= 30 then
					BringMob(mob.Name)
					EquipWeapon()
					Attack()
				end
			end
		until not mob or not mob.PrimaryPart or not mob:FindFirstChildOfClass("Humanoid") or mob.Humanoid.Health <= 0 or (tick() - startKillThisNPC) >= 90
	else
        LogChange("bone_target", "bone: waiting for spawn")
        SetStatus("bone farm | waiting for spawn")
		Tween(CFrame.new(-9515, 164, 5786), 350).Completed:Wait()
	end
end

local function FarmKataLogic()
    LogChange("cake_farm", "cake: checking prince")
	Travel.Sea3()
	if LocalPlayer:DistanceFromCharacter(Vector3.new(-2132, 70, -12319)) >= 1200 and not GetCakePrince() then
		Tween(CFrame.new(-2251, 146, -12196), 350).Completed:Wait()
	end
	if GetCakePrince() then
        LogChange("cake_target", "cake: fighting cake prince")
        SetStatus("cake farm | fighting cake prince")
		local Target = GetCakePrince()
		repeat
			if LocalPlayer:DistanceFromCharacter(Target.PrimaryPart.CFrame.Position) >= 1200 and GetCakePrince() then
				StopTween()
				Tween(workspace.Map.CakeLoaf.BigMirror.Main.CFrame, 350).Completed:Wait()
				task.wait(0.75)
			end
			Tween(Target.PrimaryPart.CFrame * CFrame.new(0, 17.5, 10), 350)
			if LocalPlayer:DistanceFromCharacter(Target.PrimaryPart.CFrame.Position) <= 200 then
				Tween(Target.PrimaryPart.CFrame * CFrame.new(0, 17.5, 10), math.huge)
				if LocalPlayer:DistanceFromCharacter(Target.PrimaryPart.CFrame.Position) <= 40 then
					EquipWeapon()
					Attack()
				end
			end
			task.wait()
		until not Target or not GetCakePrince() or Character.Humanoid.Health <= 0
	else
		local mob = nil
		local min = math.huge
		for _, v in workspace.Enemies:GetChildren() do
			if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
				local dist = LocalPlayer:DistanceFromCharacter(v.HumanoidRootPart.Position)
				if dist < min then
					min = dist
					mob = v
				end
			end
		end
		if mob and table.find(MobsCakePrince, mob.Name) and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
            LogChange("cake_target", "cake: farming " .. string.lower(mob.Name))
            SetStatus("cake farm | " .. string.lower(mob.Name))
			TakeQuestCake(mob.Name)
			startKillThisNPC = tick()
			repeat
				task.wait()
				Tween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0), 350)
				if LocalPlayer:DistanceFromCharacter(mob.HumanoidRootPart.Position) <= 200 then
					Tween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0), math.huge)
					if LocalPlayer:DistanceFromCharacter(mob.HumanoidRootPart.Position) <= 40 then
						BringMob(mob.Name)
						EquipWeapon()
						Attack()
					end
				end
			until not mob
				or not mob:FindFirstChild("Humanoid")
				or mob.Humanoid.Health <= 0
				or not mob:FindFirstChild("HumanoidRootPart")
				or (tick() - startKillThisNPC) >= 90
		end
	end
end

local function GetCDKLogic()
    LogChange("cdk", "cdk: checking progress")
	Travel.Sea3()
	if CommF_:InvokeServer("CDKQuest", "OpenDoor") == "can" then
		CommF_:InvokeServer("CDKQuest", "OpenDoor", true)
	end
	local q = CommF_:InvokeServer("CDKQuest", "Progress")
    LogChange("cdk_progress", "cdk: evil " .. tostring(q.Evil) .. " / good " .. tostring(q.Good))
	if q.Evil == 0 or q.Evil == -3 then
        LogChange("cdk_stage", "cdk: evil trial - mythological pirate")
        SetStatus("cdk | evil trial - mythological pirate")
		CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
		if workspace.Enemies:FindFirstChild("Mythological Pirate") then
			repeat
				task.wait()
				Tween( workspace.Enemies:FindFirstChild("Mythological Pirate").HumanoidRootPart.CFrame * CFrame.new(5, 0, 0), 350 )
			until CommF_:InvokeServer("CDKQuest", "Progress").Evil ~= -3
				and GetMaterial("Alucard Fragment") == 1
		else
			Tween(Vector3.new(-13239, 520, -6813), 350).Completed:Wait()
		end
	elseif q.Evil == 1 or q.Evil == -4 then
        LogChange("cdk_stage", "cdk: evil trial - haze mobs")
        SetStatus("cdk | evil trial - haze mobs")
		CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
		if LocalPlayer:FindFirstChild("QuestHaze") then
			for _, v in LocalPlayer.QuestHaze:GetChildren() do
				if v.Value > 0 then
                    LogChange("cdk_haze_target", "cdk: clearing " .. string.lower(v.Name) .. " " .. tostring(v.Value))
                    SetStatus("cdk | clearing " .. string.lower(v.Name))
					repeat
						task.wait()
						if LocalPlayer:DistanceFromCharacter( ReplicatedStorage.FortBuilderReplicatedSpawnPositionsFolder[v.Name].CFrame.Position ) >= 600 then
							Tween(ReplicatedStorage.FortBuilderReplicatedSpawnPositionsFolder[v.Name].CFrame, 350).Completed:Wait()
						end
						for _, v2 in workspace.Enemies:GetChildren() do
							if v2.Name == v.Name and v2:FindFirstChild("HumanoidRootPart") and v2:FindFirstChild("Humanoid") and v2.Humanoid.Health > 0 then
								repeat
									task.wait()
									Tween(v2.HumanoidRootPart.Position + Vector3.new(0, 25, 10), 350)
									if LocalPlayer:DistanceFromCharacter(v2.HumanoidRootPart.Position) <= 40 then
										BringMob(v2.Name)
										EquipWeapon()
										Attack()
									end
								until not v2.Humanoid or not v2.HumanoidRootPart or v2.Humanoid.Health <= 0 or not v2
								break
							end
						end
					until not v or v.Value == 0 or not LocalPlayer:FindFirstChild("QuestHaze")
				end
			end
		end
	elseif q.Evil == 2 or q.Evil == -5 then
        LogChange("cdk_stage", "cdk: evil trial - hell dimension")
        SetStatus("cdk | evil trial - hell dimension")
		CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
		if workspace.Enemies:FindFirstChild("Soul Reaper") or workspace.Map:FindFirstChild("HellDimension") then
			if workspace.Enemies:FindFirstChild("Soul Reaper") and not workspace.Map:FindFirstChild("HellDimension") then
				repeat
					Tween(workspace.Enemies:FindFirstChild("Soul Reaper").HumanoidRootPart.CFrame, 350).Completed:Wait()
					task.wait()
				until workspace.Map:FindFirstChild("HellDimension")
			end
			if tw then
				tw:Cancel()
			end
			task.wait(1)
			for i = 1, 3 do
                LogChange("cdk_torch", "cdk: lighting hell torch " .. tostring(i) .. "/3")
                SetStatus("cdk | lighting hell torch " .. tostring(i) .. "/3")
				Tween(workspace.Map.HellDimension["Torch" .. i].CFrame, 350).Completed:Wait()
				fireproximityprompt(workspace.Map.HellDimension["Torch" .. i].ProximityPrompt)
				repeat
					task.wait()
				until #workspace.Enemies:GetChildren() > 0
				for _, v in workspace.Enemies:GetChildren() do
					if LocalPlayer:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 300 and v.HumanoidRootPart and v.Humanoid and v.Humanoid.Health > 0 then
						repeat
							task.wait()
							Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 25, 10), 350)
							if LocalPlayer:DistanceFromCharacter(v.HumanoidRootPart.Position) <= 210 then
								Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 25, 10), math.huge)
								if LocalPlayer:DistanceFromCharacter(v.HumanoidRootPart.Position) <= 40 then
									BringMob(v.Name)
									EquipWeapon()
									Attack()
								end
							end
						until not v
							or not v:FindFirstChild("Humanoid")
							or v.Humanoid.Health <= 0
							or not v:FindFirstChild("HumanoidRootPart")
					end
				end
			end
		else
			local boneNPCs = {
				"Reborn Skeleton",
				"Living Zombie",
				"Demonic Soul",
				"Posessed Mummy",
			}
			repeat
				task.wait()
				local mob = nil
				local min = math.huge
				for _, v in workspace.Enemies:GetChildren() do
					if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and table.find(boneNPCs, v.Name) then
						local dist = LocalPlayer:DistanceFromCharacter(v.HumanoidRootPart.Position)
						if dist < min then
							min = dist
							mob = v
						end
					end
				end
				if mob and mob.HumanoidRootPart and mob.Humanoid and mob.Humanoid.Health > 0 then
					repeat
						task.wait()
						Tween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 5), 350)
						if LocalPlayer:DistanceFromCharacter(mob.HumanoidRootPart.Position) <= 210 then
							Tween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 5), math.huge)
							if LocalPlayer:DistanceFromCharacter(mob.HumanoidRootPart.Position) <= 30 then
								BringMob(mob.Name)
								EquipWeapon()
								Attack()
							end
						end
					until not mob
						or not mob:FindFirstChild("Humanoid")
						or mob.Humanoid.Health <= 0
						or not mob:FindFirstChild("HumanoidRootPart")
				else
					Tween(CFrame.new(-9515, 164, 5786), 350).Completed:Wait()
				end
			until LocalPlayer.Backpack:FindFirstChild("Hallow Essence") or CheckMonster("Soul Reaper")
			if LocalPlayer.Backpack:FindFirstChild("Hallow Essence") then
				EquipTool("Hallow Essence")
				if Character:FindFirstChild("Hallow Essence") then
					firetouchinterest(Character.HumanoidRootPart, workspace.Map["Haunted Castle"].Summoner.Detection, 1)
					firetouchinterest(Character.HumanoidRootPart, workspace.Map["Haunted Castle"].Summoner.Detection, 0)
				end
			end
		end
	elseif q.Good == 0 or q.Good == -3 then
        LogChange("cdk_stage", "cdk: good trial - finding boats")
        SetStatus("cdk | good trial - finding boats")
		CommF_:InvokeServer("CDKQuest", "StartTrial", "Good")
		for _, x in {CFrame.new(-9550, 21, 4690), CFrame.new(-6120, 16, -2250), CFrame.new(-9530, 7, -8370)} do
			repeat
				LocalPlayer.Character.HumanoidRootPart.CFrame = x
				task.wait()
			until workspace.NPCs:FindFirstChildWhichIsA("Model")
				and workspace.NPCs:FindFirstChildWhichIsA("Model").Name:find("Boat")
			for _, n in workspace.NPCs:GetChildren() do
				if n.Name:find("Boat") then
					CommF_:InvokeServer("CDKQuest", "BoatQuest", n)
				end
			end
		end
	elseif q.Good == 1 or q.Good == -4 then
        LogChange("cdk_stage", "cdk: good trial - reaching objective")
        SetStatus("cdk | good trial - reaching objective")
		CommF_:InvokeServer("CDKQuest", "StartTrial", "Good")
		Tween(CFrame.new(6148.4116210938, 294.38687133789, -6741.1166992188), 350)
	elseif q.Good == 2 or q.Good == -5 then
        LogChange("cdk_stage", "cdk: good trial - heavenly dimension")
        SetStatus("cdk | good trial - heavenly dimension")
		CommF_:InvokeServer("CDKQuest", "StartTrial", "Good")
		if workspace.Map:FindFirstChild("HeavenlyDimension") ~= nil and workspace.Map:FindFirstChild("Heavenly Dimension") then
			if workspace.Map.HeavenlyDimension.Exit.Color ~= Color3.fromRGB(0, 0, 0) then
				firetouchinterest( workspace.Map.HeavenlyDimension.Exit.Touchinterest, LocalPlayer.Character.HumanoidRootPart, 0 )
			else
				for i = 1, 3 do
                    LogChange("cdk_heaven_torch", "cdk: lighting heaven torch " .. tostring(i) .. "/3")
                    SetStatus("cdk | lighting heaven torch " .. tostring(i) .. "/3")
					repeat
						task.wait()
						local e = workspace.Enemies:FindFirstChildWhichIsA("Model", true)
						if e and (e.Name:find("Cursed Skeleton") or e.Name:find("Heaven")) then
							KillMonster(e.Name)
						else
							if workspace.Map.HeavenlyDimension["Torch" .. i].ProximityPrompt.Enabled then
								Tween(workspace.Map.HeavenlyDimension["Torch" .. i].CFrame, 350).Completed:Wait()
								fireproximityprompt(workspace.Map.HeavenlyDimension["Torch" .. i].ProximityPrompt)
							end
						end
					until not workspace.Map.HeavenlyDimension["Torch" .. i].ProximityPrompt.Enabled
						or workspace.Map.HeavenlyDimension.Exit.Color ~= Color3.fromRGB(0, 0, 0)
						or Character.Humanoid.Health <= 0
					StopTween()
				end
			end
		else
			if CheckMonster("Cake Queen") then
				KillMonster("Cake Queen")
				StopTween()
			else
				HopLowServer()
			end
		end
	end
end

CheckedMelee = false
MeleeData = {

	BlackLeg = 0,
	Electro = 0,
	FishmanKarate = 0,

	SharkmanKarate = 0,
	DeathStep = 0,
	DragonClaw = 0,
	Superhuman = 0,

	ElectricClaw = 0,
	DragonTalon = 0,
	GodHuman = 0,
	SanguineArt = 0,
}

MeleePrices = {
	BlackLeg = {
		Price = {
			Beli = 150000,
		},
		Id = "BlackLeg",
		NextLevelRequirement = 400,
	},
	Electro = {
		Price = {
			Beli = 500000,
		},
		Id = "Electro",
		NextLevelRequirement = 400,
	},
	FishmanKarate = {
		Price = {
			Beli = 750000,
		},
		NextLevelRequirement = 400,
	},
	DragonClaw = {
		Price = {
			Fragments = 1500,
		},
		NextLevelRequirement = 400,
	},
	Superhuman = {
		Price = {
			Beli = 3000000,
		},
		NextLevelRequirement = 400,
	},
	DeathStep = {
		Price = {
			Beli = 2500000,
			Fragments = 5000,
		},
		NextLevelRequirement = 400,
	},
	SharkmanKarate = {
		Price = {
			Beli = 2500000,
			Fragments = 5000,
		},
		NextLevelRequirement = 400,
	},
	ElectricClaw = {
		Price = {
			Beli = 2500000,
			Fragments = 5000,
		},
		NextLevelRequirement = 400,
	},
	DragonTalon = {
		Price = {
			Beli = 2500000,
			Fragments = 5000,
		},
		NextLevelRequirement = 400,
	},
	Godhuman = {
		Price = {
			Beli = 5000000,
			Fragments = 5000,
		},
		NextLevelRequirement = 350,
	},
}

Name2Name = {
	["Water Kung Fu"] = "FishmanKarate",
	["Electric"] = "Electro",
	["Dark Step"] = "BlackLeg",
	["Dragon Breath"] = "DragonClaw",
}
local lastMeleeDataCheck = 0
local function CheckMeleeMastery()
	local now = tick()
	if (now - lastMeleeDataCheck) < 10 then
		return
	end
	lastMeleeDataCheck = now

	if not CheckedMelee then
        LogChange("melee_data", "melee: checking data")
	end

	local success = pcall(function()
		local data = IRS:GetItems(KEYS.MASTERY)
		for _, v in data do
			local matched = MATCH(v.ItemId)
			local item = matched and matched._ok
			if item and item.Index and item.Display then
				local n = item.Index.StorageKey
				if item.Display.Category == "Fighting Style" and n then
					local key = Name2Name[n] or n:gsub(" ", "")
					if MeleeData[key] ~= nil then
						MeleeData[key] = tonumber(v.Value) or MeleeData[key]
					end
				end
			end
		end
	end)

	if success then
		CheckedMelee = true
        LogChange("melee_data", "melee: data loaded")
    else
        LogChange("melee_data", "melee: data load failed")
	end
end

local CheckCanDungeon, AutoDungeon

local GetMeleeLogics = {
	SharkmanKarate = function()
		if not World.Sea2() then
			while true do
				CommF_:InvokeServer("TravelDressrosa")
				task.wait(10)
			end
		end
		local check = CommF_:InvokeServer("BuySharkmanKarate", true)
		if (not HasItem("Water Key")) and check ~= 0 and check ~= 1 and typeof(check) == "string" then
			if CheckMonster("Tide Keeper") then
				KillMonster("Tide Keeper")
			else
				HopLowServer()
				task.wait(5)
			end
		else
			TweenToMeleeBuyer("SharkmanKarate")
			CommF_:InvokeServer("BuySharkmanKarate", true)
			CommF_:InvokeServer("BuySharkmanKarate")
		end
	end,
	DeathStep = function()
		if not World.Sea2() then
			while true do
				CommF_:InvokeServer("TravelDressrosa")
				task.wait(10)
			end
		end
		local check = CommF_:InvokeServer("OpenLibrary")
		if not HasItem("Library Key") and not check then
			if CheckMonster("Awakened Ice Admiral") then
				KillMonster("Awakened Ice Admiral")
			else
				HopLowServer()
				task.wait(5)
			end
		elseif HasItem("Library Key") then
			CommF_:InvokeServer("OpenLibrary")
		elseif check == true then
			TweenToMeleeBuyer("DeathStep")
			CommF_:InvokeServer("BuyDeathStep")
		end
	end,
	ElectricClaw = function()
		Travel.Sea3()
		TweenToMeleeBuyer("ElectricClaw")
		CommF_:InvokeServer("BuyElectricClaw", "Start")
		Tween(CFrame.new(-12550, 336, -7510), 350).Completed:Wait()
		task.wait(0.5)
		TweenToMeleeBuyer("ElectricClaw")
		CommF_:InvokeServer("BuyElectricClaw")
	end,
	DragonTalon = function()
		Travel.Sea3()
		repeat
			task.wait()
			FarmBoneLogic()
			if GetMaterial("Bones") >= 50 then
				CommF_:InvokeServer("Bones", "Buy", 1, 1)
			end
		until HasItem("Fire Essence")
		TweenToMeleeBuyer("DragonTalon")
		CommF_:InvokeServer("BuyDragonTalon", true)
		CommF_:InvokeServer("BuyDragonTalon")
	end,
}

local function CheckYama()
	return CommF_:InvokeServer("EliteHunter", "Progress") or 0
end

local function MeleeKaitunLogic()
    LogChange("melee_logic", "melee: checking styles")
	if Character then
		local beli = LocalPlayer.Data.Beli.Value
		if not CollectionService:HasTag(Character, "Buso") and (beli >= 25000) then
			CommF_:InvokeServer("BuyHaki", "Buso")
		end
		if not CollectionService:HasTag(Character, "Geppo") and (beli >= 10000) then
			CommF_:InvokeServer("BuyHaki", "Geppo")
		end
		if not CollectionService:HasTag(Character, "Soru") and (beli >= 100000) then
			CommF_:InvokeServer("BuyHaki", "Soru")
		end
	else
		return
	end
	if not CheckedMelee then
		CheckMeleeMastery()
	end
	for _, v in {"BlackLeg", "Electro", "FishmanKarate"} do
		local realName = v:gsub("(%l)(%u)", "%1 %2")

			if (MeleeData[v] or 0) < 400 then
            LogChange("melee_progress", "melee: " .. string.lower(realName) .. " " .. tostring(MeleeData[v] or 0) .. "/400")

			if (MeleeData[v] or 0) == 0 and LocalPlayer.Data.Beli.Value < MeleePrices[v].Price.Beli then
                LogChange("melee_wait", "melee: need beli for " .. string.lower(realName))

				return
			end
			if not HasItem(realName) then
                LogChange("melee_action", "melee: getting " .. string.lower(realName))
				if not TweenToMeleeBuyer(v) then
					return
				end
				task.wait(0.5)
				CommF_:InvokeServer("Buy" .. v)
			end
			return
		end
	end

	if not World.Sea1() then
		for _, v in {"DragonClaw", "Superhuman", "DeathStep", "SharkmanKarate"} do
			local realName = v:gsub("(%l)(%u)", "%1 %2")
			if (MeleeData[v] or 0) < 400 then
				local hasEnoughEco = (
					(MeleePrices[v].Price.Beli == nil) or (LocalPlayer.Data.Beli.Value >= MeleePrices[v].Price.Beli)
				)
					and (
						(MeleePrices[v].Price.Fragments == nil)
						or (LocalPlayer.Data.Fragments.Value >= MeleePrices[v].Price.Fragments)
					)
				if (MeleeData[v] or 0) == 0 and hasEnoughEco then
                    LogChange("melee_action", "melee: unlocking " .. string.lower(realName))
					if v ~= "DragonClaw" and v ~= "Superhuman" then
						GetMeleeLogics[v]()
						return true
					else
						TweenToMeleeBuyer(v)
						if v == "Superhuman" then
							CommF_:InvokeServer("Buy" .. v)
						else
							CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
						end
					end
				elseif (MeleeData[v] or 0) == 0 and (MeleePrices[v].Price.Fragments and (LocalPlayer.Data.Fragments.Value < MeleePrices[v].Price.Fragments)) and CheckCanDungeon() then
                    LogChange("melee_action", "melee: farming fragments")
					if (not World.Sea1()) and LocalPlayer.Data.Level.Value >= 1250 then
						AutoDungeon()
					end
				elseif (MeleeData[v] or 0) == 0 and not hasEnoughEco then
                    LogChange("melee_wait", "melee: waiting for " .. string.lower(realName) .. " resources")
				elseif (MeleeData[v] or 0) > 0 and not HasItem(realName) then
					if not TweenToMeleeBuyer(v) then
						break
					end
					if v == "DragonClaw" then
						CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
					else
						CommF_:InvokeServer("Buy" .. v)
					end
				end
				return
			end
		end
		for _, v in {"ElectricClaw", "DragonTalon", "Godhuman"} do
			local realName = v:gsub("(%l)(%u)", "%1 %2")
			if (MeleeData[v] or 0) < 400 then
				local hasEnoughEco = (
					(MeleePrices[v].Price.Beli == nil) or (LocalPlayer.Data.Beli.Value >= MeleePrices[v].Price.Beli)
				)
					and (
						(MeleePrices[v].Price.Fragments == nil)
						or (LocalPlayer.Data.Fragments.Value >= MeleePrices[v].Price.Fragments)
					)
				if (MeleeData[v] or 0) == 0 and hasEnoughEco then
                    LogChange("melee_action", "melee: unlocking " .. string.lower(realName))
					if v == "Godhuman" then
						-- print("godhuman...")
						GetGodHuman()
					else
						GetMeleeLogics[v]()
					end
					return true
				elseif (MeleeData[v] or 0) == 0 and (MeleePrices[v].Price.Fragments and (LocalPlayer.Data.Fragments.Value < MeleePrices[v].Price.Fragments)) and CheckCanDungeon() then
					if (not World.Sea1()) and LocalPlayer.Data.Level.Value >= 1250 then
						AutoDungeon()
					end
				elseif (MeleeData[v] or 0) == 0 and not hasEnoughEco then
                    LogChange("melee_wait", "melee: waiting for " .. string.lower(realName) .. " resources")
				elseif (MeleeData[v] or 0) > 0 and not Character:FindFirstChild(realName) and not LocalPlayer.Backpack:FindFirstChild(realName) then
					if not TweenToMeleeBuyer(v) then
						break
					end
					CommF_:InvokeServer("Buy" .. v)
				end
				return
			end
		end
	end
end

KEYS = require(ReplicatedStorage.ItemReplicationService.KEYS)
IRS = require(ReplicatedStorage.ItemReplicationService)
MATCH = require(ReplicatedStorage.ItemConfig.Storage).match
local function GetUseableFruit()
	local data = IRS:GetItems(KEYS.QUANTITY)
	for _, v in data do
		local item = MATCH(v.ItemId)._ok
		if item.Display.Category == "Blox Fruit" and item.Quality.MoneyPrice < 1000000 then
			return item.Index.StorageKey
		end
	end
end

CheckCanDungeon = function()
	local res = CommF_:InvokeServer("RaidsNpc", "Select", "Dark")
	if HasItem("Special Microchip") then
		return true
	elseif GetUseableFruit() then
		return true
	elseif LocalPlayer.Data.Beli.Value >= 100000 and ((type(res) == "number" and res == 1) or (type(res) == "string" and not res:find("wait"))) then
		return true
	end
end

local RaidController = {
	isRaiding = false,
}
RaidController.RaidState_Connection = nil
if World.Sea2() or World.Sea3() then
	if ReplicatedStorage.Remotes:FindFirstChild("Raids") then
		while not RaidController.RaidState_Connection do
			RaidController.RaidState_Connection = ReplicatedStorage.Remotes.Raids.OnClientEvent:Connect(function(a)
				if a == "StartTimer" then
					RaidController.isRaiding = true
				else
					RaidController.isRaiding = false
				end
			end)
			task.wait(0.5)
		end
	end
end

local function KillAura(distance)
	for _, v in workspace.Enemies:GetChildren() do
		if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChildOfClass("Humanoid") then
			if LocalPlayer:DistanceFromCharacter(v.PrimaryPart.Position) <= distance then
				v.Humanoid:ChangeState(15)
			end
		end
	end
end

AutoDungeon = function()
    LogChange("raid", "raid: preparing")
	local res = CommF_:InvokeServer("RaidsNpc", "Select", "Dark")
	while not Character or not Character.PrimaryPart do
		task.wait()
	end
	if not RaidController.isRaiding then
		if not (LocalPlayer.Backpack:FindFirstChild("Special Microchip") or Character:FindFirstChild("Special Microchip")) then
            LogChange("raid_stage", "raid: getting microchip")
            SetStatus("raid | getting microchip")
			if LocalPlayer.Data.Beli.Value >= 100000 and ((type(res) == "number" and res == 1) or (type(res) == "string" and not res:find("wait"))) then
				CommF_:InvokeServer("RaidsNpc", "Select", "Dark")
			else
				PAUSE_AUTO_STORE = true
				CommF_:InvokeServer("LoadFruit", GetUseableFruit())
				task.wait(0.5)
				CommF_:InvokeServer("RaidsNpc", "Select", "Dark")
				PAUSE_AUTO_STORE = false
			end
		end
		if World.Sea2() then
            LogChange("raid_stage", "raid: summoning at sea 2")
            SetStatus("raid | summoning at sea 2")
			local clickDetector = workspace.Map.CircleIsland.RaidSummon2:FindFirstChildWhichIsA("ClickDetector", true)
			if clickDetector then
				pcall(fireclickdetector, clickDetector)
			end
		elseif World.Sea3() then
            LogChange("raid_stage", "raid: summoning at sea 3")
            SetStatus("raid | summoning at sea 3")
			Tween(Vector3.new(-5018, 315, -2828), 300).Completed:Wait()
			task.wait(1)
			local clickDetector = workspace.Map["Boat Castle"].RaidSummon2:FindFirstChildWhichIsA("ClickDetector", true)
			if clickDetector then
				pcall(fireclickdetector, clickDetector)
			end
		end
		local startWait = tick()
        LogChange("raid_state", "raid: waiting to join")
        SetStatus("raid | waiting to join")
		repeat
			SetStatus("raid | waiting to join")
			StopTween()
			task.wait(0.25)
		until RaidController.isRaiding or (tick() - startWait) >= 30
        LogChange("raid_state", RaidController.isRaiding and "raid: started" or "raid: join timed out")
        SetStatus(RaidController.isRaiding and "raid | started" or "raid | join timed out")
		task.wait(0.5)
		while RaidController.isRaiding do
            LogChange("raid_state", "raid: clearing island")
			SetStatus("raid | clearing island")
			for _, v in workspace.Enemies:GetChildren() do
				if v.PrimaryPart and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health > 0 and LocalPlayer:DistanceFromCharacter(v.PrimaryPart.Position) <= 2000 then
					repeat
						task.wait()
						pcall(sethiddenproperty, LocalPlayer, "SimulationRadius", math.huge)
						pcall(function()
							Tween(v.PrimaryPart.Position + Vector3.new(0, 28, 15), 350)
							if LocalPlayer:DistanceFromCharacter(v.PrimaryPart.Position) <= 200 then
								Tween(v.PrimaryPart.Position + Vector3.new(0, 28, 15), math.huge)
								if LocalPlayer:DistanceFromCharacter(v.PrimaryPart.Position) <= 50 then
									EquipWeapon()
									Attack()
								end
							end
						end)
					until not v
						or not v.PrimaryPart
						or not v:FindFirstChildOfClass("Humanoid")
						or v:FindFirstChildOfClass("Humanoid").Health == 0
					break
				end
			end
			local found = false
			for i = 5, 1, -1 do
				for _, z in workspace["_WorldOrigin"].Locations:GetChildren() do
					if z.Name == ("Island " .. i) and LocalPlayer:DistanceFromCharacter( workspace["_WorldOrigin"].Locations["Island " .. i]:GetPivot().Position ) <= 6000 then
                        LogChange("raid_island", "raid: moving to island " .. tostring(i))
                        SetStatus("raid | moving to island " .. tostring(i))
						found = true
						Tween( workspace["_WorldOrigin"].Locations["Island " .. i]:GetPivot() * CFrame.new(100, 70, 100), 350 )
						task.wait(0.5)
						break
					end
				end
				if found then
					break
				end
			end
			task.wait()
		end
	end
	 task.wait(5)
    LogChange("raid_state", "raid: cycle ended")
end

local function GetYama()
    LogChange("yama", "yama: unlocking")
    SetStatus("yama | unlocking")
	repeat
		fireclickdetector(workspace.Map.Waterfall.SealedKatana.Hitbox.ClickDetector)
		task.wait(0.5)
	until LocalPlayer.Backpack:FindFirstChild("Yama")
end

local function CheckTushita()
	return LocalPlayer.Data.Level.Value >= 2200
end

local function GetTushita()
    LogChange("tushita", "tushita: checking progress")
	if not workspace.Map.Turtle:FindFirstChild("TushitaGate") then
        LogChange("tushita_stage", "tushita: defeating longma")
        SetStatus("tushita | defeating longma")
		if CheckMonster("Longma") then
			KillMonster("Longma")
		end
	elseif (function() for _, v in {workspace.Enemies, ReplicatedStorage} do for _, v2 in v:GetChildren() do if v2:IsA("Model") and v2:FindFirstChild("Humanoid") and v2.Humanoid.Health > 0 and v2.Name:find("indra") then
						return true
					end
				end
			end
		end)()
	then
		if not Character:FindFirstChild("Holy Torch") and not LocalPlayer.Backpack:FindFirstChild("Holy Torch") then
            LogChange("tushita_stage", "tushita: collecting holy torch")
            SetStatus("tushita | collecting holy torch")
			Tween(workspace.Map.Waterfall.SecretRoom.Room.Door.Door.Hitbox.CFrame, 350).Completed:Wait()
			task.wait(1)
		else
			for i = 1, 5, 1 do
                LogChange("tushita_torch", "tushita: lighting torch " .. tostring(i) .. "/5")
                SetStatus("tushita | lighting torch " .. tostring(i) .. "/5")
				EquipTool("Holy Torch")
				Tween(workspace.Map.Turtle.QuestTorches["Torch" .. tostring(i)].Particles.Main.Enabled, 350).Completed:Wait()
			end
		end
	end
end

local c = 0
local function AutoChest()
	local m = workspace.Map:GetDescendants()
	local h = Character:FindFirstChild("Humanoid") or false
	for i = 1, #m do
		local v = m[i]
		if v:IsA("BasePart") and v.Name:find("Chest") and (v.Name:match("%d+") or v.Name:find("Frag")) and v.CanTouch then
			if (function() for _, v in {Character, LocalPlayer.Backpack} do for _, v2 in v:GetChildren() do if v2.Name == "God's Chalice" or v2.Name == "Fist of Darkness" or v2.Name == "Sweet Chalice" then
								return true
							end
						end
					end
					return false
				end)()
			then
				break
			end
			if c >= 10 then
				c = 0
				h.Health = 0
			else
				if Character.PrimaryPart and Character:FindFirstChildOfClass("Humanoid") then
					if Character.Humanoid.Health > 0 then
						Character:SetPrimaryPartCFrame(v.CFrame * CFrame.new(0, 2, 0))
						c = c + 1
					end
				end
			end
			task.wait(0.2)
		end
	end
end

local function CheckHakiLegendInTitles(NAME_HAKI)
	local res, kl = pcall(function()
		CommF_:InvokeServer("getTitles")
	end)
	if not res or not kl or typeof(kl) ~= "table" then
		return false
	end
	local gg = kl[NAME_HAKI]
	if not gg then
		return false
	end
	for _, v in kl do
		if v.Unlocked and v.Description and v.Description:find(gg) then
			return true
		end
	end
	return false
end

local function GetTitle(title)
	local a = CommF_:InvokeServer("getTitles") or {}
	for _, v in a do
		if v.InternalName == title and v.Name ~= "(LOCKED)" then
			return true
		end
	end
	return false
end

SWAN_KILLED = false
if GetTitle("Heavenly Devil") then
	SWAN_KILLED = true
end
local function GetSwanKilled()
	return SWAN_KILLED
end

task.spawn(function()
	for _, v in {"EASTEREXP", "BANEXPLOIT", "NOMOREHACKS", "WildDares", "BossBuild", "GetPranked", "EARN_FRUITS", "Sub2UncleKizaru", "FIGHT4FRUIT", "kittgaming", "TRIPLEABUSE", "Sub2CaptainMaui", "Sub2Fer999", "Enyu_is_Pro", "Magicbus", "JCWK", "Starcodeheo", "Bluxxy", "SUB2GAMERROBOT_EXP1", "Sub2NoobMaster123", "Sub2Daigrock", "Axiore", "TantaiGaming", "StrawHatMaine", "Sub2OfficialNoobie", "TheGreatAce", "SEATROLLIN", "24NOADMIN", "ADMIN_TROLL", "NEWTROLL", "SECRET_ADMIN", "staffbattle", "NOEXPLOIT", "NOOB2ADMIN", "CODESLIDE", "fruitconcepts"} do
		ReplicatedStorage.Remotes.Redeem:InvokeServer(v)
	end
end)

task.spawn(function()
	while task.wait() do
		if LocalPlayer.Data.Points.Value > 0 then
			local Melee = LocalPlayer.Data.Stats.Melee.Level.Value
			local Defense = LocalPlayer.Data.Stats.Defense.Level.Value
			local Sword = LocalPlayer.Data.Stats.Sword.Level.Value
			CommF_:InvokeServer("AddPoint","Melee",LocalPlayer.Data.Level.Value * 2 - Melee)
			CommF_:InvokeServer("AddPoint","Defense",LocalPlayer.Data.Level.Value - Defense)
			if Melee == MaxLevel and Defense == MaxLevel then
				CommF_:InvokeServer("AddPoint","Sword",LocalPlayer.Data.Level.Value * 3 - MaxLevel * 2)
			end
		end
	end
end)

CAN_SPAWN_CAKE_PRINCE = true
task.spawn(function()
	while World.Sea3() do
		if CAN_SPAWN_CAKE_PRINCE then
			CommF_:InvokeServer("CakePrinceSpawner")
		end
		if GetMaterial("Bones") >= 50 then
			CommF_:InvokeServer("Bones", "Buy", 1, 1)
		end
		task.wait(0.5)
	end
end)

-- print("initialized")
task.spawn(function()
    -- print("main loop started")
	while task.wait() do
		if MeleeKaitunLogic() then
			continue
		end
		if Config.CursedDualKatana and (function() local b = 0 for i in {"Tushita", "Yama"} do if CheckItem(i) then
						LoadItem(i, "Sword")
						for _, v in {LocalPlayer.Backpack, Character} do
							if v.Name == i and v.ToolTip == "Sword" and v.Level.Value >= 350 then
								b = b + 1
							end
						end
					end
				end
				return b
			end)() == 2
			and LocalPlayer.Data.Level.Value >= 2200
		then
            LogChange("main_mode", "mode: cursed dual katana")
			GetCDKLogic()
		elseif Config.Saber and LocalPlayer.Data.Level.Value >= 200 and not CheckItem("Saber") then
            LogChange("main_mode", "mode: saber")
			GetSaber()
		elseif World.Sea3() and ( (HasItem("Sweet Chalice") or HasItem("Sweet Chalice")) or (function() for _, v in {workspace.Enemies, ReplicatedStorage} do for _, v2 in v:GetChildren() do if v2.Name:find("indra") or v2.Name:find("Dough King") then
								return true
							end
						end
					end
					return false
				end)()
			)
		then
            LogChange("main_mode", "mode: farm indra / dough king")
			if (function() for _, v in {workspace.Enemies, ReplicatedStorage} do for _, v2 in v:GetChildren() do if v2.Name:find("indra") or v2.Name:find("Dough King") then
								return true
							end
						end
					end
					return false
				end)()
			then
				for _, v in {workspace.Enemies, ReplicatedStorage} do
					for _, v2 in v:GetChildren() do
						if (v2.Name:find("indra") or v2.Name:find("Dough King")) and v2:FindFirstChildOfClass("Humanoid") then
							return KillMonster(v2.Name)
						end
					end
				end
			elseif HasItem("Sweet Chalice") then
				local msg = CommF_:InvokeServer("CakePrinceSpawner")
				if type(msg) == "string" and msg:find("defeat") then
					pcall(FarmKataLogic)
				end
			elseif HasItem("God's Chalice") then
				if (function() local b = 0 pcall(function() for _, v in workspace.Map["Boat Castle"].Summoner:GetChildren() do if v:IsA("Part") and v.Name == "Part" then
									if v.Color ~= Color3.fromRGB(99, 95, 98) then
										b = b + 1
									end
								end
							end
						end)
						return b
					end)() == 3
				then
					if not Character:FindFirstChild("God's Chalice") then
                        LogChange("chalice_stage", "chalice: summoning boss")
                        SetStatus("chalice | summoning boss")
						EquipTool("God's Chalice")
					end
					pcall(firetouchinterest, workspace.Map["Boat Castle"].Summoner.Detection, Character.PrimaryPart)
				else
					if GetMaterial("Conjured Cocoa") >= 10 then
						CommF_:InvokeServer("SweetChaliceNpc")
					else
						pcall(FarmMaterial, "Conjured Cocoa")
					end
				end
			end
		elseif LocalPlayer.Data.Level.Value >= 850 and not CheckItem("Warrior Helmet") then
            LogChange("main_mode", "mode: bartilo quest")
			DoBartiloQuest()
		elseif Config.RaceV3 and LocalPlayer.Data.Level.Value >= 850 and LocalPlayer.Data.Beli.Value >= 500000 and GetRaceGrade() == "V1" and CheckItem("Warrior Helmet") then
            LogChange("main_mode", "mode: race v2")
			DoRaceV2()
		elseif Config.RaceV3 and (LocalPlayer.Data.Level.Value >= 1000) and (LocalPlayer.Data.Beli.Value >= 2000000) and GetRaceGrade() == "V2" and GetSwanKilled() then
            LogChange("main_mode", "mode: race v3")
			DoRaceV3()
		elseif Config.CursedDualKatana and World.Sea3() and GetElite() then
            LogChange("main_mode", "mode: farm elite")
			pcall(function()
				for _, v2 in {workspace.Enemies, ReplicatedStorage} do
					for _, v in v2:GetChildren() do
						if v:IsA("Model") and v:GetAttribute("Level") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
							if table.find({"Tyrant of the Skies", "Diablo", "Urban", "Deandre"}, v.Name) then
								if QuestController.CurrentQuest:find(v.Name) then
									return KillMonster(v.Name)
								else
									CommF_:InvokeServer("EliteHunter")
								end
							end
						end
					end
				end
			end)
		elseif Config.SkullGuitar and LocalPlayer.Data.Level.Value >= 2300 then
            LogChange("main_mode", "mode: skull guitar")
			GetSG()
		elseif World.Sea3() and GetCastleRaid() and false then
			SetStatus("farm castle raid")
			if LocalPlayer:DistanceFromCharacter(Vector3.new(-5000, 350, -3035)) > 700 then
				CommF_:InvokeServer("requestEntrance", Vector3.new(-5000, 350, -3035))
			end
			for _, v in workspace.Enemies:GetChildren() do
				if v.PrimaryPart and v:FindFirstChild("Humanoid") and LocalPlayer:DistanceFromCharacter(v.WorldPivot.Position) <= 700 then
					repeat
						task.wait()
						EquipWeapon()
						Tween(v:GetPivot() * CFrame.new(0, 20, 10), 350)
						Attack()
					until not v or not v.PrimaryPart or not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0
				end
				break
			end
		elseif World.Sea2() and workspace.Enemies:FindFirstChild("Factory") and false then
			SetStatus("farm factory")
			local coreEnemy = workspace.Enemies:FindFirstChild("Core")
			if coreEnemy and coreEnemy.Humanoid.Health > 0 then
				repeat
					task.wait()
					EquipWeapon()
					Tween(coreEnemy.HumanoidRootPart.CFrame, 300)
					Attack()
				until coreEnemy.Humanoid.Health <= 0
			end
		elseif Config.CursedDualKatana and CheckYama() >= 30 and not CheckItem("Yama") then
            LogChange("main_mode", "mode: get yama")
			SetStatus("yama | unlocking")
			GetYama()
		elseif Config.CursedDualKatana and World.Sea3() and not CheckItem("Tushita") and CheckMonster("rip_indra") then
            LogChange("main_mode", "mode: get tushita")

			GetTushita()
		elseif LocalPlayer.Data.Level.Value >= 700 and World.Sea1() then
            LogChange("main_mode", "mode: unlock second sea")
			UnlockSecondSea()
		elseif LocalPlayer.Data.Level.Value >= 1500 and World.Sea2() then
            LogChange("main_mode", "mode: unlock third sea")
			UnlockThirdSea()
		elseif World.Sea2() and CheckMonster("Darkbeard") then
			KillMonster("Darkbeard")
		else
            LogChange("main_mode", "mode: farm level")
            if not title.Text:find("^farm |") then
                SetStatus("farm level | level " .. tostring(LocalPlayer.Data.Level.Value))
            end
			if World.Sea2() then
				if HasItem("Hidden Key") and not CheckItem("Rengoku") then
					EquipTool("Hidden Key")
					Tween(CFrame.new(6571, 298, -6967), 300).Completed:Wait()
					task.wait(1)
				elseif HasItem("Library Key") and workspace.Map.IceCastle.Hall.LibraryDoor.PhoeyuDoor.Transparency == 0 then
					CommF_:InvokeServer("OpenLibrary")
					task.wait(1)
				elseif HasItem("Water Key") and CommF_:InvokeServer("BuySharkmanKarate", true):find("lost") then
					if TweenToMeleeBuyer("SharkmanKarate") then
						CommF_:InvokeServer("BuySharkmanKarate", true)
						CommF_:InvokeServer("BuySharkmanKarate")
					end
				end
			elseif World.Sea3() then
				if HasItem("Fire Essence") and CommF_:InvokeServer("BuyDragonTalon", true):find("your") then
					if TweenToMeleeBuyer("DragonTalon") then
						CommF_:InvokeServer("BuyDragonTalon", true)
						CommF_:InvokeServer("BuyDragonTalon")
					end
				end
			end
			if LocalPlayer.Data.Level.Value == MaxLevel then
				pcall(FarmKataLogic)
			else
				pcall(FarmLevelLogic)
			end
		end
	end
end)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

local Settings = {
    PC = {
        FillTransparency = 0.65,
        OutlineTransparency = 0
    },
    Mobile = {
        FillTransparency = 0.75,
        OutlineTransparency = 0
    }
}

local function ApplyHighlight(Character)
    if not Character then return end

    local Highlight = Character:FindFirstChild("RUNIN_Highlight")

    if not Highlight then
        Highlight = Instance.new("Highlight")
        Highlight.Name = "RUNIN_Highlight"
        Highlight.Parent = Character
    end

    local Config = UserInputService.TouchEnabled
        and not UserInputService.KeyboardEnabled
        and Settings.Mobile
        or Settings.PC

    Highlight.Adornee = Character
    Highlight.FillColor = Color3.fromRGB(0, 255, 0)
    Highlight.FillTransparency = Config.FillTransparency
    Highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
    Highlight.OutlineTransparency = Config.OutlineTransparency
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.Enabled = true
end

Player.CharacterAdded:Connect(function(Character)
    task.wait(0.5)
    ApplyHighlight(Character)
end)

task.spawn(function()
    while task.wait(1) do
        local Character = Player.Character
        if Character and Character.Parent then
            ApplyHighlight(Character)
        end
    end
end)

if Player.Character then
    ApplyHighlight(Player.Character)
end
