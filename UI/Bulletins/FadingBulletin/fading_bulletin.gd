class_name FadingBulletin extends Bulletin

const TRANSPARENT_COLOR: Color = Color.TRANSPARENT
const BG_NORMAL_COLOR: Color = Color(0.0, 0.0, 0.0, 0.7)
const BG_FADE_TIME: float = 0.25

@onready var background: ColorRect = %BackgroundColorRect


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	background.color = TRANSPARENT_COLOR
	fade_in()
	EventSystem.hud_hide.emit()


func fade_in() -> void:
	create_tween().tween_property(background, "color", BG_NORMAL_COLOR, BG_FADE_TIME)


func fade_out() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate", TRANSPARENT_COLOR, BG_FADE_TIME)
	tween.tween_callback(destroy_self)


func destroy_self() -> void:
	EventSystem.disabled_bulletin.emit(BulletinConfig.Keys.PAUSE_MENU)
