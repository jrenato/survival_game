class_name CraftingButton extends TextureRect

var item_key: Variant

@onready var icon_texture: TextureRect = %IconTextureRect
@onready var button: Button = %Button


func set_item_key(_item_key: Variant) -> void:
	item_key = _item_key
	icon_texture.texture = ItemConfig.get_item_resource(item_key).icon
