class_name CookingMenu extends PlayerMenuBase

var cooking_recipe: CookingRecipeResource
var time_cooked: float
var interactable_cooker: InteractableCooker
var cooking_state: InteractableCooker.STATE = InteractableCooker.STATE.INACTIVE

@onready var start_cooking_slot: StartCookingSlot = %StartCookingSlot
@onready var cooking_progress_bar: TextureProgressBar = %CookingProgressBar
@onready var final_cooking_slot: FinalCookingSlot = %FinalCookingSlot
@onready var cook_button = %CookButton


func initialize(_extra_args: Variant) -> void:
	if not _extra_args or not _extra_args is Dictionary:
		return

	cooking_recipe = _extra_args["cooking_recipe"]
	time_cooked = _extra_args["time_cooked"]
	interactable_cooker = _extra_args["interactable_cooker"]
	cooking_state = _extra_args["cooking_state"] as InteractableCooker.STATE


func _ready() -> void:
	start_cooking_slot.mouse_entered.connect(_on_cooking_slot_mouse_entered.bind(start_cooking_slot))
	start_cooking_slot.mouse_exited.connect(_on_cooking_slot_mouse_exited)
	final_cooking_slot.mouse_entered.connect(_on_cooking_slot_mouse_entered.bind(final_cooking_slot))
	final_cooking_slot.mouse_exited.connect(_on_cooking_slot_mouse_exited)

	start_cooking_slot.start_ingredient_enable.connect(_on_start_ingredient_enable)
	start_cooking_slot.start_ingredient_disable.connect(_on_start_ingredient_disable)

	final_cooking_slot.cooked_food_taken.connect(interactable_cooker.cooked_item_removed)
	cook_button.pressed.connect(_on_cook_button_pressed)

	if cooking_state == InteractableCooker.STATE.READY:
		start_cooking_slot.item_key = cooking_recipe.uncooked_item
		cook_button.disabled = false
	elif cooking_state == InteractableCooker.STATE.COOKING:
		start_cooking_slot.item_key = cooking_recipe.uncooked_item
		start_cooking()
	elif cooking_state == InteractableCooker.STATE.COOKED:
		final_cooking_slot.item_key = cooking_recipe.cooked_item

	super()


func start_cooking() -> void:
	start_cooking_slot.is_cooking_in_progress = true
	cook_button.disabled = true
	cooking_progress_bar.value = time_cooked / cooking_recipe.cooking_time

	var tween: Tween = create_tween()
	tween.tween_property(
		cooking_progress_bar,
		"value",
		cooking_progress_bar.max_value,
		cooking_recipe.cooking_time - time_cooked
	)

	tween.tween_callback(_on_finished_cooking)

	if cooking_state != InteractableCooker.STATE.COOKING:
		interactable_cooker.cooking_started()
		EventSystem.play_sound.emit(SFXConfig.Keys.UI_CLICK)


func close() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.disabled_bulletin.emit(BulletinConfig.Keys.COOKING_MENU)
	EventSystem.enabled_player.emit()
	EventSystem.play_sound.emit(SFXConfig.Keys.UI_CLICK)


func _on_cooking_slot_mouse_entered(cooking_slot: InventorySlot) -> void:
	Input.set_custom_mouse_cursor(CursorLibrary.get_cursor(CursorLibrary.CURSOR_TYPE.INTERACT))


func _on_cooking_slot_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(CursorLibrary.get_cursor(CursorLibrary.CURSOR_TYPE.ARROW_NONE))


func _on_start_ingredient_enable() -> void:
	cook_button.disabled = false
	cooking_recipe = ItemConfig.get_item_resource(start_cooking_slot.item_key).cooking_recipe
	time_cooked = 0
	interactable_cooker.uncooked_item_added(cooking_recipe)


func _on_start_ingredient_disable() -> void:
	cook_button.disabled = true
	cooking_recipe = null
	time_cooked = 0
	interactable_cooker.uncooked_item_removed()


func _on_finished_cooking() -> void:
	final_cooking_slot.item_key = cooking_recipe.cooked_item
	start_cooking_slot.item_key = null
	cooking_progress_bar.value = 0
	start_cooking_slot.is_cooking_in_progress = false


func _on_cook_button_pressed():
	start_cooking()
