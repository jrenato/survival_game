class_name Animal extends CharacterBody3D

const ANIM_BLEND: float = 0.3

enum STATE {
	IDLE,
	WANDER,
	DEAD,
	FLEE,
	HURT,
	CHASE,
	ATTACK,
}

@export var max_health: float = 80.0
@export var normal_speed: float = 0.6
@export var alarmed_speed: float = 1.8
@export var vision_range: float = 15.0
@export var vision_fov: float = 80.0
@export var is_agressive: bool = false
@export var attack_distance: float = 2.0
@export var damage: float = 20.0

@export_group("Movement")
@export var turn_speed_weight: float = 0.07
@export var min_idle_time: float = 2.0
@export var max_idle_time: float = 7.0
@export var min_wander_time: float = 2.0
@export var max_wander_time: float = 4.0
@export var flee_time: float = 3.0

@export_group("Animations")
@export var animation_player: AnimationPlayer
@export var idle_animations: Array[String] = []
@export var hurt_animations: Array[String] = []

var state: STATE = STATE.IDLE : set = set_state
var is_player_in_vision_range: bool = false

@onready var player: Player = get_tree().get_first_node_in_group("Players")
@onready var health: float = max_health

@onready var idle_timer: Timer = %IdleTimer
@onready var wander_timer: Timer = %WanderTimer
@onready var flee_timer: Timer = %FleeTimer
@onready var disappear_after_death_timer: Timer = %DisappearAfterDeathTimer

@onready var hitbox: Area3D = %Hitbox
@onready var main_collision_shape: CollisionShape3D = %CollisionShape3D
@onready var meat_spawn_marker: Marker3D = %MeatSpawnMarker
@onready var eyes_marker: Marker3D = %EyesMarker
@onready var attack_hit_area: Area3D = %AttackHitArea
@onready var navigation_agent: NavigationAgent3D = %NavigationAgent3D
@onready var vision_area: Area3D = %VisionArea
@onready var vision_collision_shape: CollisionShape3D = %VisionCollisionShape



func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	idle_timer.timeout.connect(_on_idle_timer_timeout)
	wander_timer.timeout.connect(_on_wander_timer_timeout)
	flee_timer.timeout.connect(_on_flee_timer_timeout)
	disappear_after_death_timer.timeout.connect(_on_disappear_after_death_timer_timeout)
	hitbox.register_hit.connect(_on_register_hit)
	vision_area.body_entered.connect(_on_vision_area_body_entered)
	vision_area.body_exited.connect(_on_vision_area_body_exited)

	vision_collision_shape.shape.radius = vision_range


func _physics_process(_delta: float) -> void:
	match state:
		STATE.IDLE:
			idle_loop()
		STATE.WANDER:
			wander_loop()
		STATE.FLEE:
			flee_loop()
		STATE.CHASE:
			chase_loop()
		STATE.ATTACK:
			attack_loop()


func idle_loop() -> void:
	if is_agressive and can_see_player():
		state = STATE.CHASE


func wander_loop() -> void:
	look_forward()
	move_and_slide()

	if is_agressive and can_see_player():
		state = STATE.CHASE


func flee_loop() -> void:
	look_forward()
	move_and_slide()


func chase_loop() -> void:
	look_forward()
	if global_position.distance_to(player.global_position) < attack_distance:
		state = STATE.ATTACK
		return

	navigation_agent.set_target_position(player.global_position)
	var direction: Vector3 = global_position.direction_to(navigation_agent.get_next_path_position())
	direction.y = 0
	velocity = direction.normalized() * alarmed_speed
	move_and_slide()


func attack_loop() -> void:
	var direction: Vector3 = global_position.direction_to(player.global_position)
	rotation.y = lerp_angle(rotation.y, atan2(direction.x, direction.z) + PI, turn_speed_weight)


func attack() -> void:
	if player in attack_hit_area.get_overlapping_bodies():
		EventSystem.changed_health.emit(-damage)


func look_forward() -> void:
	rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z) + PI, turn_speed_weight)


func pick_away_from_player_velocity() -> void:
	if not player:
		state = STATE.IDLE
		return

	var direction: Vector3 = player.global_position.direction_to(global_position)
	direction.y = 0
	velocity = direction.normalized() * alarmed_speed


func pick_wander_velocity() -> void:
	var direction: Vector2 = Vector2(0, -1).rotated(randf() * TAU)
	velocity = Vector3(direction.x, 0, direction.y) * normal_speed


func can_see_player() -> bool:
	return is_player_in_vision_range and player_in_fov() and player_in_los()


func player_in_fov() -> bool:
	if not player:
		return false

	var direction_to_player: Vector3 = global_position.direction_to(player.global_position)
	var forward: Vector3 = -global_transform.basis.z
	return direction_to_player.angle_to(forward) <= deg_to_rad(vision_fov)


## Returns true if player is in line of sight
func player_in_los() -> bool:
	if not player:
		return false

	var query_params := PhysicsRayQueryParameters3D.new()
	query_params.from = eyes_marker.global_transform.origin
	query_params.to = player.head.global_position
	query_params.collision_mask = 64 # Static Bodies layer
	var result: Dictionary = get_world_3d().get_direct_space_state().intersect_ray(query_params)

	# There are no obstacles in line of sight
	return result.is_empty()


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

		STATE.HURT:
			idle_timer.stop()
			wander_timer.stop()
			flee_timer.stop()
			animation_player.play(hurt_animations.pick_random(), ANIM_BLEND)

		STATE.FLEE:
			pick_away_from_player_velocity()
			animation_player.play("Gallop", ANIM_BLEND)
			flee_timer.start(flee_time)

		STATE.CHASE:
			idle_timer.stop()
			wander_timer.stop()
			flee_timer.stop()
			animation_player.play("Gallop", ANIM_BLEND)

		STATE.ATTACK:
			animation_player.play("Attack", ANIM_BLEND)

		STATE.DEAD:
			main_collision_shape.disabled = true
			idle_timer.stop()
			wander_timer.stop()
			flee_timer.stop()
			set_physics_process(false)

			animation_player.play("Death", ANIM_BLEND)

			var meat_scene: PackedScene = ItemConfig.get_pickupable_item(ItemConfig.Keys.RAWMEAT)
			EventSystem.object_spawned.emit(meat_scene, meat_spawn_marker.global_transform)

			disappear_after_death_timer.start(10)


func _on_animation_finished(_anim_name: StringName) -> void:
	match state:
		STATE.WANDER:
			animation_player.play(idle_animations.pick_random(), ANIM_BLEND)
		STATE.HURT:
			if not is_agressive:
				state = STATE.FLEE
			else:
				state = STATE.CHASE
		STATE.ATTACK:
			state = STATE.CHASE


func _on_idle_timer_timeout() -> void:
	state = STATE.WANDER


func _on_wander_timer_timeout() -> void:
	state = STATE.IDLE


func _on_flee_timer_timeout() -> void:
	state = STATE.IDLE


func _on_disappear_after_death_timer_timeout() -> void:
	queue_free()


func _on_register_hit(weapon_item_resource: WeaponItemResource) -> void:
	health -= weapon_item_resource.damage

	if not state in [STATE.HURT, STATE.DEAD]:
		if health <= 0:
			set_state(STATE.DEAD)
		else:
			set_state(STATE.HURT)


func _on_vision_area_body_entered(body: Node3D) -> void:
	is_player_in_vision_range = body is Player


func _on_vision_area_body_exited(body: Node3D) -> void:
	is_player_in_vision_range = body is Player
