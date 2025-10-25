extends Node

func _ready() -> void:
	await get_tree().process_frame

	var geo_block = get_parent().get_node("GeoBlock")
	if geo_block == null:
		push_error("GeoBlock not found!")
		return

	var ScalingScript: GDScript = load("res://scripts/transformations/Scaling.gd") as GDScript
	var scaling = ScalingScript.new()

	await get_tree().create_timer(1.0).timeout

	var notation1 = scaling.get_notation({"scale": 2.0})
	print(notation1)
	scaling.apply(geo_block, {"scale": 2.0})

	await get_tree().create_timer(2.0).timeout

	var notation2 = scaling.get_notation({"scale": 0.5})
	print(notation2)
	scaling.apply(geo_block, {"scale": 0.5})

	await get_tree().create_timer(2.0).timeout
	geo_block.reset_to_original()
