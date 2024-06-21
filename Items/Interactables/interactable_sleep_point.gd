extends Interactable


func start_interaction() -> void:
	EventSystem.sleep_started.emit()
	EventSystem.play_sound.emit(SFXConfig.Keys.ENTER_TENT)
