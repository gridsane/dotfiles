-- Load Debian menu entries
require("debian.menu")

-- Create a laucher widget and a main menu
local menu = {
  awesome = {
    { "manual", config.terminal .. " -e man awesome" },
    { "edit config", config.editor .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", awesome.quit }
  },
  debian = debian.menu.Debian_menu.Debian,
}


config.menu = awful.menu({items = {
    {"terminal", config.terminal},
    {"awesome", menu.awesome, beautiful.awesome_icon},
    {"debian",  menu.debian},
}})