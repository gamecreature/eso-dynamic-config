--[[==========================================
	DynamicConfig
	==========================================
	Dynamicly downscale graphics quality when in combat. 
	For a smooter combat response with a graphicly pleasing world while exploring.
  ]]--

DynamicConfig = {}
DynamicConfig.name = "DynamicConfig"
DynamicConfig.command = "/dynconf"
DynamicConfig.versionString = "v1.0.2"
DynamicConfig.versionSettings = 1
DynamicConfig.versionBuild = 0
DynamicConfig.debugCombatSwitch = false

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
	}
}

DynamicConfig.vars = DynamicConfig.defaultSettings.high



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

end

-- Hook initialization onto the ADD_ON_LOADED event
EVENT_MANAGER:RegisterForEvent( DynamicConfig.name, EVENT_ADD_ON_LOADED, DynamicConfig.Initialize )

--[[==========================================
	Combat event listener
	==========================================]]--
function DynamicConfig.CombatStateEvent( eventCode, inCombat )
	
	if ( inCombat == true ) then
		DynamicConfig.Apply("low",DynamicConfig.debugCombatSwitch)
	else
		DynamicConfig.Apply("high",DynamicConfig.debugCombatSwitch)
	end

end


--[[==========================================
	Save the current variables
	==========================================]]--
function DynamicConfig.Save( mode ) 
	d("Save configuration "..mode)
	d("---------------------------")
	for name, v in pairs(DynamicConfig.vars) do
		val = GetCVar(name)
		DynamicConfig.settings[mode][name] = val
		d("-"..name.."="..val)
	end	
end


--[[==========================================
	Applies the variables
	==========================================]]--
function DynamicConfig.Apply( mode, loud ) 
	if loud then d("Apply configuration "..mode )	end
	-- if loud then d("--------------------------------") end
	for name, v in pairs(DynamicConfig.vars) do
		value = DynamicConfig.settings[mode][name]
		if( value ) then
			-- if loud then d("-"..name.."="..value) end
			SetCVar(name,value)
		end
	end	
end

--[[==========================================
	Show the configuration
	==========================================]]--
function DynamicConfig.Show( mode ) 
	d("Show configuration "..mode)	
	d("---------------------------")
	for name, v in pairs(DynamicConfig.vars) do
		value = DynamicConfig.settings[mode][name]
		if( value ) then
			d("-"..name.."="..value)
		end
	end	
end


--[[==========================================
	Print current settings to chat window (debugging)
	==========================================]]--
function DynamicConfig.showCur()
	-- d("<-----  Current Graphics Config  ----->")
	-- d("Sub Sampling: " .. GetCVar('SUB_SAMPLING'))
	-- d("Ambient Occlusion: " .. GetCVar('AMBIENT_OCCLUSION'))
	-- d("Anti Aliasing: " .. GetCVar('ANTI_ALIASING_v2'))
	-- d("Bloom: " .. GetCVar('BLOOM'))
	-- d("Particle Density: " .. GetCVar('PARTICLE_DENSITY'))
	-- d("View Distance: " .. GetCVar('VIEW_DISTANCE'))
	-- d("<------------------------------------->")

	d("Current Graphics Config")
	d("-----------------------")
	for name, v in pairs(DynamicConfig.vars) do
		d( "-"..name .. " = " .. GetCVar(name) )
	end	
end

--[[==========================================
	Shows all settings
	==========================================]]--
function DynamicConfig.ShowAll()
	d("All stored configurations")	
	d("=========================")
	DynamicConfig.Show( "high" )
	DynamicConfig.Show( "low" )
end


function DynamicConfig.SlashCommands( text )

	if ( text == "" ) then
		d( "DynamicConfig " .. DynamicConfig.versionString )
		d( "Command line options: /dynconf [command] " )
		d( "/dynconf save high  (save the current settings as high quality settings)" )
		d( "/dynconf save low   (save the current settings as low quality settings)" )
		d( "/dynconf show high  (shows the high settings)" )
		d( "/dynconf show low   (shows the low settings)" )
		d( "/dynconf show cur   (shows the current settings)" )
		d( "/dynconf show       (shows all settings)" )
		d( "/dynconf up         " )
		d( "/dynconf down " )
		return
	end

	if ( text == "up" or text == "high") then
		DynamicConfig.Apply("high",true)
		return
	end
	
	if ( text == "down" or text == "low" ) then
		DynamicConfig.Apply("low",true)
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

	if( text == "debug" ) then
		if ( DynamicConfig.debugCombatSwitch ) then 
			DynamicConfig.debugCombatSwitch = false
			d( "Config switch messages are disabled")
		else
			DynamicConfig.debugCombatSwitch = true
			d( "Config switch messages are enabled")
		end
	end

end
