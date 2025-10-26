Task: Create TutorialOverlay.tscn for first-time hints

Before you begin enacting this prompt, ask me whether extended thinking is turned on.  (Tell me it should be ON!)


Requirements:
- Create scenes/ui/TutorialOverlay.tscn
- Root node: CanvasLayer named "TutorialOverlay"
- Child: ColorRect, fullscreen, color Color(0, 0, 0, 0.5)
- Child: Panel, anchors CENTER, size 600x200:
  - VBoxContainer:
	- RichTextLabel "MessageText"
	- HBoxContainer:
	  - Button "Got it!"
	  - CheckButton "Don't show again"
- Create scenes/ui/TutorialOverlay.gd:
  - Extend CanvasLayer
  - Add var tutorial_messages: Dictionary = {
	"first_translation": "Click on a block to move it...",
	"first_rotation": "Rotation swings the block around...",
	"first_scaling": "Scaling changes the size...",
	"first_anchor": "Golden anchors are pivot points..."
  }
  - Add var shown_messages: Dictionary = {}
  - Add func show_tutorial(message_key: String):
	- Check if message already shown
	- If not: display overlay with message
	- Save shown state
  - Add func _on_got_it_pressed():
	- Hide overlay
	- If "don't show again" checked, mark all tutorials as shown

Technical constraints:
- Godot 4.5 .tscn and .gd format
- Use tabs for indentation
- Non-intrusive design
- Respects user preference to skip

Success criteria:
- Shows context-sensitive help first time only
- Clear, concise messages
- Easy to dismiss
- Remembers "don't show again" preference
