Task: Create AccessibilitySettings.tscn options menu

Before you begin enacting this prompt, ask me whether extended thinking is turned on. (Tell me it should be OFF!)

Requirements:
- Create scenes/ui/AccessibilitySettings.tscn
- Root node: Panel, anchors CENTER, size 500x400
- Child: VBoxContainer with margins:
  - Label "Accessibility Settings" (title)
  - CheckButton "Colorblind Mode"
  - HSlider "Text Size" (range 0.5 to 2.0, default 1.0)
  - HSlider "Grid Opacity" (range 0.3 to 1.0, default 1.0)
  - CheckButton "Show Coordinates"
  - CheckButton "Simplified Graphics"
  - Button "Apply"
  - Button "Close"
- Create scenes/ui/AccessibilitySettings.gd:
  - Extend Panel
  - In _ready():
	- Load settings from GlobalData.game_settings
	- Set UI elements to match current settings
  - Add func _on_apply_pressed():
	- Update GlobalData.game_settings with UI values
	- Call apply_settings()
  - Add func apply_settings():
	- If colorblind_mode:
	  - Update transformation colors to deuteranopia-friendly palette
	  - Translation: Color("#0173B2")
	  - Rotation: Color("#F0E442")
	  - Scaling: Color("#009E73")
	- Apply text_size to all UI themes
	- Apply grid_opacity to grid visuals
	- Toggle coordinate display on/off
	- Toggle simplified graphics (fewer particles, simpler effects)

Technical constraints:
- Godot 4.5 .tscn and .gd format
- Use tabs for indentation
- Settings persist via GlobalData
- Changes apply immediately

Success criteria:
- All settings function correctly
- Colorblind mode uses accessible colors
- Text size scaling works across all UI
- Settings persist between scenes
