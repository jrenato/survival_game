class_name MusicController extends AudioStreamPlayer


func _ready() -> void:
	bus = "Music"
	play_music(MusicConfig.Keys.ISLAND_AMBIANCE)


func play_music(key: MusicConfig.Keys) -> void:
	stream = MusicConfig.get_audio_stream(key)
	play()
