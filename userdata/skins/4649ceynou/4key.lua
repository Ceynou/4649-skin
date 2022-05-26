local NoteSkin = require("sphere.models.NoteSkinModel.NoteSkin")

local noteskin = NoteSkin:new({
	name = "new lua skin",
	inputMode = "4key",
	playField = "4key.playfield.lua",
	path = ...,
	range = {-1, 5},
})

local colors = {
	transparent = {1, 1, 1, 0},
	semiTransparent = {1, 1, 1, 0.5},
	clear = {1, 1, 1, 1},
	missed = {0.5, 0.5, 0.5, 1},
	passed = {1, 1, 1, 0},
	startMissed = {0.5, 0.5, 0.5, 1},
	startMissedPressed = {0.75, 0.75, 0.75, 1},
	startPassedPressed = {1, 1, 1, 1},
	endPassed = {1, 1, 1, 0},
	endMissed = {0.5, 0.5, 0.5, 1},
	endMissedPassed = {0.5, 0.5, 0.5, 1}
}

local color = function(timeState, noteView)
	local logicalState = noteView.logicalState
	if logicalState == "clear" or logicalState == "skipped" then
		return colors.clear
	elseif logicalState == "missed" then
		return colors.missed
	elseif logicalState == "passed" then
		return colors.passed
	end

	local startTimeState = timeState.startTimeState or timeState
	local endTimeState = timeState.endTimeState or timeState
	local sdt = timeState.scaledFakeVisualDeltaTime or timeState.scaledVisualDeltaTime

	if startTimeState.fakeCurrentVisualTime >= endTimeState.absoluteTime then
		return colors.transparent
	elseif logicalState == "clear" then
		return colors.clear
	elseif colors[logicalState] then
		return colors[logicalState]
	end

	return colors.clear
end

local textures = {
	{pixel = "pixel.png"},
	{notes = "notes.png"},
	-- {left = "note/left.png"},
	-- {down = "note/down.png"},
	-- {up = "note/up.png"},
	-- {right = "note/right.png"},
	-- {tail_up = "note/tail-up.png"},
	-- {tail_down = "note/tail-down.png"},
	-- {mine = "note/mine.png"},
	-- {body = "note/body.png"},
	{lightingN = {"hit/lightingN-%d.png", {0, 8}}},
	-- {lightingL = {"hit/lightingL-%d.png", {0, 5}}},
	{lightingL = "hit/lightingL.png"},
}
for i, texture in ipairs(textures) do
	local k, v = next(texture)
	textures[k] = v
	textures[i] = v
end
noteskin.textures = textures

-- texturePath, quadParams(4[, range]), [{w h}]
local images = {
	pixel = {"pixel"},
	arrow = {"notes", {0, 0, 128, 128}},
	-- left = {"notes", {0, 0, 128, 128}},
	-- down = {"notes", {0, 0, 128, 128}},
	-- up = {"notes", {0, 0, 128, 128}},
	-- right = {"notes", {0, 0, 128, 128}},
	-- tail_up = {"tail_up"},
	tail_down = {"notes", {0, 128, 128, 128}},
	-- body = {"body"},
	body = {"notes", {128, 0, 128, 128}},
	lightingN = {"lightingN"},
	lightingL = {"lightingL", {0, 0, 192, 222, {0, 2}}},
	-- lightingL = {"lightingL"},
}
for _, image in pairs(images) do
	image[1] = textures[image[1]]
end
noteskin.images = images

local columnsPosition = {-128, -64, 0, 64, -192, -160}

local position = function(timeState)
	return 450 + 480 * (timeState.scaledFakeVisualDeltaTime or timeState.scaledVisualDeltaTime)
end

local animationRate = 30

