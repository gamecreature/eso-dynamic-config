local LAM = LibStub:GetLibrary("LibAddonMenu-1.0")
local PanelName = "Dynamic Config Settings"
local menus = {}

local BoolVariables = {
	ALPHA = false, -- Should probably never be used
	AMBIENT_OCCLUSION = false,
	ANAGLYPH = false,
	ANTI_ALIASING_v2 = false,
	BLOOM = false,
	CHARACTER_LIGHTING = false,
	CLUTTER_2D = false, -- This is grass
	COLOR_CORRECTION = false,
	COLOR_GRADING = false,
	COLOR_PICKER = false,
	CUBE_LIGHTING = false,
	DEPTH_OF_FIELD = false,
	DETAIL_MAPS = false,
	DIFFUSE_2_MAPS = false,
	DIFFUSE_MAPS = false,
	DISTORTION = false,
	DQ_SKINNING = false,
	DRAW_BAD_FIXTURES = false,
	FADER = false,
	FOG = false,
	FRESNEL = false,
	GLOW = false,
	GOD_RAYS_v2 = false,
	GRAPHICS_DEBUG_VIEW = false,
	GRAY_DIFFUSE = false,
	HIGH_RESOLUTION_SHADOWS = false, -- Boolean value which makes your shadow look nicer
	LENS_FLARE = false,
	MAX_ANISOTROPY = false,
	NO_CHARACTER_ATLAS = false,
	NORMAL_MAPS = false,
	OCCLUSION_QUERIES = false,
	PARTICLE_DENSITY = false,
	POINT_SAMPLING = false,
	POST_PROCESS_PANELS = false,
	RAIN_WETNESS = false,
	SCREEN_PERCENTAGE = false, -- probably useless
	SHOW_ART_METRICS = false,
	SIMPLE_SHADERS = false,
	SKINNING = false,
	SOFT_ALPHA = false,
	SPECULAR_MAPS =  false,	
	SUN_LIGHTING = false,
	TEXTURE_POOLING = false,
	TINT_MAPS = false,
	VERTEX_COLORS = false,
	VIEW_SHADER_CHANNEL = false,
	VSYNC = false,
	WATER_FOAM = false,
	WATERMARK = false,
	WEAPONS_IN_ATLAS = false,
	WIREFRAME = false,
	Z_PREPASS = false
}

local function SetDefaultVars(reset)
	if DynamicConfig.settings.vars == nil or reset == true then
		DynamicConfig.settings.vars = {
			ALPHA = false, -- Should probably never be used
			AMBIENT_OCCLUSION = true,
            ANAGLYPH = false,
			ANTI_ALIASING_v2 = true,
			BLOOM = true,
			CHARACTER_LIGHTING = false,
			CLUTTER_2D = true, -- This is grass
			COLOR_CORRECTION = false,
			COLOR_GRADING = false,
			COLOR_PICKER = false,
			CUBE_LIGHTING = false,
			DEPTH_OF_FIELD = false,
			DETAIL_MAPS = false,
			DIFFUSE_2_MAPS = false,
			DIFFUSE_MAPS = false,
			DISTORTION = false,
			DQ_SKINNING = false,
			DRAW_BAD_FIXTURES = false,
			FADER = false,
			FOG = false,
			FRESNEL = false,
			GAMMA_ADJUSTMENT = false, -- Probably pointless
			GLOW = false,
			GOD_RAYS_v2 = false,
			GRAPHICS_DEBUG_VIEW = false,
			GRAY_DIFFUSE = false,
			HIGH_RESOLUTION_SHADOWS = false,
			LENS_FLARE = false,
			MAX_ANISOTROPY = false,
			NO_CHARACTER_ATLAS = false,
			NORMAL_MAPS = false,
			OCCLUSION_QUERIES = false,
			PARTICLE_DENSITY = true,
			POINT_SAMPLING = false,
			POST_PROCESS_PANELS = false,
			RAIN_WETNESS = false,
			SCREEN_PERCENTAGE = false, -- probably useless
			SHOW_ART_METRICS = false,
			SIMPLE_SHADERS = false,
			SKINNING = false,
			SOFT_ALPHA = false,
			SPECULAR_MAPS =  false,
			SUB_SAMPLING = true,
			SUN_LIGHTING = false,
			TEXTURE_POOLING = false,
			TINT_MAPS = false,
			VERTEX_COLORS = false,
			VIEW_DISTANCE = true,
			VIEW_SHADER_CHANNEL = false,
			VSYNC = false,
			WATER_FOAM = false,
			WATERMARK = false,
			WEAPONS_IN_ATLAS = false,
			WIREFRAME = false,
			Z_PREPASS = false,
		}
	end
