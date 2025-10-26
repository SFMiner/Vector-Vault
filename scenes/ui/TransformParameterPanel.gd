extends Control

signal parameter_confirmed(transformation_type: String, params: Dictionary)
signal parameter_cancelled()
signal parameters_changed(transformation_type: String, params: Dictionary)

var current_transformation_type: String = ""
var current_input_node: Node = null

@onready var parameter_inputs = $ContentContainer/ParameterInputs

var input_scenes: Dictionary = {
	"translate_basic": preload("res://scenes/ui/inputs/TranslationBasicInput.tscn"),
	"translate_advanced": preload("res://scenes/ui/inputs/TranslationAdvancedInput.tscn"),
	"rotate_basic": preload("res://scenes/ui/inputs/RotationBasicInput.tscn"),
	"rotate_advanced": preload("res://scenes/ui/inputs/RotationAdvancedInput.tscn"),
	"scale_basic": preload("res://scenes/ui/inputs/ScalingBasicInput.tscn"),
	"scale_advanced": preload("res://scenes/ui/inputs/ScalingAdvancedInput.tscn")
}

func _ready() -> void:
	visible = false
	$ContentContainer/ButtonContainer/ConfirmButton.pressed.connect(_on_confirm_pressed)
	$ContentContainer/ButtonContainer/CancelButton.pressed.connect(_on_cancel_pressed)

func open_for_transformation(type: String) -> void:
	current_transformation_type = type
	visible = true
	_setup_inputs_for_type(type)

func close_panel() -> void:
	visible = false
	if current_input_node:
		current_input_node.queue_free()
		current_input_node = null

func _setup_inputs_for_type(type: String) -> void:
	if current_input_node:
		current_input_node.queue_free()
		current_input_node = null

	var mode = GlobalData.get_transformation_mode(type)
	var scene_key = type + "_" + mode

	if scene_key in input_scenes:
		current_input_node = input_scenes[scene_key].instantiate()
		parameter_inputs.add_child(current_input_node)

		if current_input_node.has_signal("parameters_changed"):
			current_input_node.parameters_changed.connect(_on_parameters_changed)

		# Emit initial parameters so preview shows immediately
		if current_input_node.has_method("get_parameters"):
			var initial_params = current_input_node.get_parameters()
			parameters_changed.emit(current_transformation_type, initial_params)

func _on_parameters_changed(params: Dictionary) -> void:
	parameters_changed.emit(current_transformation_type, params)

func _on_confirm_pressed() -> void:
	if current_input_node and current_input_node.has_method("get_parameters"):
		var params = current_input_node.get_parameters()
		parameter_confirmed.emit(current_transformation_type, params)
	close_panel()

func _on_cancel_pressed() -> void:
	parameter_cancelled.emit()
	close_panel()
