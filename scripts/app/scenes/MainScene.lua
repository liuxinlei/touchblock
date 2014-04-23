
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor(model)
    global.sceneMgr.p_model = model
    -------------------------变量定义开始-------------
    self.m_startLine = nil
    self.m_blockLayer = nil
    self.m_uiLayer = nil
    self.m_guidLayer = nil
    -------------------------变量定义结束-------------
    self:_initLayer()
end

function MainScene:_initLayer()
    display.newSprite("bg.png",display.cx,display.cy):addTo(self)
    self.m_startLine = display.newSprite("startline.png")
    self.m_startLine:setAnchorPoint(ccp(0,0))

    self.m_blockLayer = display.newLayer():addTo(self)
    self.m_uiLayer = display.newLayer():addTo(self)

    self.m_blockLayer:setTag(TAG.BLOCK_LAYER)
    self.m_uiLayer:setTag(TAG.UI_LAYER)

    self:addChild(self.m_startLine)
end

function MainScene:showOrHideStartLine(isshow)
    self.m_startLine:setVisible(isshow)
end

---------------------新手引导界面-------------------------

function MainScene:_handleGuid()
    if global.isOpenGuid == 1 then
        self.m_guidLayer = require("app.views.GuidLayer").new(global.sceneMgr.p_model)
        self:addChild(self.m_guidLayer)
    end
end

function MainScene:removeGuid()
    if self.m_guidLayer then
        self.m_guidLayer:removeSelf()
        self.m_guidLayer = nil
        global.isOpenGuid = 2
        global.gamecenterMgr:updateSettings()
    end
end

function MainScene:onEnter()
    global.blockLayerMgr:initBlocks()
    self.m_startLine:setScaleY(global.sceneMgr.p_scaleY)
    global.blockLayerMgr:start()
    global.uilayerMgr:initLayer()

    self:_handleGuid()
end

function MainScene:onExit()
	global.blockLayerMgr:clearAll()
    global.uilayerMgr:stopAll()

    self.m_startLine = nil
    self.m_blockLayer = nil
    self.m_uiLayer = nil

    global.sceneMgr.p_score = 0
end

return MainScene
