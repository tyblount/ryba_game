Player = Object:extend()

local SPRITE_SHEET = love.graphics.newImage("assets/sprites_blanc.png")
local SPRITE_FRAME_TIME = 0.2
local SPRITE_W = 16
local SPRITE_H = 16
local SPRITE_GRID = anim8.newGrid(SPRITE_W, SPRITE_H, SPRITE_SHEET:getWidth(), SPRITE_SHEET:getHeight(), 0, 0, 0)

local State = { IDLE = 1, WALKING = 2, }
local Direction = { DOWN = 1, UP = 2, LEFT = 3, RIGHT = 4 } -- Sprite sheet order is DOWN, UP, LEFT, RIGHT

function Player:new(pos)
    self.pos = pos
    self.collider = Game.phys:newBSGRectangleCollider(pos.x, pos.y, SPRITE_W * .8, SPRITE_H * .8, 3)
    self.collider:setFixedRotation(true)

    self.animations = {
        walkDown = anim8.newAnimation(SPRITE_GRID(Direction.DOWN, '1-4'), SPRITE_FRAME_TIME),
        walkUp = anim8.newAnimation(SPRITE_GRID(Direction.UP, '1-4'), SPRITE_FRAME_TIME),
        walkLeft = anim8.newAnimation(SPRITE_GRID(Direction.LEFT, '1-4'), SPRITE_FRAME_TIME),
        walkRight = anim8.newAnimation(SPRITE_GRID(Direction.RIGHT, '1-4'), SPRITE_FRAME_TIME),
    }

    self.animation = self.animations.walkDown
    self.walkSpeed = 100
    self.state = State.IDLE
    self.direction = Direction.DOWN
end

function Player:updateAnimation(dt)
    if self.state == State.WALKING then
        if self.direction == Direction.UP then
            self.animation = self.animations.walkUp
        elseif self.direction == Direction.LEFT then
            self.animation = self.animations.walkLeft
        elseif self.direction == Direction.RIGHT then
            self.animation = self.animations.walkRight
        else
            self.animation = self.animations.walkDown
        end
        self.animation:update(dt)
    else -- IDLE
        self.animation:gotoFrame(1)
    end
end

function Player:update(dt)
    self.state = State.IDLE
    local vx = 0
    local vy = 0

    if Game.mode == GameMode.EXPLORE then
        if (love.keyboard.isDown("f") and love.keyboard.isDown("s")) or
            (love.keyboard.isDown("e") and love.keyboard.isDown("d")) then
            -- Competing inputs: player is going nowhere.
            self.state = State.IDLE
        else
            if love.keyboard.isDown("f") then
                self.state = State.WALKING
                self.direction = Direction.RIGHT
                vx = vx + self.walkSpeed
            end
            if love.keyboard.isDown("s") then
                self.state = State.WALKING
                self.direction = Direction.LEFT
                vx = vx - self.walkSpeed
            end
            if love.keyboard.isDown("e") then
                self.state = State.WALKING
                self.direction = Direction.UP
                vy = vy - self.walkSpeed
            end
            if love.keyboard.isDown("d") then
                self.state = State.WALKING
                self.direction = Direction.DOWN
                vy = vy + self.walkSpeed
            end
        end
    end

    self.collider:setLinearVelocity(vx, vy)

    self.pos.x = self.collider:getX()
    self.pos.y = self.collider:getY()
    self:updateAnimation(dt)
end

-- Check the next tile
function Player:interact()
    if Game.mode == GameMode.FISH then
        Game.changeMode(GameMode.EXPLORE)
        return
    end

    local target = Pos(self.pos.x, self.pos.y)
    if self.direction == Direction.LEFT then
        target.x = target.x - Game.map.tileSize
    elseif self.direction == Direction.RIGHT then
        target.x = target.x + Game.map.tileSize
    end
    if self.direction == Direction.UP then
        target.y = target.y - Game.map.tileSize
    elseif self.direction == Direction.DOWN then
        target.y = target.y + Game.map.tileSize
    end
    local match = Game.world:findFirst(function(obj)
        return obj:intersects(target)
    end, "Interactable")
    if (match) then
        match:onInteract()
    end
end

function Player:draw()
    -- Global scale is applied at the Game level, so we draw at normal scale
    self.animation:draw(SPRITE_SHEET, self.pos.x, self.pos.y, self.pos.r, 1, 1, SPRITE_W / 2, SPRITE_H / 2)
end
