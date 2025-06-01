local Player = Object:extend()

local MOVE_SPEED = 100
local SPRITE_SHEET = love.graphics.newImage("assets/player_sprites.png")
local STATE = { IDLE = 0, WALKING = 1, }
local WALK_STATE = { DOWN = 0, UP = 1, LEFT = 2, RIGHT = 3 } -- Sprite sheet order is DOWN, UP, LEFT, RIGHT
local SPRITE_W = 16
local SPRITE_H = 16

local function createWalkAnimation(image, w, h, duration)
    local animation = {}
    animation.duration = duration or 1
    animation.currentTime = 0
    animation.spriteSheet = image;
    animation.quads = {}

    for x = 0, math.floor(image:getWidth() / w) - 1 do
        for y = 0, 3 do -- 4 total walk animation steps, laid out vertically
            animation.quads[#animation.quads + 1] = love.graphics.newQuad(x * w, y * h, w, h, image:getDimensions())
        end
    end

    return animation
end

function Player:new(pos)
    self.pos = pos

    self.animation = createWalkAnimation(SPRITE_SHEET, SPRITE_W, SPRITE_H, 1)
    self.scale = Vec2(2, 2)
    self.state = STATE.IDLE
    self.walkState = WALK_STATE.DOWN
end

function Player:animate()
    -- 4 total movement directions, so calculate the number of steps per move animation
    local numSteps = #self.animation.quads / 4
    -- IDLE state just sits on the first frame of the walk animation
    local step = 1
    if self.state == STATE.WALKING then
        -- Figure out which frame of the walk animation we need to show
        step = math.floor(self.animation.currentTime / self.animation.duration * numSteps) + 1
    end
    -- All sprite steps are stored linearly, so we need to index to the animation frames based on walk direction.
    step = (self.walkState * numSteps) + step
    love.graphics.draw(self.animation.spriteSheet, self.animation.quads[step], self.pos.x, self.pos.y, self.pos.r,
        self.scale.x, self.scale.y)
end

function Player:draw()
    self:animate()
end

function Player:update(dt)
    self.animation.currentTime = self.animation.currentTime + dt
    if self.animation.currentTime >= self.animation.duration then
        self.animation.currentTime = self.animation.currentTime - self.animation.duration
    end

    self.state = STATE.IDLE
    if ((love.keyboard.isDown("f") and love.keyboard.isDown("s")) or
            (love.keyboard.isDown("e") and love.keyboard.isDown("d"))) then
        -- Competing inputs: player is going nowhere.
        self.state = STATE.IDLE
    else
        if (love.keyboard.isDown("f")) then
            self.state = STATE.WALKING
            self.walkState = WALK_STATE.RIGHT
            self.pos.x = self.pos.x + MOVE_SPEED * dt
        end
        if (love.keyboard.isDown("s")) then
            self.state = STATE.WALKING
            self.walkState = WALK_STATE.LEFT
            self.pos.x = self.pos.x - MOVE_SPEED * dt
        end
        if (love.keyboard.isDown("e")) then
            self.state = STATE.WALKING
            self.walkState = WALK_STATE.UP
            self.pos.y = self.pos.y - MOVE_SPEED * dt
        end
        if (love.keyboard.isDown("d")) then
            self.state = STATE.WALKING
            self.walkState = WALK_STATE.DOWN
            self.pos.y = self.pos.y + MOVE_SPEED * dt
        end
    end
end

return Player
