extends Node


var active_hotbar_slot: Variant
var hotbar: Array = []


func _enter_tree() -> void:
	EventSystem.hotbar_updated.connect(_on_hotbar_updated)
	EventSystem.hotkey_pressed.connect(_on_hotkey_pressed)
	EventSystem.deleted_equipped_item.connect(_on_deleted_equipped_item)


func _ready() -> void:
	EventSystem.updated_active_hotbar_slot.emit(null)


func _on_hotbar_updated(_hotbar: Array) -> void:
	hotbar = _hotbar


func _on_hotkey_pressed(hotkey: int) -> void:
	var index: int = hotkey - 1

	if hotbar.is_empty() or hotbar[index] == null:
		return

	if index != active_hotbar_slot:
		active_hotbar_slot = index
		EventSystem.item_equipped.emit(hotbar[index])
		EventSystem.updated_active_hotbar_slot.emit(index)
	else:
		active_hotbar_slot = null
		EventSystem.item_unequipped.emit()
		EventSystem.updated_active_hotbar_slot.emit(null)


func _on_deleted_equipped_item() -> void:
	EventSystem.deleted_item_by_index.emit(active_hotbar_slot, true)
	EventSystem.updated_active_hotbar_slot.emit(null)
	active_hotbar_slot = null
