extends TransformationBase

class_name Rotation

func _init():
	transformation_type = "Rotation"
	color = Color.GOLD

func apply(target: Node2D, params: Dictionary) -> void:
	var angle = params.get("angle", 0.0)
	var anchor_point = params.get("anchor", target.global_position)

	var tween := target.create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)

	if anchor_point != target.global_position:
		var initial_offset = target.global_position - anchor_point
		var rotated_offset = initial_offset.rotated(deg_to_rad(angle))
		var new_position = anchor_point + rotated_offset

		tween.set_parallel(true)
		tween.tween_property(target, "rotation_degrees", target.rotation_degrees + angle, 0.5)
		tween.tween_property(target, "global_position", new_position, 0.5)
	else:
		tween.tween_property(target, "rotation_degrees", target.rotation_degrees + angle, 0.5)

func get_notation(params: Dictionary) -> String:
	return "R(%d°)" % int(params.get("angle", 0))
