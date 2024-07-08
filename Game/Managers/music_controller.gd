class_name MusicController extends AudioStreamPlayer


func _ready() -> void:
	bus = "Music"
	EventSystem.play_music.connect(play_music)


func play_music(key: MusicConfig.Keys) -> void:
	stream = MusicConfig.get_audio_stream(key)
	play()
