## What's this about?

This is a very simple plugin for The Elder Scrolls Online.

It tweaks the graphics configuration depending on combat status.
When in combat the graphics quality is turned down, so the game is more responsive.
When not in combat the quality is turned higher.


## Setup

1.  Go to the ESO documents directory at ```C:\Users\YOURUSER\Documents\Elder Scrolls Online\VERSION\``` (replace VERSION with the client you're using)
    Or use the ```/Users/YOURUSER/Documents/Elder Scrolls Online/VERSION/AddOns``` on the mac
2.  If a folder called ``Addons`` doesn't exist, create it.
3.  Copy he files of this plugin in to a directory name DynamicConfig

## Configuration

At the moment configuration can be done in the DynamicConfig.lua file:

The qualityUp function sets the configuration for my high quality experience. (Non-Combat)


```
function DynamicConfig.qualityUp()
    SetCVar('SUB_SAMPLING',2)
    SetCVar('AMBIENT_OCCLUSION',1)
    SetCVar('ANTI_ALIASING_v2', 1)
    SetCVar('BLOOM', 1)
    d("quality UP")
end
```


The quality down function sets the lower quality for the combat mode 

```
function DynamicConfig.qualityDown()
    SetCVar('SUB_SAMPLING',0)
    SetCVar('AMBIENT_OCCLUSION',0)
    SetCVar('ANTI_ALIASING_v2', 0)
    SetCVar('BLOOm', 0)
    d("quality down")
end
```



## Ideas

Perhaps build in a UI feature so you can toggle the different combat mode settings
