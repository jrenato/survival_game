class_name Pickupable extends Interactable


@export var item_key: ItemConfig.Keys

@onready var parent: Node3D = get_parent()


func start_interaction() -> void:
	EventSystem.tried_to_pick_item.emit(item_key, destroy_self)


func destroy_self() -> void:
	EventSystem.play_sound.emit(SFXConfig.Keys.ITEM_PICKUP)
	parent.queue_free()
