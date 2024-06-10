extends Node3D


@onready var items: Node3D = %Items


func _enter_tree() -> void:
	EventSystem.object_spawned.connect(_on_object_spawned)


func _on_object_spawned(object_scene: PackedScene, object_transform: Transform3D) -> void:
	var object: Node3D = object_scene.instantiate()
	object.global_transform = object_transform
	items.add_child(object)
	#if object is RigidBody3D:
		#(object as RigidBody3D).apply_force(Vector3(0.0, -100.0, 0.0))
