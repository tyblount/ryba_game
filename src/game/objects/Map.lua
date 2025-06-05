Map = Object:extend()

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

    -- Add edge walls around the map perimeter
    local mapWidth = self.gameMap.width * self.gameMap.tilewidth
    local mapHeight = self.gameMap.height * self.gameMap.tileheight
    local wallThickness = self.gameMap.tilewidth

    -- Top wall
    local topWall = Game.phys:newRectangleCollider(0, -wallThickness, mapWidth, wallThickness)
    topWall:setType("static")
    table.insert(self.walls, topWall)

    -- Bottom wall
    local bottomWall = Game.phys:newRectangleCollider(0, mapHeight, mapWidth, wallThickness)
    bottomWall:setType("static")
    table.insert(self.walls, bottomWall)

    -- Left wall
    local leftWall = Game.phys:newRectangleCollider(-wallThickness, 0, wallThickness, mapHeight)
    leftWall:setType("static")
    table.insert(self.walls, leftWall)

    -- Right wall
    local rightWall = Game.phys:newRectangleCollider(mapWidth, 0, wallThickness, mapHeight)
    rightWall:setType("static")
    table.insert(self.walls, rightWall)

    self.fishable = {}
    if (self.gameMap.layers["Fishable"]) then
        for _, obj in pairs(self.gameMap.layers["Fishable"].objects) do
            local fishable = Game.phys:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            fishable:setType("static")
            table.insert(self.fishable, fishable)
        end
    end
end

function Map:draw()
    self.gameMap:drawLayer(self.gameMap.layers["Ground"])
    self.gameMap:drawLayer(self.gameMap.layers["Props"])
end

function Map:update()
end
