extends Node3D

@export var attributes: HittableObjectAttributes
@export var residue_static_body: StaticBody3D

var current_health: float

@onready var hitbox: Area3D = %Hitbox
@onready var item_spawn_points: Node3D = %ItemSpawnPoints


func _ready() -> void:
	hitbox.register_hit.connect(_on_register_hit)
	current_health = attributes.max_health

	if residue_static_body != null:
		remove_child(residue_static_body)


func take_damage(damage: float) -> void:
	current_health -= damage

	if current_health <= 0.0:
		die()


func die() -> void:
	var scene_to_spawn: PackedScene = ItemConfig.get_pickupable_item(attributes.drop_item_key)
	for marker in item_spawn_points.get_children():
		EventSystem.object_spawned.emit(scene_to_spawn, marker.global_transform)

	if residue_static_body == null:
		queue_free()

	for child in get_children():
		child.queue_free()

	if residue_static_body:
		add_child(residue_static_body)


func _on_register_hit(weapon_item_resource: WeaponItemResource) -> void:
	if not attributes.weapon_filter.is_empty() and not weapon_item_resource.item_key in attributes.weapon_filter:
		return

	take_damage(weapon_item_resource.damage)
