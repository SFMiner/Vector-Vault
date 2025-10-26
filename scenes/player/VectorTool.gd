extends Node2D

signal block_targeted(block: GeoBlock)
signal block_untargeted()

@export var aim_range: float = 300.0

var current_target: GeoBlock = null
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
