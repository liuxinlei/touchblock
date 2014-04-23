--
-- Author: tracy
-- Date: 2014-03-24 19:25:22
--
local LoadScene = class("LoadScene", function ()
	return display.newScene("LoadScene")
end)

function LoadScene:ctor()
	display.newSprite("loading.png", display.cx, display.cy):addTo(self)

	scheduler.performWithDelayGlobal(function()
		app:enterScene("StartScene", nil, "fade",0.5,display.COLOR_BLACK)
	end,3)
end

return LoadScene