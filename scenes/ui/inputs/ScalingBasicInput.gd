extends VBoxContainer

signal parameters_changed(params: Dictionary)

var current_scale: float = 2.0

func _ready() -> void:
	$ScaleButtons/HalfButton.pressed.connect(func(): _set_scale(0.5))
	$ScaleButtons/DoubleButton.pressed.connect(func(): _set_scale(2.0))
	$ScaleButtons/TripleButton.pressed.connect(func(): _set_scale(3.0))
	_update_notation()

func _set_scale(scale: float) -> void:
	current_scale = scale
	_update_notation()
	parameters_changed.emit({"scale": scale})

func _update_notation() -> void:
	$NotationLabel.text = "S(%.1f)" % current_scale

func get_parameters() -> Dictionary:
	return {"scale": current_scale}
