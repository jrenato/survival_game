class_name ItemConfig

enum Keys {
	# Pickupables
	STICK,
	STONE,
	PLANT,
	MUSHROOM,
	FRUIT,
	LOG,
	COAL,
	FLINTSTONE,
	RAWMEAT,
	COOKEDMEAT,

	# Craftables
	AXE,
	PICKAXE,
	CAMPFIRE,
	MULTITOOL,
	ROPE,
	TINDERBOX,
	TORCH,
	TENT,
	RAFT,
}


const CRAFTABLE_ITEM_KEYS: Array[Keys] = [
	Keys.AXE,
	Keys.PICKAXE,
	# Keys.CAMPFIRE,
	# Keys.MULTITOOL,
	Keys.ROPE,
	# Keys.TINDERBOX,
	# Keys.TORCH,
	# Keys.TENT,
	# Keys.RAFT,
]


const ITEM_RESOURCE_PATHS: Dictionary = {
	Keys.STICK: "res://Resources/ItemResources/stick_item_resource.tres",
	Keys.STONE: "res://Resources/ItemResources/stone_item_resource.tres",
	Keys.PLANT: "res://Resources/ItemResources/plant_item_resource.tres",
	Keys.AXE: "res://Resources/ItemResources/axe_item_resource.tres",
	Keys.PICKAXE: "res://Resources/ItemResources/pickaxe_item_resource.tres",
	Keys.ROPE: "res://Resources/ItemResources/rope_item_resource.tres",
	Keys.MUSHROOM: "res://Resources/ItemResources/mushroom_item_resource.tres",
	Keys.LOG: "res://Resources/ItemResources/log_item_resource.tres",
	Keys.COAL: "res://Resources/ItemResources/coal_item_resource.tres",
	Keys.RAWMEAT: "res://Resources/ItemResources/raw_meat_item_resource.tres",
	Keys.TENT: "res://Resources/ItemResources/tent_item_resource.tres",
}


const CRAFTING_BLUEPRINT_RESOURCE_PATHS: Dictionary = {
	Keys.AXE: "res://Resources/CraftingBlueprintResources/axe_blueprint.tres",
	Keys.PICKAXE: "res://Resources/CraftingBlueprintResources/pickaxe_blueprint.tres",
	Keys.ROPE: "res://Resources/CraftingBlueprintResources/rope_blueprint.tres",
}


const EQUIPABLE_ITEM_SCENES: Dictionary = {
	# Constructibles
	Keys.TENT: "res://Items/Constructibles/equipable_tent.tscn",
	# Consumables
	Keys.MUSHROOM: "res://Items/Consumables/equipable_mushroom.tscn",
	# Weapons
	Keys.AXE: "res://Items/Weapons/equipable_axe.tscn",
	Keys.PICKAXE: "res://Items/Weapons/equipable_pickaxe.tscn",
}


const PICKUPABLE_ITEM_SCENES: Dictionary = {
	Keys.LOG: "res://Items/Pickupables/rigid_pickupable_log.tscn",
	Keys.COAL: "res://Items/Pickupables/rigid_pickupable_coal.tscn",
	Keys.RAWMEAT: "res://Items/Pickupables/rigid_pickupable_raw_meat.tscn",
}


const CONSTRUCTIBLE_SCENES: Dictionary = {
	Keys.TENT: "res://Objects/Constructibles/constructible_tent.tscn",
}


static func get_item_resource(item_key: Keys) -> ItemResource:
	return load(ITEM_RESOURCE_PATHS.get(item_key))


static func get_crafting_blueprint_resource(item_key: Keys) -> CraftingBlueprintResource:
	return load(CRAFTING_BLUEPRINT_RESOURCE_PATHS.get(item_key))


static func get_equipable_scene(item_key: Keys) -> PackedScene:
	return load(EQUIPABLE_ITEM_SCENES.get(item_key))


static func get_pickupable_scene(item_key: Keys) -> PackedScene:
	return load(PICKUPABLE_ITEM_SCENES.get(item_key))


static func get_constructible_scene(item_key: Keys) -> PackedScene:
	return load(CONSTRUCTIBLE_SCENES.get(item_key))
