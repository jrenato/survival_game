class_name InventorySlot extends TextureRect


@onready var icon_texture: TextureRect = %IconTextureRect

var item_key: Variant:
	set(value):
		item_key = value
		update_icon()


func update_icon() -> void:
	if item_key == null:
		icon_texture.texture = null
		return

	icon_texture.texture = ItemConfig.get_item_resource(item_key).icon


func _get_drag_data(at_position: Vector2) -> Variant:
	if item_key != null:
		var drag_preview: Control = Control.new()

		var texture_rect: TextureRect = TextureRect.new()
		texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		texture_rect.texture = icon_texture.texture
		texture_rect.custom_minimum_size = Vector2(80, 80)
		texture_rect.position = -0.3 * texture_rect.custom_minimum_size
		texture_rect.modulate = Color(1.0, 1.0, 1.0, 0.75)

		drag_preview.add_child(texture_rect)
		set_drag_preview(drag_preview)

		return self

	return null


func _can_drop_data(at_position: Vector2, origin_slot: Variant) -> bool:
	if item_key != null:
		if origin_slot is HotBarSlot:
			return ItemConfig.get_item_resource(item_key).is_equipable

		if origin_slot is StartCookingSlot:
			return ItemConfig.get_item_resource(item_key).cooking_recipe != null

		if origin_slot is FinalCookingSlot:
			return false

	return origin_slot is InventorySlot


func _drop_data(at_position: Vector2, origin_slot: Variant) -> void:
	if origin_slot is StartCookingSlot:
		var temp_own_key: Variant = item_key
		EventSystem.added_item_by_index.emit(origin_slot.item_key, get_index(), self is HotBarSlot)
		origin_slot.item_key = temp_own_key
		origin_slot.start_ingredient_enable.emit()

	if origin_slot is FinalCookingSlot:
		EventSystem.added_item_by_index.emit(origin_slot.item_key, get_index(), self is HotBarSlot)
		origin_slot.item_key = null
		origin_slot.cooked_food_taken.emit()

	else:
		EventSystem.switched_two_items.emit(
			origin_slot.get_index(),
			origin_slot is HotBarSlot,
			get_index(),
			self is HotBarSlot
		)
