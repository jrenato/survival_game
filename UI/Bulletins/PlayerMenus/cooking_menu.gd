class_name CookingMenu extends PlayerMenuBase

@onready var start_cooking_slot: StartCookingSlot = %StartCookingSlot
@onready var cooking_progress_bar: TextureProgressBar = %CookingProgressBar
@onready var final_cooking_slot: FinalCookingSlot = %FinalCookingSlot


func _ready() -> void:
	start_cooking_slot.mouse_entered.connect(_on_cooking_slot_mouse_entered.bind(start_cooking_slot))
	start_cooking_slot.mouse_exited.connect(_on_cooking_slot_mouse_exited)
	final_cooking_slot.mouse_entered.connect(_on_cooking_slot_mouse_entered.bind(final_cooking_slot))
	final_cooking_slot.mouse_exited.connect(_on_cooking_slot_mouse_exited)

	super()


func close() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.disabled_bulletin.emit(BulletinConfig.Keys.COOKING_MENU)
	EventSystem.enabled_player.emit()


func _on_cooking_slot_mouse_entered(cooking_slot: StartCookingSlot) -> void:
	Input.set_custom_mouse_cursor(CursorLibrary.get_cursor(CursorLibrary.CURSOR_TYPE.INTERACT))


func _on_cooking_slot_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(CursorLibrary.get_cursor(CursorLibrary.CURSOR_TYPE.ARROW_NONE))
