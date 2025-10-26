Task: Create MainMenu.tscn title screen

Requirements:
- Create scenes/ui/MainMenu.tscn
- Root node: Control, fullscreen
- Child 1: ColorRect background (gradient or solid color)
- Child 2: VBoxContainer, anchors CENTER:
  - Label "VectorVault" (large title font)
  - Label "Dimension-Hopping Puzzle Platformer" (subtitle)
  - Button "Start Game" (loads World 1 Level 1)
  - Button "Level Select" (opens level select menu)
  - Button "Settings" (opens accessibility settings)
  - Button "Credits"
  - Button "Quit" (only visible in desktop builds)
- Create scenes/ui/MainMenu.gd:
  - Extend Control
  - In _ready():
	- Play menu music if AudioManager supports it
	- Hide "Quit" button if OS.has_feature("web")
  - Connect buttons to appropriate functions:
	- Start → LevelManager.load_level("Plains 1-1")
	- Level Select → show level select menu
	- Settings → show accessibility settings
	- Quit → get_tree().quit()

Technical constraints:
- Godot 4.5 .tscn and .gd format
- Use tabs for indentation
- Clean, readable layout
- Mobile-friendly button sizes

Success criteria:
- Professional-looking title screen
- All navigation works correctly
- Quit button hidden on web export
- Smooth transitions between menus
