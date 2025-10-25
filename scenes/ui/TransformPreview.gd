extends Node2D

var preview_sprite: Sprite2D = null
var original_block: GeoBlock = null

func show_preview(block: GeoBlock, transformation_type: String, params: Dictionary) -> void:
	original_block = block

	if preview_sprite == null:
		preview_sprite = Sprite2D.new()
		add_child(preview_sprite)

	var block_sprite = block.get_node("Sprite2D")
	preview_sprite.texture = block_sprite.texture
	preview_sprite.modulate = Color(1, 1, 1, 0.4)
	preview_sprite.global_position = block.global_position
	preview_sprite.rotation_degrees = block.rotation_degrees
	preview_sprite.scale = block.scale

	match transformation_type:
		"translate":
			preview_sprite.global_position += params.get("offset", Vector2.ZERO)
		"rotate":
			preview_sprite.rotation_degrees = block.rotation_degrees + params.get("angle", 0.0)
		"scale":
			preview_sprite.scale = block.scale * params.get("scale", 1.0)

	preview_sprite.visible = true

func hide_preview() -> void:
	preview_sprite.visible = false
