extends Control


var current_cursor: CursorLibrary.CURSOR_TYPE:
	set(value):
		current_cursor = value
		crosshair.texture = CursorLibrary.get_cursor(current_cursor)


@onready var crosshair: TextureRect = %Crosshair


func _ready() -> void:
	EventSystem.pointed_at_interactable.connect(_on_pointed_at_interactable)
	EventSystem.pointed_at_pickupable.connect(_on_pointed_at_pickupable)
	EventSystem.stopped_pointing_at_interactable.connect(_on_stopped_pointing_at_interactable)
	current_cursor = CursorLibrary.CURSOR_TYPE.NONE


func _on_pointed_at_interactable() -> void:
	current_cursor = CursorLibrary.CURSOR_TYPE.INTERACT


func _on_pointed_at_pickupable() -> void:
	current_cursor = CursorLibrary.CURSOR_TYPE.PICKUP


func _on_stopped_pointing_at_interactable() -> void:
	current_cursor = CursorLibrary.CURSOR_TYPE.NONE
