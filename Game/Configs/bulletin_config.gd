class_name BulletinConfig

enum Keys {
	INTERACTION_PROMPT,
	CRAFTING_MENU,
}

const BULLETIN_PATHS: Dictionary = {
	Keys.INTERACTION_PROMPT: "res://UI/Bulletins/interaction_prompt.tscn",
	Keys.CRAFTING_MENU: "res://UI/Bulletins/player_menus/crafting_menu.tscn",
}


static func get_bulletin(key: Keys) -> PackedScene:
	return load(BULLETIN_PATHS.get(key))
