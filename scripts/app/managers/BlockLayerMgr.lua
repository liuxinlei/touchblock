--
-- Author: tracy
-- Date: 2014-04-14 19:35:47
--
local BlockLayerMgr = class("BlockLayerMgr")

function BlockLayerMgr:ctor()
	-------------------------变量定义开始-------------
    self.p_blocks = {}
    self.m_blockLayer = nil
    self.p_blockw = 0
    self.p_blockh = 0

    self.p_movequeue = {}

    --街机模式中：应该被点击但是没有被点击的长方块
    self.p_shouldTouchBlock = nil
    -------------------------变量定义结束-------------
end

function BlockLayerMgr:initBlocks()
	local blocklayer = global.sceneMgr.p_curScene:getChildByTag(TAG.BLOCK_LAYER)
	self.m_blockLayer = require("app.views.BlockLayer").new()
	self.m_blockLayer:initBlocks()
	blocklayer:addChild(self.m_blockLayer)
end

function BlockLayerMgr:updateBlockPos()
	self.m_blockLayer:moveAllBlocks()
end

function BlockLayerMgr:handleSpecialEnd()
	self.m_blockLayer:handleSpecialEnd()
end

function BlockLayerMgr:start()
	self.m_blockLayer:setTouchEnabled(true)
end

function BlockLayerMgr:stop()
	self.m_blockLayer:setTouchEnabled(false)
end

function BlockLayerMgr:clearAll()
	self.p_blocks = {}
	self.m_blockLayer:clearAll()
	self.m_blockLayer = nil
	self.p_shouldTouchBlock = nil
end

return BlockLayerMgr