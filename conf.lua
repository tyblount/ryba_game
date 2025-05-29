-- conf.lua: Love runs this file before running main.lua

-- Simple OOP for Lua
Object = require "lib/classic"

-- Push all of our classes into the global space
require "engine"
require "ryba"

-- Enable live reload
local lick = require "lib/lick"
lick.reset = false             -- call love.load() on every reload?
lick.showReloadMessage = false -- print a console log on every reload?

function love.conf(t)
    t.title = "Ryba"           -- The title of the window
    t.version = "11.4"         -- The LÖVE version this game was made for
    t.window.width = 800       -- The window width
    t.window.height = 600      -- The window height
    t.window.resizable = false -- Let the window be resizable?

    -- For debugging
    t.console = false -- Attach a console for print statements
end