local animations = {
	beforeStart = {
		x = -32, y = -64 - 32, w = 128, h = 128,
		ox = 0, oy = 0, r = 0,
		image = "lightingN",
		range = {0, 4},
		rate = animationRate,
		frames = 5,
	},
	afterStart = {
		x = -32, y = -64 - 32, w = 128, h = 128,
		ox = 0, oy = 0, r = 0,
		image = "lightingN",
		range = {5, 8},
		rate = animationRate,
		frames = 4,
	},
	between = {
		image = "lightingL",
		x = -32, y = -64 - (128 * (222 / 192) - 64) / 2, w = 128, h = 128 * 222 / 192,
		ox = 0, oy = 0, r = 0,
		range = {0, 2},
		rate = animationRate,
		frames = 3,
	},
	beforeEnd = {
		x = -32, y = -64 - 32, w = 128, h = 128,
		ox = 0, oy = 0, r = 0,
		image = "lightingN",
		range = {8, 5},
		rate = animationRate,
		frames = 4,
	},
	afterEnd = {
		x = -32, y = -64 - 32, w = 128, h = 128,
		ox = 0, oy = 0, r = 0,
		image = "lightingN",
		range = {4, 0},
		rate = animationRate,
		frames = 5,
	},
}

local function getAnimation(timeState)
	local beforeStart = animations.beforeStart
	local afterStart = animations.afterStart
	local between = animations.between
	local beforeEnd = animations.beforeEnd
	local afterEnd = animations.afterEnd

	local currentTime = timeState.currentTime
	local startTime = timeState.absoluteTime

	local endTime
	if timeState.endTimeState then
		endTime = timeState.endTimeState.absoluteTime
	else
		endTime = math.huge
		between = nil
		beforeEnd = nil
		afterEnd = nil
	end

	local bs = currentTime - startTime < 0
	local as = currentTime - startTime > 0
	local be = currentTime - endTime < 0
	local ae = currentTime - endTime > 0
	if beforeStart then
		bs = (currentTime - startTime) * beforeStart.rate < -beforeStart.frames
	end
	if afterStart then
		as = (currentTime - startTime) * afterStart.rate > afterStart.frames
	end
	if beforeEnd then
		be = (currentTime - endTime) * beforeEnd.rate < -beforeEnd.frames
	end
	if afterEnd then
		ae = (currentTime - endTime) * afterEnd.rate > afterEnd.frames
	end

	-- check < <= > >=
	local animation
	if bs or ae then
		animation = nil
	elseif beforeStart and (currentTime - startTime) * beforeStart.rate < 0 then
		animation = beforeStart
	elseif afterStart and (currentTime - startTime) * afterStart.rate < math.min(afterStart.frames, (endTime - startTime) / 2) then
		animation = afterStart
	elseif between and as and be then
		animation = between
	elseif beforeEnd and (currentTime - endTime) * beforeStart.rate < 0 then
		animation = beforeEnd
	elseif afterEnd and (currentTime - endTime) * beforeStart.rate < afterEnd.frames then
		animation = afterEnd
	end

	local time
	if animation == beforeStart or animation == afterStart then
		time = startTime
	elseif animation == between then
		time = startTime - afterStart.frames / afterStart.rate
	elseif animation == beforeEnd or animation == afterEnd then
		time = endTime
	end

	if not animation then
		return
	end

	return animation, currentTime - time
end

local function getFrame(a, deltaTime)
	return math.floor(deltaTime * a.rate) % a.frames * (a.range[2] - a.range[1]) / (a.frames - 1) + a.range[1]
end

local function getAnimationImage(timeState)
	local animation, deltaTime = getAnimation(timeState)
	if not animation then
		return
	end
	return animation.image, getFrame(animation, deltaTime)
end

local ShortNoteAnimationHead = {
	x = function(timeState, _, column) return columnsPosition[column] + getAnimation(timeState).x end,
	y = function(timeState) return 450 + getAnimation(timeState).y end,
	w = function(timeState) return getAnimation(timeState).w end,
	h = function(timeState) return getAnimation(timeState).h end,
	ox = 0,
	oy = 0,
	r = 0,
	color = {colors.clear, colors.clear, colors.clear, colors.clear},
	image = getAnimationImage,
}

local LongNoteAnimationHead = {
	x = function(timeState, _, column) return columnsPosition[column] + getAnimation(timeState).x end,
	y = function(timeState) return 450 + getAnimation(timeState).y end,
	w = function(timeState) return getAnimation(timeState).w end,
	h = function(timeState) return getAnimation(timeState).h end,
	ox = 0,
	oy = 0,
	r = 0,
	color = {colors.clear, colors.clear, colors.clear, colors.clear},
	image = getAnimationImage,
}

