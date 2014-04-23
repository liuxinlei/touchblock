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

	ui.newTTFLabel({
		text = GAME_MODEL_NAME[result.model + 1],
		x = display.cx,
		y = display.top - 100,
		size = 70,
		align = ui.TEXT_ALIGN_CENTER
		})
		:addTo(self)


	self.m_resultLabel = ui.newTTFLabel({
		text = result.result,
		x = display.cx,
		y = display.cy + 130,
		size = 70,
		align = ui.TEXT_ALIGN_CENTER
		})
	self:addChild(self.m_resultLabel)

	local bestStr = nil
	if global.gamecenterMgr:updateNativeInfo({model = result.model,newScore = result.result}) then
		bestStr = BEST_TIPS
	else
		bestStr = BEST_LABEL..global.gamecenterMgr:getBestScore(result.model)
	end

	if nil ~= bestStr and bestStr ~= BEST_LABEL then
		ui.newTTFLabel({
			text = bestStr,
			x = display.cx ,
			y = display.cy + 60,
			size = 40,
			align = ui.TEXT_ALIGN_CENTER
			})
			:addTo(self)
	end

	cc.ui.UIPushButton.new("return.png", {scale9 = true})
		:setButtonSize(160, 160)
		:onButtonPressed(function(event)
			event.target:setScale(1.1)
		end)
		:onButtonRelease(function(event)
			event.target:setScale(1.0)
		end)
		:onButtonClicked(function()
			audio.playSound(GAME_MUSIC.click)
			global.sceneMgr:replaceScene("StartScene","pageTurn",0.5)
		end)
		:pos(display.cx - 170, display.cy - 150)
		:addTo(self)

	cc.ui.UIPushButton.new("restart.png", {scale9 = true})
		:setButtonSize(160, 160)
		:onButtonPressed(function(event)
			event.target:setScale(1.1)
		end)
		:onButtonRelease(function(event)
			event.target:setScale(1.0)
		end)
		:onButtonClicked(function()
			audio.playSound(GAME_MUSIC.click)
			global.sceneMgr:replaceScene("MainScene",nil,0,global.sceneMgr.p_model)
		end)
		:pos(display.cx, display.cy - 150)
		:addTo(self)

	cc.ui.UIPushButton.new("rank.png", {scale9 = true})
		:setButtonSize(160, 160)
		:onButtonPressed(function(event)
			event.target:setScale(1.1)
		end)
		:onButtonRelease(function(event)
			event.target:setScale(1.0)
		end)
		:onButtonClicked(function()
			audio.playSound(GAME_MUSIC.click)
			global.gamecenterMgr:showLeaderboard()
		end)
		:pos(display.cx + 170, display.cy - 150)
		:addTo(self)
end

function EndScene:onEnter()
	--每次结束玩得次数+1，到达10此后提示评分
	global.gamecenterMgr:rateManager()
end

function EndScene:onExit()
	
end

return EndScene
