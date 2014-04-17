--
-- Author: tracy
-- Date: 2014-04-14 19:09:06
--
local Block = class("Block", function()
	return display.newLayer()
end)

function Block:ctor(type,row)
	self.p_type = type
	self.p_row = row

	self.p_isTouched = false

	self.m_bg = nil
	self.m_arrow = nil
	self.m_touchMask = nil

	self:_initContent()

	global.blockLayerMgr.p_blockw = self:getBoundingBox().size.width
	global.blockLayerMgr.p_blockh = self:getBoundingBox().size.height

	-- self:setTouchEnabled(true)
end

function Block:_initContent()
	self.m_bg = display.newSprite("block.png")
	self.m_arrow = display.newSprite("arrow.png")

	self.m_bg:setAnchorPoint(ccp(0,0))
	self.m_arrow:setAnchorPoint(ccp(0,0))

	self:addChild(self.m_bg)
	self:addChild(self.m_arrow)

	self.m_touchMask = display.newColorLayer(ccc4(128, 128, 128, 200))
		:size(self.m_bg:getBoundingBox().size)
		:addTo(self)

	self:setContentSize(self.m_bg:getBoundingBox().size)
end

function Block:touchEffect()
	if self.p_type == 0 then
		local action1 = CCBlink:create(5, 15)
    	self:runAction(action1)
    else
    	self.m_touchMask:setVisible(true)
	end
end

function Block:blockBlink()
	local action1 = CCBlink:create(5, 15)
	self:runAction(action1)
end

function Block:getTouchRect()
	local touchBox = self:getBoundingBox()
	local newMinY = 0
	local newh = 0
	if self.p_type == 0 then
		return touchBox
	else
		newMinY = touchBox:getMinY() - touchBox.size.height/3
		newh = touchBox.size.height*5/3
	end
	return CCRect(touchBox:getMinX(),newMinY,touchBox.size.width,newh)
end

function Block:reset()
	if self.p_type == 0 then
		self.m_arrow:setVisible(false)
		self.m_bg:setVisible(true)
	else
		self.m_bg:setVisible(false)
		self.m_arrow:setVisible(true)
	end
	self.m_touchMask:setVisible(false)
	self.p_isTouched = false
end

return  Block