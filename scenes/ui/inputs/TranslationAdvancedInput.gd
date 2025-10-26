extends VBoxContainer

signal parameters_changed(params: Dictionary)

var x_distance: int = 0
var y_distance: int = 0

func _ready() -> void:
	$XInput/XSpinBox.value_changed.connect(_on_x_changed)
	$YInput/YSpinBox.value_changed.connect(_on_y_changed)
	_update_notation()

func _on_x_changed(value: float) -> void:
	x_distance = int(value)
	_update_params()

func _on_y_changed(value: float) -> void:
	y_distance = int(value)
	_update_params()

func _update_params() -> void:
	# Negate Y to use normal math coordinates (positive up)
	var offset = Vector2(x_distance * GridHelper.GRID_SIZE, -y_distance * GridHelper.GRID_SIZE)
	_update_notation()
	parameters_changed.emit({"offset": offset})

func _update_notation() -> void:
	$NotationLabel.text = "T(%d, %d)" % [x_distance, y_distance]

func get_parameters() -> Dictionary:
	# Negate Y to use normal math coordinates (positive up)
	var offset = Vector2(x_distance * GridHelper.GRID_SIZE, -y_distance * GridHelper.GRID_SIZE)
	return {"offset": offset}
