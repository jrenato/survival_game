class_name ShakingCamera extends Camera3D


@export var noise_speed: float = 1.0
@export var noise_multiplier: float = 0.25

var noise: FastNoiseLite = FastNoiseLite.new()


func _ready() -> void:
	noise.seed = randi()
	noise.frequency = noise_speed * 0.00001


func _process(delta: float) -> void:
	rotation.x = noise.get_noise_1d(Time.get_ticks_msec()) * noise_multiplier
	rotation.y = noise.get_noise_1d(Time.get_ticks_msec() + 10000) * noise_multiplier
