extends VBoxContainer


@onready var energy_bar: TextureProgressBar = %EnergyBar
@onready var health_bar: TextureProgressBar = %HealthBar


func _ready() -> void:
	EventSystem.updated_energy.connect(_on_updated_energy)
	EventSystem.updated_health.connect(_on_updated_health)


func _on_updated_energy(max_energy: float, current_energy: float) -> void:
	energy_bar.max_value = max_energy
	energy_bar.value = current_energy


func _on_updated_health(max_health: float, current_health: float) -> void:
	health_bar.max_value = max_health
	health_bar.value = current_health
