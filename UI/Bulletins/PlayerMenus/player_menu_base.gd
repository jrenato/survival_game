class_name PlayerMenuBase extends Bulletin


@onready var inventory_container: GridContainer = %InventoryGridContainer
@onready var item_description_label: Label = %ItemDescriptionLabel


func _enter_tree() -> void:
	EventSystem.inventory_updated.connect(_on_inventory_updated)


func _ready() -> void:
	EventSystem.disabled_player.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	EventSystem.inventory_update_requested.emit()

	for inventory_slot in inventory_container.get_children():
		if inventory_slot is InventorySlot:
			inventory_slot.mouse_entered.connect(_on_inventory_slot_mouse_entered.bind(inventory_slot))
			inventory_slot.mouse_exited.connect(_on_inventory_slot_mouse_exited)


func close() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.disabled_bulletin.emit(BulletinConfig.Keys.CRAFTING_MENU)
	EventSystem.enabled_player.emit()


func _on_inventory_updated(inventory: Array) -> void:
	for i in inventory.size():
		var inventory_slot: InventorySlot = inventory_container.get_child(i) as InventorySlot
		if inventory_slot:
			inventory_slot.set_item_key(inventory[i])


func _on_inventory_slot_mouse_entered(inventory_slot: InventorySlot) -> void:
	if inventory_slot.item_key == null:
		return

	Input.set_custom_mouse_cursor(CursorLibrary.get_cursor(CursorLibrary.CURSOR_TYPE.PICKUP))
	var item_resource: ItemResource = ItemConfig.get_item_resource(inventory_slot.item_key)
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		item_description_label.text = "%s\n%s" % [item_resource.display_name, item_resource.description]


func _on_inventory_slot_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(CursorLibrary.get_cursor(CursorLibrary.CURSOR_TYPE.ARROW_NONE))
	item_description_label.text = ""
