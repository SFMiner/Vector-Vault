extends Node

func _ready() -> void:
	await get_tree().process_frame

	var geo_block = get_parent().get_node("GeoBlock")
	if geo_block == null:
		push_error("GeoBlock not found!")
		return

	var RotationScript: GDScript = load("res://scripts/transformations/Rotation.gd") as GDScript
	var rotation = RotationScript.new()

	await get_tree().create_timer(1.0).timeout


	var notation1 = rotation.get_notation({"angle": 90})
	print(notation1)
	rotation.apply(geo_block, {"angle": 90})

	await get_tree().create_timer(3.0).timeout

	var notation2 = rotation.get_notation({"angle": -180})
	print(notation2)
	rotation.apply(geo_block, {"angle": -180})

	await get_tree().create_timer(3.0).timeout
	geo_block.reset_to_original()
