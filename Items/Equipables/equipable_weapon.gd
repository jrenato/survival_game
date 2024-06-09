class_name EquipableWeapon extends EquipableItem


@onready var hit_check_marker: Marker3D = %HitCheckMarker

var weapon_item_resource: WeaponItemResource
var layers = []


func _ready() -> void:
	hit_check_marker.position.z = -weapon_item_resource.range
	for i in range(1, 21):
		layers.append(ProjectSettings.get_setting("layer_names/3d_physics/layer_" + str(i)))


func get_layer(layer_name: String):
	return layers.find(layer_name) + 1


func check_hit() -> void:
	var space_state := get_world_3d().direct_space_state

	var ray_query_params := PhysicsRayQueryParameters3D.new()
	ray_query_params.collide_with_areas = true
	ray_query_params.collide_with_bodies = false
	ray_query_params.collision_mask = get_layer("hitbox")
	ray_query_params.from = global_position
	ray_query_params.to = hit_check_marker.global_position

	var result: Dictionary = space_state.intersect_ray(ray_query_params)

	if not result.is_empty():
		result.collider.take_hit(weapon_item_resource.damage)
