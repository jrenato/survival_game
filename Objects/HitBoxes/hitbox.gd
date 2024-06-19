extends Area3D

signal register_hit(weapon_item_resource: WeaponItemResource)

@export var hit_audio_key: SFXConfig.Keys = SFXConfig.Keys.TREE_HIT


func take_hit(weapon_item_resource: WeaponItemResource) -> void:
	register_hit.emit(weapon_item_resource)
	EventSystem.play_dynamic_sound.emit(hit_audio_key, global_position)
