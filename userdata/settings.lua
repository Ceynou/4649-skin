return {
	_4649 = {
		input = {
			hitposition = {
				decrease = "end",
				increase = "home"
			}
		},
		notes = {
			height = 20,
			widthKey1 = 48,
			widthKey2 = 48,
			widthSP = 80
		},
		ui = {
			align = "right",
			baseElements = false,
			hitposition = 460,
			offset = 0,
			scratchAlign = "left",
			widthLines = 2
		}
	},
	audio = {
		midi = {
			constantVolume = false
		},
		mode = {
			preview = "streamOpenAL",
			primary = "sample",
			secondary = "sample"
		},
		volume = {
			effects = 1,
			master = 0.6,
			music = 1
		}
	},
	gameplay = {
		bga = {
			image = false,
			video = false
		},
		lastMeanValues = 10,
		longNoteShortening = -0.02500000000000001,
		needTimeRound = true,
		newRating = true,
		noteskin4key = "userdata/skins/4649ceynou/4K.skin.lua",
		noteskin5key1scratch = "userdata/skins/soundsphere circle/5key1scratch.skin.lua",
		noteskin5key2scratch = "userdata/skins/4649ceynou/14K2S.skin.lua",
		noteskin6key2scratch = "userdata/skins/4649ceynou/6K2S.skin.lua",
		noteskin7key = "userdata/skins/mizu/7key.skin.lua",
		noteskin7key1pedal = "userdata/skins/4649ceynou/5K1P1S.skin.lua",
		noteskin7key1pedal1scratch = "userdata/skins/4649ceynou/5K1P1S.skin.lua",
		noteskin7key1scratch = "userdata/skins/4649ceynou/7K1S.skin.lua",
		noteskin8key = "userdata/skins/4649ceynou/8K.skin.lua",
		noteskin8key1scratch = "userdata/skins/4649ceynou/5K1P1S.skin.lua",
		noteskin9key = "userdata/skins/4649ceynou/9K.skin.lua",
		noteskin9key2scratch = "userdata/skins/4649ceynou/5K1P1S.skin.lua",
		noteskin10key = "userdata/skins/muu_PrayerV2_edit/skin.ini",
		noteskin10key1scratch = "userdata/skins/4649ceynou/5K1P1S.skin.lua",
		noteskin10key2scratch = "userdata/skins/4649ceynou/10K2S.skin.lua",
		noteskin11key1scratch = "userdata/skins/4649ceynou/5K1P1S.skin.lua",
		noteskin12key1scratch = "userdata/skins/4649ceynou/5K1P1S.skin.lua",
		noteskin12key2scratch = "userdata/skins/4649ceynou/5K1P1S.skin.lua",
		noteskin14key2scratch = "userdata/skins/4649ceynou/14K2S.skin.lua",
		noteskin18key = "userdata/skins/muu_PrayerV2_edit/skin.ini",
		noteskin88key = "userdata/skins/soundsphere piano/88key.skin.lua",
		offset = {
			input = 0,
			judgement = 0,
			note = -0.006,
			visual = 0
		},
		pauseOnFail = false,
		ratingHitTimingWindow = 0.016,
		replayType = "NanoChart",
		speed = 1.9,
		time = {
			pausePlay = 0.5,
			pauseRetry = 0.5,
			playPause = 0,
			playRetry = 0.5,
			prepare = 2
		}
	},
	graphics = {
		asynckey = false,
		blur = {
			gameplay = 0,
			result = 0,
			select = 0
		},
		cursor = "arrow",
		dim = {
			gameplay = 1,
			result = 0.8,
			select = 0.8
		},
		dwmflush = false,
		fps = 240,
		mode = {
			flags = {
				borderless = false,
				centered = true,
				display = 1,
				fullscreen = true,
				fullscreentype = "exclusive",
				highdpi = false,
				msaa = 0,
				resizable = true,
				usedpiscale = true,
				vsync = 0
			},
			fullscreen = {
				height = 1080,
				width = 1920
			},
			window = {
				height = 540,
				width = 960
			}
		},
		perspective = {
			camera = false,
			pitch = 0,
			rx = false,
			ry = false,
			x = 0.5,
			y = 0.5,
			yaw = 0,
			z = -0.71407400337106
		},
		predictDrawTime = false
	},
	input = {
		offset = {
			decrease = "[",
			increase = "="
		},
		pause = "escape",
		playSpeed = {
			decrease = "f3",
			increase = "f4",
			invert = "f2"
		},
		quickRestart = "t",
		screenshot = {
			capture = "f12",
			open = "lshift"
		},
		selectRandom = "f2",
		skipIntro = "space",
		timeRate = {
			decrease = "f5",
			increase = "f6",
			invert = "f7"
		}
	},
	miscellaneous = {
		autoUpdate = true
	}
}
