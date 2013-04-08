menubar = require("menubar")

local connect_menu = {
  { "nalanda", function () awful.util.spawn(env.terminal .. ' -T ssh::nalanda -e ssh nalanda') end },
  { "saraswati", function () awful.util.spawn(env.terminal .. ' -T ssh::saraswati -e ssh saraswati') end },
}

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
    awful.util.spawn("/home/mark/.screenlayout/default.sh")
  end },
  { "home", function () 
      awful.util.spawn("/home/mark/.screenlayout/home.sh") 
    end }
}

local wallpaper_menu = {
  { "restore wallpaper", "nitrogen --restore" },
  { "set wallpaper", "nitrogen --save" },
}

local settings_menu = {
  { "arandr", "arandr" },
  { "displays", monitor_confs },
  { "gtk", "lxappearance" },
  { "pulseaudio", "paprefs"},
  { "screensaver", "xscreensaver-command -prefs" },
  { "wallpaper", wallpaper_menu }
}
-- {{{ Menu
-- Create a laucher widget and a main menu
mymainmenu = awful.menu({ items = { { "files", genMenu("/home/mark/") },
                                    { "servers", connect_menu },
                                    { "__________", nil },
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
