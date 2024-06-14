class_name ItemHolder extends Node3D


var current_item_scene: Node3D


func _enter_tree() -> void:
	EventSystem.item_equipped.connect(_on_item_equipped)
	EventSystem.item_unequipped.connect(_on_item_unequipped)


func try_to_use_item() -> void:
	if current_item_scene == null:
		return

	current_item_scene.try_to_use()


func equip_item(item_key: ItemConfig.Keys) -> void:
	unequip_item()

	var item_scene: Node3D = ItemConfig.get_equipable_scene(item_key).instantiate()

	if item_scene is EquipableWeapon:
		item_scene.weapon_item_resource = ItemConfig.get_item_resource(item_key)
	elif item_scene is EquipableConsumable:
		item_scene.consumable_item_resource = ItemConfig.get_item_resource(item_key)
	elif item_scene is EquipableConstructable:
		item_scene.constructible_item_key = item_key

	add_child(item_scene)
	current_item_scene = item_scene


func unequip_item() -> void:
	for child in get_children():
		child.queue_free()

	current_item_scene = null


func _on_item_equipped(item_key: ItemConfig.Keys) -> void:
	equip_item(item_key)


func _on_item_unequipped() -> void:
	unequip_item()
