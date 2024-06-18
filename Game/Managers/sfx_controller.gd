class_name SFXController extends AudioStreamPlayer


func _enter_tree() -> void:
	EventSystem.play_sound.connect(play_sound)


func _ready() -> void:
	bus = "SFX"


func play_sound(key: SFXConfig.Keys) -> void:
	stream = SFXConfig.get_audio_stream(key)
	play()
