--[[==========================================
	DynamicConfig
	==========================================
	Dynamicly downscale graphics quality when in combat. 
	For a smooter combat response with a graphicly pleasing world while exploring.
  ]]--

DynamicConfig = {}
DynamicConfig.name = "DynamicConfig"
DynamicConfig.command = "/dynconf"
DynamicConfig.versionString = "v1.0.0"
DynamicConfig.versionSettings = 1;
DynamicConfig.versionBuild = 0;


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
end

-- Hook initialization onto the ADD_ON_LOADED event
EVENT_MANAGER:RegisterForEvent( DynamicConfig.name, EVENT_ADD_ON_LOADED, DynamicConfig.Initialize )

--[[==========================================
	Configure here your high quality exploring configuration
	==========================================]]--
function DynamicConfig.qualityUp()
	SetCVar('SUB_SAMPLING',2)
	SetCVar('AMBIENT_OCCLUSION',1)
	SetCVar('ANTI_ALIASING_v2', 1)
	SetCVar('BLOOM', 1)
	SetCVar('PARTICLE_DENSITY', 3)
	SetCVar('VIEW_DISTANCE', 2.00)
	d("quality UP")
end

--[[==========================================
	Configure here your low quality combat configuration 
	==========================================]]--
function DynamicConfig.qualityDown()
	SetCVar('SUB_SAMPLING',0)
	SetCVar('AMBIENT_OCCLUSION',0)
	SetCVar('ANTI_ALIASING_v2', 0)
	SetCVar('BLOOM', 0)
	SetCVar('PARTICLE_DENSITY', 1)
	SetCVar('VIEW_DISTANCE', 1.21)
	d("quality down")
end

--[[==========================================
	Print current settings to chat window (debugging)
	==========================================]]--
function DynamicConfig.qualityGet()
	d("<-----  Current Graphics Config  ----->")
	d("Sub Sampling: " .. GetCVar('SUB_SAMPLING'))
	d("Ambient Occlusion: " .. GetCVar('AMBIENT_OCCLUSION'))
	d("Anti Aliasing: " .. GetCVar('ANTI_ALIASING_v2'))
	d("Bloom: " .. GetCVar('BLOOM'))
	d("Particle Density: " .. GetCVar('PARTICLE_DENSITY'))
	d("View Distance: " .. GetCVar('VIEW_DISTANCE'))
	d("<------------------------------------->")
end

--[[==========================================

	==========================================]]--
function DynamicConfig.CombatStateEvent( eventCode, inCombat )
	
	if ( inCombat == true ) then
		DynamicConfig.qualityDown()
	else
		DynamicConfig.qualityUp()
	end

end


function DynamicConfig.SlashCommands( text )

	if ( text == "" ) then
		d( "DynamicConfig " .. DynamicConfig.versionString );
		d( "Command line options: /dynconf up down get  :);" );
		return
	end

	if ( text == "up" ) then
		DynamicConfig.qualityUp()
		return
	end
	
	if ( text == "down" ) then
		DynamicConfig.qualityDown()
		return
	end
	
	if ( text == "get" ) then
		DynamicConfig.gualityGet()
		return
	end
	
end
