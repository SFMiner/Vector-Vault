extends Control

signal transformation_selected(type: String, params: Dictionary)
signal scale_changed(value: float)  # For preview updates

@export var radius: float = 80.0

@onready var scale_input: SpinBox = $ScaleInput

var menu_items: Array = []
var is_open: bool = false
var scale_mode_active: bool = false

func _ready() -> void:
	visible = false
	mouse_filter = MOUSE_FILTER_IGNORE

	$TranslateButton.pressed.connect(_on_translate_pressed)
	$RotateButton.pressed.connect(_on_rotate_pressed)
	$ScaleButton.pressed.connect(_on_scale_pressed)

	# Setup scale input
	scale_input.visible = false
	scale_input.min_value = 0.25
	scale_input.max_value = 4.0
	scale_input.step = 0.25
	scale_input.value = 1.5
	scale_input.value_changed.connect(_on_scale_changed)
	scale_input.gui_input.connect(_on_scale_input_gui_input)

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

	# Reset scale mode when menu closes
	scale_mode_active = false
	scale_input.visible = false

func _on_translate_pressed() -> void:
	transformation_selected.emit("translate", {})
	close()

func _on_rotate_pressed() -> void:
	transformation_selected.emit("rotate", {})
	close()

func _on_scale_pressed() -> void:
	scale_mode_active = true
	scale_input.visible = true
	scale_input.grab_focus()

func _on_scale_changed(value: float) -> void:
	if scale_mode_active:
		# Emit for preview updates, NOT for actual transformation
		scale_changed.emit(value)

func _input(event: InputEvent) -> void:
	if scale_mode_active and event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:
			confirm_scale()
			get_tree().root.set_input_as_handled()
		elif event.keycode == KEY_ESCAPE:
			_cancel_scale()
			get_tree().root.set_input_as_handled()

func _on_scale_input_gui_input(event: InputEvent) -> void:
	# Legacy - can be removed if _input works
	pass

func confirm_scale() -> void:
	if scale_mode_active:
		var scale_value = scale_input.value
		transformation_selected.emit("scale", {"scale": scale_value})
		scale_mode_active = false
		scale_input.visible = false
		close()

func _cancel_scale() -> void:
	if scale_mode_active:
		scale_mode_active = false
		scale_input.visible = false
		scale_input.value = 1.5  # Reset to default
