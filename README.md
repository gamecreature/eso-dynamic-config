## What's this about?

This is a very simple plugin for The Elder Scrolls Online.

It tweaks the graphics configuration depending on combat status.
When in combat the graphics quality is turned down, so the game is more responsive.
When not in combat the quality is turned higher.


## Setup

1.  Go to the ESO documents directory at ```C:\Users\YOURUSER\Documents\Elder Scrolls Online\VERSION\``` (replace VERSION with the client you're using)
    Or use the ```/Users/YOURUSER/Documents/Elder Scrolls Online/VERSION/AddOns``` on the mac	
	* Note: Change ```VERSION``` above to etheir ```liveeu``` (EU Mega Server) or ```live``` (North America Mega Server)
2.  If a folder called ``Addons`` doesn't exist, create it.
3.  Copy the files of this plugin into a directory named DynamicConfig

## Configuration

You can save the coniguration you would like to use for high and low quality via a slash-command in the chat window.

To configure the high quality you can configure your settings via the settings menu.
When complete enter the follow command:

```
/dynconf save high
```

To configure the low quality you can configure your low quality settings via the settings menu.
When complete enter the follow command:


```
/dynconf save low
```

You can also do this using the settings menu...


## Command list 

Warning commands are space and case sensitive! (so type it exactly)

```
/dynconf            : shows some help
/dynconf save high  : save high quality settings (explorer modes)
/dynconf save low   : save low quality settings  (combat modes)
/dynconf show high  : shows the high quality settings
/dynconf show low   : shows the high quality settings
/dynconf show cur   : shows the current game settings
/dynconf high       : activates the high settings
/dynconf low        : activates the low settings
/dynconf auto on	: enables auto combat tracker
/dynconf auto off	: disables auto combat tracker
```


## Settings/Variables that are stored

The following settings are stored for now (by default).
I've experimented with some other setting, but there are settings that are problematic (well at least on my Mac). 

```
SUB_SAMPLING 
AMBIENT_OCCLUSION 
ANTI_ALIASING_v2
BLOOM
PARTICLE_DENSITY
VIEW_DISTANCE
CLUTTER_2D
```

## Additional Settings/Variables (can be activated)

The following additional settings can be stored using the settings for them:

```
ALPHA
ANAGLYPH
CHARACTER_LIGHTING
COLOR_CORRECTION
COLOR_GRADING
COLOR_PICKER
CUBE_LIGHTING
DEPTH_OF_FIELD
DETAIL_MAPS
DIFFUSE_2_MAPS
DIFFUSE_MAPS
DISTORTION
DQ_SKINNING
DRAW_BAD_FIXTURES
FADER
FOG
FRESNEL
FULLSCREEN
GAMMA_ADJUSTMENT
GLOW
GOD_RAYS_v2
GRAPHICS_DEBUG_VIEW
GRAY_DIFFUSE
HIGH_RESOLUTION_SHADOWS
LENS_FLARE
MAX_ANISOTROPY
NO_CHARACTER_ATLAS
NORMAL_MAPS
OCCLUSION_QUERIES
POINT_SAMPLING
POST_PROCESS_PANELS
RAIN_WETNESS
RESOLUTION
SCREEN_PERCENTAGE
SHOW_ART_METRICS
SIMPLE_SHADERS
SKINNING
SOFT_ALPHA
SPECULAR_MAPS
SUN_LIGHTING
TEXTURE_POOLING
TINT_MAPS
VERTEX_COLORS
VIEW_SHADER_CHANNEL
VSYNC
WATER_FOAM
WATERMARK
WEAPONS_IN_ATLAS
WIREFRAME
Z_PREPASS
```


## Histoy

v1.1.0
* Added a setting to disable the RefreshSettings and ApplySettings function calls (they may cause the UI scale to change for some users)
* Added buttons to enable/disable all variables aswell as reset defaults
* Added the ability to manually configure each variable (live editing!)
* Added slash command to toggle auto combat on/off (auto on and auto off)
* Added keybinding to toggle auto combat on/off (a single button to toggle it on or off, a message will be displayed as to which state it's changed to)
* Deleted the settings which require a UI reload to not cause problems (they're now available as manual option settings instead, keep in mind there might be more that we haven't tested yet)

v1.0.10
* Enabled more variables for you to experiment with
* Added a slider for SystemID, only change it if the addon appears to not be changing anything... the default value is 5...

v1.0.9
* Fixed a crash for new users when wanting to show current settings

v1.0.8
* Moved from cVar editing to SetSetting instead - Fixes the SUB_SAMPLING issues (it's now beeing applied directly, meaning bigger difference!)
* Under the hood: The Settings menu is now more dynamic (for variable's to modify)
* Added Override when doing manual shifting of the configuration (it'll always change no matter what mode was set previously, when having the automatic one it'll not change if it's already set to high/low)

v1.0.7
* Added an option to configure the cooldown period and reduce the number of graphic quality switches

v1.0.6
* Added settings for each variable (you can now toggle exactly which variables you want the addon to change for you)

v1.0.5
* Added some additional variables (as an option) per request by [SektaNZ](http://www.esoui.com/forums/member.php?u=5291)

v1.0.4
* Added Keybindings (Thanks to [SkOODaT](http://www.esoui.com/forums/member.php?userid=1305)!)

v1.0.3
* Added DynamicConfig UI Settings (Thanks [Swizzy](https://github.com/Swizzy)!)

v1.0.2 
* Added configuration support. Settings are now changable
* Added grass configuration support

v1.0.1
* PARTICLE_DENSITY and VIEW_DISTANCE added
* Fixed file list so it also includes README.md

v1.0 
* First release
