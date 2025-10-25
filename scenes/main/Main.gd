extends Node2D

var vector_tool: Node2D
var radial_menu: Control
var preview: Node2D
var transformation_instances: Dictionary = {}
var prev_menu_open: bool = false

func _ready() -> void:
	vector_tool = $Player/Sprite2D/VectorTool
	radial_menu = $UI/RadialMenu
	preview = $Preview

	var TranslationScript: GDScript = load("res://scripts/transformations/Translation.gd") as GDScript
	var RotationScript: GDScript = load("res://scripts/transformations/Rotation.gd") as GDScript
	var ScalingScript: GDScript = load("res://scripts/transformations/Scaling.gd") as GDScript

	transformation_instances["translate"] = TranslationScript.new()
	transformation_instances["rotate"] = RotationScript.new()
	transformation_instances["scale"] = ScalingScript.new()

	radial_menu.transformation_selected.connect(_on_transformation_selected)

func _process(delta: float) -> void:
	if radial_menu.is_open and not prev_menu_open:
		var target = vector_tool.current_target
		if target != null:
			preview.show_preview(target, "translate", {"offset": Vector2(96, 0)})
		prev_menu_open = true
		_connect_button_hover()
	elif not radial_menu.is_open and prev_menu_open:
		preview.hide_preview()
		prev_menu_open = false

func _connect_button_hover() -> void:
	var target = vector_tool.current_target
	if target == null:
		return

	radial_menu.get_node("TranslateButton").mouse_entered.connect(func():
		preview.show_preview(target, "translate", {"offset": Vector2(96, 0)})
	)
	radial_menu.get_node("RotateButton").mouse_entered.connect(func():
		preview.show_preview(target, "rotate", {"angle": 90.0})
	)
	radial_menu.get_node("ScaleButton").mouse_entered.connect(func():
		preview.show_preview(target, "scale", {"scale": 1.5})
	)

func _input(event: InputEvent) -> void:
	if radial_menu.is_open:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
				radial_menu.close()
				get_tree().root.set_input_as_handled()
		elif event is InputEventKey:
			if event.keycode == KEY_ESCAPE and event.pressed:
				radial_menu.close()
				get_tree().root.set_input_as_handled()
	else:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if vector_tool.current_target != null:
					radial_menu.open_at(get_global_mouse_position())

func _on_transformation_selected(type: String) -> void:
	preview.hide_preview()

	var target = vector_tool.current_target
	if target == null:
		return

	var transformation = transformation_instances[type]
	var params = {}

	match type:
		"translate":
			params = {"offset": Vector2(96, 0)}
		"rotate":
			params = {"angle": 90.0}
		"scale":
			params = {"scale": 1.5}

	target.apply_transformation(transformation, params)
