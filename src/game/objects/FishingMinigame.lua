FishingMinigame = Object:extend()

SPRITE_SHEET = love.graphics.newImage("assets/fish.png")
SPRITE_W = 16
SPRITE_H = 16
FISH_SPRITE = love.graphics.newQuad(0, 0, SPRITE_W, SPRITE_H,
    SPRITE_SHEET:getWidth(), SPRITE_SHEET:getHeight())

State = {
    WAITING = 1,
    CAUGHT = 2,
    MISSED = 3,
}

function FishingMinigame:new()
    self.state = State.WAITING
    self.screenWidth, self.screenHeight = love.window.getMode()

    -- Target zone properties
    self.circleR = math.min(self.screenWidth, self.screenHeight) * 0.10
    self.circlePos = Pos(self.screenWidth / 2, self.screenHeight / 2)

    -- Fish animation properties
    self.fishTime = 0
    self.fishSpeed = 3                           -- Speed of sine wave movement
    self.fishAmplitude = self.screenWidth * 0.35 -- How far fish moves horizontally
    self.fishY = self.circlePos.y                -- Fish moves at circle height

    -- Visual feedback
    self.showFeedback = false
    self.feedbackColor = { 1, 1, 1 }
    self.feedbackTime = 0
    self.feedbackDuration = 1.5
end

function FishingMinigame:onInteract()
    if self.showFeedback then
        -- Expedite finishing up the game
        self.feedbackTime = self.feedbackTime + self.feedbackDuration
        return
    end

    -- Check if fish center is within the circle
    local fishCenterX = self:getFishX() + SPRITE_W / 2
    local fishCenterY = self.fishY + SPRITE_H / 2

    -- Calculate distance from fish center to circle center
    local dx = fishCenterX - self.circlePos.x
    local dy = fishCenterY - self.circlePos.y
    local distance = math.sqrt(dx * dx + dy * dy)

    -- Check if fish is within the circle
    if distance <= self.circleR then
        self.state = State.CAUGHT
    else
        self.state = State.MISSED
    end

    self.showFeedback = true
    self.feedbackTime = 0
end

function FishingMinigame:getFishX()
    -- Calculate fish X position using sine wave
    local centerX = self.screenWidth / 2
    local offset = math.sin(self.fishTime * self.fishSpeed) * self.fishAmplitude
    return centerX + offset - SPRITE_W / 2
end

function FishingMinigame:draw()
    love.graphics.push()
    love.graphics.origin()

    -- Draw opaque overlay over the entire screen
    love.graphics.setColor(0, 0, 0, 0.5) -- Semi-transparent black overlay
    love.graphics.rectangle("fill", 0, 0, self.screenWidth, self.screenHeight)

    -- Draw center target zone
    if self.state == State.CAUGHT then
        love.graphics.setColor(0.2, 1, 0.6, 0.8)
    elseif self.state == State.MISSED then
        love.graphics.setColor(1, 0.2, 0.6, 0.8)
    else
        love.graphics.setColor(0.2, 0.6, 1, 0.8)
    end
    love.graphics.circle("fill", self.circlePos.x, self.circlePos.y, self.circleR)

    -- Draw circle outline
    if self.state == State.CAUGHT then
        love.graphics.setColor(0.4, 0.9, 0, 1)
    elseif self.state == State.MISSED then
        love.graphics.setColor(0.9, 0, 0.4, 1)
    else
        love.graphics.setColor(0, 0.4, 0.9, 1)
    end
    love.graphics.setLineWidth(4)
    love.graphics.circle("line", self.circlePos.x, self.circlePos.y, self.circleR)
    love.graphics.setLineWidth(1)

    -- Draw the fish sprite (top-left sprite from fish.png)
    love.graphics.setColor(1, 1, 1, 1) -- Reset color to white for sprite
    love.graphics.draw(SPRITE_SHEET, FISH_SPRITE, self:getFishX(), self.fishY, 0, 4, 4, SPRITE_W / 2, SPRITE_H / 2)

    -- Restore graphics state
    love.graphics.pop()
end

function FishingMinigame:update(dt)
    if not self.showFeedback then
        -- Update fish animation time
        self.fishTime = self.fishTime + dt
    end

    -- Update feedback timer
    if self.showFeedback then
        self.feedbackTime = self.feedbackTime + dt
        if self.feedbackTime >= self.feedbackDuration then
            Game.changeMode(GameMode.EXPLORE)
            Game.world:removeAllOfType("Minigame")
            Game.minigame = nil
        end
    end
end