local lightingShort = {
	image = "lightingN",
	range = {0, 8},
	rate = animationRate,
	frames = 4,
}

local lightingLong = {
	image = "lightingL",
	range = {0, 2},
	rate = animationRate,
	frames = 3,
}

local ShortNoteLightingHead = {
	-- x = function(timeState, _, column) return columnsPosition[column] - 32 end,
	x = function(timeState, _, column) return columnsPosition[column] + 32 end,
	-- y = -64 - 32 + 450,
	y = 450 - 32,
	-- w = 128,
	-- h = 128,
	sx = 480 / 1080,
	sy = 480 / 1080,
	ox = 0.5,
	oy = 0.5,
	-- ox = 0,
	-- oy = 0,
	r = 0,
	color = {colors.clear, colors.clear, colors.clear, colors.clear},
	image = function(timeState, noteView)
		if not noteView.startTime then
			return
		end
		local deltaTime = timeState.currentTime - noteView.startTime
		if deltaTime >= lightingShort.frames / lightingShort.rate then
			return
		end
		return lightingShort.image, getFrame(lightingShort, deltaTime)
	end,
}

local LongNoteLightingHead = {
	-- x = function(timeState, _, column) return columnsPosition[column] - 32 end,
	x = function(timeState, _, column) return columnsPosition[column] + 32 end,
	-- y = -64 - (128 * (222 / 192) - 64) / 2 + 450,
	y = 450 - 32,
	-- w = 128,
	-- h = 128 * 222 / 192,
	sx = 480 / 1080,
	sy = 480 / 1080,
	-- ox = 0,
	-- oy = 0,
	ox = 0.5,
	oy = 0.5,
	r = 0,
	color = {colors.clear, colors.clear, colors.clear, colors.clear},
	image = function(timeState, noteView)
		if not noteView.startTime then
			return
		end
		local deltaTime = timeState.currentTime - noteView.startTime
		return lightingLong.image, getFrame(lightingLong, deltaTime)
	end,
}

local Head = {
	x = columnsPosition,
	y = position,
	w = {64, 64, 64, 64, 64, 320},
	h = {64, 64, 64, 64, 64, 4},
	ox = {1, 0, 1, 0, 0, 0},
	oy = {1, 1, 0, 0, 0, 1},
	r = {math.pi / 2, 0, math.pi, -math.pi / 2},
	color = {color, color, color, color, colors.clear, colors.semiTransparent},
	image = {"arrow", "arrow", "arrow", "arrow", "tail_down", "pixel"}
}

local Tail = {
	x = columnsPosition,
	y = position,
	w = 64,
	h = 64,
	ox = {1, 1, 1, 1, 0, 0},
	oy = {0, 0, 0, 0, 0, 0},
	r = {math.pi, math.pi, math.pi, math.pi, 0, 0},
	color = {color, color, color, color, nil, colors.transparent},
	image = {"tail_down", "tail_down", "tail_down", "tail_down", nil, "pixel"}
}

local Body = {
	x = columnsPosition,
	y = function(...) return position(...) - 32 end,
	w = 64,
	h = 0,
	ox = 0,
	oy = 0,
	color = {color, color, color, color, nil, colors.transparent},
	image = {"body", "body", "body", "body", nil, "pixel"}
}

local ShortNoteAnimation = {
	Head = ShortNoteAnimationHead
}

local LongNoteAnimation = {
	Head = LongNoteAnimationHead,
}

local ShortNoteLighting = {
	Head = ShortNoteLightingHead
}

local LongNoteLighting = {
	Head = LongNoteLightingHead,
}

local ShortNote = {
	Head = Head
}

local LongNote = {
	Head = Head,
	Tail = Tail,
	Body = Body,
}

noteskin.notes = {
	ShortNote = ShortNote,
	SoundNote = ShortNote,
	LongNote = LongNote,
	ShortNoteAnimation = ShortNoteAnimation,
	LongNoteAnimation = LongNoteAnimation,
	ShortNoteLighting = ShortNoteLighting,
	LongNoteLighting = LongNoteLighting,
}

local inputs = {"key1", "key2", "key3", "key4", "auto0", "measure1"}
for i, input in ipairs(inputs) do
	inputs[input] = i
end
noteskin.inputs = inputs

return noteskin
