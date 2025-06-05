Map = Object:extend()

function Map:new(path)
    self.gameMap = sti(path)
    self.tileSize = self.gameMap.tilewidth
    self.width = self.gameMap.width * self.tileSize
    self.height = self.gameMap.height * self.tileSize

    self.walls = {}
    if (self.gameMap.layers["Walls"]) then
        for _, obj in pairs(self.gameMap.layers["Walls"].objects) do
            local wall = Game.phys:newBSGRectangleCollider(obj.x, obj.y, obj.width, obj.height, 4)
            wall:setType("static")
            table.insert(self.walls, wall)
        end
    end

    -- Add edge walls around the map perimeter
    local wallThickness = self.tileSize

    -- Top wall
    local topWall = Game.phys:newRectangleCollider(0, -wallThickness, self.width, wallThickness)
    topWall:setType("static")
    table.insert(self.walls, topWall)

    -- Bottom wall
    local bottomWall = Game.phys:newRectangleCollider(0, self.height, self.width, wallThickness)
    bottomWall:setType("static")
    table.insert(self.walls, bottomWall)

    -- Left wall
    local leftWall = Game.phys:newRectangleCollider(-wallThickness, 0, wallThickness, self.height)
    leftWall:setType("static")
    table.insert(self.walls, leftWall)

    -- Right wall
    local rightWall = Game.phys:newRectangleCollider(self.width, 0, wallThickness, self.height)
    rightWall:setType("static")
    table.insert(self.walls, rightWall)

    if (self.gameMap.layers["Fishable"]) then
        for _, obj in pairs(self.gameMap.layers["Fishable"].objects) do
            local fishable = Fishable(Pos(obj.x, obj.y), Size(obj.width, obj.height))
            Game.world:addEntity(fishable, "Interactable")
        end
    end
end

function Map:draw()
    self.gameMap:drawLayer(self.gameMap.layers["Ground"])
    self.gameMap:drawLayer(self.gameMap.layers["Props"])
end

function Map:update()
end
