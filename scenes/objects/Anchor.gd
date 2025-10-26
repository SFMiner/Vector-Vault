extends Node2D

class_name Anchor

var is_active: bool = false

func _ready() -> void:
	add_to_group("anchors")

func set_active(active: bool) -> void:
	is_active = active
	if active:
		modulate = Color(1, 1, 1, 1)  # Full brightness when active
	else:
		modulate = Color(0.6, 0.6, 0.6, 1)  # Dimmed when inactive
