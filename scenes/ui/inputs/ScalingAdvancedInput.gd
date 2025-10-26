extends VBoxContainer

signal parameters_changed(params: Dictionary)

var current_scale: float = 1.5

func _ready() -> void:
	$ScaleInput/ScaleSpinBox.value_changed.connect(_on_scale_changed)
	$ScaleSlider/ScaleSliderControl.value_changed.connect(_on_slider_changed)
	_update_notation()

func _on_scale_changed(value: float) -> void:
	current_scale = value
	$ScaleSlider/ScaleSliderControl.value = value
	_update_params()

func _on_slider_changed(value: float) -> void:
	current_scale = value
	$ScaleInput/ScaleSpinBox.value = value
	_update_params()

func _update_params() -> void:
	_update_notation()
	parameters_changed.emit({"scale": current_scale})

func _update_notation() -> void:
	$NotationLabel.text = "S(%.2f)" % current_scale

func get_parameters() -> Dictionary:
	return {"scale": current_scale}
