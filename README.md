# 4649-skin
soundsphere script that can generate a skin off a base file.

### adding the default settings of the skin
add the following code to your settings file in `userdata\settings.lua`
```lua
	_4649 = {
		notes = {
			height = 20,
			widthKey1 = 48,
			widthKey2 = 48,
			widthSP = 80
		},
		ui = {
			align = "center",
			baseElements = false,
			hitposition = 460,
			offset = 0,
			scratchAlign = "left",
			widthLines = 2
		}
	},
```
so it should look like this:
```lua
return {
	_4649 = {
		notes = {
			height = 20,
			widthKey1 = 48,
			widthKey2 = 48,
			widthSP = 80
		},
		ui = {
			align = "center",
			baseElements = false,
			hitposition = 460,
			offset = 0,
			scratchAlign = "left",
			widthLines = 2
		}
	},
	audio = {
		midi = {
			constantVolume = false
		},
		mode = {
			preview = "streamOpenAL",
			primary = "sample",
			secondary = "sample"
		},
		volume = {
			effects = 1,
			master = 0.6,
			music = 1
		}
	},
```
### add more keymode
You need to create a new file, the name doesn't matter as long as the extension is `.skin.lua`
in that file add the following code
```lua
local config = assert(loadfile("userdata/settings.lua"))
local cfg = config()

return require("..\\userdata\\skins\\4649ceynou\\base")
    .createNoteskin(key, scratch, pedal, ..., cfg)
```
and replace key, scratch and pedal by their corresponding value, so if you want to make a skin for 13 keys and 1 pedal, it will become
```lua
    .createNoteskin(13, 0, 1, ..., cfg)
```

#### note that there can only be the following cases
`key, 1, 0,`
`key, 2, 0,`
`key, 1, 1,`
`key, 0, 1,`
