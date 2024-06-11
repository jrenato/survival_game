extends VBoxContainer


@onready var energy_bar: TextureProgressBar = %EnergyBar


func _enter_tree() -> void:
	EventSystem.updated_energy.connect(_on_updated_energy)


func _on_updated_energy(max_energy: float, current_energy: float) -> void:
	energy_bar.max_value = max_energy
	energy_bar.value = current_energy
