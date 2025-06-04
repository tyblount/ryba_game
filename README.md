# ryba_
2d Fishing Simulator via Lua

## Development Setup

### Run
If you haven't yet, install the dependencies:
```sh
$> chmod +x ./lib/install.sh
$> ./lib/install.sh
```

Then, from the root directory, start the game with:
```sh
$> love .
```

### Repo Organization
```
<root>
  assets/     -- sprites, backgrounds, sounds, etc.
  lib/        -- contains an install script to download third-party stuff, and LICENSE files
  src/        -- the majority of the code we're writing lives here
    engine/   -- code that isn't ryba-specific and could be re-used in another game
    game/     -- code specifically for the ryba game
  conf.lua    -- special file that love runs before main.lua
  main.lua    -- special file that love runs to start the game
```

### Formatting with Prettier
Prettier is a code formatter that helps maintain consistent code style across your project.
It makes styling decisions for you (and your team) so that you don't have to spend time on it.

Follow the [installation instructions](https://prettier.io/docs/install) for your editor of choice.

### Lua Language Server
The Lua Language Server (LLS) makes coding with Lua in an editor a lot easier.
It provides [a bunch of features](https://luals.github.io/#features) like code completion, error checking, and documentation lookup.

Follow the [installation instructions](https://luals.github.io/#vscode-install) for your editor of choice.

#### Configuration
Configuration for LLS is defined in `.luarc.json`

#### Install the Löve LLS Addon
To get editor support for Löve, we need to install the LLS Addon. This will be pulled in along with other dependencies with the `lib/install.sh` script.

## Dependencies
Software and libraries we're using to build and run the game.

Most of these are installed automatically with the install script, but the programs that need manual installation are listed first.

### Löve2D
We're using the Löve2D framework to help make the more technical parts of game development easier.
It's hard to type the o-with-umlaut 'ö' so it may just be referred to as 'Love2D', 'Love', or even just 'love' elsewhere.
Follow the [installation instructions](https://love2d.org/wiki/Getting_Started) to install it for your platform.

### Maps and Tilesets
Using `Tiled` to create tilemaps and tilesets, which can be downloaded from the website:
- https://www.mapeditor.org/download.html

And then we're using `Simple-Tiled-Implementation` to load in the map data and render it using love. The install script will download this for you.

### Sprite Animation
Using `anim8` library to lookup animation frames in sprite sheets and animate those frames.

### Camera
Using `gamera` for camera management and rendering within the camera view.

### Physics
Using `windfield` for wrapping love's physics implementation and making it simpler to use.

**PATCH:**
For whatever reason, the `windfield` library (which is now archived) defines its own `World` class globally.
This conflicts with the local `engine/World`, so the install script makes a small patch to `windfield/init.lua`.

The following global declaration
```lua
-- in windfield/init.lua
World = {}
```
becomes a module-level `local` declaration
```lua
local World = {}
```

### Live Reload
It's a chore to have to quit the game and restart it whenever you make any changes.
The `lurker` package aims to reload changes while the game is running.
It also relies on `lume`, which is a library of Lua helper functions written by the
same developer, [rxi](http://github.com/rxi), aimed at game development.

### OOP
We're using `classic` to implement Object-Oriented Programming in Lua.

Using OOP certainly isn't a requirement for game dev in Lua, but it's familiar which has value on its own.
Plus, letting instances reference methods and fields on classes via metatable lookups
rather than maintaining references with closures better enables live reloading.

## References
Here are some resources that have been helpful so far:

- [Game Programming Patterns by Robert Nystrom](https://gameprogrammingpatterns.com/contents.html)
- [Love2D Basics on YT by Challacade](https://www.youtube.com/playlist?list=PLqPLyUreLV8DrLcLvQQ64Uz_h_JGLgGg2)
- [How to Löve by Sheepolution](https://sheepolution.com/learn/book/contents)
