local lick = require "./lib/lick/lick"
lick.reset = true              -- call love.load() on every reload?
lick.showReloadMessage = false -- print a console log on every reload?

local x
local y
local velocity
function love.load()
    velocity = 100 -- pixels/s
    x = 300
    y = 300
end

function love.update(dt)
    if (love.keyboard.isDown("right")) then
        x = x + velocity * dt
    end
    if (love.keyboard.isDown("left")) then
        x = x - velocity * dt
    end
    if (love.keyboard.isDown("up")) then
        y = y - velocity * dt
    end
    if (love.keyboard.isDown("down")) then
        y = y + velocity * dt
    end
end

function love.draw()
    love.graphics.rectangle("line", x, y, 50, 100)
end
