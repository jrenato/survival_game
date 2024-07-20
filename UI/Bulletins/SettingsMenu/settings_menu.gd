extends FadingBulletin

var open_pause_menu_after_closing: bool = false

@onready var music_label: Label = %MusicVolumeLabel
@onready var sfx_label: Label = %SFXVolumeLabel
@onready var resolution_scale_label: Label = %ResolutionScaleLabel

@onready var music_volume_slider: HSlider = %MusicVolumeSlider
@onready var sfx_volume_slider: HSlider = %SFXVolumeSlider
@onready var resolution_scale_slider: HSlider = %ResolutionScaleSlider
@onready var ssaa_check_button: CheckButton = %SSAACheckButton
@onready var fullscreen_check_button: CheckButton = %FullscreenCheckButton


func initialize(_open_pause_menu_after_closing: Variant) -> void:
	if _open_pause_menu_after_closing is bool:
		open_pause_menu_after_closing = _open_pause_menu_after_closing


func _ready() -> void:
	EventSystem.request_settings_resource.emit(set_settings_visual)

	music_volume_slider.value_changed.connect(_on_music_volume_slider_value_changed)
	sfx_volume_slider.value_changed.connect(_on_sfx_volume_slider_value_changed)
	resolution_scale_slider.value_changed.connect(_on_resolution_scale_slider_value_changed)
	ssaa_check_button.toggled.connect(_on_ssaa_check_button_toggled)
	fullscreen_check_button.toggled.connect(_on_fullscreen_check_button_toggled)

	super()


func set_settings_visual(settings_resource: SettingsResource) -> void:
	update_music_volume_label(settings_resource.music_volume)
	music_volume_slider.value = settings_resource.music_volume
	update_sfx_volume_label(settings_resource.sfx_volume)
	sfx_volume_slider.value = settings_resource.sfx_volume
	update_resolution_scale_label(settings_resource.resolution_scale)
	resolution_scale_slider.value = settings_resource.resolution_scale

	ssaa_check_button.button_pressed = settings_resource.ssaa_enabled
	fullscreen_check_button.button_pressed = settings_resource.fullscreen_enabled


func destroy_self() -> void:
	EventSystem.disabled_bulletin.emit(BulletinConfig.Keys.SETTINGS_MENU)


func _on_music_volume_slider_value_changed(value: float) -> void:
	EventSystem.music_volume_changed.emit(value)
	update_music_volume_label(value)


func update_music_volume_label(value: float) -> void:
	music_label.text = str(snappedi(value * 100, 1)) + " %"


func _on_sfx_volume_slider_value_changed(value: float) -> void:
	EventSystem.sfx_volume_changed.emit(value)
	update_sfx_volume_label(value)


func update_sfx_volume_label(value: float) -> void:
	sfx_label.text = str(snappedi(value * 100, 1)) + " %"


func _on_resolution_scale_slider_value_changed(value: float) -> void:
	EventSystem.resolution_scale_changed.emit(value)
	update_resolution_scale_label(value)


func update_resolution_scale_label(value: float) -> void:
	resolution_scale_label.text = str(snappedi(value * 100, 1)) + " %"


func _on_ssaa_check_button_toggled(toggled_on: bool) -> void:
	EventSystem.ssaa_changed.emit(toggled_on)


func _on_fullscreen_check_button_toggled(toggled_on: bool) -> void:
	EventSystem.fullscreen_changed.emit(toggled_on)


func _on_close_button_pressed() -> void:
	fade_out()

	EventSystem.request_save_settings.emit()

	if open_pause_menu_after_closing:
		EventSystem.enabled_bulletin.emit(BulletinConfig.Keys.PAUSE_MENU)
