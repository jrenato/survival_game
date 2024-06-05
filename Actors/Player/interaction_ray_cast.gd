extends RayCast3D


var is_hitting: bool = false


func check_interaction() -> void:
	if is_colliding():
		var interactable: Interactable = get_collider() as Interactable
		if not interactable:
			return

		if Input.is_action_just_pressed("interact"):
			interactable.start_interaction()

		if not is_hitting:
			is_hitting = true
			EventSystem.looked_at_interactable.emit(
				BulletinConfig.Keys.INTERACTION_PROMPT,
				interactable.prompt
			)

	elif is_hitting:
		is_hitting = false
		EventSystem.stopped_looking_at_interactable.emit(BulletinConfig.Keys.INTERACTION_PROMPT)
