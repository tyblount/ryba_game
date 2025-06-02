-- conf.lua: Love runs this file before running main.lua

function love.conf(t)
    t.title = "Ryba"   -- The title of the window
    t.version = "11.4" -- The LÖVE version this game was made for
    t.window.width = 320
    t.window.height = 320
    t.window.resizable = false -- Let the window be resizable?

    -- For debugging
    t.console = false -- Attach a console for print statements
end
