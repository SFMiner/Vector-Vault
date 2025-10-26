extends Panel

@onready var transform_count_label = $VBoxContainer/TransformCountLabel
@onready var export_button = $VBoxContainer/ExportButton
@onready var print_button = $VBoxContainer/PrintButton

func _ready() -> void:
	export_button.pressed.connect(func():
		Analytics_Manager.complete_level()
		Analytics_Manager.download_csv_web()
	)
	print_button.pressed.connect(func():
		Analytics_Manager.complete_level()
		print(Analytics_Manager.get_session_summary())
	)

func _process(delta: float) -> void:
	var count = 0
	if not Analytics_Manager.current_level_stats.is_empty():
		count = Analytics_Manager.current_level_stats.transformations.size()

	transform_count_label.text = "Transformations: %d" % count
