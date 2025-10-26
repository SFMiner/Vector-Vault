extends CompletionConditionBase

class_name ScaleCondition

var target_object: Node2D
var min_scale: float = 1.5
var max_scale: float = 10.0

func is_met() -> bool:
	if target_object == null:
		return false

	var current_scale = (target_object.scale.x + target_object.scale.y) / 2.0

	if current_scale < min_scale:
		return false

	if current_scale > max_scale:
		return false

	return true
