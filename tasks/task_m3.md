Task: Create World_4_Level_1.tscn - requires translation then rotation

Requirements:
- Create scenes/levels/world_4_architects_vault/World_4_Level_1.tscn
- Root node: Node2D named "World_4_Level_1", attach BaseLevel.gd
- Set exports: level_name = "Vault 4-1", world_number = 4, level_number = 1
- Children:
  - Player at position (150, 500)
  - StaticBody2D "Floor": (400, 550) size 800x50
  - GeoBlock "KeyBlock" at (300, 500)
  - Sprite2D "GhostOutline" at (600, 400)
	- Shows target position and rotation
	- Modulate: Color(1, 1, 1, 0.3) for transparency
	- Set rotation_degrees = 45
  - Marker2D "TargetAlignment" at (600, 400)
  - SequenceRecorder instance at top-left
  - Label "Hint" at (400, 450): "Match the ghost outline exactly!"
- Add UI instances
- Script override in setup_level():
  - Enable sequence recording
  - AlignmentCondition checking KeyBlock matches GhostOutline position and rotation
  - Requires: T(+300, -100) then R(45°)

Technical constraints:
- Godot 4.5 .tscn format
- Ghost outline shows target state
- Sequence recorder tracks steps
- Exact alignment required (within tolerance)

Success criteria:
- Block must be moved AND rotated to match outline
- Order doesn't matter but both needed
- Sequence recorder shows steps taken
- Level completes on exact match
