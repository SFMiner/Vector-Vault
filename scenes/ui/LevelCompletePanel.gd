extends Panel

signal continue_pressed()
signal retry_pressed()

@onready var transform_count_label = $VBoxContainer/TransformCountLabel
@onready var time_label = $VBoxContainer/TimeLabel
@onready var continue_button = $VBoxContainer/ButtonContainer/ContinueButton
@onready var retry_button = $VBoxContainer/ButtonContainer/RetryButton

func _ready() -> void:
	visible = false
	modulate.a = 0.0

	continue_button.pressed.connect(func():
		continue_pressed.emit()
	)
	retry_button.pressed.connect(func():
		retry_pressed.emit()
	)

func show_results(transform_count: int, time_ms: int) -> void:
	transform_count_label.text = "Transformations: %d" % transform_count

	var time_seconds = time_ms / 1000.0
	time_label.text = "Time: %.2fs" % time_seconds

	visible = true

	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.5)
