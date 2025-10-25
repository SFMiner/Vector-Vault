extends TransformationBase

class_name TranslationTransformation

func _init():
	transformation_type = "Translation"
	color = Color.CYAN

func apply(target: Node2D, params: Dictionary) -> void:
	var offset = params.get("offset", Vector2.ZERO)

	if "grid_locked" in target and target.grid_locked:
		offset = GridHelper.snap_to_grid(offset)

	var tween = target.create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(target, "position", target.position + offset, 0.5)

func get_notation(params: Dictionary) -> String:
	var offset = params.get("offset", Vector2.ZERO)
	var grid_offset = GridHelper.world_to_grid(offset)
	return "T(%d, %d)" % [grid_offset.x, grid_offset.y]
