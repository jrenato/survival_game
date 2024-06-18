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
	Keys.CAMPFIRE,
	Keys.MULTITOOL,
	Keys.ROPE,
	Keys.TINDERBOX,
	Keys.TORCH,
	Keys.TENT,
	Keys.RAFT,
]


const ITEM_RESOURCE_PATHS: Dictionary = {
	# Collectibles
	Keys.STICK: "res://Resources/ItemResources/stick_item_resource.tres",
	Keys.STONE: "res://Resources/ItemResources/stone_item_resource.tres",
	Keys.PLANT: "res://Resources/ItemResources/plant_item_resource.tres",
	Keys.RAWMEAT: "res://Resources/ItemResources/raw_meat_item_resource.tres",

	# Consumables
	Keys.MUSHROOM: "res://Resources/ItemResources/mushroom_item_resource.tres",
	Keys.FRUIT: "res://Resources/ItemResources/fruit_item_resource.tres",
	Keys.COOKEDMEAT: "res://Resources/ItemResources/cooked_meat_item_resource.tres",

	# Equipables
	Keys.AXE: "res://Resources/ItemResources/axe_item_resource.tres",
	Keys.PICKAXE: "res://Resources/ItemResources/pickaxe_item_resource.tres",
	Keys.TORCH: "res://Resources/ItemResources/torch_item_resource.tres",

	# Tools
	Keys.MULTITOOL: "res://Resources/ItemResources/multitool_item_resource.tres",
	Keys.TINDERBOX: "res://Resources/ItemResources/tinderbox_item_resource.tres",

	# Resources
	Keys.ROPE: "res://Resources/ItemResources/rope_item_resource.tres",
	Keys.LOG: "res://Resources/ItemResources/log_item_resource.tres",
	Keys.COAL: "res://Resources/ItemResources/coal_item_resource.tres",
	Keys.FLINTSTONE: "res://Resources/ItemResources/flintstone_item_resource.tres",

	# Constructibles
	Keys.TENT: "res://Resources/ItemResources/tent_item_resource.tres",
	Keys.CAMPFIRE: "res://Resources/ItemResources/campfire_item_resource.tres",
	Keys.RAFT: "res://Resources/ItemResources/raft_item_resource.tres",
}


const CRAFTING_BLUEPRINT_RESOURCE_PATHS: Dictionary = {
	Keys.AXE: "res://Resources/CraftingBlueprintResources/axe_blueprint.tres",
	Keys.CAMPFIRE: "res://Resources/CraftingBlueprintResources/campfire_blueprint.tres",
	Keys.MULTITOOL: "res://Resources/CraftingBlueprintResources/multitool_blueprint.tres",
	Keys.PICKAXE: "res://Resources/CraftingBlueprintResources/pickaxe_blueprint.tres",
	Keys.RAFT: "res://Resources/CraftingBlueprintResources/raft_blueprint.tres",
	Keys.ROPE: "res://Resources/CraftingBlueprintResources/rope_blueprint.tres",
	Keys.TENT: "res://Resources/CraftingBlueprintResources/tent_blueprint.tres",
	Keys.TINDERBOX: "res://Resources/CraftingBlueprintResources/tinderbox_blueprint.tres",
	Keys.TORCH: "res://Resources/CraftingBlueprintResources/torch_blueprint.tres",
}


const EQUIPABLE_ITEM_SCENES: Dictionary = {
	# Constructibles
	Keys.TENT: "res://Items/Constructibles/equipable_tent.tscn",
	Keys.CAMPFIRE: "res://Items/Constructibles/equipable_campfire.tscn",
	Keys.RAFT: "res://Items/Constructibles/equipable_raft.tscn",
	# Consumables
	Keys.MUSHROOM: "res://Items/Consumables/equipable_mushroom.tscn",
	Keys.COOKEDMEAT: "res://Items/Consumables/equipable_cooked_meat.tscn",
	Keys.FRUIT: "res://Items/Consumables/equipable_fruit.tscn",
	# Weapons
	Keys.AXE: "res://Items/Equipables/equipable_axe.tscn",
	Keys.PICKAXE: "res://Items/Equipables/equipable_pickaxe.tscn",
	# Misc
	Keys.TORCH: "res://Items/Equipables/equipable_torch.tscn",
}


const PICKUPABLE_ITEM_SCENES: Dictionary = {
	# Pickupables
	Keys.FRUIT: "res://Items/Pickupables/pickupable_fruit.tscn",
	Keys.MUSHROOM: "res://Items/Pickupables/pickupable_mushroom.tscn",
	Keys.PLANT: "res://Items/Pickupables/pickupable_plant.tscn",
	Keys.STICK: "res://Items/Pickupables/pickupable_stick.tscn",

	# Rigid Pickupables
	Keys.COAL: "res://Items/Pickupables/rigid_pickupable_coal.tscn",
	Keys.FLINTSTONE: "res://Items/Pickupables/rigid_pickupable_flintstone.tscn",
	Keys.LOG: "res://Items/Pickupables/rigid_pickupable_log.tscn",
	Keys.RAWMEAT: "res://Items/Pickupables/rigid_pickupable_raw_meat.tscn",
}


const CONSTRUCTIBLE_SCENES: Dictionary = {
	Keys.TENT: "res://Objects/Constructibles/constructible_tent.tscn",
	Keys.CAMPFIRE: "res://Objects/Constructibles/constructible_campfire.tscn",
	Keys.RAFT: "res://Objects/Constructibles/constructible_raft.tscn",
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

