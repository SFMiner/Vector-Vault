extends Node2D

@onready var show_hide_button : Button = $ShowHideButton
@onready var panel : Panel = $Panel 
@onready var label : Label = $InstructionsLabel
var dragging : bool = false
var offset : Vector2 = Vector2.ZERO
var label_size

var hiding = false
@export var panel_color: Color = Color(1,1,1)
var panel_position : Vector2
var label_position : Vector2
@export var label_text : String = "Instructions"
var panel_size : Vector2


func _ready():
	label.text = label_text
	panel_position = panel.position
	label_position = label.position
	label_size = label.size
	panel_size = panel.size 
	var existing_style = panel.get_theme_stylebox("panel")
	if existing_style is StyleBoxFlat:
		existing_style.bg_color = panel_color
		panel.add_theme_stylebox_override("panel", existing_style)
	var existing_button_style = show_hide_button.get_theme_stylebox("button")
	if existing_button_style is StyleBoxFlat:
		existing_button_style.bg_color = panel_color
		show_hide_button.add_theme_stylebox_override("button", existing_style)
	show_hide_button.position = panel.position + Vector2(panel.size.x - show_hide_button.size.x - 2, 2)
	panel.gui_input.connect(_on_grabber_gui_input)
	
func _on_show_hide_button_pressed() -> void:
	print("Button pressed")
	hiding = !hiding
	label.visible = !hiding
	if hiding:
		show_hide_button.text = "show"
		show_hide_button.add_theme_color_override("font_color", Color.BLACK)
		panel.size = show_hide_button.size + Vector2(4,4)
		panel.position = show_hide_button.position - Vector2(2,2) 
	else:
		show_hide_button.text = "hide"
		show_hide_button.add_theme_color_override("font_color", 
Color.BLACK)
		panel.size = panel_size
		panel.position = panel_position
		label.position = label_position 
	pass # Replace with function body.


func _on_grabber_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed
		if dragging:
			offset = get_global_mouse_position() - global_position
			panel.accept_event()  # keeps clicks from passing through
		elif event is InputEventMouseMotion and dragging:
			global_position = get_global_mouse_position() - offset
