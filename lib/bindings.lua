require("lib/tags")

modkey = env.modkey

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Client Menu
    awful.key({ modkey            }, "c", function () awful.menu.clients() end),
    --
    -- Desktop Menu
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Standard program
    awful.ful({ modkey,           }, "Return", function () awful.util.spawn(env.terminal) end),
    awful.key({ modkey,           }, "semicolon", function () 
      local matcher = function (c) 
        return awful.rules.match(c, { class = "xfce4-terminal" })
      end
      awful.client.run_or_raise('xfce4-terminal --tab', matcher)
      end),

    -- Prompt
    awful.key({ modkey            }, "r",     function () mypromptbox[mouse.screen]:run() end),

    -- Menubar
    --awful.key({ modkey }, "p", function() menubar.show() end)
    
    -- Restart
    awful.key({ modkey, "Control", "Alt" }, "r", awesome.restart),

    -- Quit
    awful.key({ modkey, "Control", "Alt" }, "q", awesome.quit),

    -- Restore client
    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Tag Switching
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    -- Client Switching
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    awful.key({ modkey,           }, "period",  function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "comma",   function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey,           }, "next",    function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey,           }, "prior",   function () awful.layout.inc(layouts, -1) end)
    
    --awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    --awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    --awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    --awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),

    -- awful.key({ modkey }, "x",
    --           function ()
    --               awful.prompt.run({ prompt = "Run Lua code: " },
    --               mypromptbox[mouse.screen].widget,
    --               awful.util.eval, nil,
    --               awful.util.getdir("cache") .. "/history_eval")
    --           end),
    --
)

clientkeys = awful.util.table.join(
    -- Moving clients between screens
    awful.key({ modkey, "Control" }, "Left",   function (c) awful.client.movetoscreen(c) end),
    awful.key({ modkey, "Control" }, "Right",   function (c) awful.client.movetoscreen(c) end),
    awful.key({ modkey, "Shift"   }, "Left",    function (c) awful.client.movetotag(c) end),
    awful.key({ modkey, "Shift"   }, "Right",    function (c) awful.client.movetotag(c) end),

    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- }}}
-- {{{ Custom Bindings
customkeys = {
    -- {{{ System Stat(us)
}
globalkeys = awful.util.table.join(globalkeys,
    awful.key({ modkey }, "F12", 
            function() 
                awful.util.spawn(env.terminal .. " --hide-menubar --hide-toolbars -T htop -e htop") 
            end),
    awful.key({ modkey }, "F11",
        function()
            awful.util.spawn(env.terminal .. " --hide-menubar --hide-toolbars -T slurm -e slurm -i wlan0")
        end),
    awful.key({ modkey }, "F10",
        function()
            awful.util.spawn(env.terminal .. " --hide-menubar --hide-toolbars -T wicd -e wicd-curses")
        end),
    awful.key({ modkey }, "F9",
        function()
            awful.util.spawn(env.terminal .. " --hide-menubar --hide-toolbars -T ranger -e ranger")
        end),
    --- }}}

    --- {{{ Multimedia
   awful.key({ }, "XF86AudioPlay",
        function() 
          os.execute("/usr/bin/mpc toggle")
        end),
   awful.key({ }, "XF86AudioNext",
        function() 
          os.execute("/usr/bin/mpc next")
        end),
   awful.key({ }, "XF86AudioPrev",
        function() 
          os.execute("/usr/bin/mpc prev")
        end),
   awful.key({ }, "XF86AudioStop",
        function() 
          os.execute("/usr/bin/mpc stop")
        end),
   awful.key({ }, "XF86AudioRaiseVolume", 
        function() 
            os.execute("/usr/bin/vol_up") 
        end),
   awful.key({ }, "XF86AudioLowerVolume", 
        function() 
            os.execute("/usr/bin/vol_down") 
        end),
   awful.key({ }, "XF86AudioMute",        
        function() 
            os.execute("/usr/bin/mute_toggle") 
        end),
    awful.key({ modkey }, "XF86Display", 
        function()
            awful.util.spawn("xrandr --auto")
        end),
    --- }}}

    -- {{{ Apps
    awful.key({ modkey }, "b", 
        function() 
            local matcher = function (c)
              return awful.rules.match(c, { class = "google-chrome" })
            end
            awful.client.run_or_raise("google-chrome", matcher) 
        end)

    -- }}}
)
-- }}}
-- Set keys
root.keys(globalkeys)

print("[awesome] Bindings set.")

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
