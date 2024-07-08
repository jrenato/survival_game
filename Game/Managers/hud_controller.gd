extends Node

@onready var hud: Control = %HUD

func _enter_tree() -> void:
	EventSystem.hud_show.connect(hud_show)
	EventSystem.hud_hide.connect(hud_hide)


func _ready() -> void:
	hud_hide()


func hud_show() -> void:
	add_child(hud)


func hud_hide() -> void:
	remove_child(hud)
