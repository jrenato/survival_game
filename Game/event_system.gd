extends Node

## Game
@warning_ignore("unused_signal")
signal fast_forward_time(time: float)
@warning_ignore("unused_signal")
signal game_fade_in(fade_time: float, possible_callback: Callable)
@warning_ignore("unused_signal")
signal game_fade_out(fade_time: float, possible_callback: Callable)

## Bulletins
@warning_ignore("unused_signal")
signal enabled_bulletin
@warning_ignore("unused_signal")
signal disabled_bulletin
@warning_ignore("unused_signal")
signal destroy_all_bulletins

## Cursors
@warning_ignore("unused_signal")
signal pointed_at_pickupable
@warning_ignore("unused_signal")
signal pointed_at_interactable
@warning_ignore("unused_signal")
signal stopped_pointing_at_interactable

## Inventory
@warning_ignore("unused_signal")
signal tried_to_pick_item
@warning_ignore("unused_signal")
signal inventory_update_requested
@warning_ignore("unused_signal")
signal inventory_updated(inventory: Array)
@warning_ignore("unused_signal")
signal hotbar_updated(hotbar: Array)
@warning_ignore("unused_signal")
signal switched_two_items(index_1: int, from_hotbar: bool, index_2: int, to_hotbar: bool)
@warning_ignore("unused_signal")
signal crafted_item(item_key: ItemConfig.Keys)
@warning_ignore("unused_signal")
signal added_item(item_key: ItemConfig.Keys)
@warning_ignore("unused_signal")
signal removed_item(item_key: ItemConfig.Keys)
@warning_ignore("unused_signal")
signal deleted_item_by_index(index: int, is_in_hotbar: bool)
@warning_ignore("unused_signal")
signal added_item_by_index(item_key: ItemConfig.Keys, index: int, is_in_hotbar: bool)

## Interaction
@warning_ignore("unused_signal")
signal tried_to_interact

## Stage Management
@warning_ignore("unused_signal")
signal stage_changed(stage: StageConfig.Keys)
@warning_ignore("unused_signal")
signal hud_hide
@warning_ignore("unused_signal")
signal hud_show

## Player
@warning_ignore("unused_signal")
signal enabled_player
@warning_ignore("unused_signal")
signal disabled_player
@warning_ignore("unused_signal")
signal changed_energy(energy_change: float)
@warning_ignore("unused_signal")
signal updated_energy(max_energy: float, current_energy: float)
@warning_ignore("unused_signal")
signal changed_health(health_change: float)
@warning_ignore("unused_signal")
signal updated_health(max_health: float, current_health: float)
@warning_ignore("unused_signal")
signal sleep_started

## Equipment
@warning_ignore("unused_signal")
signal hotkey_pressed(hotkey: int)
@warning_ignore("unused_signal")
signal item_equipped(item_key: ItemConfig.Keys)
@warning_ignore("unused_signal")
signal item_unequipped
@warning_ignore("unused_signal")
signal updated_active_hotbar_slot(active_index: int)
@warning_ignore("unused_signal")
signal deleted_equipped_item

## Spawning
@warning_ignore("unused_signal")
signal object_spawned(object_scene: PackedScene, transform: Transform3D)

## Music and Sounds
@warning_ignore("unused_signal")
signal play_music(key: MusicConfig.Keys)
@warning_ignore("unused_signal")
signal play_sound(key: SFXConfig.Keys)
@warning_ignore("unused_signal")
signal play_dynamic_sound(key: SFXConfig.Keys, position: Vector3)

## Settings
@warning_ignore("unused_signal")
signal music_volume_changed(value: float)
@warning_ignore("unused_signal")
signal sfx_volume_changed(value: float)
@warning_ignore("unused_signal")
signal resolution_scale_changed(value: float)
@warning_ignore("unused_signal")
signal ssaa_changed(value: bool)
@warning_ignore("unused_signal")
signal fullscreen_changed(value: bool)
@warning_ignore("unused_signal")
signal request_settings_resource(target_callable: Callable)
@warning_ignore("unused_signal")
signal request_save_settings
