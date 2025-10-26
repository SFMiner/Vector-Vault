@tool
extends EditorScript

var Analytics_Manager = load("res://scripts/autoloads/AnalyticsManager.gd")

func _run() -> void:
	Analytics_Manager.complete_level()
	print(Analytics_Manager.get_session_summary())
	Analytics_Manager.download_csv_web()
