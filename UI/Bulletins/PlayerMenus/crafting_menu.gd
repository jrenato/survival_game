class_name CraftingMenu extends PlayerMenuBase

@onready var crafting_button_container: GridContainer = %CraftingButtonContainer

@export var crafting_button_scene: PackedScene


func _ready() -> void:
	for item_key in ItemConfig.CRAFTABLE_ITEM_KEYS:
		var crafting_button: CraftingButton = crafting_button_scene.instantiate()
		crafting_button_container.add_child(crafting_button)
		crafting_button.set_item_key(item_key)
		crafting_button.button.mouse_entered.connect(_on_crafting_button_mouse_entered.bind(crafting_button))
		crafting_button.button.mouse_exited.connect(_on_crafting_button_mouse_exited)
		crafting_button.button.pressed.connect(_on_crafting_button_pressed.bind(crafting_button))

	super()


func update_inventory(inventory: Array) -> void:
	update_craft_button(inventory)
	super(inventory)


func update_craft_button(inventory: Array) -> void:
	for crafting_button in crafting_button_container.get_children():
		var crafting_blueprint: CraftingBlueprintResource = ItemConfig.get_crafting_blueprint_resource(crafting_button.item_key)
		var disable_button: bool = false

		if crafting_blueprint.needs_multitool and not ItemConfig.Keys.MULTITOOL in inventory:
			disable_button = true
		elif crafting_blueprint.needs_tinderbox and not ItemConfig.Keys.TINDERBOX in inventory:
			disable_button = true
		else:
			for cost in crafting_blueprint.costs:
				if inventory.count(cost.item_key) < cost.amount:
					disable_button = true
					break

		crafting_button.button.disabled = disable_button


func _on_crafting_button_mouse_entered(crafting_button: CraftingButton) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return

	if not crafting_button.button.disabled:
		Input.set_custom_mouse_cursor(CursorLibrary.get_cursor(CursorLibrary.CURSOR_TYPE.INTERACT))
	else:
		Input.set_custom_mouse_cursor(CursorLibrary.get_cursor(CursorLibrary.CURSOR_TYPE.FORBIDDEN))

	var item_key: ItemConfig.Keys = crafting_button.item_key

	var item_resource: ItemResource = ItemConfig.get_item_resource(item_key)
	item_description_label.text = "%s\n%s" % [item_resource.display_name, item_resource.description]
	item_extra_info_label.text = "Requirements:"
	
	var crafting_blueprint: CraftingBlueprintResource = ItemConfig.get_crafting_blueprint_resource(item_key)

	if crafting_blueprint.needs_multitool:
		item_extra_info_label.text += "\nMultitool"

	if crafting_blueprint.needs_tinderbox:
		item_extra_info_label.text += "\nTinderbox"

	for cost in crafting_blueprint.costs:
		var cost_item: ItemResource = ItemConfig.get_item_resource(cost.item_key)
		item_extra_info_label.text += "\n%s x %s" % [cost.amount, cost_item.display_name]


func _on_crafting_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(CursorLibrary.get_cursor(CursorLibrary.CURSOR_TYPE.ARROW_NONE))
	item_description_label.text = ""
	item_extra_info_label.text = ""


func _on_crafting_button_pressed(crafting_button: CraftingButton):
	EventSystem.crafted_item.emit(crafting_button.item_key)
