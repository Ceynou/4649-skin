local JustConfig = require("sphere.JustConfig")

local root = (...):match("(.+)/.-")

local config = JustConfig:fromFile(root .. "/base.config.lua")
return require(root .. "/base")
    .createNoteskin(7, 1, 1, ..., config)