-- Define a tag table which hold all screen tags.
config.tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    config.tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, config.layouts[1])
end

-- Global key bindings to tags

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  config.keys.global = awful.util.table.join(
    config.keys.global,

    awful.key({ modkey }, "#" .. i + 9,
      function ()
        local screen = mouse.screen
        if config.tags[screen][i] then
            awful.tag.viewonly(config.tags[screen][i])
        end
      end),
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function ()
        local screen = mouse.screen
        if config.tags[screen][i] then
            awful.tag.viewtoggle(config.tags[screen][i])
        end
      end
    ),
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function ()
        if client.focus and config.tags[client.focus.screen][i] then
            awful.client.movetotag(config.tags[client.focus.screen][i])
        end
      end
    ),
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function ()
        if client.focus and config.tags[client.focus.screen][i] then
            awful.client.toggletag(config.tags[client.focus.screen][i])
        end
      end
    )
  )
end