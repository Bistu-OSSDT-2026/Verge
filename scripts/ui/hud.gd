## hud.gd
## HUD 顶部信息栏 — 显示阶段、倒计时、天数、金币、核心HP
## 包含一个倍速切换按钮 (1x / 2x)
## 只管理顶部 Label + 倍速按钮，部署面板由 deploy_panel.gd 负责

extends Control

@onready var phase_label: Label = $PhaseLabel
@onready var timer_label: Label = $TimerLabel
@onready var day_label: Label = $DayLabel
@onready var gold_label: Label = $GoldLabel
@onready var core_hp_label: Label = $CoreHPLabel
@onready var speed_btn: Button = $SpeedBtn
@onready var pause_btn: Button = $PauseBtn

# 倍速状态
var speed_multiplier: float = 1.0  # 1.0 或 2.0

# PauseMenu 节点缓存（避免每次点击都 find_child）
var pause_menu_ref: CanvasLayer = null


func _ready() -> void:
	_refresh_all()
	SignalBus.cycle_phase_changed.connect(_on_phase_changed)
	SignalBus.gold_changed.connect(_on_gold_changed)
	SignalBus.core_hp_changed.connect(_on_core_hp_changed)
	SignalBus.day_completed.connect(_on_day_completed)
	# 倍速按钮
	if speed_btn:
		speed_btn.pressed.connect(_on_speed_btn_pressed)
		_refresh_speed_btn()
	# 暂停按钮
	if pause_btn:
		pause_btn.pressed.connect(_on_pause_btn_pressed)


func _process(_delta: float) -> void:
	_update_time_display()


func _on_speed_btn_pressed() -> void:
	# 1x ↔ 2x 切换（暂停状态下不响应）
	if GameManager.is_paused:
		return
	if speed_multiplier == 1.0:
		speed_multiplier = 2.0
	else:
		speed_multiplier = 1.0
	Engine.time_scale = speed_multiplier
	_refresh_speed_btn()
	print("[HUD] 倍速切换 → %.1fx" % speed_multiplier)


func _on_pause_btn_pressed() -> void:
	# 打开暂停菜单 — 直接通过节点名查找
	if not is_instance_valid(pause_menu_ref):
		var scene := get_tree().current_scene
		if scene:
			pause_menu_ref = scene.find_child("PauseMenu", true, false)
	if pause_menu_ref and pause_menu_ref.has_method("open"):
		pause_menu_ref.open()
	else:
		# 兜底：如果 PauseMenu 没找到，单纯暂停游戏
		GameManager.set_paused(true)
		print("[HUD] 警告：未找到 PauseMenu 节点，仅暂停游戏逻辑")


func _refresh_speed_btn() -> void:
	if not speed_btn:
		return
	if speed_multiplier == 1.0:
		speed_btn.text = "▶ 1x"
	else:
		speed_btn.text = "▶▶ 2x"




func _on_phase_changed(phase_name: String) -> void:
	_refresh_phase(phase_name)

func _on_gold_changed(new_gold: int) -> void:
	_refresh_gold(new_gold)

func _on_core_hp_changed(hp: float) -> void:
	_refresh_core_hp(hp)

func _on_day_completed(day: int) -> void:
	# GameManager.next_day() 已经先 +1 再 emit, 所以 day 参数就是"当前天"
	if day_label:
		day_label.text = "📅 Day %d / 3" % day


func _refresh_all() -> void:
	if not phase_label:
		return
	_refresh_phase(TimeCycle.get_phase_name(TimeCycle.current_phase))
	_refresh_gold(Economy.gold)
	# 从核心节点读当前 HP（策划书 4.1: 1000）
	var initial_hp := 1000.0
	var core := get_tree().current_scene.find_child("Core", true, false) if get_tree().current_scene else null
	if core and core.get("current_hp") != null:
		initial_hp = float(core.get("current_hp"))
	_refresh_core_hp(initial_hp)
	if day_label:
		day_label.text = "📅 Day %d / 3" % GameManager.current_day

func _refresh_phase(phase_name: String) -> void:
	if not phase_label:
		return
	var icon := TimeCycle.get_phase_display_icon(TimeCycle.current_phase)
	phase_label.text = "%s %s" % [icon, phase_name]

func _refresh_gold(amount: int) -> void:
	if not gold_label:
		return
	gold_label.text = "💰 %d 金" % amount

func _refresh_core_hp(hp: float) -> void:
	if not core_hp_label:
		return
	# 从核心节点读 max_hp（策划书 4.1: 1000）
	var max_hp: float = 1000.0
	var core := get_tree().current_scene.find_child("Core", true, false) if get_tree().current_scene else null
	if core and core.get("max_hp") != null:
		max_hp = float(core.get("max_hp"))
	var percent: float = hp / max_hp if max_hp > 0 else 0.0
	core_hp_label.text = "❤️ 核心 %.0f%%" % (percent * 100)
	if percent < 0.25:  # 策划书 3.2: 75% 受损时变红
		core_hp_label.modulate = Color(1, 0.2, 0.2)
	elif percent < 0.5:
		core_hp_label.modulate = Color(1, 0.85, 0.2)
	elif percent < 0.75:
		core_hp_label.modulate = Color(1, 1, 0.5)
	else:
		core_hp_label.modulate = Color(1, 1, 1)

func _update_time_display() -> void:
	if not timer_label:
		return
	var remaining := TimeCycle.get_time_remaining()
	if remaining > 60:
		timer_label.text = "⏱ %d:%02d" % [int(remaining) / 60, int(remaining) % 60]
	else:
		timer_label.text = "⏱ %.0fs" % remaining
