extends CharacterBody3D


@export var normal_speed: float = 3.0
@export var sprint_speed: float = 5.0
@export var jump_velocity: float = 4.0
@export var gravity: float = 0.2
@export var mouse_sensitivity: float = 0.005

var is_sprinting: bool = false

@onready var head: Node3D = %Head
@onready var interaction_ray_cast: RayCast3D = %InteractionRayCast


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta: float) -> void:
	interaction_ray_cast.check_interaction()


func _physics_process(delta: float) -> void:
	move()


func move() -> void:
	if is_on_floor():
		is_sprinting = Input.is_action_pressed("sprint")
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
	else:
		velocity.y -= gravity
		is_sprinting = false

	var speed: float = normal_speed if not is_sprinting else sprint_speed

	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction: Vector3 = transform.basis * Vector3(input_dir.x, 0, input_dir.y)

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_around(event.relative)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_pressed("open_crafting_menu"):
		EventSystem.opened_crafting_menu.emit()


func look_around(relative: Vector2) -> void:
	rotate_y(-relative.x * mouse_sensitivity)
	head.rotate_x(-relative.y * mouse_sensitivity)
	head.rotation_degrees.x = clampf(head.rotation_degrees.x, -90, 90)
