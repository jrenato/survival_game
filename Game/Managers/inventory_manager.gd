extends Node


const INVENTORY_SIZE: int = 28

var inventory: Array = []


func _enter_tree() -> void:
	EventSystem.tried_to_pick_item.connect(_on_tried_to_pick_item)
	EventSystem.inventory_update_requested.connect(_on_inventory_update_requested)
	EventSystem.switched_two_items.connect(_on_switched_two_items)
	EventSystem.crafted_item.connect(_on_crafted_item)


func _ready() -> void:
	inventory.resize(INVENTORY_SIZE)


func add_item(item_key: ItemConfig.Keys) -> void:
	inventory[inventory.find(null)] = item_key
	update_inventory()


func remove_item(item_key: ItemConfig.Keys) -> bool:
	if not inventory.has(item_key):
		return false

	inventory[inventory.rfind(item_key)] = null

	update_inventory()
	return true


func update_inventory() -> void:
	EventSystem.inventory_updated.emit(inventory)


func _on_tried_to_pick_item(item_key: ItemConfig.Keys, destroy_pickupable: Callable) -> void:
	if not inventory.count(null):
		return

	add_item(item_key)
	destroy_pickupable.call()


func _on_inventory_update_requested() -> void:
	update_inventory()


func _on_switched_two_items(index_1: ItemConfig.Keys, index_2: ItemConfig.Keys) -> void:
	var item_key_1: int = inventory[index_1]
	inventory[index_1] = inventory[index_2]
	inventory[index_2] = item_key_1
	EventSystem.inventory_updated.emit(inventory)


func _on_added_item(item_key: ItemConfig.Keys) -> void:
	add_item(item_key)


func _on_removed_item(item_key: ItemConfig.Keys) -> void:
	remove_item(item_key)


func _on_crafted_item(item_key: ItemConfig.Keys) -> void:
	var item_blueprint: CraftingBlueprintResource = ItemConfig.get_crafting_blueprint_resource(item_key)

	for cost in item_blueprint.costs:
		for i in range(cost.amount):
			remove_item(cost.item_key)

	add_item(item_key)
