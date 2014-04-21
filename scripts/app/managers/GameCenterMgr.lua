--
-- Author: tracy
-- Date: 2014-04-18 16:45:06
--
local GameCenterMgr = class("GameCenterMgr")

function GameCenterMgr:ctor()
	self.m_localinfo = {}

	self:_initNativeInfo()
	self:_initGameCenter()
end

function GameCenterMgr:_initGameCenter()
	luaoc.callStaticMethod("GameCenter", "login")
end

function GameCenterMgr:showLeaderboard()
	luaoc.callStaticMethod("GameCenter", "showLeaderboard")
end

function GameCenterMgr:reportScore(data)
	luaoc.callStaticMethod("GameCenter", "reportScore",data)
end

function GameCenterMgr:_initNativeInfo()
	GameStateEventListener = function(obj)
    	if obj.name == "init" then
    		return true
    	elseif obj.name == "load" then
    		return obj.values
    	elseif obj.name == "save" then
    		return obj.values
    	else
    		print("Error:GameStateEventListener",obj.name)
    	end
    end

    gamestate.init(GameStateEventListener, "localInfo.txt", "A-Rocket")
    if gamestate.load() ~= nil then
    	self.m_localinfo = gamestate.load()
    	global.isOpenGuid = self.m_localinfo.isOpenGuid
    else
    	self.m_localinfo = {}
    end
end

function GameCenterMgr:updateNativeInfo(data)
	local newScore = data.newScore
	local model = tostring(data.model) 
	local nativeScore = self.m_localinfo[model]
	--失败不记录得分
	if newScore == FAILED_TIPS then
		return false
	end
	--第一次
	if nil == nativeScore then 
		self.m_localinfo[model] = newScore
		gamestate.save(self.m_localinfo)
		return true
	end

	if data.model == GAME_MODEL.CLASSICAL then
		if nativeScore > newScore then
			self.m_localinfo[model] = newScore
			gamestate.save(self.m_localinfo)
			self:reportScore({score = newScore*1000,category = LEADBOARD_IDS[data.model+1]})
			return true
		end
	else
		if nativeScore < newScore then
			self.m_localinfo[model] = newScore
			gamestate.save(self.m_localinfo)
			self:reportScore({score = newScore,category = LEADBOARD_IDS[data.model+1]})
			return true
		end
	end
	return false
end

function GameCenterMgr:getBestScore(model)
	return self.m_localinfo[tostring(model)] or ""
end

function GameCenterMgr:updateSettings()
	self.m_localinfo.isOpenGuid = global.isOpenGuid
	gamestate.save(self.m_localinfo)
end

return GameCenterMgr