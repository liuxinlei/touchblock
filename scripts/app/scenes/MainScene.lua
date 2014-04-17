
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor(model)
    
    global.sceneMgr.p_model = model
    -------------------------变量定义开始-------------
    self.m_blockLayer = nil
    self.m_uiLayer = nil
    -------------------------变量定义结束-------------
    self:_initLayer()
end

function MainScene:_initLayer()
    display.newSprite("bg.png",display.cx,display.cy):addTo(self)
    self.m_blockLayer = display.newLayer():addTo(self)
    self.m_uiLayer = display.newLayer():addTo(self)

    self.m_blockLayer:setTag(TAG.BLOCK_LAYER)
    self.m_uiLayer:setTag(TAG.UI_LAYER)

    -- self.m_blockLayer:setTouchEnabled(true)
end

function MainScene:onEnter()
    global.blockLayerMgr:initBlocks()
    global.blockLayerMgr:start()
    global.uilayerMgr:initLayer()
end

function MainScene:onExit()
	global.blockLayerMgr:clearAll()
    global.uilayerMgr:stopAll()
end

return MainScene
