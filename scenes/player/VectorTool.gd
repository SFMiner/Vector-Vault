extends Node2D

signal block_targeted(block: GeoBlock)
signal block_untargeted()

@export var aim_range: float = 300.0
@export var anchor_detect_range: float = 150.0

var current_target: GeoBlock = null
var current_anchor: Anchor = null
var aim_line: Line2D
var reticle: Sprite2D
var targeting_locked: bool = false

func _ready() -> void:
	aim_line = $AimLine
	reticle = $Reticle

func lock_targeting() -> void:
	targeting_locked = true

func unlock_targeting() -> void:
	targeting_locked = false

func _process(delta: float) -> void:
	# Skip target updates if targeting is locked
	if not targeting_locked:
		var mouse_pos = get_global_mouse_position()
		var blocks = get_tree().get_nodes_in_group("geo_blocks")

		var closest_block = null
		var closest_distance = aim_range

		for block in blocks:
			var distance = mouse_pos.distance_to(block.global_position)
			if distance < closest_distance:
				closest_distance = distance
				closest_block = block

		if closest_block != current_target:
			if current_target != null:
				current_target.set_selected(false)
				block_untargeted.emit()

			current_target = closest_block

			if current_target != null:
				current_target.set_selected(true)
				block_targeted.emit(current_target)

		# Detect anchors
		var anchors = get_tree().get_nodes_in_group("anchors")
		var closest_anchor = null
		var closest_anchor_distance = anchor_detect_range

		for anchor in anchors:
			var distance = mouse_pos.distance_to(anchor.global_position)
			if distance < closest_anchor_distance:
				closest_anchor_distance = distance
				closest_anchor = anchor

		if closest_anchor != current_anchor:
			if current_anchor != null:
				current_anchor.set_active(false)

			current_anchor = closest_anchor

			if current_anchor != null:
				current_anchor.set_active(true)

	aim_line.clear_points()
	if current_target != null:
		aim_line.add_point(Vector2.ZERO)
		aim_line.add_point(to_local(current_target.global_position))
		aim_line.visible = true
		reticle.position = to_local(current_target.global_position)
		reticle.visible = true
	else:
		aim_line.visible = false
		reticle.visible = false

func prepare_transformation_params(transformation_type: String, params: Dictionary) -> Dictionary:
	var enriched_params = params.duplicate()

	if transformation_type == "rotate" and current_anchor != null:
		enriched_params["anchor"] = current_anchor.global_position

	return enriched_params
