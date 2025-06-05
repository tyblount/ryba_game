Fishable = Object:extend()

function Fishable:new(pos, size)
    self.pos = pos
    self.size = size
    self.collider = Game.phys:newRectangleCollider(pos.x, pos.y, size.w, size.h)
    self.collider:setType("static")
end

function Fishable:overlaps(pos)
    local x1, y1 = self.pos.x, self.pos.y
    local x2, y2 = x1 + self.size.w, y1 + self.size.h
    return x1 <= pos.x and x2 >= pos.x and y1 <= pos.y and y2 >= pos.y
end

function Fishable:onInteract()
    Game.changeMode(GameMode.FISH)
    Game.minigame = FishingMinigame()
    Game.world:addEntity(Game.minigame, "Minigame")
end

function Fishable:update()
end

function Fishable:draw()
end
