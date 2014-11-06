local LAM2 = LibStub:GetLibrary("LibAddonMenu-2.0")
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

local function GetDropDownHigh(name, text, warnmsg)
    return {
        type = "dropdown",
        name = text,
        choices = {
            "Low",
            "Medium",
            "High",
        },
        getFunc = function() 
            local val = GetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name])
            if (val == "0") then
                return "Low"
            elseif (val == "1") then
                return "Medium"
            else
                return "High"
            end
        end,
        setFunc = function() 
            if (val == "Low") then
                val = "0"
            elseif (val == "Medium") then
                val = "1"
            else
                val = "2"
            end
            SetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name], val)
        end,
        warning = warnmsg,
    }
end

local function GetDropDownLowUltra(name, text, warnmsg)
    return {
        type = "dropdown",
        name = text,
        choices = {
            "Low",
            "Medium",
            "High",
            "Ultra",
        },
        getFunc = function() 
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
        end,
        setFunc = function() 
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
        end,
        warning = warnmsg,
    }
end

local function GetDropDownHighInverted(name, text, warnmsg)
    return {
        type = "dropdown",
        name = text,
        choices = {
            "Low",
            "Medium",
            "High",
        },
        getFunc = function() 
            local val = GetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name])
            if (val == "2") then
                return "Low"
            elseif (val == "1") then
                return "Medium"
            else
                return "High"
            end
        end,
        setFunc = function() 
            if (val == "Low") then
                val = "2"
            elseif (val == "Medium") then
                val = "1"
            else
                val = "0"
            end
            SetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name], val)
        end,
        warning = warnmsg,
    }

end

local function GetDropDownOffUltra(name, text, warnmsg)

    return {
        type = "dropdown",
        name = text,
        choices = {
            "Off",
            "Low",
            "Medium",
            "High",
            "Ultra",
        },
        getFunc = function() 
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
        end,
        setFunc = function() 
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
        end,
        warning = warnmsg,
    }

end

local function GetCheckBox(name, text, warnmsg)
    if (text == nil) then 
        text = name
    end
    return {
        type = "checkbox",
        name = text,
        getFunc = function()
            return GetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name])
        end,
        setFunc = function(val)
            if (val) then
                SetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name], "1")
            else
                SetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants[name], "0")
            end
        end,
        warning = warnmsg,
    }
end

