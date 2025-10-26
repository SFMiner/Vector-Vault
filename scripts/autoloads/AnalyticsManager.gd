@tool
extends Node

var session_data: Dictionary = {}
var current_level_stats: Dictionary = {}

func start_level(level_name: String) -> void:
	current_level_stats = {
		"level_name": level_name,
		"start_time": Time.get_ticks_msec(),
		"transformations": [],
		"attempts": 0
	}

func record_transformation(type: String, params: Dictionary, notation: String) -> void:
	var simplified_params = _simplify_params(type, params)

	var record = {
		"type": type,
		"notation": notation,
		"timestamp": Time.get_ticks_msec(),
		"data": simplified_params
	}

	current_level_stats.transformations.append(record)

func complete_level() -> void:
	if current_level_stats.is_empty():
		push_warning("AnalyticsManager: No active level to complete")
		return

	var completion_time = Time.get_ticks_msec() - current_level_stats.start_time
	current_level_stats.completion_time = completion_time

	var level_name = current_level_stats.level_name
	session_data[level_name] = current_level_stats

	current_level_stats = {}

func get_session_summary() -> String:
	var summary = "=== Session Summary ===\n"

	for level_name in session_data.keys():
		var level_data = session_data[level_name]
		var completion_time_sec = level_data.completion_time / 1000.0
		var transformation_count = level_data.transformations.size()

		var transformation_types = []
		for record in level_data.transformations:
			if record.type not in transformation_types:
				transformation_types.append(record.type)

		var types_str = ", ".join(transformation_types)

		summary += "\nLevel: %s\n" % level_name
		summary += "  Transformations: %d\n" % transformation_count
		summary += "  Time: %.2fs\n" % completion_time_sec
		summary += "  Types Used: %s\n" % types_str

	return summary

func export_to_csv() -> String:
	var csv = "Level,StartTime,CompletionTime,TransformationType,Notation,Timestamp\n"

	for level_name in session_data.keys():
		var level_data = session_data[level_name]
		var level_name_escaped = "\"%s\"" % level_data.level_name.replace("\"", "\"\"")
		var start_time = level_data.start_time
		var completion_time = level_data.completion_time

		for transformation in level_data.transformations:
			var trans_type = transformation.type
			var notation = transformation.notation.replace("\"", "\"\"")
			var timestamp = transformation.timestamp

			var row = "%s,%d,%d,%s,\"%s\",%d\n" % [
				level_name_escaped,
				start_time,
				completion_time,
				trans_type,
				notation,
				timestamp
			]
			csv += row

	return csv

func download_csv_web() -> void:
	var csv_data = export_to_csv()

	if OS.has_feature("web"):
		var csv_escaped = csv_data.replace("'", "\\'").replace("\n", "\\n").replace("\"", "\\\"")
		var js_code = """
			var blob = new Blob(['%s'], {type: 'text/csv'});
			var url = URL.createObjectURL(blob);
			var a = document.createElement('a');
			a.href = url;
			a.download = 'vector_vault_analytics.csv';
			a.click();
		""" % csv_escaped
		JavaScriptBridge.eval(js_code)
	else:
		var file_path = "user://vector_vault_analytics.csv"
		var file = FileAccess.open(file_path, FileAccess.WRITE)
		if file != null:
			file.store_string(csv_data)
			print("Analytics saved to: " + file_path)
		else:
			push_error("Failed to write analytics file: " + file_path)

func _simplify_params(type: String, params: Dictionary) -> Dictionary:
	match type:
		"translate":
			var offset = params.get("offset", Vector2.ZERO)
			return {
				"offset_x": offset.x,
				"offset_y": offset.y
			}
		"rotate":
			return {
				"angle": params.get("angle", 0.0)
			}
		"scale":
			return {
				"scale_factor": params.get("scale", 1.0)
			}
		_:
			return {}
