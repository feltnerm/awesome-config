menubar = require("menubar")

local leave_menu = {
  { "lock", "xscreensaver --lock" },
  { "restart awm", awesome.restart },
  { "quit awm", awesome.quit },
  { "suspend", nil},
  { "hibernate", nil},
  { "reboot", nil},
  { "shutdown", nil}
}

local monitor_confs = {
  { "default", function ()
    awful.util.spawn("xrandr --output HDMI1 --off --output LVDS1 --mode 1280x800 --pos 0x0 --rotate normal --output TV1 --off --output VGA1 --off")
  end },
  { "home", function () 
      awful.util.spawn("xrandr --output HDMI1 --off --output LVDS1 --mode 1280x800 --pos 0x400 --rotate normal --output TV1 --off --output VGA1 --mode 1600x1200 --pos 1280x0 --rotate normal") 
    end }

}

local wallpaper_menu = {
  { "restore wallpaper", "nitrogen --restore" },
  { "set wallpaper", "nitrogen --save" },
}
local looknfeel_menu = {
  { "displays", monitor_confs },
  { "gtk", "lxappearance" },
  { "screensaver", "xscreensaver-command -prefs" },
  { "wallpaper", wallpaper_menu },
}

local settings_menu = {
  { "arandr", "arandr" },
  { "pulseaudio", "paprefs"}
}
-- {{{ Menu
-- Create a laucher widget and a main menu
mymainmenu = awful.menu({ items = { { "files", genMenu("/home/mark/") },
                                    { "look 'n' feel", looknfeel_menu },
                                    { "settings", settings_menu },
                                    { "leave" , leave_menu }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = env.terminal -- Set the terminal for applications that require it
-- }}}

print("[awesome] Menu created")

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
