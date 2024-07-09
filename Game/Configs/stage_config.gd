class_name StageConfig


enum Keys {
	ISLAND,
	MAIN_MENU,
}


const STAGE_PATHS: Dictionary = {
	Keys.ISLAND: preload("res://Stages/Island/island.tscn"),
	Keys.MAIN_MENU: preload("res://Stages/MainMenu/main_menu.tscn"),
}


static func get_stage(key: Keys) -> Node:
	return STAGE_PATHS.get(key).instantiate()
