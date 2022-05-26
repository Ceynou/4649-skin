local root = (...):match("(.+)/.-") .. "/"
local currentFile = (...):match("^.*/(.*).skin.lua$")
local base = require(root .. "base")
local ImguiConfig = require("sphere.ImguiConfig")

base.createConfig(root .. currentFile .. ".config.lua")
-- function above put inside createNoteskin?

local cfg = ImguiConfig:fromFile(root .. currentFile .. ".config.lua")
if cfg:get("GeneralConfig") == 1 then
    cfg = ImguiConfig:fromFile(root .. "base.config.lua")
end

local noteskin = base.createNoteskin(14, 2, 0, ..., cfg)
return noteskin