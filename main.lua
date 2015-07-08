---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- require the composer library
local composer = require "composer"

-- load scene1
composer.gotoScene( "scene1" )

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc)


local seed = os.time();
math.randomseed( seed )

widget = require("widget")

_halfw = display.contentWidth * 0.5
_halfh = display.contentHeight * 0.5

_w = display.actualContentWidth
_h = display.actualContentHeight
print ("_w" .. _w)
print ("_h" .. _h)
_num = 0
