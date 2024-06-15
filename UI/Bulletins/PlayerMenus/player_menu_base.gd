class_name PlayerMenuBase extends Bulletin


@onready var inventory_container: GridContainer = %InventoryGridContainer
@onready var item_description_label: Label = %ItemDescriptionLabel
@onready var item_extra_info_label: Label = %ItemExtraInfoLabel


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

	var hotbar_container: HBoxContainer = get_tree().get_first_node_in_group("hotbar_container")
	if hotbar_container:
		for hotbar_slot in hotbar_container.get_children():
			hotbar_slot.mouse_entered.connect(_on_inventory_slot_mouse_entered.bind(hotbar_slot))
			hotbar_slot.mouse_exited.connect(_on_inventory_slot_mouse_exited)


func close() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.disabled_bulletin.emit(BulletinConfig.Keys.CRAFTING_MENU)
	EventSystem.enabled_player.emit()


func update_inventory(inventory: Array) -> void:
	for i in inventory.size():
		inventory_container.get_child(i).item_key = inventory[i]


func _on_inventory_updated(inventory: Array) -> void:
	update_inventory(inventory)


func _on_inventory_slot_mouse_entered(inventory_slot: InventorySlot) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or inventory_slot.item_key == null:
		return

	Input.set_custom_mouse_cursor(CursorLibrary.get_cursor(CursorLibrary.CURSOR_TYPE.PICKUP))
	var item_resource: ItemResource = ItemConfig.get_item_resource(inventory_slot.item_key)
	item_description_label.text = "%s\n%s" % [item_resource.display_name, item_resource.description]


func _on_inventory_slot_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(CursorLibrary.get_cursor(CursorLibrary.CURSOR_TYPE.ARROW_NONE))
	item_description_label.text = ""
