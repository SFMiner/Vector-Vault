extends Node2D

class_name BaseLevel

signal level_completed()

@export var level_name: String = "Untitled"
@export var world_number: int = 1
@export var level_number: int = 1

var player: CharacterBody2D
var completion_conditions: Array = []
var is_completed: bool = false
var level_complete_panel: Panel

func _ready() -> void:
	Analytics_Manager.start_level(level_name)

	player = $Player as CharacterBody2D
	if player == null:
		push_error("BaseLevel: Player node not found at $Player")

	level_complete_panel = $UI/LevelCompletePanel as Panel
	if level_complete_panel == null:
		push_error("BaseLevel: LevelCompletePanel not found at $UI/LevelCompletePanel")
	else:
		level_complete_panel.next_level_requested.connect(_on_next_level)
		level_complete_panel.retry_requested.connect(_on_retry)

	level_completed.connect(_on_level_completed)

	setup_level()

func setup_level() -> void:
	pass

func check_completion() -> void:
	if is_completed:
		return

	for condition in completion_conditions:
		if not condition.is_met():
			return

	is_completed = true
	level_completed.emit()

func _on_level_completed() -> void:
	Analytics_Manager.complete_level()
	print("Level Complete!")

func _on_next_level() -> void:
	var next_level = LevelManager.get_next_level(level_name)
	if next_level != "":
		LevelManager.unlock_level(next_level)
		LevelManager.load_level(next_level)
	else:
		print("All levels complete!")

func _on_retry() -> void:
	get_tree().reload_current_scene()
