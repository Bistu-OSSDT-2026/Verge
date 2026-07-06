## resolution_manager.gd
## 窗口分辨率适配管理器 — 拉窗口时整个游戏等比放大
## 修复 Godot 4 编辑器 stretch 不生效问题：直接轮询窗口大小 + 动态改 viewport
## Autoload 单例

extends Node

const BASE_WIDTH: int = 1280
const BASE_HEIGHT: int = 720


func _ready() -> void:
	# 监听 size_changed
	get_tree().root.size_changed.connect(_on_window_size_changed)
	# 延迟一帧应用（确保 main scene 已加载）
	await get_tree().process_frame
	_apply_resolution()
	# 持续轮询（保险：处理 size_changed 漏触发的情况）
	var timer := Timer.new()
	timer.wait_time = 0.5
	timer.timeout.connect(_apply_resolution)
	add_child(timer)
	timer.start()
	print("[Resolution] 初始化完成, 基准 %dx%d" % [BASE_WIDTH, BASE_HEIGHT])


func _on_window_size_changed() -> void:
	_apply_resolution()


func _apply_resolution() -> void:
	var window_size: Vector2i = get_tree().root.size
	if window_size.x <= 0 or window_size.y <= 0:
		return

	# cover 模式：取 max(scale) 让基准 size 放大到至少填满一个方向
	var scale_x: float = float(window_size.x) / float(BASE_WIDTH)
	var scale_y: float = float(window_size.y) / float(BASE_HEIGHT)
	var scale: float = maxf(scale_x, scale_y)

	var new_w: int = int(ceil(float(BASE_WIDTH) * scale))
	var new_h: int = int(ceil(float(BASE_HEIGHT) * scale))

	# 改 viewport size + project settings
	var viewport := get_viewport()
	if viewport:
		viewport.size = Vector2i(new_w, new_h)
	ProjectSettings.set_setting("display/window/size/viewport_width", new_w)
	ProjectSettings.set_setting("display/window/size/viewport_height", new_h)
	# 强制重设根 viewport 的 content scale（让 stretch 模式生效）
	var root_win := get_tree().root
	if root_win:
		root_win.content_scale_size = Vector2i(new_w, new_h)
		root_win.content_scale_factor = 1.0
		root_win.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_EXPAND

	print("[Resolution] 窗口 %dx%d (%.2f:1) → viewport %dx%d" % [
		window_size.x, window_size.y, float(window_size.x) / float(window_size.y),
		new_w, new_h
	])
