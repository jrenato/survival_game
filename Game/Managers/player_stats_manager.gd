extends Node


const MAX_ENERGY: float = 100.00

var current_energy: float = MAX_ENERGY


func _enter_tree() -> void:
	EventSystem.changed_energy.connect(_on_changed_energy)


func _on_changed_energy(energy_change: float) -> void:
	current_energy += energy_change
	EventSystem.updated_energy.emit(MAX_ENERGY, current_energy)
