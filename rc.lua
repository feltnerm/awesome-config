-- AwesomeWM Configuration
--
-- @author: Mark Feltner
-- ---------------------------------------------------------------------------

print("[awesome] Entering awesome: ".. os.date())
-- Standard awesome library
awful       = require("awful")
awful.rules = require("awful.rules")
              require("awful.autofocus")
beautiful   = require("beautiful")
revelation  = require("revelation")
--eminent     = require("eminent/eminent")

-- {{{ Variable definitions
-- Themes define colours, icons, apps, and wallpapers
root_dir        = awful.util.getdir("config")
env = {
    theme       = "fhuizing",
    themes_dir  = root_dir .. "/themes/",
    icons_dir   = root_dir .. "/icons/",
    terminal    = "xfce4-terminal",
    editor      = "gvim",
    browser     = "google-chrome",
    modkey      = "Mod4",
}
-- }}}

-- {{{ Dependencies
require("lib/helpers")
require("lib/debug")
require("lib/theme")
require("lib/menu")
require("lib/tags")
require("lib/widgets")
require("lib/bindings")
require("lib/rules")
require("lib/bindings")
require("lib/signals")
require("lib/startup")
--require("lib/shifty")
--
-- }}}
print("[awesome] WM initialized")

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80

