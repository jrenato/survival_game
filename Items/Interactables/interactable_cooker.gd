class_name InteractableCooker extends Interactable


func start_interaction() -> void:
	EventSystem.enabled_bulletin.emit(BulletinConfig.Keys.COOKING_MENU)
