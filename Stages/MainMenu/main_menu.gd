extends Node

@onready var start_button: Button = %StartButton
@onready var settings_button: Button = %SettingsButton
@onready var credits_button: Button = %CreditsButton
@onready var exit_button: Button = %ExitButton


func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)

	EventSystem.play_music.emit(MusicConfig.Keys.MAIN_MENU_SONG)


func _on_start_button_pressed() -> void:
	EventSystem.stage_changed.emit(StageConfig.Keys.ISLAND)


func _on_settings_button_pressed() -> void:
	pass


func _on_credits_button_pressed() -> void:
	pass


func _on_exit_button_pressed() -> void:
	get_tree().quit()
