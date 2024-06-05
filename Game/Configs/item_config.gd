class_name ItemConfig

enum Keys {
	STICK,
	STONE,
	PLANT
}

const ITEM_RESOURCE_PATHS: Dictionary = {
	Keys.STICK: preload("res://Resources/ItemResources/stick_resource.tres"),
	Keys.STONE: preload("res://Resources/ItemResources/stone_resource.tres"),
	Keys.PLANT: preload("res://Resources/ItemResources/plant_resource.tres"),
}


static func get_item_resource(key: Keys) -> ItemResource:
	return ITEM_RESOURCE_PATHS.get(key)
