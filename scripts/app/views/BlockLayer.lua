--
-- Author: tracy
-- Date: 2014-04-14 19:33:16
--
local BlockLayer = class("BlockLayer", function()
	return display.newLayer()
end)

local soundNum = 1

function BlockLayer:ctor()
	-------------------------变量定义开始-------------
	self.m_touchedRow = 0
    -------------------------变量定义结束-------------
    self:setTouchEnabled(true)
    self:addTouchEventListener(handler(self, self._onTouch))
end

function BlockLayer:initBlocks()
	for i = 1,MAX_ROW do
		local rowtable = {}
		local arrowColumn = math.random(1,MAX_COLUMN)
		for j = 1,MAX_COLUMN do
			local type = 0
			if j == arrowColumn then type = 1 end
			local block = require("app.views.Block").new(i)
			block:reset(type)
			local w = global.blockLayerMgr.p_blockw
			local h = global.blockLayerMgr.p_blockh
			block:setPosition(ccp((j - 1)*w,i*h))
			self:addChild(block)
			table.insert(rowtable,j,block)
		end
		table.insert(global.blockLayerMgr.p_blocks,i,rowtable)
	end
	self.m_lastBlockIndex = MAX_ROW
end

function BlockLayer:_onTouch(event,x,y)
	if event == "began" then
		self:_touchHandler(event,x,y)
        return true -- 在 began 事件里返回 true，表示要接收后续的触摸事件
    end
end

function BlockLayer:_touchHandler(event,x,y)
    --只有被点击行的上一行可以被点击
    local blocks = global.blockLayerMgr.p_blocks[self.m_touchedRow + 1]
    for _,block in pairs(blocks) do
    	local touchInSprite = block:getTouchRect():containsPoint(CCPoint(x, y))
    	if touchInSprite then
    		block:touchEffect()
    		if block.p_type == 0 then
    			global.sceneMgr:stopGame()
    		else
    			--音效
    			audio.playSound(GAME_MUSIC[soundNum])
    			soundNum = soundNum + 1
    			if soundNum > 4 then soundNum = 1 end
    			--音效结束

    			if not global.sceneMgr.p_isGameStarted then
    				global.sceneMgr:startGame()
    			end

    			if global.sceneMgr.p_model ~= GAME_MODEL.ACADE then
    				global.sceneMgr:moveHandler()
    			end
    			global.sceneMgr.p_score = global.sceneMgr.p_score + 1

    			block.p_isTouched = true

    			--只有被点击行的上一行可以被点击
    			self.m_touchedRow = block.p_row
    			if self.m_touchedRow == MAX_ROW then self.m_touchedRow = 0 end
    			return
    		end
    	end
    end
end


function BlockLayer:moveAllBlocks()
	local tb = global.blockLayerMgr.p_movequeue
	local speed = tb[1]
	if nil == speed then return end
	local allBlocks = global.blockLayerMgr.p_blocks
	for i,blocks in pairs(allBlocks) do
		local lastrowy = allBlocks[self.m_lastBlockIndex][1]:getPositionY()
		local arrowColumn = math.random(1,MAX_COLUMN)
		for j,block in pairs(blocks) do
			local type = 0
			--特殊判断：街机模式中，被落下每点击的方块
			if block:getPositionY() <= -global.blockLayerMgr.p_blockh and block.p_type == 1 and not block.p_isTouched then
				global.blockLayerMgr.p_shouldTouchBlock = block
			end
			if block:getPositionY() <= -global.blockLayerMgr.p_blockh*3 then
				if j == arrowColumn then type = 1 end
				block:reset(type)
				if global.sceneMgr:canMoveBlocks() then
					block:setPositionY(lastrowy + global.blockLayerMgr.p_blockh)
					self.m_lastBlockIndex = i
				end
			end
			local y = block:getPositionY()
			block:setPositionY(y - speed)
		end
	end
	table.remove(tb,1)
end

function BlockLayer:tweenAllBlocks()
	local tb = global.blockLayerMgr.p_movequeue
	local speed = tb[1]
	if nil == speed then return end
	table.remove(tb,1)
	local allBlocks = global.blockLayerMgr.p_blocks
	for i,blocks in pairs(allBlocks) do
		local lastrowy = allBlocks[self.m_lastBlockIndex][1]:getPositionY()
		local arrowColumn = math.random(1,MAX_COLUMN)
		for j,block in pairs(blocks) do
			local type = 0
			if block:getPositionY() <= -global.blockLayerMgr.p_blockh*2 then
				if j == arrowColumn then type = 1 end
				block:reset(type)
				if global.sceneMgr:canMoveBlocks() then
					block:setPositionY(lastrowy + global.blockLayerMgr.p_blockh)
					self.m_lastBlockIndex = i
				end
			end
			local y = block:getPositionY()
			transition.moveBy(block, {y = -speed,time = 0.1,onComplete = function() 
				if i == MAX_ROW and j == MAX_COLUMN then
					if #tb ~= 0 then print("居然还有时间！！！！") self:tweenAllBlocks() end
				end
				end})
		end
	end
end

--街机模式中：如果有一行忘记点击，怎当这行要移除屏幕的时候，往回缓动一段距离，游戏结束
function BlockLayer:handleSpecialEnd()
	local dis = global.blockLayerMgr.p_blockh*2
	local allBlocks = global.blockLayerMgr.p_blocks
	for _,blocks in pairs(allBlocks) do
		for _,block in pairs(blocks) do
			transition.moveBy(block, {y = dis,time = 0.2,onComplete = function()
				global.blockLayerMgr.p_shouldTouchBlock:blockBlink()
				end})
		end
	end
end

function BlockLayer:clearAll()
	self:removeAllChildren()
	self.m_touchedRow = 0
end


return BlockLayer
