class_name Stage extends Node

signal loading_complete

@export var show_mouse: bool = false
@export var music: MusicConfig.Keys = MusicConfig.Keys.MAIN_MENU_SONG
@export var scatter_nodes: Array[Node3D] = []

var scatter_nodes_ready: int = 0


func _enter_tree() -> void:
	for scatter_node in scatter_nodes:
		if scatter_node.has_signal("build_completed"):
			scatter_node.build_completed.connect(_on_scatter_node_build_completed)


func _ready() -> void:
	EventSystem.play_music.emit(music)


func _on_scatter_node_build_completed() -> void:
	scatter_nodes_ready += 1

	if scatter_nodes_ready >= scatter_nodes.size():
		if show_mouse:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		loading_complete.emit()
