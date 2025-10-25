extends Node

static func lerp_transform(from: Transform2D, to: Transform2D, weight: float) -> Transform2D:
	var lerped_origin := from.origin.lerp(to.origin, weight)
	var lerped_rotation := lerp_angle(from.get_rotation(), to.get_rotation(), weight)
	var lerped_scale := from.get_scale().lerp(to.get_scale(), weight)
	
	var result := Transform2D(lerped_rotation, lerped_origin)
	result = result.scaled(lerped_scale)
	return result

static func angle_difference(from_degrees: float, to_degrees: float) -> float:
	var diff := fmod(to_degrees - from_degrees + 180.0, 360.0)
	if diff < 0:
		diff += 360.0
	return diff - 180.0

static func clamp_scale(scale: Vector2, min_val: float, max_val: float) -> Vector2:
	return Vector2(
		clamp(scale.x, min_val, max_val),
		clamp(scale.y, min_val, max_val)
	)
