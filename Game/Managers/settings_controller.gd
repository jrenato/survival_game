extends Node


func _enter_tree() -> void:
	EventSystem.music_volume_changed.connect(_on_music_volume_changed)
	EventSystem.sfx_volume_changed.connect(_on_sfx_volume_changed)
	EventSystem.resolution_scale_changed.connect(_on_resolution_scale_changed)
	EventSystem.ssaa_changed.connect(_on_ssaa_changed)
	EventSystem.fullscreen_changed.connect(_on_fullscreen_changed)


func _on_music_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value))


func _on_sfx_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value))


func _on_resolution_scale_changed(value: float) -> void:
	get_viewport().set_scaling_3d_scale(value)


func _on_ssaa_changed(enabled: bool) -> void:
	get_viewport().set_screen_space_aa(
		Viewport.SCREEN_SPACE_AA_FXAA if enabled else Viewport.SCREEN_SPACE_AA_DISABLED
	)


func _on_fullscreen_changed(enabled: bool) -> void:
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if enabled else DisplayServer.WINDOW_MODE_WINDOWED
	)
