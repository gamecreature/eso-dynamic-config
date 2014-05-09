## What's this about?

This is a very simple plugin for The Elder Scrolls Online.

It tweaks the graphics configuration depending on combat status.
When in combat the graphics quality is turned down, so the game is more responsive.
When not in combat the quality is turned higher.


## Setup

1.  Go to the ESO documents directory at ```C:\Users\YOURUSER\Documents\Elder Scrolls Online\VERSION\``` (replace VERSION with the client you're using)
    Or use the ```/Users/YOURUSER/Documents/Elder Scrolls Online/VERSION/AddOns``` on the mac
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


## Command list 

Warning commands are space sensitive! (so type it exactly)

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


## Settings that are stored

The following settings are stored for now.
I'v experimented with some other setting, but there are settings that are problematic (wel at least on my Mac). 

```
SUB_SAMPLING 
AMBIENT_OCCLUSION 
ANTI_ALIASING_v2
BLOOM
PARTICLE_DENSITY
VIEW_DISTANCE
```


## Ideas

  * Build in a UI feature
  * Add a cooldown period, so it switches to high-quality after a few seconds (prevent to much switching)


## Histoy

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
