extends Node

var current_level: String = ""
var player_position: Vector2 = Vector2.ZERO
var unlocked_transformations: Array[String] = ["translate"]
var game_settings: Dictionary = {
	"colorblind_mode": false,
	"text_size": 1.0,
	"grid_opacity": 1.0,
	"show_coordinates": true
}

func unlock_transformation(type: String) -> void:
	if type not in unlocked_transformations:
		unlocked_transformations.append(type)

func is_transformation_unlocked(type: String) -> bool:
	return type in unlocked_transformations
