
local config = assert(loadfile("userdata/settings.lua"))
local cfg = config()

return require("..\\userdata\\skins\\4649ceynou\\base")
    .createNoteskin(10, 2, 0, ..., cfg)