-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")

-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Simple function to load additional LUA files from rc/.
function loadrc(name, mod)
  local success
  local result

  -- Which file? In rc/ or in lib/?
  local path = awful.util.getdir("config") .. "/" .. (mod and "lib" or "rc") .. "/" .. name .. ".lua"

  -- If the module is already loaded, don't load it again
  if mod and package.loaded[mod] then return package.loaded[mod] end

  -- Execute the RC/module file
  success, result = pcall(function() return dofile(path) end)
  if not success then
    naughty.notify({ title = "Error while loading an RC file",
                     text = "When loading `" .. name .. "`, got the following error:\n" .. result,
                     preset = naughty.config.presets.critical
    })
    return print("E: error loading RC file '" .. name .. "': " .. result)
  end

  -- Is it a module?
  if mod then
    return package.loaded[mod]
  end

  return result
end

-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/default/theme.lua")

-- Errors and debug stuff
loadrc("errors")

-- Configuration
modkey = "Mod4"
config = {
  terminal = "x-terminal-emulator",
  browser  = "x-www-browser",
  editor   = "vim",
  layouts  = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
  },
  keys = {
    global = {},
    client = {},
  },
  widgets = {},
}

loadrc('tags')
loadrc('menu')
loadrc('widgets')
loadrc('bindings')
loadrc('rules')
loadrc('signals')
loadrc('quake')

-- Apply keys configuration
root.keys(config.keys.global)
