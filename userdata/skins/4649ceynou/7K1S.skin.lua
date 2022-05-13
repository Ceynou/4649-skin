local ImguiConfig = require("sphere.ImguiConfig")

local root = (...):match("(.+)/.-")

local config = ImguiConfig:fromFile(root .. "/base.config.lua")
return require("..\\userdata\\skins\\4649ceynou\\base")
    .createNoteskin(7, 1, 0, ..., config)