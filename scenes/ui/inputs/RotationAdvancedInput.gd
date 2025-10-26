extends VBoxContainer

signal parameters_changed(params: Dictionary)

var current_angle: float = 90.0

func _ready() -> void:
	$AngleInput/AngleSpinBox.value_changed.connect(_on_angle_changed)
	$AngleSlider/AngleSliderControl.value_changed.connect(_on_slider_changed)
	_update_notation()

func _on_angle_changed(value: float) -> void:
	current_angle = value
	$AngleSlider/AngleSliderControl.value = value
	_update_params()

func _on_slider_changed(value: float) -> void:
	current_angle = value
	$AngleInput/AngleSpinBox.value = value
	_update_params()

func _update_params() -> void:
	_update_notation()
	parameters_changed.emit({"angle": current_angle})

func _update_notation() -> void:
	$NotationLabel.text = "R(%d°)" % int(current_angle)

func get_parameters() -> Dictionary:
	return {"angle": current_angle}
