extends Node


func _ready() -> void:
	EventSystem.play_music.emit(MusicConfig.Keys.ISLAND_AMBIANCE)
