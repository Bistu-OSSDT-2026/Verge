## constants.gd
## 全局常量定义
## 在 project.godot 中设为 Autoload: Constants

extends Node

# ============ 时间循环 ============
const DAY_DURATION: float = 90.0
const DUSK_DURATION: float = 30.0
const NIGHT_DURATION: float = 90.0

const PHASE_DAY = "day"
const PHASE_DUSK = "dusk"
const PHASE_NIGHT = "night"
const PHASE_DAWN = "dawn"

# ============ 关卡配置 ============
const TUTORIAL_TOTAL_DAYS: int = 3  # 策划书 4.1: 教程关 3 天

# ============ 网格 ============
const GRID_CELL_SIZE: int = 64
const GRID_COLUMNS: int = 16
const GRID_ROWS: int = 9

# ============ 地形标记 ============
const TERRAIN_EMPTY = 0
const TERRAIN_PATH = 1
const TERRAIN_GROUND = 2    # 地面部署位
const TERRAIN_HIGH = 3     # 高台部署位
const TERRAIN_CORE = 4     # 核心位置
const TERRAIN_BLOCKED = 5  # 不可部署

# ============ 部署类型 ============
const DEPLOY_GROUND = "ground"
const DEPLOY_HIGH = "high"
const DEPLOY_BOTH = "both"
const DEPLOY_BUILDING = "building"

# ============ 角色类型 ============
# CHAR_PIONEER  先锋：廉价中庸，挡 2 + DPS 20（基础前排）
# CHAR_DEFENDER 重装：纯肉盾，挡 4 + HP 400 + 攻击 8（终极坦克）
# CHAR_SNIPER   狙击：远程单体爆发，DPS 30 / 6 格射程（远程输出）
# 设计决策（2026-07-01）：原 Guard 改为 Defender（重装型），重新定位差异化
const CHAR_PIONEER = "pioneer"
const CHAR_DEFENDER = "defender"  # 原 CHAR_GUARD，2026-07-01 改名为重装
const CHAR_SNIPER = "sniper"

# ============ 敌人类型 ============
const ENEMY_GRUNT = "chaos_grunt"
const ENEMY_GHOST = "swift_ghost"
const ENEMY_ELITE = "iron_elite"

# ============ 元素类型（Phase 2 扩展用） ============
const EARTH = "earth"
const WATER = "water"
const FIRE = "fire"
const WIND = "wind"

# ============ 黎明 ============
const DAWN_REVIVE_HP_PERCENT: float = 0.3
const DAWN_BONUS_CORE_THRESHOLD: float = 0.7
const DAWN_BONUS_GOLD: int = 50

# ============ Boss（正式关 Day 4） ============
const BOSS_SHADOW_LORD = "shadow_lord"
const BOSS_HP: int = 3000
