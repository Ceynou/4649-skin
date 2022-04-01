local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")

local base = {}

base.createNoteskin = function(key, scratch, pedal, path, cfg)
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
				width[i] = cfg._4649.notes.widthKey1
			else
				image[i] = "color2"
				width[i] = cfg._4649.notes.widthKey2
			end
		end
	else
		for i = 1, key do
			if i < math.floor(key / 2) + 1 then
				if i % 2 ~= 0 then
					image[i] = "color1"
					width[i] = cfg._4649.notes.widthKey1
				else
					image[i] = "color2"
					width[i] = cfg._4649.notes.widthKey2
				end
			else
				if i % 2 ~= 0 then
					image[i] = "color2"
					width[i] = cfg._4649.notes.widthKey2
				else
					image[i] = "color1"
					width[i] = cfg._4649.notes.widthKey1
				end
			end
		end
	end


	if key > 9 and key % 2 == 0 then
		spaces[math.floor(key / 2) + 1] = cfg._4649.ui.widthLines
		lines[math.floor(key / 2) + 1] = cfg._4649.ui.widthLines
	end

	local offsetCenter = 0
	if scratch ~= 0 then
		local inputS, imageS = {}, {}
		
		if pedal ~= 0 then
			local inputP, imageP = {}, {}

			name = "4649 " .. key .. "K" .. pedal .. "P" .. scratch .. "S"
			inputMode = key .. "key" .. pedal .. "pedal" .. scratch .. "scratch"

			inputP[1] = "pedal" .. 1
			inputS[1] = "scratch" .. 1

			imageS[1] = "colorS"
			imageP[1] = "colorP"

			if cfg._4649.ui.scratchAlign == "center" then
				table.insert(input, 1, inputS[1])
				table.insert(input, 2, inputP[1])

				table.insert(image, 1, imageS[1])
				table.insert(image, 2, imageP[1])
			else
				if cfg._4649.ui.scratchAlign == "right" then
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
				table.insert(spaces, 2, cfg._4649.ui.widthLines)
				table.insert(spaces, #input, cfg._4649.ui.widthLines)

				table.insert(lines, 2, cfg._4649.ui.widthLines)
				table.insert(lines, #input, cfg._4649.ui.widthLines)
					
				table.insert(width, 1, cfg._4649.notes.widthSP)
				table.insert(width, #input, cfg._4649.notes.widthSP)
			end
		else
			name = "4649 " .. key .. "K" .. scratch .. "S"
			inputMode = key .. "key" .. scratch .. "scratch"

			for i = 1, scratch do
				inputS[i] = "scratch" .. i
				imageS[i] = "colorS"
			end

			if scratch == 2 then
				if cfg._4649.ui.scratchAlign == "center" then
					table.insert(input, 1, inputS[1])
					table.insert(input, 2, inputS[2])

					table.insert(image, 1, imageS[1])
					table.insert(image, 2, imageS[2])
				else
					table.insert(input, 1, inputS[1])
					table.insert(input, #input + 1, inputS[2])

					table.insert(image, 1, imageS[1])
					table.insert(image, #input, imageS[2])
				
					table.insert(width, 1, cfg._4649.notes.widthSP)
					table.insert(width, #input, cfg._4649.notes.widthSP)

					table.insert(spaces, 2, cfg._4649.ui.widthLines)
					table.insert(spaces, #input, cfg._4649.ui.widthLines)

					table.insert(lines, 2, cfg._4649.ui.widthLines)
					table.insert(lines, #input, cfg._4649.ui.widthLines)
				end
			else
				if cfg._4649.ui.scratchAlign == "center" then
					table.insert(input, 1, inputS[1])

					table.insert(image, 1, imageS[1])
				elseif cfg._4649.ui.scratchAlign == "left" then
					table.insert(input, 1, inputS[1])

					table.insert(image, 1, imageS[1])

					table.insert(width, 1, cfg._4649.notes.widthSP)

					table.insert(spaces, 2, cfg._4649.ui.widthLines)

					table.insert(lines, 2, cfg._4649.ui.widthLines)
				else
					table.insert(input, #input + 1, inputS[1])

					table.insert(image, #input, imageS[1])

					table.insert(width, #input, cfg._4649.notes.widthSP)

					table.insert(spaces, #input, cfg._4649.ui.widthLines)

					table.insert(lines, #input, cfg._4649.ui.widthLines)
				end
			end
		end
	elseif pedal ~= 0 then
		local inputP, imageP = {}, {}

		name = "4649 " .. key .. "K" .. pedal .. "P"
		inputMode = key .. "key" .. pedal .. "pedal"
		
		for i = 1, pedal do
			inputP[i] = "pedal" .. i
		end
		
		for i = 1, #inputP do
			imageP[i] = "colorP"
		end

		if cfg._4649.ui.scratchAlign == "center" then
			table.insert(input, 1, inputP[1])

			table.insert(image, 1, imageP[1])
		elseif cfg._4649.ui.scratchAlign == "left" then
			table.insert(input, #input, inputP[1])

			table.insert(image, #input, imageP[1])
				
			table.insert(width, #input, cfg._4649.notes.widthSP)

			table.insert(spaces, #input, cfg._4649.ui.widthLines)

			table.insert(lines, #input, cfg._4649.ui.widthLines)
		else
			table.insert(input, 1, inputP[1])

			table.insert(image, 1, imageP[1])
				
			table.insert(width, 1, cfg._4649.notes.widthSP)

			table.insert(spaces, 2, cfg._4649.ui.widthLines)

			table.insert(lines, 2, cfg._4649.ui.widthLines)
		end
	else
		name = "4649 " .. key .. "K"
		inputMode = key .. "key"
	end

	for i = 1, #input do
		pressed[i] = "pressed.png"
		released[i] = "black.png"
	end

	local widthTotal = 0
	local spaceTotal = 0
	local lineSpace = 0

	if cfg._4649.ui.align == "center" then
		if cfg._4649.ui.scratchAlign == "left" then
			offsetCenter = -cfg._4649.notes.widthSP / 2
		elseif  cfg._4649.ui.scratchAlign == "right" then
			offsetCenter = cfg._4649.notes.widthSP / 2
		end
	end

	if cfg._4649.ui.scratchAlign == "center" then
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
				spaces[2] = cfg._4649.ui.widthLines
				spaces[3] = -widthTotal - cfg._4649.ui.widthLines
			end
			table.insert(lines, 1, 0)
			table.insert(lines, 2, 0)
		elseif scratch + pedal == 1 then
			table.insert(width, 1, widthTotal + spaceTotal)

			table.insert(spaces, 2, -widthTotal - cfg._4649.ui.widthLines)
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
		hitposition = cfg._4649.ui.hitposition,
	})

	noteskin:setInput(input)
	noteskin:setColumns({
		offset = cfg._4649.ui.offset + offsetCenter,
		align = cfg._4649.ui.align,
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
		h = cfg._4649.notes.height,
	})
	noteskin:setLongNote({
		head = image,
		body = image,
		tail = image,
		h = cfg._4649.notes.height,
	})
	noteskin:addMeasureLine({
		h = 1,
		color = {1, 1, 1, 1},
		image = "pixel"
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
	playfield:addBga({
		transform = {{1 / 2, -16 / 9 / 2}, {0, -7 / 9 / 2}, 0, {0, 16 / 9}, {0, 16 / 9}, 0, 0, 0, 0}
	})
	playfield:enableCamera()
	playfield:add({
		class = "ImageView",
		x = 5, y = 0, w = 188, h = 480,
		transform = playfield:newNoteskinTransform(),
		image = "black.png",
	})
	playfield:addNotes()


	playfield:addKeyImages({
		h = 480 - cfg._4649.ui.hitposition - cfg._4649.ui.widthLines * 2,
		padding = 0,
		pressed = pressed,
		released = released,
	})
	playfield:disableCamera()
	if cfg._4649.ui.baseElements == true then
		playfield:addBaseElements()
	end
	playfield:add({
		class = "RectangleView",
		transform = playfield:newLaneCenterTransform(480),
		rectangles = {
			{
				color = {0.5, 0.5, 0.5, 0.5},
				mode = "fill",
				lineStyle = "smooth",
				lineWidth = 1,
				x = -widthTotal / 2 - lineSpace,
				y = cfg._4649.ui.hitposition,
				w = widthTotal + lineSpace * 2,
				h = cfg._4649.ui.widthLines * 2,
				rx = 0,
				ry = 0
			},
			{
				color = {0.5, 0.5, 0.5, 1},
				mode = "fill",
				lineStyle = "smooth",
				lineWidth = 1,
				x = -widthTotal / 2 - cfg._4649.ui.widthLines * 2 - lineSpace,
				y = 0,
				w = cfg._4649.ui.widthLines * 2,
				h = 480,
				rx = 0,
				ry = 0
			},
			{
				color = {0.5, 0.5, 0.5, 1},
				mode = "fill",
				lineStyle = "smooth",
				lineWidth = 1,
				x = widthTotal / 2 + lineSpace,
				y = 0,
				w = cfg._4649.ui.widthLines * 2,
				h = 480,
				rx = 0,
				ry = 0
			},
		}
	})

	local widthAdd = {0}
	local oneOrZero = 0

	for i = 2, key + scratch + pedal do
		widthAdd[i] = widthAdd[i-1] + spaces[i-1] + width[i-1]
		if i > math.ceil((key+scratch+pedal) / 4) and i < math.ceil((key+scratch+pedal) / 4 * 3) and cfg._4649.ui.scratchAlign == "center" then
			oneOrZero = 1
		else
			oneOrZero = 0
		end
		playfield:add({
			class = "RectangleView",
			transform = playfield:newLaneCenterTransform(480),
			rectangles = {
				{
					color = {1, 1, 1, 0.5},
					mode = "fill",
					lineStyle = "smooth",
					lineWidth = 1,
					x = -widthTotal / 2 + widthAdd[i] - oneOrZero * cfg._4649.ui.widthLines / 2,
					y = 0,
					w = lines[i],
					h = cfg._4649.ui.hitposition,
					rx = 0,
					ry = 0
				},
			}
		})
	end
	return noteskin
end

return base