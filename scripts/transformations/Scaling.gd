extends TransformationBase

class_name Scaling

func _init():
	transformation_type = "Scaling"
	color = Color.GREEN

func apply(target: Node2D, params: Dictionary) -> void:
	var audio_player = AudioManager.play_transformation_sound("scale")
	var scale_factor = params.get("scale", 1.0)
	var new_scale = target.scale * scale_factor
	new_scale = MathUtils.clamp_scale(new_scale, 0.25, 4.0)

	var tween = target.create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(target, "scale", new_scale, 0.5)

	# Stop audio when transformation completes
	if audio_player != null:
		tween.tween_callback(func(): audio_player.stop())

func get_notation(params: Dictionary) -> String:
	return "S(%.2f)" % params.get("scale", 1.0)
