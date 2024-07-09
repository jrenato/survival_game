class_name BulletinConfig

enum Keys {
	INTERACTION_PROMPT,
	CRAFTING_MENU,
	COOKING_MENU,
	PAUSE_MENU,
}

const BULLETIN_PATHS: Dictionary = {
	Keys.INTERACTION_PROMPT: "res://UI/Bulletins/interaction_prompt.tscn",
	Keys.CRAFTING_MENU: "res://UI/Bulletins/PlayerMenus/crafting_menu.tscn",
	Keys.COOKING_MENU: "res://UI/Bulletins/PlayerMenus/cooking_menu.tscn",
	Keys.PAUSE_MENU: "res://UI/Bulletins/PauseMenu/pause_menu.tscn",
}


static func get_bulletin(key: Keys) -> PackedScene:
	return load(BULLETIN_PATHS.get(key))
