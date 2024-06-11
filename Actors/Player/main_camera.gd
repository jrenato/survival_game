extends Camera3D


@export var item_camera: Camera3D


func _process(delta: float) -> void:
	if item_camera:
		item_camera.global_transform = global_transform
