--
-- Author: tracy
-- Date: 2014-04-15 01:00:33
--
local EndScene  = class("EndScene", function()
    return display.newScene("EndScene")
end)

function EndScene:ctor(result)
	display.newSprite("bg.png", display.cx, display.cy):addTo(self)
	display.newSprite("s_bg.png", display.cx, display.cy):addTo(self)

	self.m_resultLabel = ui.newTTFLabel({
		text = result,
		x = display.cx,
		y = display.cy + 150,
		size = 50,
		color = ccc3(255, 0, 0),
		align = ui.TEXT_ALIGN_CENTER
		})
	self:addChild(self.m_resultLabel)


	cc.ui.UIPushButton.new("restart.png", {scale9 = true})
		:setButtonSize(160, 160)
		:onButtonPressed(function(event)
			event.target:setScale(1.1)
		end)
		:onButtonRelease(function(event)
			event.target:setScale(1.0)
		end)
		:onButtonClicked(function()
			global.sceneMgr:replaceScene("MainScene",global.sceneMgr.p_model)
		end)
		:pos(display.cx + 100, display.cy)
		:addTo(self)

	cc.ui.UIPushButton.new("return.png", {scale9 = true})
		:setButtonSize(160, 160)
		:onButtonPressed(function(event)
			event.target:setScale(1.1)
		end)
		:onButtonRelease(function(event)
			event.target:setScale(1.0)
		end)
		:onButtonClicked(function()
			global.sceneMgr:replaceScene("StartScene")
		end)
		:pos(display.cx - 100, display.cy)
		:addTo(self)
end

return EndScene
