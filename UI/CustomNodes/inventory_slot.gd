class_name InventorySlot extends TextureRect


@onready var icon_texture: TextureRect = %IconTextureRect

var item_key: Variant


func set_item_key(_item_key: Variant) -> void:
	item_key = _item_key
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
	return origin_slot is InventorySlot


func _drop_data(at_position: Vector2, origin_slot: Variant) -> void:
	EventSystem.switched_two_items.emit(origin_slot.get_index(), get_index())
