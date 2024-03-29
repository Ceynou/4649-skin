local JustConfig = require("sphere.JustConfig")

local root = (...):match("(.+)/.-")

local config = JustConfig:fromFile(root .. "/centered.config.lua")
return require(root .. "/base")
    .createNoteskin(6, 2, 0, ..., config)