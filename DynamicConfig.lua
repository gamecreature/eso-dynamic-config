--[[==========================================
	DynamicConfig
	==========================================
	Dynamicly downscale graphics quality when in combat. 
	For a smooter combat response with a graphicly pleasing world while exploring.
  ]]--

DynamicConfig = {}
DynamicConfig.name = "DynamicConfig"
DynamicConfig.command = "/dynconf"
DynamicConfig.versionString = "v1.0.5"
DynamicConfig.versionSettings = 2
DynamicConfig.versionBuild = 0


local LAM = LibStub:GetLibrary("LibAddonMenu-1.0")
local PanelName = "Dynamic Config Settings"
local menus = {}

ZO_CreateStringId("SI_BINDING_NAME_DYN_UP", "DYN UP")
ZO_CreateStringId("SI_BINDING_NAME_DYN_DOWN", "DYN DOWN")

DynamicConfig.defaultSettings = {
	high = {
		SUB_SAMPLING = 2,
		AMBIENT_OCCLUSION = 1,
		ANTI_ALIASING_v2 = 1,
		BLOOM = 1,
		PARTICLE_DENSITY = 2,
		VIEW_DISTANCE = 1.0,
		CLUTTER_2D = 1		-- This is grass :)
		-- SHADOWS = 1,
		-- HIGH_RESOLUTION_SHADOWS = 1,
		-- REFLECTION_QUALITY_v3 = 1,
		-- LENS_FLARE = 1,
		-- GOD_RAYS_v2 = 1,
		-- MAX_ANISOTROPY = 2
		-- DIFFUSE_2_MAPS = 1,
		-- DETAIL_MAPS = 1,
		-- NORMAL_MAPS = 1,
		-- SPECULAR_MAPS=  1
	},
	low = {
		SUB_SAMPLING = 0,
		AMBIENT_OCCLUSION = 0,
		ANTI_ALIASING_v2 = 0,
		BLOOM = 0,
		PARTICLE_DENSITY = 0,
		VIEW_DISTANCE = 0.7,
		CLUTTER_2D = 0		-- This is grass :)
		-- SHADOWS = 0,
		-- HIGH_RESOLUTION_SHADOWS = 0,
		-- REFLECTION_QUALITY_v3 = 0,
		-- LENS_FLARE = 0,
		-- GOD_RAYS_v2 = 0,
		-- MAX_ANISOTROPY = 0
		-- DIFFUSE_2_MAPS = 0,
		-- DETAIL_MAPS = 0,
		-- NORMAL_MAPS = 0,
		-- SPECULAR_MAPS = 0
	},
	auto = true,
	enableOutput = true,
	debugOutput = false,
	AdditionalVars = false,
}

function DynamicConfig.SetDynamicVars()
	if not DynamicConfig.settings.AdditionalVars then
		DynamicConfig.vars = {
			SUB_SAMPLING = 2,
			AMBIENT_OCCLUSION = 1,
			ANTI_ALIASING_v2 = 1,
			BLOOM = 1,
			PARTICLE_DENSITY = 2,
			VIEW_DISTANCE = 1.0,
			CLUTTER_2D = 1		-- This is grass :)
			-- SHADOWS = 1,
			-- HIGH_RESOLUTION_SHADOWS = 1,
			-- REFLECTION_QUALITY_v3 = 1,
			-- LENS_FLARE = 1,
			-- GOD_RAYS_v2 = 1,
			-- MAX_ANISOTROPY = 2
			-- DIFFUSE_2_MAPS = 1,
			-- DETAIL_MAPS = 1,
			-- NORMAL_MAPS = 1,
			-- SPECULAR_MAPS=  1
		}
	else
		DynamicConfig.vars = {
			SUB_SAMPLING = 2,
			AMBIENT_OCCLUSION = 1,
			ANTI_ALIASING_v2 = 1,
			BLOOM = 1,
			PARTICLE_DENSITY = 2,
			VIEW_DISTANCE = 1.0,
			CLUTTER_2D = 1,		-- This is grass :)
			-- SHADOWS = 1,
			-- HIGH_RESOLUTION_SHADOWS = 1,
			-- REFLECTION_QUALITY_v3 = 1,
			-- LENS_FLARE = 1,
			GOD_RAYS_v2 = 1,
			MAX_ANISOTROPY = 2,
			-- DIFFUSE_2_MAPS = 1,
			-- DETAIL_MAPS = 1,
			-- NORMAL_MAPS = 1,
			SPECULAR_MAPS =  1,
			DISTORTION = 1,
			WATER_FOAM = 1,
			MIP_LOAD_SKIP_LEVELS = 0,
			RAIN_WETNESS = 1,
			
		}
	end
