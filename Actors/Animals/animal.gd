class_name Animal extends CharacterBody3D

const ANIM_BLEND: float = 0.3

enum STATE {
	IDLE,
	WANDER,
	DEAD,
}

@export var normal_speed: float = 0.6
@export var max_health: float = 80.0
@export var turn_speed_weight: float = 0.07
@export var min_idle_time: float = 2.0
@export var max_idle_time: float = 7.0
@export var min_wander_time: float = 2.0
@export var max_wander_time: float = 4.0

@export var animation_player: AnimationPlayer
@export var idle_animations: Array[String] = []

var state: STATE = STATE.IDLE : set = set_state

@onready var idle_timer: Timer = %IdleTimer
@onready var wander_timer: Timer = %WanderTimer
@onready var disappear_after_death_timer: Timer = %DisappearAfterDeathTimer

@onready var hitbox: Area3D = %Hitbox
@onready var main_collision_shape: CollisionShape3D = %CollisionShape3D
@onready var meat_spawn_marker: Marker3D = %MeatSpawnMarker

@onready var health: float = max_health


func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	idle_timer.timeout.connect(_on_idle_timer_timeout)
	wander_timer.timeout.connect(_on_wander_timer_timeout)
	disappear_after_death_timer.timeout.connect(_on_disappear_after_death_timer_timeout)
	hitbox.register_hit.connect(_on_register_hit)


func _physics_process(_delta: float) -> void:
	match state:
		STATE.WANDER:
			wander_loop()


func wander_loop() -> void:
	look_forward()
	move_and_slide()


func look_forward() -> void:
	rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z) + PI, turn_speed_weight)


func pick_wander_velocity() -> void:
	var direction: Vector2 = Vector2(0, -1).rotated(randf() * TAU)
	velocity = Vector3(direction.x, 0, direction.y) * normal_speed


func set_state(new_state: STATE) -> void:
	state = new_state

	match state:
		STATE.IDLE:
			idle_timer.start(randf_range(min_idle_time, max_idle_time))
			animation_player.play(idle_animations.pick_random(), ANIM_BLEND)
		STATE.WANDER:
			pick_wander_velocity()
			wander_timer.start(randf_range(min_wander_time, max_wander_time))
			animation_player.play("Walk", ANIM_BLEND)
		STATE.DEAD:
			main_collision_shape.disabled = true
			idle_timer.stop()
			wander_timer.stop()
			set_physics_process(false)

			animation_player.play("Death", ANIM_BLEND)

			var meat_scene: PackedScene = ItemConfig.get_pickupable_item(ItemConfig.Keys.RAWMEAT)
			EventSystem.object_spawned.emit(meat_scene, meat_spawn_marker.global_transform)

			disappear_after_death_timer.start(10)

func _on_animation_finished(_anim_name: StringName) -> void:
	match state:
		STATE.WANDER:
			animation_player.play(idle_animations.pick_random(), ANIM_BLEND)


func _on_idle_timer_timeout() -> void:
	state = STATE.WANDER


func _on_wander_timer_timeout() -> void:
	state = STATE.IDLE


func _on_disappear_after_death_timer_timeout() -> void:
	pass


func _on_register_hit(weapon_item_resource: WeaponItemResource) -> void:
	health -= weapon_item_resource.damage

	if state != STATE.DEAD and health <= 0.0:
		state = STATE.DEAD
