local LAM = LibStub:GetLibrary("LibAddonMenu-1.0")
local PanelName = "Dynamic Config Settings"
local menus = {}

local function SetDefaultVars(reset)
	if DynamicConfig.settings.vars == nil or reset == true then
		DynamicConfig.settings.vars = {
			ALPHA = false, -- Should probably never be used
			AMBIENT_OCCLUSION = true,
            ANAGLYPH = false,
			ANTI_ALIASING_v2 = true,
			--ANTI_ALIASING = false, -- probably a duplicate of the above?
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
			FULLSCREEN = false, -- This one is most likely useless seeing as it'll  require a reload, and why would you want to change this while in combat?!
			GAMMA_ADJUSTMENT = false, -- Probably pointless
			GLOW = false,
			GOD_RAYS_v2 = false,
			--GOD_RAYS = false, -- Probably a duplicate of the above?
			GRAPHICS_DEBUG_VIEW = false,
			GRAY_DIFFUSE = false,
			HIGH_RESOLUTION_SHADOWS = false,
			LENS_FLARE = false,
			MAX_ANISOTROPY = false,
			MIP_LOAD_SKIP_LEVELS = false,
			NO_CHARACTER_ATLAS = false,
			NORMAL_MAPS = false,
			OCCLUSION_QUERIES = false,
			PARTICLE_DENSITY = true,
			POINT_SAMPLING = false,
			POST_PROCESS_PANELS = false,
			--PRESETS = false, -- probably useless?
			RAIN_WETNESS = false,
			REFLECTION_QUALITY_v3 = false,	
			--REFLECTION_QUALITY = false, -- Probably a duplicate of the above?
			RESOLUTION = false, -- Probably pointless, why would you want to change the resolution while in combat?! this also probably requires a reload...
			SCREEN_PERCENTAGE = false, -- probably useless
			SHADOWS = false,
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
	LAM:AddDescription(menus[PanelName].ID, "DynamicConfigAdvancedDescription", "|cFF2222WARNING:|r These settings are only for advanced users!\nChanging these settings MAY cause the addon NOT to work!")
	
	LAM:AddCheckbox(menus[PanelName].ID, "DynamicConfigEnableRefreshAndApply", "Enable Refresh and Apply settings", nil, function()
		return DynamicConfig.settings.RefreshApply
	end, function(val)
		DynamicConfig.settings.RefreshApply = val
	end) -- Enable Refresh and Apply settings
	
	LAM:AddSlider(menus[PanelName].ID, "DynamicConfigSystemIDSlider", "System ID", nil, 0, 100, 1, function()
		return DynamicConfig.settings.SystemID
	end, function(val)
		DynamicConfig.settings.SystemID = val
	end)
	
	menus[PanelName].SubID = LAM:AddSubMenu(menus[PanelName].ID, "DynamicConfigSubMenu", "Choose Variables to modify", "Only change these if you know what you're doing!") -- Add Submenu for the advanced users to set what variables to modify
	
	SetDefaultVars(false)
	LAM:AddButton(menus[PanelName].SubID, "DynamicConfigResetVarsBtn", "Reset Default Variables", "Resets the variables to the default values and reloads the UI", function() 
		SetDefaultVars(true) -- Reset the variables to the default values
		ReloadUI() -- ReloadUI so we get the defaults shown properly
	end)
	
	for name, v in pairs(DynamicConfig.settings.vars) do
		LAM:AddCheckbox(menus[PanelName].SubID, "DynamicConfig"..name.."Box", name, nil, function()
			return DynamicConfig.settings.vars[name]
		end, function(val)
			DynamicConfig.settings.vars[name] = val
		end)
	end
end