end

local function AddDropDownHigh(name, text, warn, warnmsg)
	LAM:AddDropdown(menus[PanelName].SubIDCFG, "DynamicConfigManualSetting"..name.."DropDown", text, nil, {
		"Low",
		"Medium",
		"High",
	}, function()
		local val = GetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name])
		if (val == "0") then
			return "Low"
		elseif (val == "1") then
			return "Medium"
		else
			return "High"
		end
	end, function(val)
		if (val == "Low") then
			val = "0"
		elseif (val == "Medium") then
			val = "1"
		else
			val = "2"
		end
		SetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name], val)
	end, warn, warnmsg)
end

local function AddDropDownLowUltra(name, text, warn, warnmsg)
	LAM:AddDropdown(menus[PanelName].SubIDCFG, "DynamicConfigManualSetting"..name.."DropDown", text, nil, {
		"Low",
		"Medium",
		"High",
		"Ultra",
	}, function()
		local val = GetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name])
		if (val == "0") then
			return "Low"
		elseif (val == "1") then
			return "Medium"
		elseif (val == "2") then
			return "High"
		else
			return "Ultra"
		end
	end, function(val)
		if (val == "Low") then
			val = "0"
		elseif (val == "Medium") then
			val = "1"
		elseif (val == "High") then
			val = "2"
		else
			val = "3"
		end
		SetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name], val)
	end, warn, warnmsg)
end

local function AddDropDownHighInverted(name, text, warn, warnmsg)
	LAM:AddDropdown(menus[PanelName].SubIDCFG, "DynamicConfigManualSetting"..name.."DropDown", text, nil, {
		"Low",
		"Medium",
		"High",
	}, function()
		local val = GetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name])
		if (val == "2") then
			return "Low"
		elseif (val == "1") then
			return "Medium"
		else
			return "High"
		end
	end, function(val)
		if (val == "Low") then
			val = "2"
		elseif (val == "Medium") then
			val = "1"
		else
			val = "0"
		end
		SetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name], val)
	end, warn, warnmsg)
end

local function AddDropDownOffUltra(name, text, warn, warnmsg)
	LAM:AddDropdown(menus[PanelName].SubIDCFG, "DynamicConfigManualSetting"..name.."DropDown", text, nil, {
		"Off",
		"Low",
		"Medium",
		"High",
		"Ultra",
	}, function()
		local val = GetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name])
		if (val == "0") then
			return "Off"
		elseif (val == "1") then
			return "Low"
		elseif (val == "2") then
			return "Medium"
			elseif (val == "3") then
			return "High"
		else
			return "Ultra"
		end
	end, function(val)
		if (val == "Off") then
			val = "0"
		elseif (val == "Low") then
			val = "1"
		elseif (val == "Medium") then
			val = "2"
		elseif (val == "High") then
			val = "3"
		else
			val = "4"
		end
		SetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name], val)
	end, warn, warnmsg)
end

local function AddCheckBox(name, text, warn, warnmsg)
	if (text == nil) then 
		text = name
	end
	LAM:AddCheckbox(menus[PanelName].SubIDCFG, "DynamicConfigManualSetting"..name.."CheckBox", text, nil, function()
		return GetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name])
	end, function(val)
		if (val) then
			SetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name], "1")
		else
			SetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name], "0")
		end
	end, warn, warnmsg)
end

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
	
	LAM:AddSlider(menus[PanelName].ID, "DynamicConfigSwitchBackTime", "Switchback Timeout", "How long to wait (in ms) before switing back to high (only applies to auto combat)", 0, 10000, 250, function()
		return DynamicConfig.settings.switchBackTime
	end, function(val)
		DynamicConfig.settings.switchBackTime = val
	end) -- Delay for switching to High (in auto combat)
	
	LAM:AddButton(menus[PanelName].ID, "DynamicConfigSaveHighBtn", "Save current as High", nil, function()
		DynamicConfig.Save("high")
	end) -- Save "High" settings button
	
	LAM:AddButton(menus[PanelName].ID, "DynamicConfigSaveLowBtn", "Save current as Low", nil, function()
		DynamicConfig.Save("low")
	end) -- Save "Low" settings button

