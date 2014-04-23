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

	self.m_guidBtn = nil
	self.m_rateBtn = nil
	self.m_rankBtn = nil

	self:_init()
end

function StartScene:_init()
	self.m_bg = display.newSprite("startbg.png", display.cx, display.cy):addTo(self)
	self:_addBtn("btn_start.png",GAME_MODEL_NAME_SHORT[1], function()
		audio.playSound(GAME_MUSIC.click)
		global.sceneMgr:replaceScene("MainScene",nil,0,GAME_MODEL.CLASSICAL)
	end, display.cx, display.cy + 360)
	self:_addBtn("btn_start.png",GAME_MODEL_NAME_SHORT[2], function()
		audio.playSound(GAME_MUSIC.click)
		global.sceneMgr:replaceScene("MainScene",nil,0,GAME_MODEL.ARCADE)
	end, display.cx, display.cy + 230)
	self:_addBtn("btn_start.png", GAME_MODEL_NAME_SHORT[3],function()
		audio.playSound(GAME_MUSIC.click)
		global.sceneMgr:replaceScene("MainScene",nil,0,GAME_MODEL.BUDDHIST)
	end, display.cx, display.cy + 100)

	local MainMenu = CCMenu:create()
	MainMenu:setPosition(ccp(0,0))
	self:addChild(MainMenu)

	self.m_guidBtn = ui.newTTFLabelMenuItem({
		listener = function()
			audio.playSound(GAME_MUSIC.click)
			local text = GUID_TEXT[global.isOpenGuid]
			if text == GUID_TEXT[1] then
				self.m_guidBtn:setString(GUID_TEXT[2])
				global.isOpenGuid = 2
			else
				self.m_guidBtn:setString(GUID_TEXT[1])
				global.isOpenGuid = 1
			end
			global.gamecenterMgr:updateSettings()
		end,
		x = 90,
		y = display.cy - 10,
		text = GUID_TEXT[global.isOpenGuid],
		size = 30,
		align = ui.TEXT_ALIGN_CENTER
		})
	MainMenu:addChild(self.m_guidBtn)

	self.m_rateBtn = ui.newTTFLabelMenuItem({
		listener = function()
			audio.playSound(GAME_MUSIC.click)
			global.gamecenterMgr:showLeaderboard()
		end,
		x = display.cx,
		y = display.cy - 10,
		text = RANK_TEXT,
		size = 30,
		align = ui.TEXT_ALIGN_CENTER
		})
	MainMenu:addChild(self.m_rateBtn)

	self.m_rankBtn = ui.newTTFLabelMenuItem({
		listener = function()
			audio.playSound(GAME_MUSIC.click)
			global.gamecenterMgr:rate()
		end,
		x = display.right - 50,
		y = display.cy - 10,
		text = RATE_TEXT,
		size = 30,
		align = ui.TEXT_ALIGN_CENTER
		})
	MainMenu:addChild(self.m_rankBtn)
end

function StartScene:_addBtn(imgName,text,callback,x,y)
	cc.ui.UIPushButton.new(imgName, {scale9 = true})
		:setButtonLabel(cc.ui.UILabel.new({text = text,size = 55,align = ui.TEXT_ALIGN_CENTER}))
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

function StartScene:onExit()
	self.m_bg = nil
	self.m_btn_classical = nil
	self.m_btn_arcade = nil
	self.m_btn_buddhist = nil

	self.m_guidBtn = nil
	self.m_rateBtn = nil
	self.m_rankBtn = nil
end

return StartScene
