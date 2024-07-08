class_name MusicConfig

enum Keys {
	ISLAND_AMBIANCE,
	MAIN_MENU_SONG,
}

const FILE_PATHS: Dictionary = {
	Keys.ISLAND_AMBIANCE: "res://Assets/audio/music/island_ambience.ogg",
	Keys.MAIN_MENU_SONG: "res://Assets/audio/music/transfixed_main_theme.ogg",
}


static func get_audio_stream(key: Keys) -> AudioStream:
	return load(FILE_PATHS[key])
