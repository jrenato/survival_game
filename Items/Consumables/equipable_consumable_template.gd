class_name EquipableConsumable extends EquipableItem


var consumable_item_resource: ConsumableItemResource


func consume() -> void:
	EventSystem.changed_health.emit(consumable_item_resource.health_change)
	EventSystem.changed_energy.emit(consumable_item_resource.energy_change)
	EventSystem.deleted_equipped_item.emit()


func destroy_self() -> void:
	EventSystem.item_unequipped.emit()
