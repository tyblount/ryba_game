Fishable = Object:extend()

local RIPPLE_SHEET = love.graphics.newImage("assets/ripple.png")
local RIPPLE_FRAME_W = 16
local RIPPLE_FRAME_H = 16
local RIPPLE_GRID = anim8.newGrid(RIPPLE_FRAME_W, RIPPLE_FRAME_H, RIPPLE_SHEET:getWidth(), RIPPLE_SHEET:getHeight(), 0, 0,
    0)

function Fishable:new(pos, size)
    self.pos = pos
    self.size = size
    self.collider = Game.phys:newRectangleCollider(pos.x, pos.y, size.w, size.h)
    self.collider:setType("static")

    -- Create ripple animation
    self.rippleAnimation = anim8.newAnimation(RIPPLE_GRID(1, '1-6'), 0.2)
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

function Fishable:update(dt)
    self.rippleAnimation:update(dt)
end

function Fishable:draw()
    -- Calculate center position of the fishable area
    local centerX = self.pos.x + self.size.w / 2
    local centerY = self.pos.y + self.size.h / 2

    -- Draw the ripple animation centered on the fishable area
    self.rippleAnimation:draw(RIPPLE_SHEET, centerX, centerY, 0, 1, 1, RIPPLE_FRAME_W / 2, RIPPLE_FRAME_H / 2)
end
