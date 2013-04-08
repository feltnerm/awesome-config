require("lib/tags")

function load_prog(cmd, tag)
   awful.tag.viewonly(tags[1][tag])
   awful.util.spawn(cmd)
end

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     maximized_horizontal = false,
                     maximized_vertical = false
                   } 
    },
    { rule = { class = "Exe" },
      properties = { floating = true },
    },
    { rule = { class = "anamnesis" },
      properties = { floating = true },
    },
    { rule  = { class = "vlc" },
      properties = { floating = true },
    },
    { rule = { class = "nitrogen" },
      properties = { floating = true },
    },
    { rule = { class= "conky" },
      properties = { border_width = 0 } 
    },
    { rule  = { class = "xfce4-terminal" },
      properties = { floating = true, opacity = 0.9 },
      callback = function (c)
        local clientgeom = c:geometry()
        local screengeom = screen[mouse.screen].workarea

        local width = screengeom.width * 0.60
        local height = screengeom.height * 0.50

        local x = screengeom.x + (screengeom.width - width) / 2
        local y = screengeom.y + (screengeom.height - height)

        c:geometry({ x= x, y = y, width = width, height = height })
      end,
    },
}
-- }}}

print("[awesome] rules initialized")

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
