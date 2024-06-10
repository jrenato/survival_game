extends Area3D


signal register_hit(weapon_item_resource: WeaponItemResource)


func take_hit(weapon_item_resource: WeaponItemResource) -> void:
	register_hit.emit(weapon_item_resource)
