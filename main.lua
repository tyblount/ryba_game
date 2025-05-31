-- main.lua: Love runs this file as the entrypoint for the game.

-- Simple OOP for Lua
Object = require "lib/classic"

-- Enable live reload
local lurker = require("lib/lurker")
lurker.path = "src"

-- Push all of our classes into the global space
require "src/engine"
require "src/game"

love.load = Game.load
love.draw = Game.draw
function love.update(dt)
    lurker.update()
    Game.update(dt)
end
