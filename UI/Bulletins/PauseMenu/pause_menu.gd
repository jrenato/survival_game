extends FadingBulletin

const BUTTON_FADE_TIME: float = 0.15

@onready var resume_button: Button = %ResumeButton
@onready var settings_button: Button = %SettingsButton
@onready var exit_button: Button = %ExitButton


func _ready() -> void:
	resume_button.pressed.connect(_on_resume_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)
	resume_button.modulate = TRANSPARENT_COLOR
	settings_button.modulate = TRANSPARENT_COLOR
	exit_button.modulate = TRANSPARENT_COLOR

	get_tree().paused = true

	super()


func fade_in() -> void:
	super()

	var tween: Tween = create_tween()
	tween.tween_property(resume_button, "modulate", Color.WHITE, BUTTON_FADE_TIME)
	tween.tween_property(settings_button, "modulate", Color.WHITE, BUTTON_FADE_TIME)
	tween.tween_property(exit_button, "modulate", Color.WHITE, BUTTON_FADE_TIME)


func destroy_self() -> void:
	EventSystem.disabled_bulletin.emit(BulletinConfig.Keys.PAUSE_MENU)
	EventSystem.enabled_player.emit()
	EventSystem.hud_show.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	fade_out()


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	EventSystem.stage_changed.emit(StageConfig.Keys.MAIN_MENU)
