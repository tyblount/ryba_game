-- main.lua: Love runs this file as the entrypoint for the game.

-- Prevent blurring when scaling images up
love.graphics.setDefaultFilter("nearest", "nearest")
-- Simple OOP for Lua
Object = require "lib/classic"
-- Enable live reload
local lurker = require("lib/lurker")
lurker.path = "src"
-- Sprite loading and animation
anim8 = require "lib/anim8"
-- Tilemap loading and rendering
sti = require "lib/sti"
-- Camera control
gamera = require "lib/gamera"
-- Physics
wf = require "lib/windfield"
-- Push all of our classes into the global space
require "src/engine"
require "src/game"

function love.load()
    lurker.postswap = Game.reset
    Game.load()
end

function love.update(dt)
    lurker.update()
    Game.update(dt)
end

love.draw = Game.draw

function love.keyreleased(key)
    if key == ";" then
        Game.debug = not Game.debug
    end
    if key == "\\" then
        Game.reset()
    end
    if key == "j" then
        Game.player:interact()
    end
end
