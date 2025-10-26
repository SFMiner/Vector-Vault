extends VBoxContainer

signal parameters_changed(params: Dictionary)

var selected_axis: String = "x"
var distance: int = 1

func _ready() -> void:
	$AxisSelection/XAxisButton.toggled.connect(_on_x_axis_toggled)
	$AxisSelection/YAxisButton.toggled.connect(_on_y_axis_toggled)
	$ValueInput/DistanceSpinBox.value_changed.connect(_on_distance_changed)
	_update_notation()

func _on_x_axis_toggled(pressed: bool) -> void:
	if pressed:
		selected_axis = "x"
		$AxisSelection/YAxisButton.button_pressed = false
		_update_params()

func _on_y_axis_toggled(pressed: bool) -> void:
	if pressed:
		selected_axis = "y"
		$AxisSelection/XAxisButton.button_pressed = false
		_update_params()

func _on_distance_changed(value: float) -> void:
	distance = int(value)
	_update_params()

func _update_params() -> void:
	var offset: Vector2
	if selected_axis == "x":
		offset = Vector2(distance * GridHelper.GRID_SIZE, 0)
	else:
		# Negate Y to use normal math coordinates (positive up)
		offset = Vector2(0, -distance * GridHelper.GRID_SIZE)

	_update_notation()
	parameters_changed.emit({"offset": offset})

func _update_notation() -> void:
	var x_val = distance if selected_axis == "x" else 0
	var y_val = distance if selected_axis == "y" else 0
	$NotationLabel.text = "T(%d, %d)" % [x_val, y_val]

func get_parameters() -> Dictionary:
	var offset: Vector2
	if selected_axis == "x":
		offset = Vector2(distance * GridHelper.GRID_SIZE, 0)
	else:
		# Negate Y to use normal math coordinates (positive up)
		offset = Vector2(0, -distance * GridHelper.GRID_SIZE)
	return {"offset": offset}
