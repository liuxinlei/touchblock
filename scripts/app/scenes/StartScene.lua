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

	self.m_guildBtn = nil

	self:_init()
end

function StartScene:_init()
	self.m_bg = display.newSprite("startbg.png", display.cx, display.cy):addTo(self)
	self:_addBtn("btn_start.png",GAME_MODEL_NAME_SHORT[1], function()
		global.sceneMgr:replaceScene("MainScene",nil,0,GAME_MODEL.CLASSICAL)
	end, display.cx, display.cy + 450)
	self:_addBtn("btn_start.png",GAME_MODEL_NAME_SHORT[2], function()
		global.sceneMgr:replaceScene("MainScene",nil,0,GAME_MODEL.ARCADE)
	end, display.cx, display.cy + 300)
	self:_addBtn("btn_start.png", GAME_MODEL_NAME_SHORT[3],function()
		global.sceneMgr:replaceScene("MainScene",nil,0,GAME_MODEL.BUDDHIST)
	end, display.cx, display.cy + 150)

	local MainMenu = CCMenu:create()
	MainMenu:setPosition(ccp(0,0))
	self:addChild(MainMenu)

	self.m_guildBtn = ui.newTTFLabelMenuItem({
		listener = function()
			local text = GUID_TEXT[global.isOpenGuid]
			if text == GUID_TEXT[1] then
				self.m_guildBtn:setString(GUID_TEXT[2])
				global.isOpenGuid = 2
			else
				self.m_guildBtn:setString(GUID_TEXT[1])
				global.isOpenGuid = 1
			end
			global.gamecenterMgr:updateSettings()
		end,
		x = 80,
		y = display.cy,
		text = GUID_TEXT[global.isOpenGuid],
		font = "Marker Felt",
		size = 40,
		-- color = ccc3(255, 0, 0),
		align = ui.TEXT_ALIGN_CENTER
		})
	MainMenu:addChild(self.m_guildBtn)

	ui.newTTFLabelMenuItem({
		listener = function()
		end,
		x = display.cx,
		y = display.cy,
		text = RANK_TEXT,
		font = "Marker Felt",
		size = 40,
		-- color = ccc3(255, 0, 0),
		align = ui.TEXT_ALIGN_CENTER
		})
		:addTo(self)

	ui.newTTFLabelMenuItem({
		listener = function()
		end,
		x = display.right - 50,
		y = display.cy,
		text = RATE_TEXT,
		font = "Marker Felt",
		size = 40,
		-- color = ccc3(255, 0, 0),
		align = ui.TEXT_ALIGN_CENTER
		})
		:addTo(self)
end

-- function StartScene:( ... )
-- 	-- body
-- end

function StartScene:_addBtn(imgName,text,callback,x,y)
	cc.ui.UIPushButton.new(imgName, {scale9 = true})
		:setButtonLabel(cc.ui.UILabel.new({text = text,size = 55,font = "Marker Felt",align = ui.TEXT_ALIGN_CENTER}))
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
