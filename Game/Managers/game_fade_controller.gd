class_name GameFadeController extends ColorRect

@export var animation_player: AnimationPlayer


func _enter_tree() -> void:
	EventSystem.game_fade_in.connect(_on_game_fade_in)
	EventSystem.game_fade_out.connect(_on_game_fade_out)


func _on_game_fade_in(fade_time: float, possible_callback: Variant, show_loading: bool = false) -> void:
	var tween: Tween = create_tween()

	tween.tween_property(self, "color", Color.BLACK, fade_time)
	tween.parallel()
	tween.tween_method(set_master_volume, 1.0, 0.0, fade_time)

	if possible_callback is Callable:
		tween.tween_callback(possible_callback)

	if show_loading:
		tween.tween_callback(animation_player.play.bind("loading"))


func _on_game_fade_out(fade_time: float, possible_callback: Variant) -> void:
	var tween: Tween = create_tween()

	tween.tween_property(self, "color", Color.TRANSPARENT, fade_time)
	tween.parallel()
	tween.tween_method(set_master_volume, 0.0, 1.0, fade_time)

	if possible_callback is Callable:
		tween.tween_callback(possible_callback)

	animation_player.play("RESET")


func set_master_volume(volume_linear: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(volume_linear))

