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
-- Push all of our classes into the global space
require "src/engine"
require "src/game"

function love.load()
    lurker.postswap = Game.reset
    Game.start()
end

function love.update(dt)
    lurker.update()
    Game.update(dt)
end

love.draw = Game.draw
