local keydoc = loadrc("keydoc", "vbe/keydoc")

-- Root mouse bindings
root.buttons(awful.util.table.join(
  awful.button({ }, 3, function () config.menu:toggle() end),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
))

-- External programs
config.keys.global = awful.util.table.join(
  config.keys.global,
  
  keydoc.group('External'),

  awful.key({ modkey }, 's', function () awful.util.spawn_with_shell("slock")  end, 'Lock screen (slock)')
)

-- Global key bindings
config.keys.global = awful.util.table.join(
  config.keys.global,

  awful.key({ modkey }, "F1",  keydoc.display),

  keydoc.group('Tags'),

  awful.key({ modkey }, "Left",   awful.tag.viewprev, 'Previous tag'),
  awful.key({ modkey }, "Right",  awful.tag.viewnext, 'Next tag'),
  awful.key({ modkey }, "Escape", awful.tag.history.restore, 'History'),

  -- Switch clients
  keydoc.group('Clients'),

  awful.key({ modkey }, "j",
    function ()
      awful.client.focus.byidx(1)
      if client.focus then client.focus:raise() end
    end
  , 'Next client'),

  awful.key({ modkey }, "k",
    function ()
      awful.client.focus.byidx(-1)
      if client.focus then client.focus:raise() end
    end
  , 'Previous client'),

  awful.key({ modkey }, "w", function () config.menu:show({keygrabber=true}) end),

  -- Layout manipulation
  awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end, 'Choose next screen'),
  awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end, 'Choose prev screen'),
  awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),

  -- Client manipulation

  keydoc.group('Clients'),
  awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end, 'Swap with next client'),
  awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end, 'Swap with next client'),
  awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05) end, 'Increase master width factor'),
  awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05) end, 'Decrease master width factor'),
  awful.key({ modkey,           }, "Tab",
    function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end
  ),

  keydoc.group('Layout'),
  awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)   end, 'Increase the number of master windows.'),
  awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)   end, 'Decrease the number of master windows.'),
  awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)      end, 'Increase number of column windows'),
  awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)      end, 'Decrease number of column windows'),
  awful.key({ modkey,           }, "space", function () awful.layout.inc(config.layouts,  1) end, 'Next layout'),
  awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(config.layouts, -1) end, 'Previous layout'),

  awful.key({ modkey, "Control" }, "n", awful.client.restore),

  -- Standard program
  keydoc.group('Misc'),
  awful.key({ modkey,           }, "Return", function () awful.util.spawn(config.terminal) end, 'Open terminal'),
  awful.key({ modkey, "Control" }, "r", awesome.restart, 'Restart awesome'),
  awful.key({ modkey, "Shift"   }, "q", awesome.quit, 'Quit awesome'),

  -- Prompt
  awful.key({ modkey }, "r", function () config.widgets.promptbox[mouse.screen]:run() end, 'Promptbox: run a command'),
  awful.key({ modkey }, "x",
    function ()
        awful.prompt.run({ prompt = "Run Lua code: " },
        config.widgets.promptbox[mouse.screen].widget,
        awful.util.eval, nil,
        awful.util.getdir("cache") .. "/history_eval")
    end
  , 'Promptbox: run a lua code'),

  keydoc.group("Volume control"),
  awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer set Master 9%+", false) end),
  awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer set Master 9%-", false) end),
  awful.key({ }, "XF86AudioMute", function ()
    local fd = io.popen("amixer sget Master")
    local status = fd:read("*all")
    fd:close()

    status = string.match(status, "%[(o[^%]]*)%]")

    if string.find(status, "on", 1, true) then
      awful.util.spawn("pactl set-sink-mute @DEFAULT_SINK@ 1", false)
    else
      awful.util.spawn("pactl set-sink-mute @DEFAULT_SINK@ 0", false)
    end
  end)

)

config.keys.client = awful.util.table.join(
  config.keys.client,
  keydoc.group('Current client'),
  awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end, 'Toggle fullscreen'),
  awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end, 'Kill'),
  awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     , 'Toggle floating'),
  awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end, 'Swap with master'),
  awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        , 'Move to screen'),
  awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end, 'Redraw'),
  awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end, 'Toggle "always on top"'),
  awful.key({ modkey,           }, "n",
    function (c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end
  , 'Minimize'),
  awful.key({ modkey,           }, "m",
    function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical   = not c.maximized_vertical
    end
  , 'Maximze')
)
