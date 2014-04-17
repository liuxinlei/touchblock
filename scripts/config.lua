
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 2
DEBUG_FPS = true
DEBUG_MEM = true

-- design resolution
CONFIG_SCREEN_WIDTH  = 640
CONFIG_SCREEN_HEIGHT = 960

-- auto scale mode
CONFIG_SCREEN_AUTOSCALE = "FIXED_WIDTH"

TAG = {
	BLOCK_LAYER = 1000,
	UI_LAYER = 1001
}

MAX_ROW    = 6
MAX_COLUMN = 4

--游戏模式
GAME_MODEL = {
	CLASSICAL = 0,	--经典
	ARCADE    = 1,	--街机
	BUDDHIST  = 2 	--禅
}

--街机模式方块移动速度
ARCADE_SPEED = 15

--经典模式的方块行数
CLASSICAL_ROWS = 20

--禅模式限制时间
BUDDHIST_TIME = 30

--失败提示语
FAILED_TIPS = "失败！"

--时间到提示
TIME_OUT_TIPS = "时间到了！"