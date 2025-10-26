extends StaticBody2D

class_name GeoBlock

signal transformation_completed()
signal selected()
signal deselected()

@export var can_translate: bool = true
@export var can_rotate: bool = true
@export var can_scale: bool = true
@export var grid_locked: bool = true

var original_transform: Transform2D
var is_selected: bool = false

func _ready() -> void:
	original_transform = transform
	add_to_group("geo_blocks")
	$Label.text = str(scale)

func set_selected(value: bool) -> void:
	is_selected = value
	if is_selected:
		$Highlight.visible = true
		selected.emit()
	else:
		$Highlight.visible = false
		deselected.emit()

func apply_transformation(transformation: TransformationBase, params: Dictionary) -> void:
	transformation.apply(self, params)
	transformation_completed.emit()
	$Label.text = str(scale)

func reset_to_original() -> void:
	var tween = create_tween()
	tween.tween_property(self, "transform", original_transform, 0.3)
	$Label.text = str(scale)