function DynamicConfig.SetupSettingsMenu()

    local panelData = {
        type = "panel",
        name = PanelName,
    }
    LAM2:RegisterAddonPanel("DynamicConfigOptions", panelData )

    local optionsData = {
        [1] = {
            type = "button",
            name = "Activate High",
            width = "half",
            func = function()
                DynamicConfig.Apply("high")
            end,
        },
        [2] = {
            type = "button",
            name = "Activate Low",
            width = "half",
            func = function()
                DynamicConfig.Apply("low")
            end,
        },
        [3] = {
            type = "checkbox",
            name = "Auto Combat Tracking",
            getFunc = function()
                return DynamicConfig.settings.auto
            end,
            setFunc = function(val)
                DynamicConfig.settings.auto = val
            end,
        },
        [4] = {
            type = "checkbox",
            name = "Enable Output",
            getFunc = function()
                return DynamicConfig.settings.enableOutput
            end,
            setFunc = function(val)
                DynamicConfig.settings.enableOutput = val
            end,
        },
        [5] = {
            type = "checkbox",
            name = "Enable Debug Output",
            getFunc = function()
                return DynamicConfig.settings.debugOutput
            end,
            setFunc = function(val)
                DynamicConfig.settings.debugOutput = val
            end,
        },
        [6] = {
            type = "slider",
            name = "Switchback Timeout",
            tooltip = "How long to wait (in ms) before switing back to high (only applies to auto combat)",
            min = 0,
            max = 10000,
            step = 250,
            getFunc = function()
                return DynamicConfig.settings.switchBackTime
            end,
            setFunc = function(val)
                DynamicConfig.settings.switchBackTime = val
            end,
        },
        [7] = {
            type = "button",
            name = "Save current as High",
            width = "half",
            func = function()
                DynamicConfig.Save("high")
            end,
        },
        [8] = {
            type = "button",
            name = "Save current as Low",
            width = "half",
            func = function()
                DynamicConfig.Save("low")
            end,
        },

        [9] = {
            type = "submenu",
            name = "Advanced Settings",
            controls = {
                [1] = {
                    type = "description",
                    text = "|cFF2222WARNING:|r These settings are only for advanced users!\nChanging these settings MAY cause the addon NOT to work!",
                },
                [2] = {
                    type = "checkbox",
                    name = "Enable Refresh and Apply settings",
                    getFunc = function()
                        return DynamicConfig.settings.RefreshApply
                    end,
                    setFunc = function(val)
                         DynamicConfig.settings.RefreshApply = val
                    end,
                },
                [3] = {
                    type = "slider",
                    name = "System ID",
                    tooltip = "Only change this value if you're not seeing any changes with the settings",
                    min = 0,
                    max = 100,
                    step = 1,
                    getFunc = function()
                        return DynamicConfig.settings.SystemID
                    end,
                    setFunc = function(val)
                        DynamicConfig.settings.SystemID = val
                    end,
                },
            }
        },
    }
    topIdx = 10

    -- ============================================================
    -- Variables
    -- ============================================================
    variableOptions = {
        [1] = {
            type = "button",
            name = "Reset Default Variables",
            warning = "Reloads UI",
            func = function()
                SetDefaultVars(true) -- Reset the variables to the default values
                ReloadUI() -- ReloadUI so we get the defaults shown properly
            end,
        },
        [2] = {
            type = "button",
            name = "Enable All Variables",
            warning = "Reloads UI",
            width = "half",
            func = function()
                for index, _ in pairs(DynamicConfig.settings.vars) do -- Loop all indexes
                  DynamicConfig.settings.vars[index] = true -- Enable it
                end
                ReloadUI() -- ReloadUI so we get the defaults shown properly
            end,
        },
        [3] = {
            type = "button",
            name = "Disable All Variables",
            warning = "Reloads UI",
            width = "half",
            func = function()
                for index, _ in pairs(DynamicConfig.settings.vars) do -- Loop all indexes
                    DynamicConfig.settings.vars[index] = false -- Disable it
                end
                ReloadUI() -- ReloadUI so we get the defaults shown properly
            end,
        },
    }

    --  SetDefaultVars(false)    
    idx = 4
    for name, v in pairs(DynamicConfig.settings.vars) do
        variableOptions[idx] = {
            type = 'checkbox',
            name = name,
            getFunc = function()
                return DynamicConfig.settings.vars[name]
            end,
            setFunc = function(val)
                DynamicConfig.settings.vars[name] = val
            end,
        }
        idx = idx + 1
    end

    optionsData[topIdx] = {
            type = "submenu",
            name = "Variables",
            controls = variableOptions
    }
    topIdx = topIdx + 1 



    -- ============================================================
    -- manual options
    -- ============================================================
    manualOptions = {}        
    idx = 1
    manualOptions[idx] = { 
        type = "slider",
        name = "View Distance",
        min = 0,
        max = 100,
        step = 1,
        getFunc = function()
            local val = GetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants["VIEW_DISTANCE"])
            val = val - 0.4
            val = val * 62.24
            return math.ceil(val - 0.5)
        end,
        setFunc = function(val)
            val = val / 62.24
            val = val + 0.4
            SetSetting(DynamicConfig.settings.SystemID, DynamicConfig.Constants["VIEW_DISTANCE"], val) -- Set the configuration
        end,
    }
    idx = idx + 1 
    manualOptions[idx] = GetDropDownHigh("SUB_SAMPLING","Sub Sampling Quality")
    idx = idx + 1
    manualOptions[idx] = GetDropDownLowUltra("PARTICLE_DENSITY", "Particle Density")
    idx = idx + 1
    manualOptions[idx] = GetDropDownOffUltra("SHADOWS","Shadow Quality", "ReloadUI required")
    idx = idx + 1
    manualOptions[idx] = GetDropDownOffUltra("REFLECTION_QUALITY_v3", "Water Reflection Quality", "ReloadUI required")
    idx = idx + 1
    manualOptions[idx] = GetDropDownHighInverted("MIP_LOAD_SKIP_LEVELS", "Texture Quality", "ReloadUI required")
    idx = idx + 1


    for name, v in pairs(BoolVariables) do
        if (v) then
            manualOptions[idx] = GetCheckBox(name, name, "UIReload required")
        else
            manualOptions[idx] = GetCheckBox(name)
        end
        idx = idx + 1
    end

    optionsData[topIdx] = {
            type = "submenu",
            name = "Manually Configure Settings",
            controls = manualOptions
    }
    topIdx = topIdx + 1 


    LAM2:RegisterOptionControls("DynamicConfigOptions", optionsData)

    return
end
