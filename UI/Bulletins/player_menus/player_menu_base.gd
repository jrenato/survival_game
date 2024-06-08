extends Bulletin



func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	EventSystem.disabled_player.emit()


func close() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.disabled_bulletin.emit(BulletinConfig.Keys.CRAFTING_MENU)
	EventSystem.enabled_player.emit()
