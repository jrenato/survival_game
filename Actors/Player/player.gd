class_name Player extends CharacterBody3D

@export var normal_speed: float = 3.0
@export var sprint_speed: float = 5.0
@export var jump_velocity: float = 4.0
@export var gravity: float = 0.2
@export var mouse_sensitivity: float = 0.005
@export var walking_energy_change_per_minute: float = -0.05
@export var walking_footstep_interval: float = 0.6
@export var sprinting_footstep_interval: float = 0.3

var is_grounded: bool = true
var is_sprinting: bool = false

@onready var head: Node3D = %Head
@onready var interaction_ray_cast: RayCast3D = %InteractionRayCast
@onready var equipable_item_holder: ItemHolder = %EquipableItemHolder
@onready var footstep_timer: Timer = %FootstepAudioTimer


func _enter_tree() -> void:
	EventSystem.enabled_player.connect(set_player_enabled.bind(true))
	EventSystem.disabled_player.connect(set_player_enabled.bind(false))


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.hud_show.emit()


func _exit_tree() -> void:
	EventSystem.hud_hide.emit()


func _process(delta: float) -> void:
	interaction_ray_cast.check_interaction()


func _physics_process(delta: float) -> void:
	move()
	check_walking_energy_change(delta)

	if Input.is_action_pressed("use_item"):
		equipable_item_holder.try_to_use_item()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_around(event.relative)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		EventSystem.enabled_bulletin.emit(BulletinConfig.Keys.PAUSE_MENU)
		set_player_enabled(false)
	elif event.is_action_pressed("open_crafting_menu"):
		EventSystem.enabled_bulletin.emit(BulletinConfig.Keys.CRAFTING_MENU)
	elif event.is_action_pressed("item_hotkey"):
		EventSystem.hotkey_pressed.emit(int(event.as_text()))


func move() -> void:
	if is_on_floor():
		is_sprinting = Input.is_action_pressed("sprint")

		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity

		if velocity != Vector3.ZERO and footstep_timer.is_stopped():
			EventSystem.play_dynamic_sound.emit(SFXConfig.Keys.FOOTSTEP, global_position)
			footstep_timer.start(walking_footstep_interval if not is_sprinting else sprinting_footstep_interval)

		if not is_grounded:
			is_grounded = true
			EventSystem.play_dynamic_sound.emit(SFXConfig.Keys.JUMP_LAND, global_position)

	else:
		velocity.y -= gravity

		is_sprinting = false

		if is_grounded:
			is_grounded = false

	var speed: float = normal_speed if not is_sprinting else sprint_speed

	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction: Vector3 = transform.basis * Vector3(input_dir.x, 0, input_dir.y)

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	move_and_slide()


func check_walking_energy_change(delta: float) -> void:
	if velocity.x or velocity.z:
		EventSystem.changed_energy.emit(
			delta * walking_energy_change_per_minute * Vector2(velocity.x, velocity.z).length()
		)


func look_around(relative: Vector2) -> void:
	rotate_y(-relative.x * mouse_sensitivity)
	head.rotate_x(-relative.y * mouse_sensitivity)
	head.rotation_degrees.x = clampf(head.rotation_degrees.x, -90, 90)


func set_player_enabled(enabled: bool) -> void:
	set_process(enabled)
	set_physics_process(enabled)
	set_process_input(enabled)
	set_process_unhandled_input(enabled)
