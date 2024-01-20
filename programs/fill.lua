-- Command to mimic some functionality of a Minecraft /fill command

local build = require "epoch/build";
local self = require "epoch/self"

local args = {...}
local x1 = tonumber(args[1])
local y1 = tonumber(args[2])
local z1 = tonumber(args[3])
local x2 = tonumber(args[4])
local y2 = tonumber(args[5])
local z2 = tonumber(args[6])
local block = args[7]
local mode = args[8] or "replace"

print(mode)
print(block)

local blocks = {}

for y=1,y2-y1 do
	blocks[y] = {}
	for x=1,x2-x1 do
		blocks[y][x] = {}
		for z=1,z2-z1 do
			local edges = 0
			if x == 1 or x == x2-x1 then edges = edges + 1 end
			if y == 1 or y == y2-y1 then edges = edges + 1 end
			if z == 1 or z == z2-z1 then edges = edges + 1 end
			-- print(x..", "..y..", "..z..": "..edges)
			if mode == "hollow" and edges > 0 or
				mode == "frame" and edges > 1 or
				mode == "corners" and edges > 2 or 
				mode == "replace" then
				blocks[y][x][z] = block;
			else
				blocks[y][x][z] = "minecraft:air";				
			end
			-- print(blocks[y][x][z]);
		end
	end
end

self.goToPosition(x1, y1, z1, 0)
self.resetPosition()
build.build(blocks)
self.goToPosition(-x1, 0, -z1, 0)
self.goToPosition(-x1, -y1, -z1, 0)
