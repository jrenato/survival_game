extends Node


func _ready() -> void:
	change_stage(StageConfig.Keys.ISLAND)


func change_stage(key: StageConfig.Keys) -> void:
	for child in get_children():
		child.queue_free()

	var new_stage: Node = StageConfig.get_stage(key)
	add_child(new_stage)
