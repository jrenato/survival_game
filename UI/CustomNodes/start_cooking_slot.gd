class_name StartCookingSlot extends InventorySlot

signal start_ingredient_enable
signal start_ingredient_disable


var is_cooking_in_progress: bool = false


func _get_drag_data(at_position: Vector2) -> Variant:
	if is_cooking_in_progress:
		return null

	return super(at_position)


func _can_drop_data(at_position: Vector2, origin_slot: Variant) -> bool:
	if item_key != null:
		return false

	if ItemConfig.get_item_resource(origin_slot.item_key).cooking_recipe == null:
		return false

	return origin_slot is InventorySlot


func _drop_data(at_position: Vector2, origin_slot: Variant) -> void:
	item_key = origin_slot.item_key
	EventSystem.deleted_item_by_index.emit(origin_slot.get_index(), origin_slot is HotBarSlot)
	print(self, " ", origin_slot)
	start_ingredient_enable.emit()
