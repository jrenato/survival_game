extends AnimationPlayer


func _enter_tree() -> void:
	EventSystem.fast_forward_time.connect(_on_fast_forward_time)


func _ready() -> void:
	await get_tree().physics_frame
	set_time(12)


func set_time(time: float) -> void:
	seek(time)


func _on_fast_forward_time(time: float) -> void:
	seek(fmod(current_animation_position + time, current_animation_length))
