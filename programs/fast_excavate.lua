-- fast_excavate v1.0.4

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
    local bookmark = self.getPosition()
    self.goToPosition(0, 0, 0, 2)
    for i=1,16 do
        self.select(i)
        self.drop(64)
    end
    self.select(1)
    self.goToPosition(bookmark)
end

local function chcekRefuel()
    local pos = self.getPosition();
    local limit = pos.x + math.abs(pos.y) + pos.z + 20;

    if self.getFuelLevel() < limit then
        for i=1,16 do
            self.select(i)
            self.refuel(64)
        end            
    end

    if self.getFuelLevel() < limit then
        self.goToPosition(0, 0, 0, 2)
        self.select(1)
        print("Waiting for fuel...")
        while self.getFuelLevel() < limit*2 do
            self.refuel(64)
        end
        self.goToPosition(pos)
    end
end

local function endProgram()
    self.goToPosition(0, 0, 0, 0)
    print("Finished!")
end

local function refuel()
    self.refuel()
end

local function miningCycle()
        chcekRefuel()

        if not self.forward() then return false end
        if self.getItemCount(15) > 0 then 
            if self.back() then unload() self.forward() else unload() end
        end
        self.digUp();
        if self.getItemCount(15) > 0 then unload() end
        self.digDown();
        if self.getItemCount(15) > 0 then unload() end
        return true
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
                        if not miningCycle() then return 0 end
                    self.turnLeft()
                else
                    self.turnRight()
                        if not miningCycle() then return 0 end
                    self.turnRight()
                end
                facing = not facing
            end
            cont = true;
            for depth=2,y do
                if not miningCycle() then return 0 end
            end
        end
--        self.turnLeft()
--        self.turnLeft()
        p = self.getPosition();
        p.y = p.y-3;
        p.h = (p.h+2)%4;
--        if x%2 == 1 then facing = not facing end
--        facing = not facing
        cont = false;
    end
end

main()
endProgram()
