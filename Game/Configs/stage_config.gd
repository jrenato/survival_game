class_name StageConfig


enum Keys {
	ISLAND,
}


const STAGE_PATHS: Dictionary = {
	Keys.ISLAND: preload("res://Stages/island.tscn"),
}


static func get_stage(key: Keys) -> Node:
	return STAGE_PATHS.get(key).instantiate()
