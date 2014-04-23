
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 1
DEBUG_FPS = false
DEBUG_MEM = false

-- design resolution
CONFIG_SCREEN_WIDTH  = 640
CONFIG_SCREEN_HEIGHT = 960

DESGIN_HEIGHT = 960

-- auto scale mode
CONFIG_SCREEN_AUTOSCALE = "FIXED_WIDTH"

APPID = 862970669
-- APPID = 836919450

GAME_MUSIC = {
	click = "sound/click.mp3",
	click_error = "sound/click_error.mp3"
}

TAG = {
	BLOCK_LAYER = 1000,
	UI_LAYER = 1001
}

MAX_ROW    = 8
MAX_COLUMN = 4

--游戏模式
GAME_MODEL = {
	CLASSICAL = 0,	--经典
	ARCADE    = 1,	--街机
	BUDDHIST  = 2 	--禅
}

--街机模式方块移动初始速度
ARCADE_SPEED = 14

--街机模式每次速度增加
ARCADE_SPEED_ADD = 0.007

--街机模式中速度的最大值
ARCADE_SPEED_MAX = 30

--经典模式的方块行数
CLASSICAL_ROWS = 50

--禅模式限制时间
BUDDHIST_TIME = 30

LEADBOARD_IDS = {
	"862970669_1",
	"862970669_2",
	"862970669_3"
}
--评分时跳转的Url
RATE_URL = "itms-apps://itunes.apple.com/app/id%d"