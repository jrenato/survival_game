class_name MusicConfig

enum Keys {
	ISLAND_AMBIANCE,
}

const FILE_PATHS: Dictionary = {
	Keys.ISLAND_AMBIANCE: "res://Assets/audio/music/island_ambience.ogg",
}


static func get_audio_stream(key: Keys) -> AudioStream:
	return load(FILE_PATHS[key])
