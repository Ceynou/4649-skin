local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")
local gfx_util = require("gfx_util")

local base = {}

base.createNoteskin = function(key, scratch, pedal, path, config)
	local name, inputMode
	local width, input, image, spaces, pressed, released, lines = {}, {}, {}, {}, {}, {}, {}

	for i = 1,  key do
		input[i] = "key" .. i
	end

	for i = 1, key + 1 do
		spaces[i] = 0
		lines[i] = 0
	end

	if key % 2 ~= 0 then
		for i = 1, key do
			if i % 2 ~= 0 then
				image[i] = "color1"
				width[i] = config:get("widthKey1")
			else
				image[i] = "color2"
				width[i] = config:get("widthKey2")
			end
		end
	else
		for i = 1, key do
			if i < math.floor(key / 2) + 1 then
				if i % 2 ~= 0 then
					image[i] = "color1"
					width[i] = config:get("widthKey1")
				else
					image[i] = "color2"
					width[i] = config:get("widthKey2")
				end
			else
				if i % 2 ~= 0 then
					image[i] = "color2"
					width[i] = config:get("widthKey2")
				else
					image[i] = "color1"
					width[i] = config:get("widthKey1")
				end
			end
		end
	end

	if key > 9 and key % 2 == 0 then
		spaces[math.floor(key / 2) + 1] = config:get("widthLines")
		lines[math.floor(key / 2) + 1] = config:get("widthLines")
	end

	local offsetCenter = 0
	if scratch ~= 0 then
		local inputS, imageS = {}, {}
		
		if pedal ~= 0 then
			local inputP, imageP = {}, {}

			name = "4649's " .. key .. "K" .. pedal .. "P" .. scratch .. "S"
			inputMode = key .. "key" .. pedal .. "pedal" .. scratch .. "scratch"

			inputP[1] = "pedal" .. 1
			inputS[1] = "scratch" .. 1

			imageS[1] = "colorS"
			imageP[1] = "colorP"

			if config:get("scratchAlign") == "center" then
				table.insert(input, 1, inputS[1])
				table.insert(input, 2, inputP[1])

				table.insert(image, 1, imageS[1])
				table.insert(image, 2, imageP[1])
			else
				if config:get("scratchAlign") == "right" then
					table.insert(input, 1, inputP[1])
					table.insert(input, #input + 1, inputS[1])

					table.insert(image, 1, imageP[1])
					table.insert(image, #input, imageS[1])
				else
					table.insert(input, 1, inputS[1])
					table.insert(input, #input + 1, inputP[1])

					table.insert(image, 1, imageS[1])
					table.insert(image, #input, imageP[1])
				end
				table.insert(spaces, 2, config:get("widthLines"))
				table.insert(spaces, #input, config:get("widthLines"))

				table.insert(lines, 2, config:get("widthLines"))
				table.insert(lines, #input, config:get("widthLines"))
					
				table.insert(width, 1, config:get("widthSP"))
				table.insert(width, #input, config:get("widthSP"))
			end
		else
			name = "4649's " .. key .. "K" .. scratch .. "S"
			inputMode = key .. "key" .. scratch .. "scratch"

			for i = 1, scratch do
				inputS[i] = "scratch" .. i
				imageS[i] = "colorS"
			end

			if scratch == 2 then
				if config:get("scratchAlign") == "center" then
					table.insert(input, 1, inputS[1])
					table.insert(input, 2, inputS[2])

					table.insert(image, 1, imageS[1])
					table.insert(image, 2, imageS[2])
				else
					table.insert(input, 1, inputS[1])
					table.insert(input, #input + 1, inputS[2])

					table.insert(image, 1, imageS[1])
					table.insert(image, #input, imageS[2])
				
					table.insert(width, 1, config:get("widthSP"))
					table.insert(width, #input, config:get("widthSP"))

					table.insert(spaces, 2, config:get("widthLines"))
					table.insert(spaces, #input, config:get("widthLines"))

					table.insert(lines, 2, config:get("widthLines"))
					table.insert(lines, #input, config:get("widthLines"))
				end
			else
				if config:get("scratchAlign") == "center" then
					table.insert(input, 1, inputS[1])

					table.insert(image, 1, imageS[1])
				elseif config:get("scratchAlign") == "left" then
					table.insert(input, 1, inputS[1])

					table.insert(image, 1, imageS[1])

					table.insert(width, 1, config:get("widthSP"))

					table.insert(spaces, 2, config:get("widthLines"))

					table.insert(lines, 2, config:get("widthLines"))
				else
					table.insert(input, #input + 1, inputS[1])

					table.insert(image, #input, imageS[1])

					table.insert(width, #input, config:get("widthSP"))

					table.insert(spaces, #input, config:get("widthLines"))

					table.insert(lines, #input, config:get("widthLines"))
				end
			end
		end
	elseif pedal ~= 0 then
		local inputP, imageP = {}, {}

		name = "4649's " .. key .. "K" .. pedal .. "P"
		inputMode = key .. "key" .. pedal .. "pedal"
		
		for i = 1, pedal do
			inputP[i] = "pedal" .. i
		end
		
		for i = 1, #inputP do
			imageP[i] = "colorP"
		end

		if config:get("scratchAlign") == "center" then
			table.insert(input, 1, inputP[1])

			table.insert(image, 1, imageP[1])
		elseif config:get("scratchAlign") == "left" then
			table.insert(input, #input, inputP[1])

			table.insert(image, #input, imageP[1])
				
			table.insert(width, #input, config:get("widthSP"))

			table.insert(spaces, #input, config:get("widthLines"))

			table.insert(lines, #input, config:get("widthLines"))
		else
			table.insert(input, 1, inputP[1])

			table.insert(image, 1, imageP[1])
				
			table.insert(width, 1, config:get("widthSP"))

			table.insert(spaces, 2, config:get("widthLines"))

			table.insert(lines, 2, config:get("widthLines"))
		end
	else
		name = "4649's " .. key .. "K"
		inputMode = key .. "key"
	end

	for i = 1, #input do
		pressed[i] = "pressed.png"
		released[i] = "black.png"
	end

	local widthTotal = 0
	local spaceTotal = 0
	local lineSpace = 0
	if config:get("align") == "center" and scratch+pedal == 1 then
		if config:get("scratchAlign")== "left" then
			offsetCenter = -config:get("widthSP") / 2
		elseif  config:get("scratchAlign") == "right" then
			offsetCenter = config:get("widthSP") / 2
		end
	end

	if config:get("scratchAlign") == "center" then
		for i = 1, key do
			widthTotal = widthTotal + width[i]
			spaceTotal = spaceTotal + spaces[i]
		end
		if scratch + pedal == 2 then
			table.insert(width, 1, widthTotal/2)
			table.insert(width, 1, widthTotal/2)
			
			table.insert(spaces, 2, 0)
			table.insert(spaces, 3, -widthTotal)
			if key > 9 and key % 2 == 0 then
				spaces[2] = config:get("widthLines")
				spaces[3] = -widthTotal - config:get("widthLines")
			end
			table.insert(lines, 1, 0)
			table.insert(lines, 2, 0)
		elseif scratch + pedal == 1 then
			table.insert(width, 1, widthTotal + spaceTotal)

			table.insert(spaces, 2, -widthTotal - config:get("widthLines"))
			
			table.insert(lines, 1, 0)
		end
		lineSpace = spaceTotal / 2
	else
		for i = 1, #input do
			widthTotal = widthTotal + spaces[i] + width[i]
			spaceTotal = spaceTotal + spaces[i]
		end
	end
	local noteskin = NoteSkinVsrg:new({
		path = path,
		name = name,
		inputMode = inputMode,
		range = {-1, 1},
		unit = 480,
		hitposition = config:get("hitposition"),
		config = config,
	})
	noteskin:setInput(input)
	noteskin:setColumns({
		offset = config:get("offset") + offsetCenter,
		align = config:get("align"),
		width = width,
		space = spaces,
	})
	noteskin:setTextures({
		{red = "red.png"},
		{green = "green.png"},
		{pixel = "pixel.png"},
		{black = "black.png"},
		{blue = "blue.png"},
		{white = "white.png"},
		{yellow = "yellow.png"}
	})
	noteskin:setImages({
		colorS = {"red"},
		colorP = {"green"},
		pixel = {"pixel"},
		black = {"black"},
		color2 = {"blue"},
		color1 = {"white"},
		yellow = {"yellow"}
	})

	noteskin:setShortNote({
		image = image,
		h = config:get("height"),
	})
	noteskin:setLongNote({
		head = image,
		body = image,
		tail = image,
		h = config:get("height"),
	})

	noteskin:setShortNote({
		image = "yellow",
		h = config:get("height"),
    }, "SoundNote")
	
	noteskin:addMeasureLine({
	})

	noteskin:addBga({
		x = 0,
		y = 0,
		w = 1,
		h = 1,
		color = {0.25, 0.25, 0.25, 1}
	})
	local playfield = BasePlayfield:new({
		noteskin = noteskin
	})
	playfield:addColumnsBackground({
		color = {0, 0, 0, 1}
	})
	playfield:add({
		transform = playfield:newLaneCenterTransform(480),
        draw = function(self)
            love.graphics.replaceTransform(gfx_util.transform(self.transform))
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.rectangle(
				"fill", 
				-widthTotal / 2 - lineSpace, 
				config:get("hitposition"),
				widthTotal + lineSpace * 2,
				480 - config:get("hitposition")
			)
        end
	})
	playfield:addBga({
		transform = {{1 / 2, -16 / 9 / 2}, {0, -7 / 9 / 2}, 0, {0, 16 / 9}, {0, 16 / 9}, 0, 0, 0, 0}
	})
	playfield:enableCamera()
	playfield:addNotes()

	playfield:addKeyImages({
		h = 480 - config:get("hitposition") - config:get("widthLines") * 2,
		padding = 0,
		pressed = pressed,
		released = released,
	})
	playfield:disableCamera()
	if config:get("baseElements") == true then
		playfield:addBaseElements()
	end

	local widthAdd = {0}
	local oneOrZero = 0

	for i = 2, key + scratch + pedal do
		widthAdd[i] = widthAdd[i-1] + spaces[i-1] + width[i-1]
		if i > math.ceil((key+scratch+pedal) / 4) and i < math.ceil((key+scratch+pedal) / 4 * 3) and config:get("scratchAlign") == "center" then
			oneOrZero = 1
		else
			oneOrZero = 0
		end
		playfield:add({
			transform = playfield:newLaneCenterTransform(480),
			draw = function(self)
				love.graphics.replaceTransform(gfx_util.transform(self.transform))
				love.graphics.setColor(0.5, 0.5, 0.5, 1)
				love.graphics.rectangle(
					"fill", 
					-widthTotal / 2 + widthAdd[i] - oneOrZero * config:get("widthLines") / 2,
					0,
					lines[i],
					config:get("hitposition")
				)
			end
		})
	end
	playfield:add({
		transform = playfield:newLaneCenterTransform(480),
        draw = function(self)
            love.graphics.replaceTransform(gfx_util.transform(self.transform))
            love.graphics.setColor(0.5, 0.5, 0.5, 1)
            love.graphics.rectangle(
				"fill", 
				-widthTotal / 2 - lineSpace,
				config:get("hitposition"),
				widthTotal + lineSpace * 2,
				config:get("widthLines") * 2
			)
        end
	})
	playfield:add({
		transform = playfield:newLaneCenterTransform(480),
        draw = function(self)
            love.graphics.replaceTransform(gfx_util.transform(self.transform))
            love.graphics.setColor(0.5, 0.5, 0.5, 1)
            love.graphics.rectangle(
				"fill", 
				-widthTotal / 2 - config:get("widthLines") * 2 - lineSpace,
				0,
				config:get("widthLines") * 2,
				480
			)
        end
	})
	playfield:add({
		transform = playfield:newLaneCenterTransform(480),
        draw = function(self)
            love.graphics.replaceTransform(gfx_util.transform(self.transform))
            love.graphics.setColor(0.5, 0.5, 0.5, 1)
            love.graphics.rectangle(
				"fill", 
				widthTotal / 2 + lineSpace, 
				0,
				config:get("widthLines") * 2,
				480
			)
        end
	})
	return noteskin
end

return base