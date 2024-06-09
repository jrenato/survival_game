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
signal switched_two_items(index_1: ItemConfig.Keys, index_2: ItemConfig.Keys)
signal crafted_item(item_key: ItemConfig.Keys)
signal added_item(item_key: ItemConfig.Keys)
signal removed_item(item_key: ItemConfig.Keys)

## Interaction
signal tried_to_interact

## Player
signal enabled_player
signal disabled_player
