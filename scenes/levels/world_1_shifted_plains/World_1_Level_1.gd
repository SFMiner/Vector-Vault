extends BaseLevel

var vector_tool: Node2D
var radial_menu: Control
var preview: Node2D
var parameter_panel: Control
#var level_complete_panel: Panel
var transformation_instances: Dictionary = {}
var prev_menu_open: bool = false
var targeting_locked: bool = false

func _ready() ->void:
	vector_tool = $Player/Sprite2D/VectorTool
	radial_menu = $UI/RadialMenu
	preview = $UI/TransformPreview
	parameter_panel = $UI/TransformParameterPanel
	level_complete_panel = $UI/LevelCompletePanel

	var TranslationScript: GDScript = load("res://scripts/transformations/Translation.gd") as GDScript
	var RotationScript: GDScript = load("res://scripts/transformations/Rotation.gd") as GDScript
	var ScalingScript: GDScript = load("res://scripts/transformations/Scaling.gd") as GDScript

	transformation_instances["translate"] = TranslationScript.new()
	transformation_instances["rotate"] = RotationScript.new()
	transformation_instances["scale"] = ScalingScript.new()

	radial_menu.transformation_selected.connect(_on_transformation_selected)
	radial_menu.scale_changed.connect(_on_scale_preview_changed)
	parameter_panel.parameter_confirmed.connect(_on_parameter_confirmed)
	parameter_panel.parameter_cancelled.connect(_on_parameter_cancelled)
	parameter_panel.parameters_changed.connect(_on_panel_parameters_changed)
	level_completed.connect(_on_level_complete)

	super._ready()

func _process(delta: float) -> void:
	var should_lock_targeting = radial_menu.is_open or parameter_panel.visible
	if should_lock_targeting and not targeting_locked:
		vector_tool.lock_targeting()
		targeting_locked = true
	elif not should_lock_targeting and targeting_locked:
		vector_tool.unlock_targeting()
		targeting_locked = false

	if radial_menu.is_open and not prev_menu_open:
		var target = vector_tool.current_target
		if target != null:
			preview.show_preview(target, "translate", {"offset": Vector2(96, 0)})
		prev_menu_open = true
		_connect_button_hover()
	elif not radial_menu.is_open and prev_menu_open:
		preview.hide_preview()
		prev_menu_open = false

	check_completion()

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

func _on_transformation_selected(type: String, params: Dictionary = {}) -> void:
	var target = vector_tool.current_target
	if target == null:
		return

	# If params are provided (e.g., from scale spinbox), apply directly
	if not params.is_empty():
		var start_position = target.global_position

		var final_params = vector_tool.prepare_transformation_params(type, params)

		var transformation = transformation_instances[type]
		var notation = transformation.get_notation(final_params)
		Analytics_Manager.record_transformation(type, final_params, notation)

		target.apply_transformation(transformation, final_params)

		await get_tree().create_timer(0.5).timeout
		var end_position = target.global_position

		VisualEffects.create_transformation_trail(type, start_position, end_position, self)
	else:
		# Otherwise open parameter panel for manual input
		parameter_panel.open_for_transformation(type)

func _on_parameter_confirmed(transformation_type: String, params: Dictionary) -> void:
	preview.hide_preview()
	radial_menu.close()

	var target = vector_tool.current_target
	if target == null:
		return

	var start_position = target.global_position

	# Prepare parameters with anchor support
	var final_params = vector_tool.prepare_transformation_params(transformation_type, params)

	var transformation = transformation_instances[transformation_type]
	var notation = transformation.get_notation(final_params)
	Analytics_Manager.record_transformation(transformation_type, final_params, notation)

	target.apply_transformation(transformation, final_params)

	await get_tree().create_timer(0.5).timeout
	var end_position = target.global_position

	VisualEffects.create_transformation_trail(transformation_type, start_position, end_position, self)

func _on_parameter_cancelled() -> void:
	preview.hide_preview()
	radial_menu.close()

func _on_panel_parameters_changed(transformation_type: String, params: Dictionary) -> void:
	var target = vector_tool.current_target
	if target == null:
		return

	preview.show_preview(target, transformation_type, params)

func _on_scale_preview_changed(scale_value: float) -> void:
	var target = vector_tool.current_target
	if target == null:
		return

	preview.show_preview(target, "scale", {"scale": scale_value})

func _on_level_complete() -> void:
	var transform_count = 0
	var completion_time = 0

	if not Analytics_Manager.current_level_stats.is_empty():
		transform_count = Analytics_Manager.current_level_stats.transformations.size()
		completion_time = Time.get_ticks_msec() - Analytics_Manager.current_level_stats.start_time

	level_complete_panel.show_results(transform_count, completion_time)

func setup_level() -> void:
	var movable_block = $MovableBlock
	var target_position_marker = $TargetPosition

	var pos_condition = PositionCondition.new()
	pos_condition.target_object = movable_block
	pos_condition.target_position = target_position_marker.global_position
	pos_condition.tolerance = 10.0

	completion_conditions = [pos_condition]
