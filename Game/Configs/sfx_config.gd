class_name SFXConfig

enum Keys {
	UI_CLICK,
	ITEM_PICKUP,
	CRAFT,
	BUILD,
	EAT,
	ATTACK,
}

const FILE_PATHS: Dictionary = {
	Keys.UI_CLICK: "res://Assets/audio/sfx/ui_click.wav",
	Keys.ITEM_PICKUP: "res://Assets/audio/sfx/item_pickup.wav",
	Keys.CRAFT: "res://Assets/audio/sfx/craft.wav",
	Keys.BUILD: "res://Assets/audio/sfx/build.wav",
	Keys.EAT: "res://Assets/audio/sfx/eat.wav",
	Keys.ATTACK: "res://Assets/audio/sfx/weapon_swoosh.wav",
}


static func get_audio_stream(key: Keys) -> AudioStream:
	return load(FILE_PATHS[key])
