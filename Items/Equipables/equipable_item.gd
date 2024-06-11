class_name EquipableItem extends Node3D


@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var mesh_holder: Node3D = %MeshHolder


func _ready() -> void:
	for child in mesh_holder.get_children():
		if child is VisualInstance3D:
			child.layers = 2


func try_to_use() -> void:
	if animation_player.is_playing():
		return
	animation_player.play("use_item")
