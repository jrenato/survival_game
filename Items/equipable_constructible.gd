class_name EquipableConstructable extends EquipableItem

const VALID_MATERIAL: StandardMaterial3D = preload("res://Resources/Materials/constructable_valid_material.tres")
const INVALID_MATERIAL: StandardMaterial3D = preload("res://Resources/Materials/constructable_invalid_material.tres")

@onready var item_place_ray_cast: RayCast3D = %ItemPlaceRayCast
@onready var constructible_area: Area3D = %ConstructibleArea
@onready var constructible_area_collision_shape: CollisionShape3D = %CollisionShape3D
@onready var constructible_preview_mesh: MeshInstance3D = %ConstructiblePreviewMesh
@onready var mesh_holder: Node3D = $MeshHolder

var constructible_item_key: ItemConfig.Keys
var obstacles: Array[Node3D] = []
var is_constructing: bool = false
var place_valid: bool = false: set = set_valid


func _ready() -> void:
	constructible_area.body_entered.connect(_on_constructible_area_body_entered)
	constructible_area.body_exited.connect(_on_constructible_area_body_exited)
	constructible_area.area_entered.connect(_on_constructible_area_area_entered)
	constructible_area.area_exited.connect(_on_constructible_area_area_exited)

	constructible_area.rotation = Vector3.ZERO
	constructible_preview_mesh.mesh = mesh_holder.get_child(0).mesh.duplicate()
	constructible_area_collision_shape.shape = constructible_preview_mesh.mesh.create_convex_shape()
	set_preview_material(INVALID_MATERIAL)


func set_preview_material(material: StandardMaterial3D) -> void:
	for i in constructible_preview_mesh.mesh.get_surface_count():
		constructible_preview_mesh.set_surface_override_material(i, material)


func _process(_delta: float) -> void:
	constructible_area.global_rotation.y = global_rotation.y + PI
	set_valid(check_build_validity())


func set_valid(valid: bool) -> void:
	if place_valid == valid:
		return

	set_preview_material(VALID_MATERIAL if valid else INVALID_MATERIAL)
	place_valid = valid


func check_build_validity() -> bool:
	if item_place_ray_cast.is_colliding():
		constructible_area.global_position = item_place_ray_cast.get_collision_point()

		if obstacles.is_empty():
			return true

		return false

	constructible_area.global_position = item_place_ray_cast.to_global(item_place_ray_cast.target_position)
	return false


func try_to_construct() -> void:
	if not place_valid:
		return

	EventSystem.deleted_equipped_item.emit()
	constructible_area.hide()
	set_process(false)
	EventSystem.object_spawned.emit(
		ItemConfig.get_constructible_scene(constructible_item_key),
		constructible_area.global_transform
	)
	is_constructing = true


func destroy_self() -> void:
	if not is_constructing:
		return

	EventSystem.item_unequipped.emit()


func _on_constructible_area_body_entered(body: Node3D) -> void:
	obstacles.append(body)


func _on_constructible_area_body_exited(body: Node3D) -> void:
	obstacles.erase(body)


func _on_constructible_area_area_entered(area: Area3D) -> void:
	obstacles.append(area)


func _on_constructible_area_area_exited(area: Area3D) -> void:
	obstacles.erase(area)
