extends Node


func _enter_tree() -> void:
	EventSystem.sleep_started.connect(_on_sleep_started)


func _on_sleep_started() -> void:
	EventSystem.disabled_player.emit()
	EventSystem.game_fade_in.emit(2.0, fast_forward_sleep)


func fast_forward_sleep() -> void:
	EventSystem.fast_forward_time.emit(8)

	await get_tree().create_timer(1.5).timeout

	EventSystem.enabled_player.emit()
	EventSystem.game_fade_out.emit(1.0, null)
