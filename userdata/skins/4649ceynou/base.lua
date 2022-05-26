local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")

local base = {}



base.createTable = function(key, scratch, pedal, cfg)
    local inputKey, inputPedal, inputScratch = {}, {}, {}
    local widthKey, widthSP = {}, {}
    local inputs = key + pedal + scratch
    local spaces, lines

    for i = 1, key do
        inputKey[i] = "key" .. i
    end
    for i = 1, scratch do
        inputScratch[i] = "scratch" .. i
    end
    for i = 1, pedal do
        inputPedal[i] = "pedal" .. i
    end
    for i = 1, inputs + 1 do
        spaces[i] = cfg:get("spaces")
        lines[i] = cfg:get("lines")
    end
    for i = 1, key do
        if i % 2 ~= 0 then
            imageKey[i] = cfg:get("color1")
            widthKey[i] = cfg:get("widthKey1")
        else
            imageKey[i] = cfg:get("color2")
            widthKey[i] = cfg:get("widthKey2")
        end
    end
    if key % 2 == 0 then
		for i = 1, key do
			if i > math.floor(key / 2) then
				if i % 2 ~= 0 then
					imageKey[i] = cfg:get("color2")
					widthKey[i] = cfg:get("widthKey2")
				else
					imageKey[i] = cfg:get("color1")
					widthKey[i] = cfg:get("widthKey1")
				end
			end
		end
    end
    -- key
    for key, value in pairs(inputs) do
        inputs[value] = 
    end

end

base.createConfig = function(key, scratch, pedal, cfg, path)
    base.createTable(key, scratch, pedal, cfg)
    local f = io.open(path,"r")
    if f == nil then
        io.close(f)
    else
        f:write("test" .. path)
        f:close()
    end
end

base.createNoteskin = function(key, scratch, pedal, path, cfg)
    local name = key .. "key"
    if pedal > 0 then
        name = name .. pedal .. "pedal"
    elseif scratch > 0 then
        name = name .. scratch .. "scratch"
    end
    
    local noteskin = NoteSkinVsrg:new({
		path = path,
		name = name .. " by 4649",
		inputMode = name,
		range = {-1, 1},
		unit = 1080,
		hitposition = cfg:get("hitposition"),
        config = cfg,
	})

    return noteskin
end

base.createPlayfield = function(key, scratch, pedal, path, cfg)

end

base.setX = function(x, input)

end
base.getX = function(xTable, input)

end

base.getFreeSpaceX = function(width)

end