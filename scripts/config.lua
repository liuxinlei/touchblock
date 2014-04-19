
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 2
DEBUG_FPS = true
DEBUG_MEM = true

-- design resolution
CONFIG_SCREEN_WIDTH  = 640
CONFIG_SCREEN_HEIGHT = 960

-- auto scale mode
CONFIG_SCREEN_AUTOSCALE = "FIXED_WIDTH"

GAME_MUSIC = {
	"sound/1.mp3",
	"sound/2.mp3",
	"sound/3.mp3",
	"sound/4.mp3"
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

GAME_MODEL_NAME = {
	"经典模式",
	"街机模式",
	"禅模式" 
}

--街机模式方块移动初始速度
ARCADE_SPEED = 10

--街机模式每次速度增加
ARCADE_SPEED_ADD = 0.005

--街机模式中速度的最大值
ARCADE_SPEED_MAX = 30

--经典模式的方块行数
CLASSICAL_ROWS = 10

--禅模式限制时间
BUDDHIST_TIME = 30

--失败提示语
FAILED_TIPS = "失败"

--时间到提示
TIME_OUT_TIPS = "时间到了！"

--历史最佳提示语
BEST_TIPS = "新纪录！"

BEST_LABEL = "最佳："

GUID_TEXT = {
	"指引：关",
	"指引：开"	
}

RANK_TEXT = "排行榜"

RATE_TEXT = "评 分"
