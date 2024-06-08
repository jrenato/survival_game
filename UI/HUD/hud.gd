extends Control

enum CURSOR_TYPE {
	NONE,
	INTERACT,
	PICKUP,
}

var cursors: Dictionary = {
	CURSOR_TYPE.NONE: preload("res://Assets/icons/cursor_none.png"),
	CURSOR_TYPE.INTERACT: preload("res://Assets/icons/hand_point.png"),
	CURSOR_TYPE.PICKUP: preload("res://Assets/icons/hand_open.png"),
}

var current_cursor: CURSOR_TYPE:
	set(value):
		current_cursor = value
		crosshair.texture = cursors[current_cursor]


@onready var crosshair: TextureRect = %Crosshair


func _ready() -> void:
	EventSystem.pointed_at_interactable.connect(_on_pointed_at_interactable)
	EventSystem.pointed_at_pickupable.connect(_on_pointed_at_pickupable)
	EventSystem.stopped_pointing_at_interactable.connect(_on_stopped_pointing_at_interactable)

	current_cursor = CURSOR_TYPE.NONE


func _on_pointed_at_interactable() -> void:
	current_cursor = CURSOR_TYPE.INTERACT


func _on_pointed_at_pickupable() -> void:
	current_cursor = CURSOR_TYPE.PICKUP


func _on_stopped_pointing_at_interactable() -> void:
	current_cursor = CURSOR_TYPE.NONE
