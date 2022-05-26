local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")

local noteskin = NoteSkinVsrg:new({
	path = ...,
	name = "new lua skin 2",
	inputMode = "4key",
	playField = "4key2.playfield.lua",
	range = {-1, 5},
	unit = 480,
	hitposition = 450,
})

noteskin:setInput({"key1", "key2", "key3", "key4"})

noteskin:setColumns({
	offset = 0,
	align = "center",
	width = {64, 64, 64, 64},
	space = {32, 0, 0, 0, 32},
})

noteskin:setTextures({
	{pixel = "pixel.png"},
	{left = "note/left.png"},
	{down = "note/down.png"},
	{up = "note/up.png"},
	{right = "note/right.png"},
	{tail_up = "note/tail-up.png"},
	{body = "note/body.png"},
	{lightingN = {"hit/lightingN-%d.png", {0, 8}}},
	{lightingL = "hit/lightingL.png"},
})

noteskin:setImages({
	pixel = {"pixel"},
	left = {"left"},
	down = {"down"},
	up = {"up"},
	right = {"right"},
	tail_up = {"tail_up"},
	body = {"body"},
	lightingN = {"lightingN"},
	lightingL = {"lightingL", {0, 0, 192, 222, {0, 2}}},
})

noteskin:setShortNote({
	image = {"left", "down", "up", "right"},
	h = 64,
})

noteskin:setLongNote({
	head = {"left", "down", "up", "right"},
	body = "body",
	tail = "tail_up",
	h = 64,
})

noteskin:addMeasureLine({
	h = 4,
	color = {1, 1, 1, 0.5},
	image = "pixel"
})

noteskin:addBga({
	x = 0,
	y = 0,
	w = 1,
	h = 1,
	color = {0.25, 0.25, 0.25, 1}
})

noteskin:setLighting({
	image = "lightingN",
	scale = 480 / 1080,
	rate = 30,
	range = {0, 8},
	offset = -32,
})

noteskin:setLighting({
	image = "lightingL",
	scale = 480 / 1080,
	rate = 30,
	range = {0, 2},
	offset = -32,
	long = true,
})

local playfield = BasePlayfield:new({
	noteskin = noteskin
})

playfield:addBga({
	transform = {{1 / 2, -16 / 9 / 2}, {0, -7 / 9 / 2}, 0, {0, 16 / 9}, {0, 16 / 9}, 0, 0, 0, 0}
})
playfield:enableCamera()
playfield:addNotes()
playfield:addLightings()
playfield:addKeyImages({
	h = 64,
	padding = 30,
	pressed = {"key/left1.png", "key/down1.png", "key/up1.png", "key/right1.png"},
	released = {"key/left0.png", "key/down0.png", "key/up0.png", "key/right0.png"},
})
playfield:addKeyImageAnimations({
	h = 64,
	padding = 30,
	rate = 5,
	pressed = {
		{"hit/left1.png", {0, 3}, {0, 0, 128, 128}},
		{"hit/left1.png", {0, 3}, {0, 0, 128, 128}},
		{"hit/left1.png", {0, 3}, {0, 0, 128, 128}},
		{"hit/left1.png", {0, 3}, {0, 0, 128, 128}},
	},
	hold = {
		{"hit/left1.png", {3, 3}, {0, 0, 128, 128}},
		{"hit/left1.png", {3, 3}, {0, 0, 128, 128}},
		{"hit/left1.png", {3, 3}, {0, 0, 128, 128}},
		{"hit/left1.png", {3, 3}, {0, 0, 128, 128}},
	},
	released = {
		{"hit/left1.png", {3, 0}, {0, 0, 128, 128}},
		{"hit/left1.png", {3, 0}, {0, 0, 128, 128}},
		{"hit/left1.png", {3, 0}, {0, 0, 128, 128}},
		{"hit/left1.png", {3, 0}, {0, 0, 128, 128}},
	},
})
playfield:addGuidelines({
	y = {0, 0, 0, 0, 0},
	w = {0, 0, 0, 0, 0},
	h = {480, 480, 480, 480, 480},
	image = {"pixel.png", "pixel.png", "pixel.png", "pixel.png", "pixel.png"}
})
playfield:disableCamera()

playfield:addBaseElements()

-- playfield:addJudgement({
-- 	x = 0, y = 540, ox = 0.5, oy = 0.5,
-- 	rate = 20,
-- 	transform = playfield:newLaneCenterTransform(1080),
-- 	key = "soundsphere",
-- 	judgements = {
-- 		{"perfect", "hit/lightingL.png", {0, 2}, {0, 0, 192, 222}},
-- 		{"not perfect", "hit/lightingN-%d.png", {8, 0}},
-- 	}
-- })

playfield:addDeltaTimeJudgement({
	x = 0, y = 540, ox = 0.5, oy = 0.5,
	rate = 20,
	transform = playfield:newLaneCenterTransform(1080),
	judgements = {
		{"hit/lightingN-%d.png", {8, 0}},
		-0.016,
		{"hit/lightingL.png", {0, 2}, {0, 0, 192, 222}},
		0.016,
		{"hit/lightingN-%d.png", {8, 0}},
	}
})

return noteskin
