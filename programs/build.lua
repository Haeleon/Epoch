-- Builder v1
-- Builder goes depth first, then width, then height

local build = {
	build = function(blocks)

		local self = require "epoch/self"
		self.track = true
        self.forced = true

		-- Turtle builds below it (for now)
		self.up()

		for y=1,#blocks do
			for x=1,#blocks[y] do
				for z=1,#blocks[y][x] do
					local b = turtle.getItemDetail() or ""
					if blocks[y][x][z] == "minecraft:air" then goto continue end
					while b.name ~= blocks[y][x][z] do                
						print(blocks[y][x][z])
						print(b.name)
						turtle.select(turtle.getSelectedSlot()%16+1)
						b = turtle.getItemDetail() or ""
					end
					self.placeDown()
					::continue::
					self.forward()
					-- print("First loop")
				end
				-- print("Next row")
				self.goToPosition(0, self.getPosition().z+1, self.getPosition().y, 0)
			end
			-- print("Next layer")
			self.goToPosition(0, 0, self.getPosition().y+1, 0)
		end
		self.down()
	end
}

return build;