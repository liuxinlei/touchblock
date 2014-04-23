--
-- Author: tracy
-- Date: 2014-04-15 16:39:58
--
local UIlayerManager = class("UIlayerManager")

function UIlayerManager:ctor()
	self.m_textLabel = nil
	self.m_scoreLabel = nil

	self.m_time = 0
	self.p_isStartTime = false
	self.m_usetimeStr = nil
end

function UIlayerManager:initLayer()
	local uilayer = global.sceneMgr.p_curScene:getChildByTag(TAG.UI_LAYER)
	self.m_textLabel = ui.newTTFLabelWithOutline({
		text = "",
		x = display.cx,
		y = display.top - 100,
		size = 60,
		color = ccc3(255, 255, 255),
		outlineColor = ccc3(255, 255, 255),
		align = ui.TEXT_ALIGN_CENTER
		})
	uilayer:addChild(self.m_textLabel)
	self.m_textLabel:setVisible(false)
end

function UIlayerManager:startTime()
	self.m_time = 0
	self.p_isStartTime = true
	self.m_textLabel:setVisible(true)
end

function UIlayerManager:stopTime()
	self.p_isStartTime = false
end

function UIlayerManager:updateTime(dt)
	self.m_time = self.m_time + dt
	self.m_usetimeStr = string.format("%.3f", self.m_time).."\""
	self.m_textLabel:setString(self.m_usetimeStr)
end

function UIlayerManager:getUseTimeStr()
	return self.m_usetimeStr
end

function UIlayerManager:getUseTime()
	return self.m_time
end

function UIlayerManager:startScore()
	self.m_textLabel:setVisible(true)
end

function UIlayerManager:updateScore()
	self.m_textLabel:setString(string.format("%d",global.sceneMgr.p_score))
end

function UIlayerManager:startTimeDown()
	self.m_time = BUDDHIST_TIME
	self.m_textLabel:setString(string.format("%.3f", self.m_time))
	self.p_isStartTime = true
	self.m_textLabel:setVisible(true)
end

function UIlayerManager:setNotice(text)
	self.m_textLabel:setString(text)
end

function UIlayerManager:stopAll()
	self.m_time = 0
	self.p_isStartTime = false
	self.m_textLabel:setVisible(false)
	self.m_usetimeStr = nil
end

return UIlayerManager