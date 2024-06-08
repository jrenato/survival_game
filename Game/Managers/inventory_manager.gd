extends Node


const INVENTORY_SIZE: int = 28

var inventory: Array = []


func _enter_tree() -> void:
	EventSystem.tried_to_pick_item.connect(_on_tried_to_pick_item)
	EventSystem.inventory_update_requested.connect(_on_inventory_update_requested)
	EventSystem.switched_two_items.connect(_on_switched_two_items)


func _ready() -> void:
	inventory.resize(INVENTORY_SIZE)


func add_item(item_key: ItemConfig.Keys) -> void:
	inventory[inventory.find(null)] = item_key


func _on_tried_to_pick_item(item_key: ItemConfig.Keys, destroy_pickupable: Callable) -> void:
	if not inventory.count(null):
		return

	add_item(item_key)
	destroy_pickupable.call()


func _on_inventory_update_requested() -> void:
	EventSystem.inventory_updated.emit(inventory)


func _on_switched_two_items(index_1: int, index_2: int) -> void:
	var item_key_1: int = inventory[index_1]
	inventory[index_1] = inventory[index_2]
	inventory[index_2] = item_key_1
	EventSystem.inventory_updated.emit(inventory)
