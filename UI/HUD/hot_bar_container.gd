extends HBoxContainer


func _ready() -> void:
	EventSystem.hotbar_updated.connect(_on_hotbar_updated)
	EventSystem.updated_active_hotbar_slot.connect(_on_updated_active_hotbar_slot)


func _on_hotbar_updated(hotbar: Array) -> void:
	for hotbar_slot in get_children():
		hotbar_slot.item_key = hotbar[hotbar_slot.get_index()]


func _on_updated_active_hotbar_slot(active_index: Variant) -> void:
	for hotbar_slot in get_children():
		hotbar_slot.set_highlighted(hotbar_slot.get_index() == active_index)
