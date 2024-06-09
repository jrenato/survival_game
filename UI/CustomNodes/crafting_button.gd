class_name CraftingButton extends TextureRect

@onready var icon_texture: TextureRect = %IconTextureRect

var item_key: Variant


func set_item_key(_item_key: Variant) -> void:
	item_key = _item_key
	icon_texture.texture = ItemConfig.get_item_resource(item_key).icon
