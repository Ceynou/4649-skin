-- local transform = {{1 / 2, -16 / 9 / 2}, 0, 0, {0, 1 / 1080}, {0, 1 / 1080}, 0, 0, 0, 0}
local transform = {{1 / 2, 0}, 0, 0, {0, 1}, {0, 1}, 0, 0, 0, 0}
local osupixels = {{1 / 2, -2 / 3}, 0, 0, {0, 1 / 480}, {0, 1 / 480}, 0, 0, 0, 0}
local osupixelsCentered = {{1 / 2, 0}, 0, 0, {0, 1 / 480}, {0, 1 / 480}, 0, 0, 0, 0}

local transformFull = {0, 0, 0, {1 / 1920, 0}, {0, 1 / 1080}, 0, 0, 0, 0}

local topRight = {{1, 0}, 0, 0, {0, 1 / 1080}, {0, 1 / 1080}, 0, 0, 0, 0}
local topCenter = {{1 / 2, 0}, 0, 0, {0, 1 / 1080}, {0, 1 / 1080}, 0, 0, 0, 0}

local RhythmView = {
	class = "RhythmView",
	transform = osupixelsCentered,
}

local RhythmViewAnimation = {
	class = "RhythmView",
	transform = osupixels,
	mode = "animation"
}

local RhythmViewLighting = {
	class = "RhythmView",
	transform = osupixelsCentered,
	mode = "lighting"
}

local PointGraph = {
	class = "PointGraphView",
	key = "hitSequence",
	time = "currentTime", value = "deltaTime", unit = 0.400, offset = 0.2,
	x = 480, y = 270, w = 960, h = 540, r = 2,
	lineColor = {1, 1, 1, 0.5},
	transform = transformFull,
	color = {0.5, 0.5, 0.5, 1},
	counterPath = "hits.lua"
}

local ProgressBar = {
	class = "ProgressView",
	min = {key = "gameController.rhythmModel.timeEngine.minTime"},
	max = {key = "gameController.rhythmModel.timeEngine.maxTime"},
	start = {key = "gameController.rhythmModel.timeEngine.startTime"},
	current = {key = "gameController.rhythmModel.timeEngine.currentTime"},
	x = 0, y = 1070, w = 1920, h = 10,
	color = {1, 1, 1, 1},
	transform = transformFull,
	direction = "left-right",
	mode = "+"
}

local Score = {
	class = "ValueView", key = "gameController.rhythmModel.scoreEngine.scoreSystem.normalscore.score",
	format = "%0.2f", multiplier = 1000,
	x = -1080, baseline = 100, limit = 1080,
	align = "right",
	color = {1, 1, 1, 1},
	font = {
		filename = "Noto Sans Mono",
		size = 40
	},
	transform = topRight
}

local Accuracy = {
	class = "ValueView", key = "gameController.rhythmModel.scoreEngine.scoreSystem.normalscore.accuracy",
	format = "%0.2f", multiplier = 1000,
	x = -1080, baseline = 200, limit = 1080,
	align = "right",
	color = {1, 1, 1, 1},
	font = {
		filename = "Noto Sans Mono",
		size = 30
	},
	transform = topRight
}

local Combo = {
	class = "ValueView", key = "gameController.rhythmModel.scoreEngine.scoreSystem.base.combo",
	format = "%d",
	x = -540, baseline = 540, limit = 1080,
	align = "center",
	color = {1, 1, 1, 0.4},
	font = {
		filename = "Noto Sans Mono",
		size = 240
	},
	transform = topCenter
}

local Judgement = {
	class = "ValueView", key = "gameController.rhythmModel.scoreEngine.scoreSystem.judgement.judgementName",
	format = "%s",
	x = -540, baseline = 540, limit = 1080,
	align = "center",
	color = {1, 1, 1, 1},
	font = {
		filename = "Noto Sans Mono",
		size = 28
	},
	transform = topCenter
}

-- local JudgementImageAnimationPerfect = {
-- 	class = "ImageAnimationView",
-- 	x = -32 - 32, y = 120 - 32, w = 64 + 64, h = 64 + 64,
-- 	transform = osupixelsCentered,
-- 	image = "hit/lightingN-%d.png",
-- 	range = {0, 8},
-- 	rate = 20,
-- 	frames = 9
-- }

local JudgementImageAnimationPerfect = {
	class = "ImageAnimationView",
	x = -32 - 32, y = 120 - 32, w = 64 + 64, h = 64 + 64,
	transform = osupixelsCentered,
	image = "hit/lightingL.png",
	range = {0, 2, 1},
	quad = {0, 0, 192, 222},
	rate = 1,
}

