extends Node

enum CURSOR_TYPE {
	NONE,
	ARROW_NONE,
	INTERACT,
	PICKUP,
	DROP,
	FORBIDDEN,
}

var cursors: Dictionary = {
	CURSOR_TYPE.NONE: load("res://Assets/icons/dot_small.png"),
	CURSOR_TYPE.ARROW_NONE: load("res://Assets/icons/cursor_none.png"),
	CURSOR_TYPE.INTERACT: load("res://Assets/icons/hand_point.png"),
	CURSOR_TYPE.PICKUP: load("res://Assets/icons/hand_open.png"),
	CURSOR_TYPE.DROP: load("res://Assets/icons/hand_closed.png"),
	CURSOR_TYPE.FORBIDDEN: load("res://Assets/icons/disabled.png"),
}


func get_cursor(cursor_type: CURSOR_TYPE) -> Texture2D:
	return cursors[cursor_type]
