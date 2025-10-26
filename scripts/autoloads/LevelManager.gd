extends Node

var current_level_path: String = ""
var unlocked_levels: Dictionary = {"Plains 1-1": true}
var level_paths: Dictionary = {
	"Plains 1-1": "res://scenes/levels/world_1_shifted_plains/World_1_Level_1.tscn",
	"Plains 1-2": "res://scenes/levels/world_1_shifted_plains/World_1_Level_2.tscn",
	"Plains 1-3": "res://scenes/levels/world_1_shifted_plains/World_1_Level_3.tscn"
}

var level_order: Array[String] = [
	"Plains 1-1",
	"Plains 1-2",
	"Plains 1-3"
]

func load_level(level_name: String) -> void:
	if level_paths.has(level_name):
		current_level_path = level_paths[level_name]
		get_tree().change_scene_to_file(current_level_path)
	else:
		push_error("Level not found: " + level_name)

func unlock_level(level_name: String) -> void:
	unlocked_levels[level_name] = true

func is_level_unlocked(level_name: String) -> bool:
	return unlocked_levels.get(level_name, false)

func get_next_level(current_name: String) -> String:
	var current_index = level_order.find(current_name)

	if current_index == -1:
		return ""

	var next_index = current_index + 1
	if next_index >= level_order.size():
		return ""

	return level_order[next_index]
