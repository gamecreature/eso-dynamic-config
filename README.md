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
SHADOWS
HIGH_RESOLUTION_SHADOWS
REFLECTION_QUALITY_v3
LENS_FLARE
GOD_RAYS_v2
MAX_ANISOTROPY
DIFFUSE_2_MAPS
DETAIL_MAPS
NORMAL_MAPS
SPECULAR_MAPS
DISTORTION
WATER_FOAM
MIP_LOAD_SKIP_LEVELS
RAIN_WETNESS
```


## Ideas

  * Add a cooldown period, so it switches to high-quality after a few seconds (after leaving combat) (prevent to much switching)


## Histoy

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
