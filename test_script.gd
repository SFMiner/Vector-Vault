extends Node

func _ready() -> void:
	var geo_block = get_parent().get_node("GeoBlock")
	var translation = Translation.new()
