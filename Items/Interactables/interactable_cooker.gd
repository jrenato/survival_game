class_name InteractableCooker extends Interactable

enum STATE {
	INACTIVE,
	READY,
	COOKING,
	COOKED
}

@export var fire_always_on: bool = false

var state: STATE = STATE.INACTIVE
var cooking_recipe: CookingRecipeResource

@onready var food_visuals_holder = %FoodVisualsHolder
@onready var cooking_timer = %CookingTimer
@onready var fire_particles = %GPUParticles3D
@onready var fire_light = %OmniLight3D
@onready var audio_stream_player: AudioStreamPlayer3D = %AudioStreamPlayer3D


func _ready() -> void:
	if fire_always_on:
		fire_particles.emitting = true
		fire_light.show()
		audio_stream_player.play()


func start_interaction() -> void:
	EventSystem.enabled_bulletin.emit(
		BulletinConfig.Keys.COOKING_MENU,
		{
			"cooking_recipe": cooking_recipe,
			"time_cooked": 0 if state != STATE.COOKING or not cooking_recipe else (cooking_recipe.cooking_time - cooking_timer.time_left),
			"interactable_cooker": self,
			"cooking_state": state,
		}
	)


func uncooked_item_added(recipe: CookingRecipeResource) -> void:
	state = STATE.READY
	cooking_recipe = recipe
	food_visuals_holder.add_child(cooking_recipe.uncooked_item_visuals.instantiate())


func uncooked_item_removed() -> void:
	state = STATE.INACTIVE
	cooking_recipe = null
	clear_food_visuals()


func cooked_item_removed() -> void:
	state = STATE.INACTIVE
	cooking_recipe = null
	clear_food_visuals()


func clear_food_visuals() -> void:
	for child in food_visuals_holder.get_children():
		child.queue_free()


func cooking_started() -> void:
	state = STATE.COOKING
	cooking_timer.start(cooking_recipe.cooking_time)

	if not fire_always_on:
		fire_particles.emitting = true
		fire_light.show()
		audio_stream_player.play()


func cooking_finished() -> void:
	state = STATE.COOKED

	clear_food_visuals()

	if not fire_always_on:
		fire_particles.emitting = false
		fire_light.hide()
		audio_stream_player.stop()

	food_visuals_holder.add_child(cooking_recipe.cooked_item_visuals.instantiate())
