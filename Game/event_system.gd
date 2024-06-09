extends Node

## Bulletins
signal enabled_bulletin
signal disabled_bulletin

## Cursors
signal pointed_at_pickupable
signal pointed_at_interactable
signal stopped_pointing_at_interactable

## Inventory
signal tried_to_pick_item
signal inventory_update_requested
signal inventory_updated(inventory: Array)
signal switched_two_items(index_1: int, from_hotbar: bool, index_2: int, to_hotbar: bool)
signal crafted_item(item_key: ItemConfig.Keys)
signal added_item(item_key: ItemConfig.Keys)
signal removed_item(item_key: ItemConfig.Keys)

# Hotbar
signal hotbar_updated(hotbar: Array)

## Interaction
signal tried_to_interact

## Player
signal enabled_player
signal disabled_player

# Equipment
signal hotkey_pressed(hotkey: int)
signal item_equipped(item_key: ItemConfig.Keys)
signal item_unequipped
signal updated_active_hotbar_slot(active_index: int)
