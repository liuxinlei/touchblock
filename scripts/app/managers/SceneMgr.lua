--
-- Author: tracy
-- Date: 2014-04-14 19:49:29
--
local SceneMgr = class("SceneMgr")

function SceneMgr:ctor()
	self.p_curScene = nil
	self.m_renderHanlder = nil

	self.p_model = 0 	--游戏模式（0：经典，1：街机，2：禅）
	self.p_speed = 0
	self.p_score = 0

	self.m_isSucceed = false
	self.p_isGameStarted = false
	self.p_result = nil
end

function SceneMgr:replaceScene(name,arg)
	self.p_curScene = require("app.scenes."..name).new(arg)
	display.replaceScene(self.p_curScene, "CROSSFADE", 0.5)
end

--游戏开始的总接口
function SceneMgr:startGame()

	self.p_isGameStarted = true

	if self.p_model == GAME_MODEL.CLASSICAL then
		self.p_speed = global.blockLayerMgr.p_blockh
		global.uilayerMgr:startTime()
	elseif self.p_model == GAME_MODEL.ARCADE then
		self.p_speed = ARCADE_SPEED
		global.uilayerMgr:startScore()
	else
		self.p_speed = global.blockLayerMgr.p_blockh
		global.uilayerMgr:startTimeDown()
	end
	if nil == self.m_renderHanlder then
		self.m_renderHanlder = scheduler.scheduleUpdateGlobal(handler(self, self._onShedule))
	end
end

--游戏结束的总接口
function SceneMgr:stopGame()
	self.p_isGameStarted = false

	if nil ~= self.m_renderHanlder then
		scheduler.unscheduleGlobal(self.m_renderHanlder)
		self.m_renderHanlder = nil
	end

	global.blockLayerMgr:stop()
	global.uilayerMgr:stopTime()

	if self.p_model == GAME_MODEL.CLASSICAL then
		if not self.m_isSucceed then
			self.p_result = FAILED_TIPS
		else
			self.p_result = global.uilayerMgr:getUseTimeStr()
		end
	else
		self.p_result = self.p_score
	end

	scheduler.performWithDelayGlobal(function ()
		self:replaceScene("EndScene",self.p_result)
		end, 2)

	self.p_score = 0
	-- self.p_result = nil
end

function SceneMgr:_onShedule(dt)
	if self.p_model == GAME_MODEL.ARCADE then
		self:moveHandler()
		global.uilayerMgr:updateScore()
	end	 
	global.blockLayerMgr:updateBlockPos()
	if global.uilayerMgr.p_isStartTime then
		if self.p_model == GAME_MODEL.BUDDHIST then
			dt = -dt
		end
		global.uilayerMgr:updateTime(dt)
	end
	if self:_isGameOver() then
		self:stopGame()
	end
end

function SceneMgr:moveHandler()
	table.insert(global.blockLayerMgr.p_movequeue,self.p_speed)
end

function SceneMgr:canMoveBlocks()
	--经典模式中所有的模块已经移动完毕，就不会继续移动了
	if self.p_model == GAME_MODEL.CLASSICAL and self.p_score >= CLASSICAL_ROWS - 3 then
		return false 
	end
	return true
end

function SceneMgr:_isGameOver()
		
	if self.p_model == GAME_MODEL.CLASSICAL then
		if self.p_score >= CLASSICAL_ROWS then
			self.m_isSucceed = true
			return true
		end
	elseif self.p_model == GAME_MODEL.BUDDHIST then
		if global.uilayerMgr:getUseTime() <= 0 then
			global.uilayerMgr:setNotice(TIME_OUT_TIPS)
			return true
		end
	else
		if nil ~= global.blockLayerMgr.p_shouldTouchBlock then
			--让长方块停止移动
			self.p_speed = 0
			--缓动回出错的模块
			global.blockLayerMgr:handleSpecialEnd()
			return true
		end
		return false
	end
end

return SceneMgr