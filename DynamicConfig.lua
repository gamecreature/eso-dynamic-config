--[[==========================================
	DynamicConfig
	==========================================
	Dynamicly downscale graphics quality when in combat. 
	For a smooter combat response with a graphicly pleasing world while exploring.
  ]]--

DynamicConfig = {}
DynamicConfig.name = "DynamicConfig"
DynamicConfig.command = "/dynconf"
DynamicConfig.versionString = "v1.1.0"
DynamicConfig.versionSettings = 2
DynamicConfig.versionBuild = 0
DynamicConfig.highCallCount = 0
DynamicConfig.currentMode = "high"
DynamicConfig.combatState = false
DynamicConfig.Constants = {
	ALPHA = 12, -- Should probably never be used
	AMBIENT_OCCLUSION = 33,
    ANAGLYPH = 38, -- No idea what it's for
	ANTI_ALIASING_v2 = 34, -- Not sure if this is correct!
	--ANTI_ALIASING = 34, -- probably a duplicate of the above?
	BLOOM = 24,
	CHARACTER_LIGHTING = 10,
	CLUTTER_2D = 46, -- This is grass
	COLOR_CORRECTION = 28,
	COLOR_GRADING = 60,
	COLOR_PICKER = 39,
	CUBE_LIGHTING = 8,
	DEPTH_OF_FIELD = 23,
	DETAIL_MAPS = 5,
	DIFFUSE_2_MAPS = 6,
	DIFFUSE_MAPS = 2,
	DISTORTION = 22,
	DQ_SKINNING = 36,
	DRAW_BAD_FIXTURES = 18,
	FADER = 29,
	FOG = 40,
	FRESNEL = 7,
	FULLSCREEN = 26, -- This one is most likely useless seeing as it'll  require a reload, and why would you want to change this while in combat?!
	GAMMA_ADJUSTMENT = 58, -- Probably pointless
	GLOW = 13,
	GOD_RAYS_v2 = 35,
	--GOD_RAYS = 35, -- Probably a duplicate of the above?
	GRAPHICS_DEBUG_VIEW = 31,
	GRAY_DIFFUSE = 15,
	HIGH_RESOLUTION_SHADOWS = 53,
	LENS_FLARE = 41,
	MAX_ANISOTROPY = 30,
	MIP_LOAD_SKIP_LEVELS = 19,
	NO_CHARACTER_ATLAS = 51,
	NORMAL_MAPS = 4,
	OCCLUSION_QUERIES = 21,
	PARTICLE_DENSITY = 48,
	POINT_SAMPLING = 56,
	POST_PROCESS_PANELS = 32,
	PRESETS = 25, -- probably useless?
	RAIN_WETNESS = 42,
	REFLECTION_QUALITY_v3 = 37,	
	--REFLECTION_QUALITY = 37, -- Probably a duplicate of the above?
	RESOLUTION = 49, -- Probably pointless, why would you want to change the resolution while in combat?! this also probably requires a reload...
	SCREEN_PERCENTAGE = 43, -- probably useless
	SHADOWS = 0,
	SHOW_ART_METRICS = 17,
	SIMPLE_SHADERS = 44,
	SKINNING = 14,
	SOFT_ALPHA = 59,
	SPECULAR_MAPS =  3,
	SUB_SAMPLING = 45,
	SUN_LIGHTING = 9,
	TEXTURE_POOLING = 52,
	TINT_MAPS = 57,
	VERTEX_COLORS = 11,
	VIEW_DISTANCE = 1,
	VIEW_SHADER_CHANNEL = 47,
	VSYNC = 27,
	WATER_FOAM = 16,
	WATERMARK = 54,
	WEAPONS_IN_ATLAS = 55,
	WIREFRAME = 20,
	Z_PREPASS = 50,
}

ZO_CreateStringId("SI_BINDING_NAME_DYN_UP", "DYN UP")
ZO_CreateStringId("SI_BINDING_NAME_DYN_DOWN", "DYN DOWN")
ZO_CreateStringId("SI_BINDING_NAME_DYN_AUTO", "DYN AUTO")

DynamicConfig.defaultSettings = {
	high = {
		SUB_SAMPLING = 2,
		AMBIENT_OCCLUSION = 1,
		ANTI_ALIASING_v2 = 1,
		BLOOM = 1,
		PARTICLE_DENSITY = 2,
		VIEW_DISTANCE = 1.0,
		CLUTTER_2D = 1
	},
	low = {
		SUB_SAMPLING = 0,
		AMBIENT_OCCLUSION = 0,
		ANTI_ALIASING_v2 = 0,
		BLOOM = 0,
		PARTICLE_DENSITY = 0,
		VIEW_DISTANCE = 0.7,
		CLUTTER_2D = 0
	},
	auto = true, -- Enable auto combat
	enableOutput = true, -- Enable output
	debugOutput = false, -- Disable Debug Output
	RefreshApply = true, -- Refresh and Apply settings upon changing mode
	switchBackTime = 2000,    -- wait two seconds to switch back
	SystemID = 5 -- Default to SystemID 5 (works for Swizzy)
	
}

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
	
	if (DynamicConfig.settings.SystemID == nil) then
		DynamicConfig.settings.SystemID = 5
	end
	zo_callLater(DynamicConfig.SetupSettingsMenu, 1000)
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
		DynamicConfig.isHigh = false
		DynamicConfig.combatState = true
	else
		DynamicConfig.combatState  = false		
		DynamicConfig.highCallCount = DynamicConfig.highCallCount + 1
		if DynamicConfig.settings.debugOutput then
			d("shedule high.."..DynamicConfig.highCallCount .. "("..DynamicConfig.settings.switchBackTime.."ms)")
		end
		zo_callLater( DynamicConfig.ApplyHigh, DynamicConfig.settings.switchBackTime )
	end

