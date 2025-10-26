extends VBoxContainer

signal parameters_changed(params: Dictionary)

var current_angle: float = 90.0

func _ready() -> void:
	$AngleButtons/Neg90Button.pressed.connect(func(): _set_angle(-90.0))
	$AngleButtons/Pos90Button.pressed.connect(func(): _set_angle(90.0))
	$AngleButtons/Pos180Button.pressed.connect(func(): _set_angle(180.0))
	_update_notation()

func _set_angle(angle: float) -> void:
	current_angle = angle
	_update_notation()
	parameters_changed.emit({"angle": angle})

func _update_notation() -> void:
	$NotationLabel.text = "R(%d°)" % int(current_angle)

func get_parameters() -> Dictionary:
	return {"angle": current_angle}
