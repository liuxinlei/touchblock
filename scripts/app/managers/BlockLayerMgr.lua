--
-- Author: tracy
-- Date: 2014-04-14 19:35:47
--
local BlockLayerMgr = class("BlockLayerMgr")

function BlockLayerMgr:ctor()
	-------------------------变量定义开始-------------
    self.p_blocks = {}		--存储所有Blocks的二维数组
    self.m_blockLayer = nil
    self.p_blockw = 0
    self.p_blockh = 0

    self.p_movequeue = {}

    --街机模式中：应该被点击但是没有被点击的长方块
    self.p_shouldTouchBlock = nil
    --为了追踪最高一行的坐标记录下其中一个方块
    self.m_lastBlockIndex = 0
    -------------------------变量定义结束-------------
end

function BlockLayerMgr:initBlocks()
	local blocklayer = global.sceneMgr.p_curScene:getChildByTag(TAG.BLOCK_LAYER)
	self.m_blockLayer = require("app.views.BlockLayer").new()
	self.m_blockLayer:initBlocks()
	blocklayer:addChild(self.m_blockLayer)
end

function BlockLayerMgr:updateBlocks()
	if GAME_MODEL.ARCADE == global.sceneMgr.p_model then
		self.m_blockLayer:moveAllBlocks()
	else
		self.m_blockLayer:tweenAllBlocks()
	end
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