end

--[[==========================================
	Applies the high item
	==========================================]]--
function DynamicConfig.ApplyHigh()
	if DynamicConfig.settings.debugOutput then
		d("high call "..DynamicConfig.highCallCounWt)
	end
	DynamicConfig.highCallCount = DynamicConfig.highCallCount - 1
	if DynamicConfig.highCallCount == 0 and not DynamicConfig.combatState then
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
	for name, v in pairs(DynamicConfig.settings.vars) do
		--if v then
			--local val = GetCVar(name)
			local val = GetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name])
			DynamicConfig.settings[mode][name] = val
			if DynamicConfig.settings.debugOutput then
				d("-"..name.."="..val)
			end
		--end
	end	
end


--[[==========================================
	Applies the variables
	==========================================]]--
function DynamicConfig.Apply(mode, override)
	if override == nil or override == false then
		if DynamicConfig.currentMode == mode then
			return
		end
	end
	DynamicConfig.currentMode = mode


	if DynamicConfig.settings.enableOutput then 
		CHAT_SYSTEM:AddMessage("Apply configuration "..mode )
	end
	for name, v in pairs(DynamicConfig.settings.vars) do
		if v then
			local val = DynamicConfig.settings[mode][name]			
			if val ~= nil then
				--SetCVar(name , val)
				SetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name], val)
			end
		end
	end
	if DynamicConfig.settings.RefreshApply then
		RefreshSettings()
		ApplySettings()
	end
end

--[[==========================================
	Show the configuration
	==========================================]]--
function DynamicConfig.Show(mode)
	CHAT_SYSTEM:AddMessage("Show configuration "..mode)	
	CHAT_SYSTEM:AddMessage("---------------------------")
	for name, v in pairs(DynamicConfig.settings.vars) do
		if v then
			local val = DynamicConfig.settings[mode][name]			
			if (val) then
				CHAT_SYSTEM:AddMessage("-"..name.."="..val)
			end
		end
	end	
end


--[[==========================================
	Print current settings to chat window (debugging)
	==========================================]]--
function DynamicConfig.showCur()
	CHAT_SYSTEM:AddMessage("Current Graphics Config")
	CHAT_SYSTEM:AddMessage("-----------------------")
	for name, v in pairs(DynamicConfig.settings.vars) do
		if v then
			local val = GetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name])
			if (val ~= nil) then
				CHAT_SYSTEM:AddMessage( "-"..name .. " = " .. val )
			end
		end
	end	
end

--[[==========================================
	Shows all settings
	==========================================]]--
function DynamicConfig.ShowAll()
	CHAT_SYSTEM:AddMessage("All stored configurations")	
	CHAT_SYSTEM:AddMessage("=========================")
	DynamicConfig.Show("high")
	DynamicConfig.Show("low")
end


function DynamicConfig.SlashCommands( text )

	if ( text == "" ) then
		CHAT_SYSTEM:AddMessage( "DynamicConfig " .. DynamicConfig.versionString )
		CHAT_SYSTEM:AddMessage( "Command line options: /dynconf [command] " )		
		CHAT_SYSTEM:AddMessage( "/dynconf save high  (save the current settings as high quality settings)" )
		CHAT_SYSTEM:AddMessage( "/dynconf save low   (save the current settings as low quality settings)" )
		CHAT_SYSTEM:AddMessage( "/dynconf show high  (shows the high quality settings)" )
		CHAT_SYSTEM:AddMessage( "/dynconf show low   (shows the low quality settings)" )
		CHAT_SYSTEM:AddMessage( "/dynconf show cur   (shows the current settings)" )
		CHAT_SYSTEM:AddMessage( "/dynconf show       (shows all settings)" )
		CHAT_SYSTEM:AddMessage( "/dynconf auto on    (Enables auto combat tracker" )
		CHAT_SYSTEM:AddMessage( "/dynconf auto off   (Disables auto combat tracker")
		CHAT_SYSTEM:AddMessage( "/dynconf up " )
		CHAT_SYSTEM:AddMessage( "/dynconf down " )
		
		return
	end

	if ( text == "up" or text == "high") then
		DynamicConfig.Apply("high", true)
		return
	end
	
	if ( text == "down" or text == "low" ) then
		DynamicConfig.Apply("low", true)
		return
	end

	if ( text == "save high" ) then
		DynamicConfig.Save("high") 	
		return
	end

	if ( text == "save low" ) then
		DynamicConfig.Save("low")
		return
	end

	if ( text == "show high" ) then
		DynamicConfig.Show("high")
		return
	end

	if ( text == "show low" ) then
		DynamicConfig.Show("low")
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
	
	if ( text == "auto off" ) then
		DynamicConfig.settings.auto = false
		return
	end
	
	if ( text == "auto on" ) then
		DynamicConfig.settings.auto = true
		return
	end
end

function DYNUP()
    DynamicConfig.Apply("high", true)
end

function DYNDOWN()
    DynamicConfig.Apply("low", true)
end

function DYNAUTO()
    if DynamicConfig.settings.auto then
		DynamicConfig.settings.auto = false
		if DynamicConfig.settings.enableOutput then
			CHAT_SYSTEM:AddMessage("Auto combat tracker is now disabled!")
		end
	else
		DynamicConfig.settings.auto = true
		if DynamicConfig.settings.enableOutput then
			CHAT_SYSTEM:AddMessage("Auto combat tracker is now enabled!")
		end
	end
end