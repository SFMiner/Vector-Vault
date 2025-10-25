extends Control

signal transformation_selected(type: String)

@export var radius: float = 80.0

var menu_items: Array = []
var is_open: bool = false

func _ready() -> void:
	visible = false
	mouse_filter = MOUSE_FILTER_IGNORE

	$TranslateButton.pressed.connect(_on_translate_pressed)
	$RotateButton.pressed.connect(_on_rotate_pressed)
	$ScaleButton.pressed.connect(_on_scale_pressed)

func open_at(pos: Vector2) -> void:
	global_position = pos
	scale = Vector2(0.001, 0.001)
	visible = true
	mouse_filter = MOUSE_FILTER_STOP
	is_open = true

	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "scale", Vector2.ONE, 0.2)

func close() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.15)
	await tween.finished

	visible = false
	is_open = false
	mouse_filter = MOUSE_FILTER_IGNORE

func _on_translate_pressed() -> void:
	transformation_selected.emit("translate")
	close()

func _on_rotate_pressed() -> void:
	transformation_selected.emit("rotate")
	close()

func _on_scale_pressed() -> void:
	transformation_selected.emit("scale")
	close()
