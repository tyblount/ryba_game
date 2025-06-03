Map = Object:extend()

-- TODO: generalize this (for fun)
-- TODO: add walls around the map!

function Map:new(path)
    self.gameMap = sti(path)

    self.walls = {}
    if (self.gameMap.layers["Walls"]) then
        for _, obj in pairs(self.gameMap.layers["Walls"].objects) do
            local wall = Game.phys:newBSGRectangleCollider(obj.x, obj.y, obj.width, obj.height, 4)
            wall:setType("static")
            table.insert(self.walls, wall)
        end
    end
end

function Map:draw()
    self.gameMap:drawLayer(self.gameMap.layers["Ground"])
    self.gameMap:drawLayer(self.gameMap.layers["Props"])
end

function Map:update()
end
