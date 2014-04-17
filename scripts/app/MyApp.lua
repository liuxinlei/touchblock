
require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")
require("app.global")

scheduler = require(cc.PACKAGE_NAME..".scheduler")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    global.sceneMgr = require("app.managers.SceneMgr").new()
	global.blockLayerMgr = require("app.managers.BlockLayerMgr").new()
	global.uilayerMgr = require("app.managers.UIlayerManager").new()

    global.sceneMgr:replaceScene("StartScene")
end

return MyApp
