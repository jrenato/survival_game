class_name EquipableWeapon extends EquipableItem

var weapon_item_resource: WeaponItemResource

@onready var hit_check_marker: Marker3D = %HitCheckMarker


func _ready() -> void:
	hit_check_marker.position.z = -weapon_item_resource.weapon_range


func change_energy() -> void:
	EventSystem.changed_energy.emit(weapon_item_resource.energy_change_per_use)


func check_hit() -> void:
	var space_state := get_world_3d().direct_space_state

	var ray_query_params := PhysicsRayQueryParameters3D.new()
	ray_query_params.collide_with_areas = true
	ray_query_params.collide_with_bodies = false
	ray_query_params.collision_mask = 8
	ray_query_params.from = global_position
	ray_query_params.to = hit_check_marker.global_position

	var result: Dictionary = space_state.intersect_ray(ray_query_params)

	if not result.is_empty():
		result.collider.take_hit(weapon_item_resource)


func play_attack_sound() -> void: 
	EventSystem.play_sound.emit(SFXConfig.Keys.ATTACK)
