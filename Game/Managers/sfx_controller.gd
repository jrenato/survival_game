class_name SFXController extends AudioStreamPlayer


func _enter_tree() -> void:
	EventSystem.play_sound.connect(play_sound)
	EventSystem.play_dynamic_sound.connect(play_dynamic_sound)

func _ready() -> void:
	bus = "SFX"


func play_sound(key: SFXConfig.Keys) -> void:
	stream = SFXConfig.get_audio_stream(key)
	play()


func play_dynamic_sound(key: SFXConfig.Keys, _position: Vector3) -> void:
	var audio_stream_player = AudioStreamPlayer3D.new()
	add_child(audio_stream_player)

	audio_stream_player.bus = "SFX"
	audio_stream_player.stream = SFXConfig.get_audio_stream(key)
	audio_stream_player.global_position = _position
	audio_stream_player.pitch_scale = randf_range(0.7, 1.3)

	audio_stream_player.finished.connect(audio_stream_player.queue_free)
	audio_stream_player.play()
