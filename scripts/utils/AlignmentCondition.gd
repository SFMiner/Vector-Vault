extends CompletionConditionBase

class_name AlignmentCondition

var target_object: Node2D
var target_transform: Transform2D
var position_tolerance: float = 5.0
var rotation_tolerance: float = 5.0
var scale_tolerance: float = 0.1

func is_met() -> bool:
	if target_object == null:
		return false

	var pos_distance = target_object.global_position.distance_to(target_transform.origin)
	if pos_distance >= position_tolerance:
		return false

	var rotation_diff = abs(angle_difference(target_object.rotation, target_transform.get_rotation()))
	if rotation_diff >= deg_to_rad(rotation_tolerance):
		return false

	var scale_x_diff = abs(target_object.scale.x - target_transform.get_scale().x)
	var scale_y_diff = abs(target_object.scale.y - target_transform.get_scale().y)
	if scale_x_diff >= scale_tolerance or scale_y_diff >= scale_tolerance:
		return false

	return true

func angle_difference(angle1: float, angle2: float) -> float:
	var diff = angle1 - angle2
	while diff > PI:
		diff -= TAU
	while diff < -PI:
		diff += TAU
	return diff
