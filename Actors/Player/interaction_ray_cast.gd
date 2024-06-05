extends RayCast3D


func check_interaction() -> void:
	if is_colliding() and Input.is_action_just_pressed("interact"):
		var collider: Node3D = get_collider()
		if collider is Interactable:
			collider.start_interaction()
