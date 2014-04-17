--
-- Author: tracy
-- Date: 2014-04-15 00:39:58
--
local StartScene = class("StartScene", function()
    return display.newScene("StartScene")
end)

function StartScene:ctor()
	self.m_bg = nil
	self.m_btn_classical = nil
	self.m_btn_arcade = nil
	self.m_btn_buddhist = nil

	self:_init()
end

function StartScene:_init()
	self.m_bg = display.newSprite("startbg.png", display.cx, display.cy):addTo(self)
	self.m_btn_classical = self:_addBtn("btn_classical.png", function()
		global.sceneMgr:replaceScene("MainScene",GAME_MODEL.CLASSICAL)
	end, display.cx, display.cy + 300)
	self.m_btn_classical = self:_addBtn("btn_arcade.png", function()
		global.sceneMgr:replaceScene("MainScene",GAME_MODEL.ARCADE)
	end, display.cx, display.cy + 200)
	self.m_btn_classical = self:_addBtn("btn_buddhist.png", function()
		global.sceneMgr:replaceScene("MainScene",GAME_MODEL.BUDDHIST)
	end, display.cx, display.cy + 100)
end

function StartScene:_addBtn(imgName,callback,x,y)
	cc.ui.UIPushButton.new(imgName, {scale9 = true})
		:setButtonSize(160, 70)
		-- :setButtonLabel(cc.ui.UILabel.new({text = "经典"}))
		:onButtonPressed(function(event)
			event.target:setScale(1.1)
		end)
		:onButtonRelease(function(event)
			event.target:setScale(1.0)
		end)
		:onButtonClicked(callback)
		:pos(x, y)
		:addTo(self)
end

return StartScene
