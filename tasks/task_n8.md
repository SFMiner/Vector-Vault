Task: Create SaveManager.gd for persistent data

Before you begin enacting this prompt, ask me whether extended thinking is turned on.  (Tell me it should be ON!)


Requirements:
- Modify scripts/autoloads/SaveManager.gd (if not exists, create it)
- Extend Node
- Add const SAVE_PATH = "user://vectorvault_save.json"
- Add func save_game():
  - Create dictionary with:
	- unlocked_levels from LevelManager
	- game_settings from GlobalData
	- analytics session_data
	- shown_tutorials from TutorialOverlay
  - Convert to JSON
  - Write to file using FileAccess
- Add func load_game():
  - Check if save file exists
  - If yes:
	- Read file
	- Parse JSON
	- Restore data to respective managers
  - If no:
	- Initialize with defaults
- Add func delete_save():
  - Remove save file
  - Reset to defaults
- Call load_game() in _ready()
- Auto-save after level completion

Technical constraints:
- Use tabs for indentation
- Godot 4.5 FileAccess API
- JSON format for compatibility
- Error handling for corrupted saves

Success criteria:
- Progress persists between sessions
- Settings saved and restored
- Analytics data preserved
- Graceful handling of missing/corrupt saves
