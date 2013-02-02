--- {{{ Helper Functions }} 

-- {{ Tree-like filesystem }}
require('lfs')
function ls(dir)
	local iter, dir_obj = lfs.dir(dir)
	local files = { }
	local directories = { }
	local line = dir_obj:next()

	while line ~= nil do
		if lfs.attributes( dir .. '/' .. line, 'mode') == 'directory' and string.sub(line,1,1) ~= '.' then
			table.insert(directories,line .. '/')
		elseif string.sub(line,1,1) ~= '.' then 
			table.insert(files,line)
		end
		line = dir_obj:next()
	end
	dir_obj:close()
	return files,directories,dir
end

filters = {  
    { {'.mp3', '.flac', '.ogg'}, 'vlc'},
	{ {'.mkv','.avi'},'vlc'},
	{ {'.pdf'},'zathura' },
	{ {'.png','.jpeg','.jpg','.gif'} , 'viewnior'},
	{ {'.odt'}, 'abiword' },
	{ {'.*'}, 'terminal -e vim' }
}	

function action(file,filters)
	for i=1,#filters do
		for j=1,#filters[i][1] do
			if string.match(file,filters[i][1][j]) ~= nil then
				return filters[i][2] .. ' '
			end
		end
	end
end

function parse(files,directories,dir)
	local result = { }
	for i=1,#directories do
		table.insert(result, { directories[i], parse(ls(dir .. directories[i])) })
	end
	for i=1,#files do
		table.insert(result, { files[i], action(files[i],filters) .. string.gsub(dir .. files[i],' ','\\ ') })
	end
	return result
end

function genMenu(dir)
	return parse(ls(dir))
end

-- {{ Gradients
--    convets a value betwen min and max into a hexadecimal color.
--    You can specify your own start and stop color.
-- }}

function gradient(color, to_color, min, max, value)
    local function color2dec(c)
        return tonumber(c:sub(2,3),16), tonumber(c:sub(4,5),16), tonumber(c:sub(6,7),16)
    end

    local factor = 0
    if (value >= max ) then 
        factor = 1  
    elseif (value > min ) then 
        factor = (value - min) / (max - min)
    end 

    local red, green, blue = color2dec(color) 
    local to_red, to_green, to_blue = color2dec(to_color) 

    red   = red   + (factor * (to_red   - red))
    green = green + (factor * (to_green - green))
    blue  = blue  + (factor * (to_blue  - blue))

    -- dec2color
    return string.format("#%02x%02x%02x", red, green, blue)
end
