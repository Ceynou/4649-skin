local ImguiConfig = require("sphere.ImguiConfig")

local root = (...):match("(.+)/.-")

local config = ImguiConfig:fromFile(root .. "/base.config.lua")
return require("..\\userdata\\skins\\4649ceynou\\base")
    .createNoteskin(10, 2, 0, ..., config)