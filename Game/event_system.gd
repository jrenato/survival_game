extends Node

## Game
signal fast_forward_time(time: float)
signal game_fade_in(fade_time: float, possible_callback: Callable)
signal game_fade_out(fade_time: float, possible_callback: Callable)

## Bulletins
signal enabled_bulletin
signal disabled_bulletin
signal destroy_all_bulletins

## Cursors
signal pointed_at_pickupable
signal pointed_at_interactable
signal stopped_pointing_at_interactable

## Inventory
signal tried_to_pick_item
signal inventory_update_requested
signal inventory_updated(inventory: Array)
signal hotbar_updated(hotbar: Array)
signal switched_two_items(index_1: int, from_hotbar: bool, index_2: int, to_hotbar: bool)
signal crafted_item(item_key: ItemConfig.Keys)
signal added_item(item_key: ItemConfig.Keys)
signal removed_item(item_key: ItemConfig.Keys)
signal deleted_item_by_index(index: int, is_in_hotbar: bool)
signal added_item_by_index(item_key: ItemConfig.Keys, index: int, is_in_hotbar: bool)

## Interaction
signal tried_to_interact

## Stage Management
signal stage_changed(stage: StageConfig.Keys)
signal hud_hide
signal hud_show

## Player
signal enabled_player
signal disabled_player
signal changed_energy(energy_change: float)
signal updated_energy(max_energy: float, current_energy: float)
signal changed_health(health_change: float)
signal updated_health(max_health: float, current_health: float)
signal sleep_started

## Equipment
signal hotkey_pressed(hotkey: int)
signal item_equipped(item_key: ItemConfig.Keys)
signal item_unequipped
signal updated_active_hotbar_slot(active_index: int)
signal deleted_equipped_item

## Spawning
signal object_spawned(object_scene: PackedScene, transform: Transform3D)

## Music and Sounds
signal play_music(key: MusicConfig.Keys)
signal play_sound(key: SFXConfig.Keys)
signal play_dynamic_sound(key: SFXConfig.Keys, position: Vector3)

## Settings
signal music_volume_changed(value: float)
signal sfx_volume_changed(value: float)
signal resolution_scale_changed(value: float)
signal ssaa_changed(value: bool)
signal fullscreen_changed(value: bool)
signal request_settings_resource(target_callable: Callable)
signal request_save_settings
