extends Resource

class_name TransformationSequence

signal sequence_completed()
signal step_completed(step_index: int)

var steps: Array[Dictionary] = []
var current_step: int = 0
var transformation_instances: Dictionary = {}

func _init() -> void:
	# Load transformation instances
	var TranslationScript: GDScript = load("res://scripts/transformations/Translation.gd") as GDScript
	var RotationScript: GDScript = load("res://scripts/transformations/Rotation.gd") as GDScript
	var ScalingScript: GDScript = load("res://scripts/transformations/Scaling.gd") as GDScript

	transformation_instances["translate"] = TranslationScript.new()
	transformation_instances["rotate"] = RotationScript.new()
	transformation_instances["scale"] = ScalingScript.new()

func add_step(transformation_type: String, params: Dictionary) -> void:
	steps.append({
		"type": transformation_type,
		"params": params
	})

func execute_sequence(target: Node) -> void:
	current_step = 0

	for step in steps:
		var transformation = transformation_instances[step.type]
		transformation.apply(target, step.params)

		# Wait for transformation to complete (0.5s based on transformation duration)
		await get_tree().create_timer(0.5).timeout

		step_completed.emit(current_step)
		current_step += 1

	sequence_completed.emit()

func get_notation() -> String:
	var notation_parts: Array[String] = []

	for step in steps:
		var transformation_type = step.type
		var params = step.params

		match transformation_type:
			"translate":
				var offset = params.get("offset", Vector2.ZERO)
				var grid_units_x = int(offset.x / 32)  # GridHelper.GRID_SIZE
				var grid_units_y = int(offset.y / 32)
				notation_parts.append("T(%d,%d)" % [grid_units_x, grid_units_y])

			"rotate":
				var angle = int(params.get("angle", 0.0))
				notation_parts.append("R(%d°)" % angle)

			"scale":
				var scale = params.get("scale", 1.0)
				notation_parts.append("S(%.1f)" % scale)

	return " → ".join(notation_parts)
