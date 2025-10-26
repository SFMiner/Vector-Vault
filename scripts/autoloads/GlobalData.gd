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
var transformation_modes: Dictionary = {
	"translate": "basic",
	"rotate": "basic",
	"scale": "basic"
}

func unlock_transformation(type: String) -> void:
	if type not in unlocked_transformations:
		unlocked_transformations.append(type)

func is_transformation_unlocked(type: String) -> bool:
	return type in unlocked_transformations

func unlock_advanced_mode(type: String) -> void:
	if type in transformation_modes:
		transformation_modes[type] = "advanced"

func is_advanced_mode(type: String) -> bool:
	return transformation_modes.get(type, "basic") == "advanced"

func get_transformation_mode(type: String) -> String:
	return transformation_modes.get(type, "basic")
