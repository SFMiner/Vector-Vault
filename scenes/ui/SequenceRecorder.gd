extends Panel

signal execute_sequence(sequence: TransformationSequence)

var current_sequence: TransformationSequence = TransformationSequence.new()
var recording_enabled: bool = false
var step_list: VBoxContainer

func _ready() -> void:
	step_list = $VBoxContainer/ScrollContainer/StepList

	$VBoxContainer/ButtonContainer/ClearButton.pressed.connect(_on_clear_pressed)
	$VBoxContainer/ButtonContainer/ExecuteButton.pressed.connect(_on_execute_pressed)

func enable_recording() -> void:
	recording_enabled = true
	current_sequence = TransformationSequence.new()
	_clear_step_list()

func record_step(type: String, params: Dictionary) -> void:
	if not recording_enabled:
		return

	current_sequence.add_step(type, params)
	_add_step_label()

func _add_step_label() -> void:
	# Get the notation for just the last added step
	var last_step = current_sequence.steps[-1]
	var step_notation = _get_step_notation(last_step.type, last_step.params)

	var label = Label.new()
	label.text = "[%d] %s" % [current_sequence.steps.size() - 1, step_notation]
	label.custom_minimum_size = Vector2(0, 30)
	step_list.add_child(label)

func _get_step_notation(type: String, params: Dictionary) -> String:
	match type:
		"translate":
			var offset = params.get("offset", Vector2.ZERO)
			var grid_units_x = int(offset.x / 32)
			var grid_units_y = int(offset.y / 32)
			return "T(%d,%d)" % [grid_units_x, grid_units_y]

		"rotate":
			var angle = int(params.get("angle", 0.0))
			return "R(%d°)" % angle

		"scale":
			var scale = params.get("scale", 1.0)
			return "S(%.1f)" % scale

		_:
			return "Unknown"

func _on_execute_pressed() -> void:
	if current_sequence.steps.is_empty():
		return

	execute_sequence.emit(current_sequence)

func _on_clear_pressed() -> void:
	current_sequence = TransformationSequence.new()
	_clear_step_list()

func _clear_step_list() -> void:
	for child in step_list.get_children():
		child.queue_free()