end

--[[==========================================
	Initialize
	==========================================]]--
function DynamicConfig.Initialize( eventCode, addOnName )

	-- Only set up for DynamicConfig
	if ( addOnName ~= DynamicConfig.name ) then
		return
	end
	
	EVENT_MANAGER:RegisterForEvent( DynamicConfig.name, EVENT_PLAYER_COMBAT_STATE, DynamicConfig.CombatStateEvent );	
	SLASH_COMMANDS[DynamicConfig.command] = DynamicConfig.SlashCommands;
	
	DynamicConfig.settings = ZO_SavedVars:NewAccountWide( "DynamicConfig_SavedVariables" , DynamicConfig.versionSettings, nil, DynamicConfig.defaultSettings, nil );
	
	if DynamicConfig.settings.AdditionalVars == nil then
		DynamicConfig.settings.AdditionalVars = false
	end
	DynamicConfig.SetDynamicVars()	

	menus[PanelName] = { Key = PanelName.."Panel", Name = PanelName}
	menus[PanelName].ID = LAM:CreateControlPanel(menus[PanelName].Key, menus[PanelName].Name)
	LAM:AddHeader(menus[PanelName].ID, "DynamicConfigHeader", "Dynamic Config Settings")

	LAM:AddButton(menus[PanelName].ID, "DynamicConfigActivateHighBtn", "Activate High", nil, function() DynamicConfig.Apply("high"); end)
	LAM:AddButton(menus[PanelName].ID, "DynamicConfigActivateLowBtn", "Activate Low", nil, function() DynamicConfig.Apply("low"); end)

	LAM:AddCheckbox(menus[PanelName].ID, "DynamicConfigAutoCombatTracking", "Enable Auto Combat Tracking", nil, function() return DynamicConfig.settings.auto; end, function(val) DynamicConfig.settings.auto = val; end)
	LAM:AddCheckbox(menus[PanelName].ID, "DynamicConfigEnableOutput", "Enable Output", nil, function() return DynamicConfig.settings.enableOutput; end, function(val) DynamicConfig.settings.enableOutput = val; end)
	LAM:AddCheckbox(menus[PanelName].ID, "DynamicConfigEnableDebugOutput", "Enable Debugging Output", nil, function() return DynamicConfig.settings.debugOutput; end, function(val) DynamicConfig.settings.debugOutput = val; end)
	LAM:AddCheckbox(menus[PanelName].ID, "DynamicConfigEnableAdditionalVarsBox", "Enable Additional Variables", nil, function() return DynamicConfig.settings.AdditionalVars; end, function(val) DynamicConfig.settings.AdditionalVars = val; DynamicConfig.SetDynamicVars(); end)

	LAM:AddButton(menus[PanelName].ID, "DynamicConfigSaveHighBtn", "Save current as High", nil, function() DynamicConfig.Save("high"); end)
	LAM:AddButton(menus[PanelName].ID, "DynamicConfigSaveLowBtn", "Save current as Low", nil, function() DynamicConfig.Save("low"); end)

end

-- Hook initialization onto the ADD_ON_LOADED event
EVENT_MANAGER:RegisterForEvent( DynamicConfig.name, EVENT_ADD_ON_LOADED, DynamicConfig.Initialize )


--[[==========================================
	Combat event listener
	==========================================]]--
function DynamicConfig.CombatStateEvent( eventCode, inCombat )
	if not DynamicConfig.settings.auto then
		return
	end
	
	if ( inCombat == true ) then
		DynamicConfig.Apply("low")
	else
		DynamicConfig.Apply("high")
	end