--[[
	Everything below this comment is advanced settings!
]]--
	
	LAM:AddHeader(menus[PanelName].ID, "DynamicConfigAdvancedHeader", "Advanced Settings") -- Advanced settings header
	LAM:AddDescription(menus[PanelName].ID, "DynamicConfigAdvancedDescription", "|cFF2222WARNING:|r These settings are only for advanced users!\nChanging these settings MAY cause the addon NOT to work!\n\n")
	
	LAM:AddCheckbox(menus[PanelName].ID, "DynamicConfigEnableRefreshAndApply", "Enable Refresh and Apply settings", nil, function()
		return DynamicConfig.settings.RefreshApply
	end, function(val)
		DynamicConfig.settings.RefreshApply = val
	end) -- Enable Refresh and Apply settings
	
	LAM:AddSlider(menus[PanelName].ID, "DynamicConfigSystemIDSlider", "System ID", nil, 0, 100, 1, function()
		return DynamicConfig.settings.SystemID
	end, function(val)
		DynamicConfig.settings.SystemID = val
	end, true, "Only change this value if you're not seeing any changes with the settings")
	
	menus[PanelName].SubID = LAM:AddSubMenu(menus[PanelName].ID, "DynamicConfigSubMenu", "Choose Variables to modify", "Only change these if you know what you're doing!") -- Add Submenu for the advanced users to set what variables to modify
	
	SetDefaultVars(false)
	LAM:AddButton(menus[PanelName].SubID, "DynamicConfigResetVarsBtn", "Reset Default Variables", nil, function() 
		SetDefaultVars(true) -- Reset the variables to the default values
		ReloadUI() -- ReloadUI so we get the defaults shown properly
	end, true, "Reloads UI")
	LAM:AddButton(menus[PanelName].SubID, "DynamicConfigeEnableAllVariablesBtn", "Enable All Variables", nil, function() 
		for index, _ in pairs(DynamicConfig.settings.vars) do -- Loop all indexes
			DynamicConfig.settings.vars[index] = true -- Enable it
		end
		ReloadUI() -- ReloadUI so we get the defaults shown properly
	end, true, "Reloads UI")
	LAM:AddButton(menus[PanelName].SubID, "DynamicConfigeDisableAllVariablesBtn", "Disable All Variables", nil, function() 
		for index, _ in pairs(DynamicConfig.settings.vars) do -- Loop all indexes
			DynamicConfig.settings.vars[index] = false -- Disable it
		end
		ReloadUI() -- ReloadUI so we get the defaults shown properly
	end, true, "Reloads UI")
	
	for name, v in pairs(DynamicConfig.settings.vars) do
		LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfig"..name.."Box", name, nil, function()
			return DynamicConfig.settings.vars[name]
		end, function(val)
			DynamicConfig.settings.vars[name] = val
		end)
	end
	
	menus[PanelName].SubIDCFG = LAM:AddSubMenu(menus[PanelName].ID, "DynamicConfigSubMenuManualConfig", "Manually Configure Settings", "Only change these if you know what you're doing!") -- Add Submenu to allow the users to manually override the high settings
	
	
	LAM:AddSlider(menus[PanelName].SubIDCFG, "DynamicConfigManualSettingVIEW_DISTANCESlider", "View Distance", nil, 0, 100, 1, function()
		local val = GetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants["VIEW_DISTANCE"])
		val = val - 0.4
		val = val * 62.24
		return math.ceil(val - 0.5)
	end, function(val)
		val = val / 62.24
		val = val + 0.4
		SetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants["VIEW_DISTANCE"], val) -- Set the configuration
	end)
	
	AddDropDownHigh("SUB_SAMPLING","Sub Sampling Quality")
	AddDropDownLowUltra("PARTICLE_DENSITY", "Particle Density")
	AddDropDownOffUltra("SHADOWS","Shadow Quality", true, "ReloadUI required")
	AddDropDownOffUltra("REFLECTION_QUALITY_v3", "Water Reflection Quality", true, "ReloadUI required")
	AddDropDownHighInverted("MIP_LOAD_SKIP_LEVELS", "Texture Quality", true, "ReloadUI required")
	
	
	for name, v in pairs(BoolVariables) do
		if (v) then
			AddCheckBox(name, name, true, "UIReload required")
		else
			AddCheckBox(name)
		end
	end
end
