local LAM = LibStub:GetLibrary("LibAddonMenu-1.0")
local PanelName = "Dynamic Config Settings"
local menus = {}

function DynamicConfig.SetupSettingsMenu()

	menus[PanelName] = { Key = PanelName.."Panel", Name = PanelName}
	menus[PanelName].ID = LAM:CreateControlPanel(menus[PanelName].Key, menus[PanelName].Name) -- Required (The main panel)
	LAM:AddHeader(menus[PanelName].ID, "DynamicConfigHeader", "Dynamic Config Settings") -- Required (The Header text)

	LAM:AddButton(menus[PanelName].ID, "DynamicConfigActivateHighBtn", "Activate High", nil, function()
		DynamicConfig.Apply("high")
	end) -- Activate "High" settings button
	LAM:AddButton(menus[PanelName].ID, "DynamicConfigActivateLowBtn", "Activate Low", nil, function()
		DynamicConfig.Apply("low")
	end) -- Activate "Low" settings button

	LAM:AddCheckbox(menus[PanelName].ID, "DynamicConfigAutoCombatTracking", "Enable Auto Combat Tracking", nil, function()
		return DynamicConfig.settings.auto
	end, function(val)
		DynamicConfig.settings.auto = val
	end) -- Enable Combat Tracker
	
	LAM:AddCheckbox(menus[PanelName].ID, "DynamicConfigEnableOutput", "Enable Output", nil, function() 
		return DynamicConfig.settings.enableOutput
	end, function(val)
		DynamicConfig.settings.enableOutput = val
	end) -- Enable general output
	
	LAM:AddCheckbox(menus[PanelName].ID, "DynamicConfigEnableDebugOutput", "Enable Debugging Output", nil, function()
		return DynamicConfig.settings.debugOutput
	end, function(val)
		DynamicConfig.settings.debugOutput = val
	end) -- Enable Debug output
	--LAM:AddCheckbox(menus[PanelName].ID, "DynamicConfigEnableAdditionalVarsBox", "Enable Additional Variables", nil, function() return DynamicConfig.settings.AdditionalVars; end, function(val) DynamicConfig.settings.AdditionalVars = val; DynamicConfig.SetDynamicVars(); end)
	
	menus[PanelName].SubID = LAM:AddSubMenu(menus[PanelName].ID, "DynamicConfigSubMenu", "Choose Variables to modify", "Only change these if you know what you're doing!") -- Add Submenu for the advanced users to set what variables to modify
	
	if DynamicConfig.settings.vars == nil then
		DynamicConfig.settings.vars = {
			SUB_SAMPLING = true,
			AMBIENT_OCCLUSION = true,
			ANTI_ALIASING_v2 = true,
			BLOOM = true,
			PARTICLE_DENSITY = true,
			VIEW_DISTANCE = true,
			CLUTTER_2D = true,		-- This is grass :)
			SHADOWS = false,
			HIGH_RESOLUTION_SHADOWS = false,
			REFLECTION_QUALITY_v3 = false,
			LENS_FLARE = false,
			GOD_RAYS_v2 = false,
			MAX_ANISOTROPY = false,
			DIFFUSE_2_MAPS = false,
			DETAIL_MAPS = false,
			NORMAL_MAPS = false,
			SPECULAR_MAPS =  false,
			DISTORTION = false,
			WATER_FOAM = false,
			MIP_LOAD_SKIP_LEVELS = false,
			RAIN_WETNESS = false
		}
	end	
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigSUB_SAMPLINGBox", "SUB_SAMPLING", nil, function()
		return DynamicConfig.settings.vars.SUB_SAMPLING
	end, function(val)
		DynamicConfig.settings.vars.SUB_SAMPLING = val
	end) -- Enable SUB_SAMPLING
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigAMBIENT_OCCLUSIONBox", "AMBIENT_OCCLUSION", nil, function()
		return DynamicConfig.settings.vars.AMBIENT_OCCLUSION
	end, function(val)
		DynamicConfig.settings.vars.AMBIENT_OCCLUSION = val
	end) -- Enable AMBIENT_OCCLUSION
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigANTI_ALIASING_v2Box", "ANTI_ALIASING_v2", nil, function()
		return DynamicConfig.settings.vars.ANTI_ALIASING_v2
	end, function(val)
		DynamicConfig.settings.vars.ANTI_ALIASING_v2 = val
	end) -- Enable ANTI_ALIASING_v2
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigBLOOMBox", "BLOOM", nil, function()
		return DynamicConfig.settings.vars.BLOOM
	end, function(val)
		DynamicConfig.settings.vars.BLOOM = val
	end) -- Enable BLOOM	
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigPARTICLE_DENSITYBox", "PARTICLE_DENSITY", nil, function()
		return DynamicConfig.settings.vars.PARTICLE_DENSITY
	end, function(val)
		DynamicConfig.settings.vars.PARTICLE_DENSITY = val
	end) -- Enable PARTICLE_DENSITY
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigVIEW_DISTANCEBox", "VIEW_DISTANCE", nil, function()
		return DynamicConfig.settings.vars.VIEW_DISTANCE
	end, function(val)
		DynamicConfig.settings.vars.VIEW_DISTANCE = val
	end) -- Enable VIEW_DISTANCE
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigCLUTTER_2DBox", "CLUTTER_2D", nil, function() 
		return DynamicConfig.settings.vars.CLUTTER_2D
	end, function(val)
		DynamicConfig.settings.vars.CLUTTER_2D = val
	end) -- Enable CLUTTER_2D (grass)
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigSHADOWSBox", "SHADOWS", nil, function()
		return DynamicConfig.settings.vars.SHADOWS
	end, function(val)
		DynamicConfig.settings.vars.SHADOWS = val
	end) -- Enable SHADOWS
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigHIGH_RESOLUTION_SHADOWSBox", "HIGH_RESOLUTION_SHADOWS", nil, function()
		return DynamicConfig.settings.vars.HIGH_RESOLUTION_SHADOWS
	end, function(val)
		DynamicConfig.settings.vars.HIGH_RESOLUTION_SHADOWS = val
	end) -- Enable HIGH_RESOLUTION_SHADOWS
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigREFLECTION_QUALITY_v3Box", "REFLECTION_QUALITY_v3", nil, function()
		return DynamicConfig.settings.vars.REFLECTION_QUALITY_v3
	end, function(val) 
		DynamicConfig.settings.vars.REFLECTION_QUALITY_v3 = val
	end) -- Enable REFLECTION_QUALITY_v3
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigLENS_FLAREBox", "LENS_FLARE", nil, function()
		return DynamicConfig.settings.vars.LENS_FLARE
	end, function(val)
		DynamicConfig.settings.vars.LENS_FLARE = val
	end) -- Enable LENS_FLARE
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigGOD_RAYS_v2Box", "GOD_RAYS_v2", nil, function()
		return DynamicConfig.settings.vars.GOD_RAYS_v2
	end, function(val)
		DynamicConfig.settings.vars.GOD_RAYS_v2 = val
	end) -- Enable GOD_RAYS_v2
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigMAX_ANISOTROPYBox", "MAX_ANISOTROPY", nil, function()
		return DynamicConfig.settings.vars.MAX_ANISOTROPY
	end, function(val) 
		DynamicConfig.settings.vars.MAX_ANISOTROPY = val
	end) -- Enable MAX_ANISOTROPY
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigDIFFUSE_2_MAPSBox", "DIFFUSE_2_MAPS", nil, function() 
		return DynamicConfig.settings.vars.DIFFUSE_2_MAPS
	end, function(val)
		DynamicConfig.settings.vars.DIFFUSE_2_MAPS = val
	end) -- Enable DIFFUSE_2_MAPS
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigDETAIL_MAPSBox", "DETAIL_MAPS", nil, function()
		return DynamicConfig.settings.vars.DETAIL_MAPS
	end, function(val) 
		DynamicConfig.settings.vars.DETAIL_MAPS = val
	end) -- Enable DETAIL_MAPS
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigNORMAL_MAPSBox", "NORMAL_MAPS", nil, function()
		return DynamicConfig.settings.vars.NORMAL_MAPS
	end, function(val)
		DynamicConfig.settings.vars.NORMAL_MAPS = val
	end) -- Enable NORMAL_MAPS
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigSPECULAR_MAPSBox", "SPECULAR_MAPS", nil, function()
		return DynamicConfig.settings.vars.SPECULAR_MAPS
	end, function(val) 
		DynamicConfig.settings.vars.SPECULAR_MAPS = val
	end) -- Enable SPECULAR_MAPS
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigDISTORTIONBox", "DISTORTION", nil, function()
		return DynamicConfig.settings.vars.DISTORTION
	end, function(val)
		DynamicConfig.settings.vars.DISTORTION = val
	end) -- Enable DISTORTION
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigWATER_FOAMBox", "WATER_FOAM", nil, function()
		return DynamicConfig.settings.vars.WATER_FOAM
	end, function(val)
		DynamicConfig.settings.vars.WATER_FOAM = val
	end) -- Enable WATER_FOAM
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigMIP_LOAD_SKIP_LEVELSBox", "MIP_LOAD_SKIP_LEVELS", nil, function()
		return DynamicConfig.settings.vars.MIP_LOAD_SKIP_LEVELS
	end, function(val)
		DynamicConfig.settings.vars.MIP_LOAD_SKIP_LEVELS = val
	end) -- Enable MIP_LOAD_SKIP_LEVELS
	
	LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfigRAIN_WETNESSBox", "RAIN_WETNESS", nil, function()
		return DynamicConfig.settings.vars.RAIN_WETNESS
	end, function(val) 
		DynamicConfig.settings.vars.RAIN_WETNESS = val
	end) -- Enable RAIN_WETNESS
	
	LAM:AddButton(menus[PanelName].ID, "DynamicConfigSaveHighBtn", "Save current as High", nil, function()
		DynamicConfig.Save("high")
	end) -- Save "High" settings button
	
	LAM:AddButton(menus[PanelName].ID, "DynamicConfigSaveLowBtn", "Save current as Low", nil, function()
		DynamicConfig.Save("low")
	end) -- Save "Low" settings button
end