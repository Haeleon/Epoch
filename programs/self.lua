-- self library for turtles for enhanced movement and abstracted turtle self-management

local self = {
    craft = turtle.craft,
    --forward = turtle.forward,
    --back = turtle.back,
    --up = turtle.up,
    --down = turtle.down,
    --turnLeft = turtle.turnLeft,
    --turnRight = turtle.turnRight,
    dig = turtle.dig,
    digUp = turtle.digUp,
    digDown = turtle.digDown,
    --place = turtle.place,
    --placeUp = turtle.placeUp,
    --placeDown = turtle.placeDown,
    drop = turtle.drop,
    dropUp = turtle.dropUp,
    dropDown = turtle.dropDown,
    select = turtle.select,
    getItemCount = turtle.getItemCount,
    getItemSpace = turtle.getItemSpace,
    detect = turtle.detect,
    detectUp = turtle.detectUp,
    detectDown = turtle.detectDown,
    compare = turtle.compare,
    compareUp = turtle.compareUp,
    compareDown = turtle.compareDown,
    attack = turtle.attack,
    attackUp = turtle.attackUp,
    attackDown = turtle.attackDown,
    suck = turtle.suck,
    suckUp = turtle.suckUp,
    suckDown = turtle.suckDown,
    getFuelLevel = turtle.getFuelLevel,
    refuel = turtle.refuel,
    compareTo = turtle.compareTo,
    transferTo = turtle.transferTo,
    getSelectedSlot = turtle.getSelectedSlot,
    getFuelLimit = turtle.getFuelLimit,
    equipLeft = turtle.equipLeft,
    equipRight = turtle.equipRight,
    inspect = turtle.inspect,
    inspectUp = turtle.inspectUp,
    inspectDown = turtle.inspectDown,
    getItemDetail = turtle.getItemDetail
 }
 
 local expect = require "cc.expect"
 
 -- Enhanced movement
 
 self.forced = false
 
 self.forward = function()
     local b, res = turtle.forward()
     if self.forced then
         while not b do
             if not self.dig() then return false, "Unremovable obstruction" end
             b, res = turtle.forward()
         end
     end
     if self.track and b then
         if self.position.h == 0 then
             self.position.x = self.position.x + 1
         elseif self.position.h == 1 then
             self.position.z = self.position.z + 1
         elseif self.position.h == 2 then
             self.position.x = self.position.x - 1
         elseif self.position.h == 3 then
             self.position.z = self.position.z - 1
         end
     end
 --	print("Tracking: x " .. self.position.x .. ", y " .. self.position.y .. ", z " .. self.position.z .. ", h " .. self.position.h);
     return b, res;
 end
 
 self.back = function()
     local b, res = turtle.back()
     if self.forced and not b then
         self.turnRight()
         self.turnRight()
         while not b do
             if not self.dig() then return false, "Unremovable obstruction" end
             b, res = turtle.forward()
         end
         self.turnRight()
         self.turnRight()
     end
     if self.track and b then
         if self.position.h == 0 then
             self.position.x = self.position.x - 1
         elseif self.position.h == 1 then
             self.position.z = self.position.z - 1
         elseif self.position.h == 2 then
             self.position.x = self.position.x + 1
         elseif self.position.h == 3 then
             self.position.z = self.position.z + 1
         end
     end
 --	print("Tracking: x " .. self.position.x .. ", y " .. self.position.y .. ", z " .. self.position.z .. ", h " .. self.position.h);
     return b, res;
 end
 
 self.up = function()
     local b, res = turtle.up()
     if self.forced then
         while not b do
             if not self.digUp() then return false, "Unremovable obstruction" end
             b, res = turtle.up()
         end
     end
     if self.track and b then
         self.position.y = self.position.y + 1
     end
 --	print("Tracking: x " .. self.position.x .. ", y " .. self.position.y .. ", z " .. self.position.z .. ", h " .. self.position.h);
     return b, res;
 end
 
 self.down = function()
     local b, res = turtle.down()
     if self.forced then
         while not b do
             if not self.digDown() then return false, "Unremovable obstruction" end
             b, res = turtle.down()
         end
     end
     if self.track and b then
         self.position.y = self.position.y - 1
     end
 --	print("Tracking: x " .. self.position.x .. ", y " .. self.position.y .. ", z " .. self.position.z .. ", h " .. self.position.h);
     return b, res;
 end
 
 self.turnLeft = function()
     if self.track then
         self.position.h = (self.position.h+3)%4
     end
 --	print("Tracking: x " .. self.position.x .. ", y " .. self.position.y .. ", z " .. self.position.z .. ", h " .. self.position.h);
     return turtle.turnLeft();
 end
 
 self.turnRight = function()
     if self.track then
         self.position.h = (self.position.h+1)%4
     end
 --	print("Tracking: x " .. self.position.x .. ", y " .. self.position.y .. ", z " .. self.position.z .. ", h " .. self.position.h);
     return turtle.turnRight();
 end
 
 -- Auto-increment slots
 self.autoIncrementSlot = false;
 
 self.place = function()
     if self.autoIncrementSlot then
         if turtle.getItemCount() == 0 then
             turtle.select(turtle.getSelectedSlot()%16+1)
         end
     end
     return turtle.place()
 end
 
 
 self.placeUp = function()
     if self.autoIncrementSlot then
         if turtle.getItemCount() == 0 then
             turtle.select(turtle.getSelectedSlot()%16+1)
         end
     end
     return turtle.placeUp()
 end
 
 
 self.placeDown = function()
     if self.autoIncrementSlot then
         if turtle.getItemCount() == 0 then
             turtle.select(turtle.getSelectedSlot()%16+1)
         end
     end
     return turtle.placeDown()
 end
 
 -- location handling
 
 self.track = true;
 
 self.position = {
     x = 0,
     z = 0,
     y = 0,
     h = 0
 }
 
 self.resetPosition = function()
     self.position.x = 0;
     self.position.z = 0;
     self.position.y = 0;
     self.position.h = 0;
 end
 
 --self.markedPositions = {};
 
 --self.markPosition = function()
 --	self.markedPositions[table.getn(markedPositions)] = {
 --		x = self.positions.x,
 --		z = self.positions.z,
 --		y = self.positions.y,
 --		h = self.positions.h,
 --	}
 --end
 
 --self.clearMarkedPositions = function()
 --	self.markedPositions = {};
 --end
 
 self.getPosition = function()
     return {
         x = self.position.x,
         z = self.position.z,
         y = self.position.y,
         h = self.position.h,
     }
 end
 
 self.goToPosition = function(posOrX, z, y, h)
     local pos = {}
     expect(1, posOrX, "number", "table")
     if type(posOrX) == "number" then
         pos.x = posOrX
         expect(2, z, "number")
         pos.z = z
         expect(3, y, "number")
         pos.y = y
         expect(4, h, "number", "nil")
         pos.h = h
         if h == nil then h = self.position.h end
     else
         pos = posOrX;
     end
     
     while self.position.y < pos.y do
         if not self.up() then return self.up() end
     end
     if self.position.z ~= pos.z then 
         while self.position.h ~= 1 do
             if not self.turnLeft() then return self.turnLeft() end
         end
     end
     while self.position.h ~= 1 do
         if not self.turnRight() then return self.turnRight() end
     end
     while self.position.z > pos.z do
         if not self.back() then return self.back() end
     end
     while self.position.z < pos.z do
         if not self.forward() then return self.forward() end
     end
     if self.position.x ~= pos.x then 
         while self.position.h ~= 0 do
             if not self.turnLeft() then return self.turnLeft() end
         end
     end
     while self.position.x > pos.x do
         if not self.back() then return self.back() end
     end
     while self.position.x < pos.x do
         if not self.forward() then return self.forward() end
     end
     while self.position.h ~= pos.h do
         if not self.turnLeft() then return self.turnLeft() end
     end
     while self.position.y > pos.y do
         if not self.down() then return self.down() end
     end
     return true, self.getPosition()
 end
 
 return self