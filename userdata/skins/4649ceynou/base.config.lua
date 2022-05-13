local ImguiConfig = require("sphere.ImguiConfig")
local imgui = require("cimgui")
local config = ImguiConfig:new()


local ptrs = config:setDefs(--[[defs]] {
	align = {"int[?]", 1, {1}},
	baseElements = {"bool[?]", 1, {false}},
	height = {"float[?]", 1, {26}},
	hitposition = {"float[?]", 1, {460}},
	offset = {"float[?]", 1, {0}},
	scratchAlign = {"int[?]", 1, {0}},
	widthKey1 = {"float[?]", 1, {48}},
	widthKey2 = {"float[?]", 1, {48}},
	widthLines = {"float[?]", 1, {2}},
	widthSP = {"float[?]", 1, {80}}
} --[[/defs]])

local position = {"left", "center", "right"}

function config:render()
    imgui.Checkbox("Base elements", ptrs.baseElements)
    imgui.Combo_Str("Playfield align", ptrs.align, table.concat(position, "\0"))
    imgui.Combo_Str("Scratch align", ptrs.scratchAlign, table.concat(position, "\0"))
    imgui.SliderFloat("Hit position", ptrs.hitposition, 0, 480, "%.0f")
    imgui.SliderFloat("Width key1", ptrs.widthKey1, 4, 100, "%.0f")
    imgui.SliderFloat("Width key2", ptrs.widthKey2, 4, 100, "%.0f")
    imgui.SliderFloat("Width SP", ptrs.widthSP, 4, 100, "%.0f")
    imgui.SliderFloat("Height", ptrs.height, 4, 100, "%.0f")
    imgui.SliderFloat("Width lines", ptrs.widthLines, 0, 10, "%.0f")
    imgui.SliderFloat("Offset", ptrs.offset, -480, 480, "%.0f")
	if imgui.Button("Save") then
		self:write()
	end
end
return config