extends Node


var bulletins: Dictionary = {}


func _enter_tree() -> void:
	EventSystem.enabled_bulletin.connect(_on_enabled_bulletin)
	EventSystem.disabled_bulletin.connect(_on_disabled_bulletin)
	EventSystem.destroy_all_bulletins.connect(_on_destroy_all_bulletins)


func create_bulletin(key: BulletinConfig.Keys, extra_args: Variant = null) -> void:
	if bulletins.has(key):
		return
	var new_bulletin: Bulletin = BulletinConfig.get_bulletin(key).instantiate()
	new_bulletin.initialize(extra_args)
	add_child(new_bulletin)
	bulletins[key] = new_bulletin


func destroy_bulletin(key: BulletinConfig.Keys) -> void:
	if not bulletins.has(key):
		return
	bulletins[key].queue_free()
	bulletins.erase(key)


func _on_enabled_bulletin(key: BulletinConfig.Keys, extra_args: Variant = null) -> void:
	create_bulletin(key, extra_args)


func _on_disabled_bulletin(key: BulletinConfig.Keys) -> void:
	destroy_bulletin(key)


func _on_destroy_all_bulletins() -> void:
	for child in get_children():
		child.queue_free()

	bulletins.clear()
