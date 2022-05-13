local ImguiConfig = require("sphere.ImguiConfig")

local root = (...):match("(.+)/.-")

local config = ImguiConfig:fromFile(root .. "/base.config.lua")
return require(root .. "/base")
    .createNoteskin(5, 1, 0, ..., config)