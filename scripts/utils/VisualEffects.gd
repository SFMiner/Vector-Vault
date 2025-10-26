extends Node

class_name VisualEffects

static func create_transformation_trail(type: String, from: Vector2, to: Vector2, parent: Node) -> void:
	var line = Line2D.new()

	# Add points from start to end
	line.add_point(from)
	line.add_point(to)

	# Set width
	line.width = 3.0

	# Set color based on transformation type
	match type:
		"translate":
			line.default_color = Color.CYAN
		"rotate":
			line.default_color = Color.GOLD
		"scale":
			line.default_color = Color.GREEN
		_:
			line.default_color = Color.WHITE

	# Add to parent
	parent.add_child(line)

	# Create tween to fade out
	var tween = line.create_tween()
	tween.tween_property(line, "modulate:a", 0.0, 1.0)
	tween.tween_callback(func(): line.queue_free())
