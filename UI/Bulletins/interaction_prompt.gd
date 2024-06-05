extends Bulletin


var prompt_text: String = ""

@onready var label: Label = %Label


func initialize(prompt) -> void:
	if prompt is String:
		prompt_text = prompt


func _ready() -> void:
	label.text = prompt_text
