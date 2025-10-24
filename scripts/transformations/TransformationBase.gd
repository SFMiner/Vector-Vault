extends Resource

class_name TransformationBase

@export var transformation_type: String = ""
@export var color: Color = Color.WHITE

func apply(target: Node2D, params: Dictionary) -> void:
	push_error("apply() must be implemented in derived class")

func get_preview_transform(target: Node2D, params: Dictionary) -> Transform2D:
	push_error("get_preview_transform() must be implemented in derived class")
	return Transform2D()

func get_notation(params: Dictionary) -> String:
	return transformation_type
