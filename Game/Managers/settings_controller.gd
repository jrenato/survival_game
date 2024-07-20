extends Node

const SAVE_PATH: String = "user://settings.tres"

var settings_resource: SettingsResource


func _enter_tree() -> void:
	EventSystem.request_settings_resource.connect(_on_request_settings_resource)
	EventSystem.request_save_settings.connect(_on_request_save_settings)


func _ready() -> void:
	load_settings()
	apply_settings()
	EventSystem.music_volume_changed.connect(_on_music_volume_changed)
	EventSystem.sfx_volume_changed.connect(_on_sfx_volume_changed)
	EventSystem.resolution_scale_changed.connect(_on_resolution_scale_changed)
	EventSystem.ssaa_changed.connect(_on_ssaa_changed)
	EventSystem.fullscreen_changed.connect(_on_fullscreen_changed)


func load_settings() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		settings_resource = ResourceLoader.load(SAVE_PATH, "SettingsResource")

	if settings_resource == null:
		settings_resource = SettingsResource.new()


func apply_settings() -> void:
	apply_music_volume(settings_resource.music_volume)
	apply_sfx_volume(settings_resource.sfx_volume)
	apply_resolution_scale(settings_resource.resolution_scale)
	apply_ssaa_enabled(settings_resource.ssaa_enabled)
	apply_fullscreen_enabled(settings_resource.fullscreen_enabled)


func _on_music_volume_changed(value: float) -> void:
	settings_resource.music_volume = value
	apply_music_volume(value)


func apply_music_volume(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value))


func _on_sfx_volume_changed(value: float) -> void:
	settings_resource.sfx_volume = value
	apply_sfx_volume(value)


func apply_sfx_volume(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value))


func _on_resolution_scale_changed(value: float) -> void:
	settings_resource.resolution_scale = value
	apply_resolution_scale(value)


func apply_resolution_scale(value: float) -> void:
	get_viewport().set_scaling_3d_scale(value)


func _on_ssaa_changed(enabled: bool) -> void:
	settings_resource.ssaa_enabled = enabled
	apply_ssaa_enabled(enabled)


func apply_ssaa_enabled(enabled: bool) -> void:
	get_viewport().set_screen_space_aa(
		Viewport.SCREEN_SPACE_AA_FXAA if enabled else Viewport.SCREEN_SPACE_AA_DISABLED
	)


func _on_fullscreen_changed(enabled: bool) -> void:
	settings_resource.fullscreen_enabled = enabled
	apply_fullscreen_enabled(enabled)


func apply_fullscreen_enabled(enabled: bool) -> void:
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if enabled else DisplayServer.WINDOW_MODE_WINDOWED
	)


func _on_request_settings_resource(target_callable: Callable) -> void:
	target_callable.call(settings_resource)


func _on_request_save_settings() -> void:
	ResourceSaver.save(settings_resource, SAVE_PATH)
