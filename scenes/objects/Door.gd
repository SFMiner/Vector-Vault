extends StaticBody2D

class_name Door

@export var is_open: bool = false

var collision_shape: CollisionShape2D
var door_sprite: ColorRect

func _ready() -> void:
	collision_shape = $CollisionShape2D
	door_sprite = $DoorSprite

	# Set initial state
	if is_open:
		position.y -= 128
		collision_shape.disabled = true
		door_sprite.modulate = Color(0.5, 1.0, 0.5, 1.0)
	else:
		collision_shape.disabled = false
		door_sprite.modulate = Color(0.8, 0.3, 0.3, 1.0)

func open() -> void:
	if is_open:
		return

	is_open = true

	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position:y", position.y - 128, 0.5)

	collision_shape.disabled = true
	door_sprite.modulate = Color(0.5, 1.0, 0.5, 1.0)  # Green when open

func close() -> void:
	if not is_open:
		return

	is_open = false

	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position:y", position.y + 128, 0.5)

	collision_shape.disabled = false
	door_sprite.modulate = Color(0.8, 0.3, 0.3, 1.0)  # Red when closed
