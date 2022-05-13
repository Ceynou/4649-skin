# 4649-skin
soundsphere script that can sets a skin off a base file.


### add more keymode
You need to create a new file, the name doesn't matter as long as the extension is `.skin.lua`
in that file add the following code
```lua
local ImguiConfig = require("sphere.ImguiConfig")

local root = (...):match("(.+)/.-")

local config = ImguiConfig:fromFile(root .. "/base.config.lua")
return require(root .. "/base")
    .createNoteskin(key, scratch, pedal, ..., config)
```
and replace key, scratch and pedal by their corresponding value, so if you want to make a skin for 13 keys and 1 pedal, it will become
```lua
    .createNoteskin(13, 0, 1, ..., config)
```
<br>
<br>

### add a separate config file
You need to copy the content of base.config.lua file and rename it somethingelse.config.lua
then in the file(s) for the keymode(s) you want to use that config file edit   
```lua
local config = ImguiConfig:fromFile(root .. "/base.config.lua")
```
to
```lua
local config = ImguiConfig:fromFile(root .. "/somethingelse.config.lua")
```

_________________

#### note that there can only be the following cases for scratch and pedal
`key, 1, 0,`
`key, 2, 0,`
`key, 1, 1,`
`key, 0, 1,`
