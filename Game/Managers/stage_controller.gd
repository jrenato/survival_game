extends Node

var can_drop_cursor_img = load("res://Assets/icons/hand_closed.png")
var forbidden_cursor_img = load("res://Assets/icons/disabled.png")

func _ready() -> void:
	Input.set_custom_mouse_cursor(
		CursorLibrary.get_cursor(CursorLibrary.CURSOR_TYPE.DROP),
		Input.CURSOR_CAN_DROP
	)
	Input.set_custom_mouse_cursor(
		CursorLibrary.get_cursor(CursorLibrary.CURSOR_TYPE.FORBIDDEN),
		Input.CURSOR_FORBIDDEN
	)

	change_stage(StageConfig.Keys.ISLAND)


func change_stage(key: StageConfig.Keys) -> void:
	for child in get_children():
		child.queue_free()

	var new_stage: Node = StageConfig.get_stage(key)
	add_child(new_stage)
