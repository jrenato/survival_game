extends HBoxContainer


func _enter_tree() -> void:
	EventSystem.hotbar_updated.connect(_on_hotbar_updated)


func _on_hotbar_updated(hotbar: Array) -> void:
	for hotbar_slot in get_children():
		hotbar_slot.set_item_key(hotbar[hotbar_slot.get_index()])
