class_name SFXConfig

enum Keys {
	UI_CLICK,
	ITEM_PICKUP,
	CRAFT,
	BUILD,
	EAT,
	ATTACK,
	TREE_HIT,
	BOULDER_HIT,
	COW_HURT,
	COW_ATTACK,
	WOLF_HURT,
	WOLF_ATTACK,
	FOOTSTEP,
	JUMP_LAND,
}

const FILE_PATHS: Dictionary = {
	Keys.UI_CLICK: "res://Assets/audio/sfx/ui_click.wav",
	Keys.ITEM_PICKUP: "res://Assets/audio/sfx/item_pickup.wav",
	Keys.CRAFT: "res://Assets/audio/sfx/craft.wav",
	Keys.BUILD: "res://Assets/audio/sfx/build.wav",
	Keys.EAT: "res://Assets/audio/sfx/eat.wav",
	Keys.ATTACK: "res://Assets/audio/sfx/weapon_swoosh.wav",
	Keys.TREE_HIT: "res://Assets/audio/sfx/tree_hit.wav",
	Keys.BOULDER_HIT: "res://Assets/audio/sfx/boulder_hit.wav",
	Keys.COW_HURT: "res://Assets/audio/sfx/cow_hurt.wav",
	Keys.COW_ATTACK: "res://Assets/audio/sfx/cow_attack.wav",
	Keys.WOLF_HURT: "res://Assets/audio/sfx/wolf_hurt.wav",
	Keys.WOLF_ATTACK: "res://Assets/audio/sfx/wolf_attack.wav",
	Keys.FOOTSTEP: "res://Assets/audio/sfx/footstep.wav",
	Keys.JUMP_LAND: "res://Assets/audio/sfx/jump_land.wav",
}


static func get_audio_stream(key: Keys) -> AudioStream:
	return load(FILE_PATHS[key])
