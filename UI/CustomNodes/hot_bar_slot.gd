class_name HotBarSlot extends InventorySlot


@onready var num_label: Label = %NumLabel


func _ready() -> void:
	num_label.text = str(get_index() + 1)


func _can_drop_data(at_position: Vector2, origin_slot: Variant) -> bool:
	if not origin_slot is InventorySlot:
		return false

	return ItemConfig.get_item_resource(origin_slot.item_key).is_equipable
