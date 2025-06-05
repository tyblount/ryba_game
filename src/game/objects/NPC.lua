NPC = Object:extend()

local SPRITE_SHEET = love.graphics.newImage("assets/sprites_guy.png")
local SPRITE_W = 16
local SPRITE_H = 16
local SPRITE_GRID = anim8.newGrid(SPRITE_W, SPRITE_H, SPRITE_SHEET:getWidth(), SPRITE_SHEET:getHeight(), 0, 0, 0)

local Direction = { DOWN = 1, UP = 2, LEFT = 3, RIGHT = 4 }

function NPC:new(pos)
    self.pos = pos
    self.textIndex = 1
    self.text = {
        "I love fishing here every day!",
        "Good day for fish, yep!",
        "Yep yep!",
        "Fish, fish, fishity fish..",
        "DUMBLEDORE!",
        "..What'd I come out here for again?",
        "Oh right, fish!",
        "Fish for dinner!",
        "Fish for lunch!",
        "Fish for breakfast!",
        "Could be bears..",
        "Aw who'm I kiddin'!",
        "Could be fish!",
        "Fish are friends. And breakfast.",
    }

    -- Create a static collider so the player can't walk through the NPC
    self.collider = Game.phys:newBSGRectangleCollider(pos.x, pos.y, SPRITE_W * 0.8, SPRITE_H * 0.8, 3)
    self.collider:setType("static")
    self.collider:setFixedRotation(true)

    -- Animation frames for each direction
    self.animations = {
        faceDown = anim8.newAnimation(SPRITE_GRID(Direction.DOWN, 1), 1),
        faceUp = anim8.newAnimation(SPRITE_GRID(Direction.UP, 1), 1),
        faceLeft = anim8.newAnimation(SPRITE_GRID(Direction.LEFT, 1), 1),
        faceRight = anim8.newAnimation(SPRITE_GRID(Direction.RIGHT, 1), 1),
    }

    self.direction = Direction.DOWN
    self.animation = self.animations.faceDown

    -- Text display properties
    self.showText = false
    self.textTimer = 0
    self.textDuration = 2.0
    self.font = love.graphics.getFont()
    self.font:setFilter("nearest", "nearest")
end

function NPC:update(dt)
    -- Always face towards the player
    local dx = Game.player.pos.x - self.pos.x
    local dy = Game.player.pos.y - self.pos.y

    -- Determine which direction to face based on the largest distance component
    if math.abs(dx) > math.abs(dy) then
        if dx > 0 then
            self.direction = Direction.RIGHT
            self.animation = self.animations.faceRight
        else
            self.direction = Direction.LEFT
            self.animation = self.animations.faceLeft
        end
    else
        if dy > 0 then
            self.direction = Direction.DOWN
            self.animation = self.animations.faceDown
        else
            self.direction = Direction.UP
            self.animation = self.animations.faceUp
        end
    end

    -- Update text display timer
    if self.showText then
        self.textTimer = self.textTimer - dt
        if self.textTimer <= 0 then
            self.showText = false
        end
    end
end

function NPC:overlaps(pos)
    -- Check if the given position overlaps with this NPC's collision area
    local x1, y1 = self.pos.x, self.pos.y
    local x2, y2 = x1 + SPRITE_W, y1 + SPRITE_H
    return x1 <= pos.x and x2 >= pos.x and y1 <= pos.y and y2 >= pos.y
end

function NPC:onInteract()
    -- Show text above the NPC's head
    self.showText = true
    self.textIndex = self.textIndex + 1
    if self.textIndex > #self.text then
        self.textIndex = 1
    end
    self.textTimer = self.textDuration
end

function NPC:draw()
    -- Draw the NPC sprite
    self.animation:draw(SPRITE_SHEET, self.pos.x, self.pos.y, 0, 1, 1, 2, 2)

    -- Draw text above the NPC's head if it should be shown
    if self.showText then
        local textWidth = self.font:getWidth(self.text[self.textIndex])
        local textHeight = self.font:getHeight()
        local textX = self.pos.x - textWidth / 2
        local textY = self.pos.y - SPRITE_H - 5

        -- Draw a background for the text
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle("fill", textX - 4, textY - 2, textWidth + 8, textHeight + 4)

        -- Draw the text
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(self.text[self.textIndex], textX, textY)
    end
end
