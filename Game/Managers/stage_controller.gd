extends Node

const FADE_TIME: float = 1.0

var can_drop_cursor_img = load("res://Assets/icons/hand_closed.png")
var forbidden_cursor_img = load("res://Assets/icons/disabled.png")

var thread: Thread = Thread.new()
var is_stage_changing: bool = false


func _ready() -> void:
	EventSystem.stage_changed.connect(start_stage_change_sequence)

	Input.set_custom_mouse_cursor(
		CursorLibrary.get_cursor(CursorLibrary.CURSOR_TYPE.DROP),
		Input.CURSOR_CAN_DROP
	)
	Input.set_custom_mouse_cursor(
		CursorLibrary.get_cursor(CursorLibrary.CURSOR_TYPE.FORBIDDEN),
		Input.CURSOR_FORBIDDEN
	)

	start_stage_change_sequence(StageConfig.Keys.MAIN_MENU)


func start_stage_change_sequence(key: StageConfig.Keys) -> void:
	if is_stage_changing:
		return

	is_stage_changing = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.game_fade_in.emit(FADE_TIME, game_faded_in.bind(key), true)


func game_faded_in(key: StageConfig.Keys) -> void:
	for child in get_children():
		child.queue_free()

	EventSystem.destroy_all_bulletins.emit()
	var new_stage: Stage = StageConfig.get_stage(key)
	thread.start(load_stage.bind(new_stage))


func load_stage(new_stage: Stage) -> void:
	call_deferred("add_child", new_stage)
	new_stage.loading_complete.connect(loading_complete)
	call_deferred("join_thread")


func join_thread() -> void:
	thread.wait_to_finish()


func loading_complete() -> void:
	EventSystem.game_fade_out.emit(FADE_TIME, func(): pass)
	is_stage_changing = false
