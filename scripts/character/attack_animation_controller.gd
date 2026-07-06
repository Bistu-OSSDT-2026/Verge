## attack_animation_controller.gd
## 攻击动画控制器 — 挂载在角色根节点下
## 负责：通过同级的 AnimatedSprite2D 播放 attack 动画 → 动画一帧结束后发出信号 → 由角色基类执行伤害

extends Node

# ---------- 信号 ----------
## 攻击动画播放完毕，可以造成伤害了
signal attack_animation_finished(target: Node)

## 攻击动画开始后触发（可用于冻结目标、播放音效等）
signal attack_animation_started

# ---------- 节点引用 ----------
@onready var parent_character: CharacterBody2D = get_parent()
@onready var animated_sprite: AnimatedSprite2D = _find_animated_sprite()


## 查找同级 AnimatedSprite2D（在角色根节点下找）
func _find_animated_sprite() -> AnimatedSprite2D:
	var sprite: Node = parent_character.find_child("AnimatedSprite2D", false, false)
	return sprite if sprite is AnimatedSprite2D else null


## 由 character_base._perform_attack() 调用
## 在 AnimatedSprite2D 上播放 "attack" 动画，播放完毕后 emit attack_animation_finished
func play_attack_animation(target: Node2D) -> void:
	if not animated_sprite:
		attack_animation_finished.emit(target)
		return

	if not animated_sprite.sprite_frames.has_animation("attack"):
		attack_animation_finished.emit(target)
		return

	attack_animation_started.emit()

	# 播放攻击动画（纯视觉，不阻塞伤害逻辑）
	# 先切 default 再切 attack，强制从头播放
	if animated_sprite.sprite_frames.has_animation("default"):
		animated_sprite.play("default")
	animated_sprite.play("attack")

	# 立即触发回调（不等动画播完）
	# 原因：attack 动画 1.5s 等于攻击冷却，等播完再发射子弹手感太差
	# 动画只是视觉反馈，不应阻塞伤害/投射物逻辑
	attack_animation_finished.emit(target)


## animation_finished 信号触发的内部回调
func _on_sprite_attack_finished(target: Node) -> void:
	attack_animation_finished.emit(target)
	if animated_sprite and animated_sprite.sprite_frames.has_animation("default"):
		animated_sprite.play("default")


## 立即攻击（无动画延迟）
func instant_attack(target: Node2D) -> void:
	attack_animation_finished.emit(target)
