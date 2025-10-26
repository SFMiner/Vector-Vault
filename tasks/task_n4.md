Task: Create Credits.tscn scene

Requirements:
- Create scenes/ui/Credits.tscn
- Root node: ScrollContainer, fullscreen
- Child: VBoxContainer with RichTextLabel:
  - Game title and version
  - "Designed by: Sean Miner"
  - "Built with: Godot 4.5"
  - "For: Middle school students with learning differences"
  - Math concepts covered
  - Special thanks section
  - License information
  - Button "Back to Menu"
- Create scenes/ui/Credits.gd:
  - Extend ScrollContainer
  - Auto-scroll credits slowly (optional)
  - Back button returns to main menu

Technical constraints:
- Godot 4.5 .tscn and .gd format
- Use tabs for indentation
- Formatted text with proper sections
- Scrollable for long content

Success criteria:
- All credits display properly
- Scrolling works (manual or automatic)
- Back button functions
- Professional presentation
