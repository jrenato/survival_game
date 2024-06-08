extends Bulletin


@onready var inventory_container: GridContainer = %InventoryGridContainer


func _enter_tree() -> void:
	EventSystem.inventory_updated.connect(_on_inventory_updated)


func _ready() -> void:
	EventSystem.disabled_player.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	EventSystem.inventory_update_requested.emit()


func close() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.disabled_bulletin.emit(BulletinConfig.Keys.CRAFTING_MENU)
	EventSystem.enabled_player.emit()


func _on_inventory_updated(inventory: Array) -> void:
	for i in inventory.size():
		var inventory_slot: InventorySlot = inventory_container.get_child(i) as InventorySlot
		if inventory_slot:
			inventory_slot.set_item_key(inventory[i])
