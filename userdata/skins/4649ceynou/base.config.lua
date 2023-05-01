local JustConfig = require("sphere.JustConfig")
local imgui = require("sphere.imgui")
local round = require("math_util").round
local just = require("just")

local config = JustConfig:new()

config.data = --[[data]] {
	align = "center",
	autosave = true,
	baseElements = false,
	height = 26,
	hitposition = 460,
	offset = 0,
	scratchAlign = "left",
	widthKey1 = 48,
	widthKey2 = 48,
	widthLines = 2,
	widthSP = 80
} --[[/data]]

function config:draw(w, h)
	local data = self.data

	just.indent(10)
	just.text("Skin by 4649ceynou")

	imgui.setSize(w, h, w / 2, 55)
    data.baseElements = imgui.checkbox("baseElements", data.baseElements, "Base Elements")
    data.align = imgui.combo("align", data.align, {"left", "center", "right"}, nil, "Playfield")
    data.scratchAlign = imgui.combo("scratchAlign", data.scratchAlign, {"left", "center", "right"}, nil, "Scratch")
    data.hitposition = imgui.slider1("hitposition", data.hitposition, "%.0f", 0, 480, 10, "Hit position")
    data.widthKey1 = imgui.slider1("widthKey1", data.widthKey1, "%.0f", 4, 100, 1, "White key's width")
    data.widthKey2 = imgui.slider1("widthKey2", data.widthKey2, "%.0f", 4, 100, 1, "Blue key's width")
    data.widthSP = imgui.slider1("widthSP", data.widthSP, "%.0f", 4, 100, 1, "SP key's width")
    data.height = imgui.slider1("height", data.height, "%.0f", 4, 100, 1, "Key's height")
    data.widthLines = imgui.slider1("widthLines", data.widthLines, "%.0f", 0, 10, 1, "Lines's width")
    data.offset = imgui.slider1("offset", data.offset, "%.0f", -480, 480, 10, "Playfield's offset")
	
	imgui.separator()
	if imgui.button("Write config file", "Write") then
		self:write()
	end
	data.autosave = imgui.checkbox("autosave", data.autosave, "Autosave")
end

return config
