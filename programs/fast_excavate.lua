-- fast_excavate v1

if not turtle then
	print("This program requires a turtle")
	exit()
end

local tArgs = { ... }
local expect = require "cc.expect"
print(tArgs[1]);
expect(1, tonumber(tArgs[1]), "number");
expect(2, tonumber(tArgs[2]), "number", "nil");
expect(3, tonumber(tArgs[3]), "number", "nil");
local self = require "/epoch/self"

local depth = 0;
local x = tonumber(tArgs[1])
local y = tonumber(tArgs[2]) or tonumber(tArgs[1])
local maxDepth = tonumber(tArgs[3]) or 1000000
local facing = false;

local function unload()
	local bookmark = self.getPosition();
	self.goToPosition(0, 0, 0, 2);
	for i=1,16 do
		self.select(i);
		self.drop(64);
	end
	self.select(1);
	self.goToPosition(bookmark);
end

local function endProgram()
	self.goToPosition(0, 0, 0, 0);
	print("Finished!");
end

local function refuel()
	self.refuel()
end

local function miningCycle()
		if not self.forward() then endProgram() end
		if self.getItemCount(15) > 0 then self.back() unload() self.forward() end
		self.digUp();
		if self.getItemCount(15) > 0 then unload() end
		self.digDown();
		if self.getItemCount(15) > 0 then unload() end
end

local function main()
	self.forced = true;
	local cont = false;
	
	local p = self.getPosition();
	p.y = p.y-1; -- Start only one tile below the chest
	-- Repeat while it can move down
	while self.goToPosition(p) do
		-- Make sure to grab the block dircetly under it when it moves down
		self.digDown()
		if self.getItemCount(15) > 0 then unload() end
		for width=1,x do
			if cont then 
				if facing then
					self.turnLeft()
					miningCycle()
					self.turnLeft()
				else
					self.turnRight()
						miningCycle()
					self.turnRight()
				end
				facing = not facing
			end
			cont = true;
			for depth=2,y do
				miningCycle()
			end
		end
--		self.turnLeft()
--		self.turnLeft()
		p = self.getPosition();
		p.y = p.y-3;
		p.h = (p.h+2)%4;
--		if x%2 == 1 then facing = not facing end
--		facing = not facing
		cont = false;
	end
	endProgram()
end

main()