local JudgementImageAnimationNotPerfect = {
	class = "ImageAnimationView",
	x = -32 - 32, y = 120 - 32, w = 64 + 64, h = 64 + 64,
	transform = osupixelsCentered,
	image = "hit/lightingN-%d.png",
	range = {8, 0, -1},
	rate = 20,
}

local JudgementAnimation = {
	class = "JudgementView", key = "gameController.rhythmModel.scoreEngine.scoreSystem.judgement",
	judgements = {
		perfect = JudgementImageAnimationPerfect,
		["not perfect"] = JudgementImageAnimationNotPerfect,
	}
}

local Key1ImagePressed = {
	class = "ImageView",
	x = -128, y = 386, w = 64, h = 64,
	transform = osupixelsCentered,
	image = "key/left1.png",
}

local Key1ImageReleased = {
	class = "ImageView",
	x = -128, y = 386, w = 64, h = 64,
	transform = osupixelsCentered,
	image = "key/left0.png",
}

local Key1 = {
	class = "InputView",
	inputType = "key", inputIndex = 1,
	pressed = Key1ImagePressed,
	released = Key1ImageReleased,
}

local animationRate = 20

local Key1ImageAnimationPressed = {
	class = "ImageAnimationView",
	x = -128 - 32 - 128, y = 386 - 32, w = 64 + 64, h = 64 + 64,
	transform = osupixelsCentered,
	image = "hit/lightingN-%d.png",
	range = {0, 8, 1},
	rate = animationRate,
}

local Key1ImageAnimationReleased = {
	class = "ImageAnimationView",
	x = -128 - 32 - 128, y = 386 - 32, w = 64 + 64, h = 64 + 64,
	transform = osupixelsCentered,
	image = "hit/lightingN-%d.png",
	range = {8, 0, -1},
	rate = animationRate,
}

local Key1ImageAnimationHold = {
	class = "ImageAnimationView",
	x = -128 - 32 - 128, y = 386 - 32, w = 64 + 64, h = 64 + 64,
	transform = osupixelsCentered,
	image = "hit/lightingL-%d.png",
	range = {0, 2, 1},
	rate = animationRate,
}

local Key1Animation = {
	class = "InputAnimationView",
	inputType = "key", inputIndex = 1,
	pressed = Key1ImageAnimationPressed,
	hold = Key1ImageAnimationHold,
	released = Key1ImageAnimationReleased,
}

local Key1ImageAnimationPressed2 = {
	class = "ImageAnimationView",
	x = -128, y = 386, w = 64, h = 64,
	transform = osupixelsCentered,
	image = "hit/left1.png",
	range = {0, 3, 1},
	quad = {0, 0, 128, 128},
	rate = 10,
}

local Key1Animation2 = {
	class = "InputAnimationView",
	inputType = "key", inputIndex = 1,
	pressed = Key1ImageAnimationPressed2,
}

local Key2 = {
	class = "InputImageView",
	inputType = "key", inputIndex = 2,
	x = -64, y = 386, w = 64, h = 64,
	released = "key/down0.png",
	pressed = "key/down1.png",
	transform = osupixelsCentered
}

local Key3 = {
	class = "InputImageView",
	inputType = "key", inputIndex = 3,
	x = 0, y = 386, w = 64, h = 64,
	released = "key/up0.png",
	pressed = "key/up1.png",
	transform = osupixelsCentered
}

local Key4 = {
	class = "InputImageView",
	inputType = "key", inputIndex = 4,
	x = 64, y = 386, w = 64, h = 64,
	released = "key/right0.png",
	pressed = "key/right1.png",
	transform = osupixelsCentered
}

local HpBar = {
	class = "ProgressView",
	min = {value = 0},
	max = {value = 1},
	start = {value = 0},
	current = {key = "gameController.rhythmModel.scoreEngine.scoreSystem.hp.hp"},
	x = 0, y = 0, w = 10, h = 1080,
	image = "down-up",
	transform = transformFull,
	color = {1, 1, 1, 1},
	direction = "down-up",
	mode = "+"
}

local CameraOn = {
	class = "CameraView",
	draw_start = true
}

local CameraOff = {
	class = "CameraView",
	draw_end = true
}

local playfield = {
	CameraOn,
	RhythmView,
	RhythmViewAnimation,
	RhythmViewLighting,
	Key1ImageReleased,
	Key1ImagePressed,
	Key1,
	Key1ImageAnimationPressed,
	Key1ImageAnimationHold,
	Key1ImageAnimationReleased,
	Key1Animation,
	Key1ImageAnimationPressed2,
	Key1Animation2,
	Key2,
	Key3,
	Key4,
	CameraOff,
	JudgementImageAnimationPerfect,
	JudgementImageAnimationNotPerfect,
	JudgementAnimation,
	-- PointGraph,
	ProgressBar,
	Score,
	Accuracy,
	Combo,
	Judgement,
	HpBar,
}

return playfield
