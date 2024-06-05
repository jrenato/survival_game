class_name BulletinConfig

enum Keys {
	INTERACTION_PROMPT
}

const BULLETIN_PATHS: Dictionary = {
	Keys.INTERACTION_PROMPT: preload("res://UI/Bulletins/interaction_prompt.tscn"),
}


static func get_bulletin(key: Keys) -> Bulletin:
	return BULLETIN_PATHS.get(key).instantiate()
