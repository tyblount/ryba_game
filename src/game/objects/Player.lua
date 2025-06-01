Player = Object:extend()

local SPRITE_SHEET = love.graphics.newImage("assets/player_sprites.png")
local SPRITE_FRAME_TIME = 0.2
local SPRITE_W = 15
local SPRITE_H = 15
local SPRITE_GRID = anim8.newGrid(SPRITE_W, SPRITE_H, SPRITE_SHEET:getWidth(), SPRITE_SHEET:getHeight(), 0, 0, 1)
local STATE = { IDLE = 1, WALKING = 2, }
local DIRECTION = { DOWN = 1, UP = 2, LEFT = 3, RIGHT = 4 } -- Sprite sheet order is DOWN, UP, LEFT, RIGHT

function Player:new(pos)
    self.pos = pos

    self.animations = {
        walkDown = anim8.newAnimation(SPRITE_GRID(DIRECTION.DOWN, '1-4'), SPRITE_FRAME_TIME),
        walkUp = anim8.newAnimation(SPRITE_GRID(DIRECTION.UP, '1-4'), SPRITE_FRAME_TIME),
        walkLeft = anim8.newAnimation(SPRITE_GRID(DIRECTION.LEFT, '1-4'), SPRITE_FRAME_TIME),
        walkRight = anim8.newAnimation(SPRITE_GRID(DIRECTION.RIGHT, '1-4'), SPRITE_FRAME_TIME),
    }

    self.animation = self.animations.walkDown
    self.walkSpeed = 200
    self.scale = Vec2(3, 4)
    self.state = STATE.IDLE
    self.direction = DIRECTION.DOWN
end

function Player:updateAnimation(dt)
    if self.state == STATE.WALKING then
        if self.direction == DIRECTION.UP then
            self.animation = self.animations.walkUp
        elseif self.direction == DIRECTION.LEFT then
            self.animation = self.animations.walkLeft
        elseif self.direction == DIRECTION.RIGHT then
            self.animation = self.animations.walkRight
        else
            self.animation = self.animations.walkDown
        end
        self.animation:update(dt)
    else -- IDLE
        self.animation:gotoFrame(1)
    end
end

function Player:draw()
    self.animation:draw(SPRITE_SHEET, self.pos.x, self.pos.y, self.pos.r, self.scale.x, self.scale.y)
end

function Player:update(dt)
    self.state = STATE.IDLE
    if (love.keyboard.isDown("f") and love.keyboard.isDown("s")) or
        (love.keyboard.isDown("e") and love.keyboard.isDown("d")) then
        -- Competing inputs: player is going nowhere.
        self.state = STATE.IDLE
    else
        if love.keyboard.isDown("f") then
            self.state = STATE.WALKING
            self.direction = DIRECTION.RIGHT
            self.pos.x = self.pos.x + self.walkSpeed * dt
        end
        if love.keyboard.isDown("s") then
            self.state = STATE.WALKING
            self.direction = DIRECTION.LEFT
            self.pos.x = self.pos.x - self.walkSpeed * dt
        end
        if love.keyboard.isDown("e") then
            self.state = STATE.WALKING
            self.direction = DIRECTION.UP
            self.pos.y = self.pos.y - self.walkSpeed * dt
        end
        if love.keyboard.isDown("d") then
            self.state = STATE.WALKING
            self.direction = DIRECTION.DOWN
            self.pos.y = self.pos.y + self.walkSpeed * dt
        end
    end
    self:updateAnimation(dt)
end
