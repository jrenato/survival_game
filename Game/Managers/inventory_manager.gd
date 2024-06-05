extends Node


const INVENTORY_SIZE: int = 28

var inventory: Array = []


func _enter_tree() -> void:
	EventSystem.tried_to_pick_item.connect(_on_tried_to_pick_item)


func _ready() -> void:
	inventory.resize(INVENTORY_SIZE)


func _on_tried_to_pick_item(item_key: ItemConfig.Keys, destroy_pickupable: Callable) -> void:
	if not inventory.count(null):
		return

	add_item(item_key)
	destroy_pickupable.call()


func add_item(item_key: ItemConfig.Keys) -> void:
	inventory[inventory.find(null)] = item_key
