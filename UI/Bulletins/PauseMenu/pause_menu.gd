extends Bulletin


const BG_NORMAL_COLOR: Color = Color(0.0, 0.0, 0.0, 0.7)
const BG_FADE_TIME: float = 0.25
const BUTTON_FADE_TIME: float = 0.15


@onready var background: ColorRect = %BackgroundColorRect
@onready var resume_button: Button = %ResumeButton
@onready var settings_button: Button = %SettingsButton
@onready var exit_button: Button = %ExitButton



func _ready() -> void:
	resume_button.pressed.connect(_on_resume_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	background.color = Color.TRANSPARENT
	resume_button.modulate = Color.TRANSPARENT
	settings_button.modulate = Color.TRANSPARENT
	exit_button.modulate = Color.TRANSPARENT
	fade_in()
	EventSystem.hud_hide.emit()


func fade_in() -> void:
	create_tween().tween_property(background, "color", BG_NORMAL_COLOR, BG_FADE_TIME)

	var tween: Tween = create_tween()
	tween.tween_property(resume_button, "modulate", Color.WHITE, BUTTON_FADE_TIME)
	tween.tween_property(settings_button, "modulate", Color.WHITE, BUTTON_FADE_TIME)
	tween.tween_property(exit_button, "modulate", Color.WHITE, BUTTON_FADE_TIME)


func fade_out() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, BG_FADE_TIME)
	tween.tween_callback(destroy_self)


func destroy_self() -> void:
	EventSystem.disabled_bulletin.emit(BulletinConfig.Keys.PAUSE_MENU)
	EventSystem.enabled_player.emit()
	EventSystem.hud_show.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_resume_button_pressed() -> void:
	fade_out()


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	EventSystem.stage_changed.emit(StageConfig.Keys.MAIN_MENU)
