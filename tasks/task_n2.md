Task: Create PauseMenu.tscn

Requirements:
- Create scenes/ui/PauseMenu.tscn
- Root node: ColorRect, fullscreen, color Color(0, 0, 0, 0.7) for dim overlay
- Child: Panel, anchors CENTER, size 400x300
  - VBoxContainer child with margins:
	- Label "Paused"
	- Button "Resume"
	- Button "Accessibility"
	- Button "Restart Level"
	- Button "Main Menu"
- Create scenes/ui/PauseMenu.gd:
  - Extend ColorRect
  - Add var is_paused: bool = false
  - Add func _input(event: InputEvent):
	- If event is InputEventKey and event.keycode == KEY_ESCAPE and event.pressed:
	  - Toggle pause state
  - Add func pause():
	- get_tree().paused = true
	- visible = true
	- is_paused = true
  - Add func resume():
	- get_tree().paused = false
	- visible = false
	- is_paused = false
  - Connect buttons:
	- Resume → resume()
	- Accessibility → show accessibility settings
	- Restart → reload current scene
	- Main Menu → load main menu scene

Technical constraints:
- Godot 4.5 .tscn and .gd format
- Use tabs for indentation
- Process mode must be PROCESS_MODE_ALWAYS
- Pauses entire game tree

Success criteria:
- ESC key pauses/unpauses game
- All buttons function correctly
- Game completely frozen while paused
- Overlay dims background
