extends Node


const MAX_ENERGY: float = 100.00
const MAX_HEALTH: float = 100.00

var current_energy: float = MAX_ENERGY
var current_health: float = MAX_HEALTH


func _enter_tree() -> void:
	EventSystem.changed_energy.connect(_on_changed_energy)
	EventSystem.changed_health.connect(_on_changed_health)


func _on_changed_energy(energy_change: float) -> void:
	current_energy += energy_change
	if current_energy < 0:
		_on_changed_health(energy_change)
	current_energy = clampf(current_energy, 0, MAX_ENERGY)
	EventSystem.updated_energy.emit(MAX_ENERGY, current_energy)


func _on_changed_health(health_change: float) -> void:
	current_health += health_change
	current_health = clampf(current_health, 0, MAX_HEALTH)
	EventSystem.updated_health.emit(MAX_HEALTH, current_health)
