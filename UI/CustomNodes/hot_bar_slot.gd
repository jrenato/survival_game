class_name HotBarSlot extends InventorySlot


const ACTIVE_COLOR: Color = Color.WHITE
const INACTIVE_COLOR: Color = Color(0.8, 0.8, 0.8, 0.5)



@onready var num_label: Label = %NumLabel
@onready var num_texture_rect: TextureRect = %NumTextureRect


func _ready() -> void:
	num_label.text = str(get_index() + 1)
	num_texture_rect.modulate = INACTIVE_COLOR


func set_highlighted(enabled: bool) -> void:
	if not num_texture_rect:
		return
	num_texture_rect.modulate = ACTIVE_COLOR if enabled else INACTIVE_COLOR


func _can_drop_data(at_position: Vector2, origin_slot: Variant) -> bool:
	if not origin_slot is InventorySlot:
		return false

	return ItemConfig.get_item_resource(origin_slot.item_key).is_equipable
