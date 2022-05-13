local ImguiConfig = require("sphere.ImguiConfig")

local root = (...):match("(.+)/.-")

local config = ImguiConfig:fromFile(root .. "/base.config.lua")
return require("..\\userdata\\skins\\4649ceynou\\base")
    .createNoteskin(5, 1, 1, ..., config)