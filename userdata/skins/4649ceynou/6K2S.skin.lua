local ImguiConfig = require("sphere.ImguiConfig")

local root = (...):match("(.+)/.-")

local config = ImguiConfig:fromFile(root .. "/base.config.lua")
return require(root .. "/base")
    .createNoteskin(6, 2, 0, ..., config)