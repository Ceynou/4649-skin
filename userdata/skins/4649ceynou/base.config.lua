local ImguiConfig = require("sphere.ImguiConfig")
local imgui = require("cimgui")

local config = ImguiConfig:new()

local ptrs = config:setDefs(--[[defs]] {
    hitposition = {"float[?]", 1, {450}},
    lightings = {"bool[?]", 1, {false}},
    measureLine = {"bool[?]", 1, {true}}
} --[[/defs]])

function config:render()
    imgui.SliderFloat("Hit position", ptrs.hitposition, 240, 480, "%.0f")
    imgui.Checkbox("Measure line", ptrs.measureLine)
    imgui.Checkbox("Lightings", ptrs.lightings)
    if imgui.Button("Save") then
        self:write()
    end
end

return config