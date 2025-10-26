extends CompletionConditionBase

class_name AllBlocksMovedCondition

var blocks_group: String = "geo_blocks"
var min_transformations: int = 1
var transformation_counts: Dictionary = {}

func is_met() -> bool:
	var blocks = get_tree().get_nodes_in_group(blocks_group)

	if blocks.is_empty():
		return false

	for block in blocks:
		if block not in transformation_counts:
			transformation_counts[block] = 0

		if transformation_counts[block] < min_transformations:
			return false

	return true

func record_transformation(block: Node2D) -> void:
	if block not in transformation_counts:
		transformation_counts[block] = 0
	transformation_counts[block] += 1
