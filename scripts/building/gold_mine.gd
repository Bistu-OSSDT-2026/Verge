## gold_mine.gd
## 金矿脚本 — 定时产出金币 + 可被敌人攻击（PVZ 向日葵逻辑）
## 挂载在 gold_mine.tscn 的根节点上

extends Node2D

# ---------- 属性 ----------
@export var build_cost: int = 50              # 建造费用
@export var gold_per_tick: int = 10           # 每次产金量
@export var tick_interval: float = 5.0        # 产出间隔（秒）
@export var max_hp: float = 80.0              # 血量（PVZ 向日葵一击就碎，这里给个缓冲）
@export var hitbox_radius: float = 32.0       # 碰撞半径（与格子大小一致）

var tick_timer: float = 0.0                   # 产出计时器
var current_hp: float = max_hp                # 当前血量
var is_active: bool = true                     # 是否活跃（夜晚停产出）
var is_destroyed: bool = false                # 是否被摧毁

# 节点引用
@onready var visual: Node2D = $Visual          # 视觉（AnimatedSprite2D）
@onready var hitbox: Area2D = $Hitbox          # 敌人碰撞区
@onready var hitbox_shape: CollisionShape2D = $Hitbox/CollisionShape2D


# ---------- 生命周期 ----------
func _ready() -> void:
	current_hp = max_hp
	# 注册到 Economy
	Economy.register_mine(self)
	# 监听时间阶段切换（夜晚停产出 / 白天恢复）
	SignalBus.cycle_phase_changed.connect(_on_cycle_phase_changed)
	# 监听敌人碰撞（敌人是 CharacterBody2D → 用 body_entered）
	if hitbox:
		hitbox.body_entered.connect(_on_body_entered)
	print("[GoldMine] 金矿建成! HP:%.0f 每%.0f秒产%d金" % [max_hp, tick_interval, gold_per_tick])


## 时间阶段切换回调
func _on_cycle_phase_changed(phase_name: String) -> void:
	match phase_name:
		"夜晚":
			on_night_start()
		"白天":
			on_day_start()


func _exit_tree() -> void:
	# 从 Economy 注销
	Economy.unregister_mine(self)


func _process(delta: float) -> void:
	if is_destroyed:
		return
	if not is_active:
		return

	tick_timer += delta
	if tick_timer >= tick_interval:
		tick_timer = 0.0
		_produce_gold()


# ---------- 产出金币 ----------
func _produce_gold() -> void:
	Economy.on_mine_produced(self)
	print("[GoldMine] 产出 +%d金" % gold_per_tick)


# ---------- 时间循环响应 ----------
## 夜晚停产出
func on_night_start() -> void:
	is_active = false
	tick_timer = 0.0  # 清空累计计时，避免出夜晚瞬间立刻补产


## 白天恢复产出
func on_day_start() -> void:
	is_active = true
	tick_timer = 0.0


# ---------- 敌人攻击 ----------
## 敌人（CharacterBody2D）进入金矿碰撞区
func _on_body_entered(body: Node) -> void:
	if is_destroyed:
		return
	# 必须是敌人（有 take_damage 方法）
	if not (body and body.has_method("take_damage")):
		return
	# 敌人攻击金矿（PvZ 式：单次接触造成金矿最大血量 30% 伤害）
	take_damage(max_hp * 0.3)
	# 金矿"反击"：让敌人自己也掉血（PVZ 风格）
	body.take_damage(20)
	print("[GoldMine] 敌人攻击金矿! 金矿 HP: %.0f/%.0f" % [current_hp, max_hp])


## 受到伤害
func take_damage(amount: float) -> void:
	if is_destroyed:
		return
	current_hp = maxf(0.0, current_hp - amount)
	print("[GoldMine] 受到 %.0f 伤害! 剩余 HP: %.0f/%.0f" % [amount, current_hp, max_hp])
	# 受伤闪白
	_play_damage_flash()
	if current_hp <= 0:
		_destroy()


## 受伤闪白（通过 modulate 实现，AnimatedSprite2D / ColorRect 均适用）
func _play_damage_flash() -> void:
	if not visual:
		return
	visual.modulate = Color.WHITE
	var tween := create_tween()
	tween.tween_property(visual, "modulate", Color.WHITE, 0.0)
	tween.tween_property(visual, "modulate", Color(1, 1, 1, 1), 0.2)


## 摧毁
func _destroy() -> void:
	if is_destroyed:
		return
	is_destroyed = true
	print("[GoldMine] 金矿被摧毁!")
	# 视觉：缩小消失
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2(0.1, 0.1), 0.3)
	tween.parallel().tween_property(self, "modulate:a", 0.0, 0.3)
	tween.tween_callback(queue_free)
	# 通知部署位：自己没了
	# （deploy_slot.is_occupied 仍为 true 但 deployed_character 已无效 → 玩家可再点这格）
