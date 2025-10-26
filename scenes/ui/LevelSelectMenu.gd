extends Control

signal level_selected(level_path: String)

var available_levels: Array[Dictionary] = []

@onready var level_list = $Panel/VBoxContainer/ScrollContainer/LevelList

func _ready() -> void:
	var levels = [
		{"name": "Plains 1-1", "path": "res://scenes/levels/world_1_shifted_plains/World_1_Level_1.tscn", "unlocked": true},
		{"name": "Plains 1-2", "path": "res://scenes/levels/world_1_shifted_plains/World_1_Level_2.tscn", "unlocked": true},
		{"name": "Plains 1-3", "path": "res://scenes/levels/world_1_shifted_plains/World_1_Level_3.tscn", "unlocked": true},
	]

	populate_levels(levels)

func populate_levels(levels: Array[Dictionary]) -> void:
	available_levels = levels

	for child in level_list.get_children():
		child.queue_free()

	for level in available_levels:
		var button = Button.new()
		button.text = level.name
		button.disabled = not LevelManager.is_level_unlocked(level.name)
		button.custom_minimum_size = Vector2(0, 40)

		var level_name = level.name
		button.pressed.connect(func():
			level_selected.emit(level_name)
			LevelManager.load_level(level_name)
		)

		level_list.add_child(button)
