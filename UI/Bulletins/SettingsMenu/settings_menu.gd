extends FadingBulletin

var open_pause_menu_after_closing: bool = false

@onready var music_label: Label = %MusicVolumeLabel
@onready var sfx_label: Label = %SFXVolumeLabel
@onready var scale_label: Label = %ResolutionScaleLabel


func initialize(_open_pause_menu_after_closing: Variant) -> void:
	if _open_pause_menu_after_closing is bool:
		open_pause_menu_after_closing = _open_pause_menu_after_closing


func destroy_self() -> void:
	EventSystem.disabled_bulletin.emit(BulletinConfig.Keys.SETTINGS_MENU)


func _on_music_volume_slider_value_changed(value: float) -> void:
	EventSystem.music_volume_changed.emit(value)
	music_label.text = str(snappedi(value * 100, 1)) + " %"


func _on_sfx_volume_slider_value_changed(value: float) -> void:
	EventSystem.sfx_volume_changed.emit(value)
	sfx_label.text = str(snappedi(value * 100, 1)) + " %"


func _on_resolution_scale_slider_value_changed(value: float) -> void:
	EventSystem.resolution_scale_changed.emit(value)
	scale_label.text = str(snappedi(value * 100, 1)) + " %"


func _on_ssaa_check_button_toggled(toggled_on: bool) -> void:
	EventSystem.ssaa_changed.emit(toggled_on)


func _on_fullscreen_check_button_toggled(toggled_on: bool) -> void:
	EventSystem.fullscreen_changed.emit(toggled_on)


func _on_close_button_pressed() -> void:
	fade_out()

	if open_pause_menu_after_closing:
		EventSystem.enabled_bulletin.emit(BulletinConfig.Keys.PAUSE_MENU)
