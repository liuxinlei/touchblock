--
-- Author: tracy
-- Date: 2014-04-21 14:34:00
--
local GuidLayer = class("GuidLayer", function ()
	return display.newLayer()
end)

function GuidLayer:ctor(model)

	display.newColorLayer(ccc4(256, 256, 256, 128)):addTo(self)

	local label1 = ui.newTTFLabel({
		text = GUID_LAYER_TEXT_CUSTOM,
		size = 40,
		font = "Marker Felt",
		color = ccc3(255, 0, 0),
		x = display.cx,
		y = display.cy + 40,
		align = ui.TEXT_ALIGN_CENTER
		})
		:addTo(self)

	local label2 = ui.newTTFLabel({
		text = GUID_LAYER_TEXT[model+1],
		size = 40,
		font = "Marker Felt",
		color = ccc3(0, 255, 0),
		x = display.cx,
		y = display.cy - 30,
		dimensions = CCSize(display.width - 100,100),
		valign = ui.TEXT_VALIGN_TOP,
		align = ui.TEXT_ALIGN_CENTER
		})
		:addTo(self)
end

return GuidLayer