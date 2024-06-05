extends Node


var bulletins: Dictionary = {}


func _enter_tree() -> void:
	EventSystem.looked_at_interactable.connect(_on_looked_at_interactable)
	EventSystem.stopped_looking_at_interactable.connect(_on_stopped_looking_at_interactable)


func create_bulletin(key: BulletinConfig.Keys, extra_args: Variant = null) -> void:
	if bulletins.has(key):
		return
	var new_bulletin: Bulletin = BulletinConfig.get_bulletin(key)
	new_bulletin.initialize(extra_args)
	add_child(new_bulletin)
	bulletins[key] = new_bulletin


func destroy_bulletin(key: BulletinConfig.Keys) -> void:
	if not bulletins.has(key):
		return
	bulletins[key].queue_free()
	bulletins.erase(key)


func _on_looked_at_interactable(key: BulletinConfig.Keys, extra_args: Variant = null) -> void:
	create_bulletin(key, extra_args)


func _on_stopped_looking_at_interactable(key: BulletinConfig.Keys) -> void:
	destroy_bulletin(key)
