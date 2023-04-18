--[[
	Idiotbox v7
	Rewrite by AdolfRoxler -> TG NGGUH
	
	Phizz, the creator
]]
--- Changelogs ---
local Changelogs = [[
New features include:
	- Dynamic configs
]]
--- Initial Values ---
local ProtectedFilenames = {["IdiotBox_latest.lua"]=true,["IdiotBox_backup.lua"]=true,["IdiotBox_dev.lua"]=true}
local build = 700
local folder = "IdiotBox"
local self = LocalPlayer()
--- Memory setup ---
local Entities = FindMetaTable("Entity")
local Players = FindMetaTable("Player")
local Commands = FindMetaTable("CUserCmd")
local Weapons = FindMetaTable("Weapon")
local Angles = FindMetaTable("Angle")
local Vectors = FindMetaTable("Vector")
local Materials = FindMetaTable("IMaterial")
--- Event setup ---
gameevent.Listen("entity_killed")
gameevent.Listen("player_disconnect")
gameevent.Listen("player_hurt")
--- Convar ---
CreateClientConVar("idiot_changename", "www.IB4G.net | Cry, dawg!", true, false)
--- Font aliases ---
surface.CreateFont("VisualsFont", {font = "Tahoma", size = 12, antialias = false, outline = true})
surface.CreateFont("MenuFont", {font = "Tahoma", size = 12, weight = 674, antialias = false, outline = true})
surface.CreateFont("MenuFont2", {font = "Tahoma", size = 12, antialias = true, outline = true})
surface.CreateFont("MainFont", {font = "Tahoma", size = 16, weight = 1300, antialias = false, outline = false})
surface.CreateFont("MainFont2", {font = "Tahoma", size = 11, weight = 640, antialias = false, outline = true})
surface.CreateFont("MainFont3", {font = "Tahoma", size = 13, weight = 800, antialias = false, outline = true})
surface.CreateFont("MiscFont", {font = "Tahoma", size = 12, weight = 900, antialias = false, outline = true})
surface.CreateFont("MiscFont2", {font = "Tahoma", size = 12, weight = 900, antialias = false, outline = false})
surface.CreateFont("MiscFont3", {font = "Tahoma", size = 13, weight = 674, antialias = false, outline = true})
--- Creditation ---

-- PS: From Phizz' list
local Contributors = {
	["STEAM_0:0:63644275"] = "Creator",
	["STEAM_0:0:162667998"] = "Creator",
	["STEAM_0:1:126050820"] = "Ex-manager",
	
	["STEAM_0:0:196578290"] = "Code dev",
	["STEAM_0:1:193781969"] = "Code dev",
	["STEAM_0:0:109145007"] = "Code dev",
	["STEAM_0:0:205376238"] = "Code dev",
	["STEAM_0:0:158432486"] = "Code dev",
	
	["STEAM_0:1:188710062"] = "Tester",
	["STEAM_0:1:191270548"] = "Tester",
	["STEAM_0:1:404757"] = "Tester",
	["STEAM_0:1:69536635"] = "Tester",
	["STEAM_0:0:150101893"] = "Tester",
	["STEAM_0:1:75441355"] = "Tester",
	
	["STEAM_0:0:453611223"] = "Multihelper",
	
	["STEAM_0:1:59798110"] = "Advertiser",
	["STEAM_0:1:4375194"] = "Advertiser",
	
	["STEAM_0:1:101813068"] = "User #1",
}
--- Function 'speedener' ---
local V3 = Vector3
local NewCmdVar = CreateClientConVar
local typeof = type
local lowercase = string.lower
local uppercase = string.upper
--- Config ---
local DefaultConfig = {
	["general"] = {
		["optimize"] = false,
		["freecam"] = false,
		["anti-afk"] = false,
		["anti-ads"] = false,
		["ANTI-BLIND"] = false,
	},
	["esp"] = {},
	["gfuel"] = {
		["aimbot"] = {State = false},
		["triggerbot"] = {State = false, Smooth = false, AZoom = false, AStop = false, ACrouch = false},
	},
	["hvh"] = {},
	["visuals"] = {},
	["ttt"] = {
		["traitor-finder"] = false,
		["ignore-detectives"] = false,
		["ignore-traitors"] = false,
		["anti-roundreport"] = false,
		["anti-panels"] = false,
		["propkill"] = false,
	},
	["murder"] = {
		["murderer-finder"] = false,
		["anti-roundreport"] = false,
		["hide-footprints"] = false,
		["no-blackscreens"] = false,
	},
	["darkrp"] = {
		["anti-arrest"] = false,
		["prop-opacity"] = {State = false, Opacity = 1},
		["show-money"] = false,
	},
	["miscellaneous"] = {
		["custom-name"] = "",
		["tooltips"] = false,
		["panic-mode"] = false,
	},
}

local CurrentConfig = DefaultConfig
--- Config Editor [MESS] ---
local function TranslateValue(str)
	local tr = lowercase(str)
	if str=="on" or str=="true" or str==1 then tr=true
	elseif str=="off" or str=="false" or str==0 then tr=false
	end
	return tr
end

local function changeData(tabl,pathArray) --- stolen from devforum | Source: https://devforum.roblox.com/t/how-to-make-equivalent-of-instancegetfullname-for-tables/1114061
	--send pathArray to client
	local template = DefaultConfig
	for index, path in ipairs(pathArray) do
		if pathArray[index + 2]==nil then
			--if typeof(ConfigTemplate[pathArray[index + 1]])==typeof(tabl[pathArray[index + 1]]) then tabl[path] = pathArray[index + 1] end
			--if typeof(tabl[path])==typeof(ConfigTemplate[path]) then
			--print(typeof(tabl[path]),typeof(template[path]),typeof(pathArray[index + 1]))

			if typeof(pathArray[index + 1]) == typeof(template[path]) and pathArray[index + 1]~=nil and template[path]~=nil then tabl[path] = pathArray[index + 1] end
			--end
		else
			if tabl[path]==nil then
				break
			end
			if typeof(tabl[path]) == typeof(template[path]) and tabl[path]~=nil and template[path]~=nil then
				tabl = tabl[path] 
				template = template[path] else break end
		end
	end
end

concommand.Add("idiot_setvalue", function(caller, cmd, args)
	local Lego = {}
	for _,N in pairs(args) do Lego[#Lego+1] = TranslateValue(lowercase(N)) end
	changeData(CurrentConfig,Lego)
end,nil,"Manually set values within IdiotBox. You should use this inside autoexec binds for your own toggles.")