end


--[[==========================================
	Save the current variables
	==========================================]]--
function DynamicConfig.Save( mode ) 
	if DynamicConfig.settings.debugOutput then
		d("Save configuration "..mode)
		d("---------------------------")
	end
	for name, v in pairs(DynamicConfig.vars) do
		local val = GetCVar(name)
		DynamicConfig.settings[mode][name] = val
		if DynamicConfig.settings.debugOutput then
			d("-"..name.."="..val)
		end
	end	
end


--[[==========================================
	Applies the variables
	==========================================]]--
function DynamicConfig.Apply(mode) 
	if DynamicConfig.settings.enableOutput then 
		CHAT_SYSTEM:AddMessage("Apply configuration "..mode )
	end
	for name, v in pairs(DynamicConfig.vars) do
		local value = DynamicConfig.settings[mode][name]
		if( value ) then
			SetCVar(name,value)
		end
	end	
end

--[[==========================================
	Show the configuration
	==========================================]]--
function DynamicConfig.Show(mode)
	CHAT_SYSTEM:AddMessage("Show configuration "..mode)	
	CHAT_SYSTEM:AddMessage("---------------------------")
	for name, v in pairs(DynamicConfig.vars) do
		local value = DynamicConfig.settings[mode][name]
		if( value ) then
			CHAT_SYSTEM:AddMessage("-"..name.."="..value)
		end
	end	
end


--[[==========================================
	Print current settings to chat window (debugging)
	==========================================]]--
function DynamicConfig.showCur()
	CHAT_SYSTEM:AddMessage("Current Graphics Config")
	CHAT_SYSTEM:AddMessage("-----------------------")
	for name, v in pairs(DynamicConfig.vars) do
		CHAT_SYSTEM:AddMessage( "-"..name .. " = " .. GetCVar(name) )
	end	
end

--[[==========================================
	Shows all settings
	==========================================]]--
function DynamicConfig.ShowAll()
	CHAT_SYSTEM:AddMessage("All stored configurations")	
	CHAT_SYSTEM:AddMessage("=========================")
	DynamicConfig.Show( "high" )
	DynamicConfig.Show( "low" )
end


function DynamicConfig.SlashCommands( text )

	if ( text == "" ) then
		CHAT_SYSTEM:AddMessage( "DynamicConfig " .. DynamicConfig.versionString )
		CHAT_SYSTEM:AddMessage( "Command line options: /dynconf [command] " )		
		CHAT_SYSTEM:AddMessage( "/dynconf save high  (save the current settings as high quality settings)" )
		CHAT_SYSTEM:AddMessage( "/dynconf save low   (save the current settings as low quality settings)" )
		CHAT_SYSTEM:AddMessage( "/dynconf show high  (shows the high settings)" )
		CHAT_SYSTEM:AddMessage( "/dynconf show low   (shows the low settings)" )
		CHAT_SYSTEM:AddMessage( "/dynconf show cur   (shows the current settings)" )
		CHAT_SYSTEM:AddMessage( "/dynconf show       (shows all settings)" )
		CHAT_SYSTEM:AddMessage( "/dynconf up         " )
		CHAT_SYSTEM:AddMessage( "/dynconf down " )
		return
	end

	if ( text == "up" or text == "high") then
		DynamicConfig.Apply("high")
		return
	end
	
	if ( text == "down" or text == "low" ) then
		DynamicConfig.Apply("low")
		return
	end

	if ( text == "save high" ) then
		DynamicConfig.Save( "high" ) 	
		return
	end

	if ( text == "save low" ) then
		DynamicConfig.Save( "low" )
		return
	end


	if ( text == "show high" ) then
		DynamicConfig.Show( "high" ) 	
		return
	end

	if ( text == "show low" ) then
		DynamicConfig.Show( "low" )
		return
	end
	
	if ( text == "show cur" ) then
		DynamicConfig.showCur()
		return
	end

	if ( text == "show" ) then
		DynamicConfig.ShowAll()
		return
	end

end

function DYNUP()
    DynamicConfig.Apply("high")
end

function DYNDOWN()
    DynamicConfig.Apply("low")
end