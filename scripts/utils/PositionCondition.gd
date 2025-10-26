extends CompletionConditionBase

class_name PositionCondition

var target_object: Node2D
var target_position: Vector2
var tolerance: float = 5.0

func is_met() -> bool:
	if target_object == null:
		return false
	return target_object.global_position.distance_to(target_position) < tolerance
