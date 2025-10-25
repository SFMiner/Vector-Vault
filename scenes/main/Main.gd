extends Node2D

var vector_tool: Node2D
var radial_menu: Control

func _ready() -> void:
	vector_tool = $Player/Sprite2D/VectorTool
	radial_menu = $UI/RadialMenu

	radial_menu.transformation_selected.connect(_on_transformation_selected)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not radial_menu.is_open and vector_tool.current_target != null:
				radial_menu.open_at(get_global_mouse_position())

func _on_transformation_selected(type: String) -> void:
	print("Selected transformation: " + type)
